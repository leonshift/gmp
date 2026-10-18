module axi_tb #(parameter PREDICT=2, parameter PERF=0);
    reg clk=0; always #2.5 clk=~clk;
    reg rst_n=0;
    reg [31:0] clock_measurement=200000;
    reg [31:0] s_awaddr=0,s_wdata=0,s_araddr=0;
    reg [3:0] s_wstrb=15;
    reg s_awvalid=0,s_wvalid=0,s_bready=0,s_arvalid=0,s_rready=0;
    wire s_awready,s_wready,s_bvalid,s_arready,s_rvalid,halted,fault;
    wire [1:0] s_bresp,s_rresp;
    wire [31:0] s_rdata;
    Rv32Axi #(.PREDICT(PREDICT), .PERF(PERF)) dut(.*);
    task automatic write_word(input [31:0] address, data, input integer aw_delay,w_delay, input [3:0] mask=15);
        fork
            begin
                repeat(aw_delay) @(negedge clk);
                @(negedge clk); s_awaddr=address; s_awvalid=1;
                @(posedge clk); while(!s_awready) @(posedge clk);
                @(negedge clk);s_awvalid=0;
            end
            begin
                repeat(w_delay) @(negedge clk);
                @(negedge clk);s_wdata=data;s_wstrb=mask;s_wvalid=1;
                @(posedge clk);while(!s_wready) @(posedge clk);
                @(negedge clk);s_wvalid=0;
            end
        join
        while(!s_bvalid) @(negedge clk);
        if(s_bresp!=0)$fatal(1,"write response %h",s_bresp);
        repeat(4)begin @(negedge clk); if(!s_bvalid||s_bresp!=0)$fatal(1,"B not held");end
        s_bready=1;@(negedge clk);s_bready=0;
    endtask
    task automatic read_word(input [31:0] address,expected, input [1:0] response=0);
        @(negedge clk);s_araddr=address;s_arvalid=1;
        @(posedge clk);while(!s_arready)@(posedge clk);
        @(negedge clk);s_arvalid=0;
        while(!s_rvalid)@(negedge clk);
        if(s_rresp!=response || (response==0 && s_rdata!=expected))$fatal(1,"read %h got %h/%h expected %h/%h",address,s_rdata,s_rresp,expected,response);
        repeat(4)begin
            @(negedge clk);
            if(!s_rvalid || (response==0 && s_rdata!=expected))$fatal(1,"R not held");
        end
        s_rready=1;@(negedge clk);s_rready=0;
    endtask
    initial begin
        repeat(5)@(negedge clk);rst_n=1;
        read_word(32'h20000000,32'h52563332);
        write_word(32'h10000,32'h12345678,0,7);
        read_word(32'h10000,32'h12345678);
        write_word(32'h10000,32'habcdef90,8,0,4'b0101);
        read_word(32'h10000,32'h12cd5690);
        read_word(32'h2000004c,200000);
        read_word(32'h40000000,0,2);
        write_word(0,32'h00100073,1,1);
        write_word(32'h20000004,1,0,0);
        repeat(100)@(negedge clk);
        if(!halted||fault)$fatal(1,"core halt status");
        read_word(0,0,2);
        write_word(32'h20000004,0,0,2);
        read_word(0,32'h00100073);
        $display("PASS: AXI AW/W ordering, byte enables, response backpressure, reset/start");
        $finish;
    end
    initial begin #100000;$fatal(1,"AXI test timeout");end
endmodule
