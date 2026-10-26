module CpuRom (
    input clk,
    input re,
    input [9:0] raddr,
    output logic [31:0] rdata,
    output logic [17:0] prediction
);
    logic [31:0] mem [0:1023];
    logic [17:0] prediction_mem [0:1023];
    logic [31:0] rq;
    logic [17:0] prediction_q;

    initial begin
        for (int _i = 0; _i < 1024; _i++) mem[_i] = 0;
        for (int _i = 0; _i < 1024; _i++) prediction_mem[_i] = 0;
    end

    assign rdata = rq;
    assign prediction = prediction_q;
    always_ff @(posedge clk) begin
        if (re) begin
            rq <= mem[raddr];
            prediction_q <= prediction_mem[raddr];
        end
    end
    // RawBlock(initial) — forward-direction artifact, preserved verbatim:
    function automatic [17:0] rom_prediction(input [13:0] address, input [31:0] inst);
        reg jal, valid;
        reg [29:0] target;
        begin
            jal = inst[6:0] == 7'h6f;
            target = {16'b0, address} + (jal ?
                {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:22]} :
                {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:9]});
            valid = (jal || (inst[6:0] == 7'h63 && inst[31])) &&
                    !(jal ? inst[21] : inst[8]) && target[29:15] == 0;
            rom_prediction = {1'b0, inst == 32'h00008067, valid, target[14:0]};
        end
    endfunction
    initial begin
    `ifdef VERILATOR
        string boot_rom_path;
        if (!$value$plusargs("boot_rom=%s", boot_rom_path)) boot_rom_path = "cpu_boot_rom.hex";
        $readmemh(boot_rom_path, mem);
    `else
        $readmemh("cpu_boot_rom.hex", mem);
    `endif
        for (int p = 0; p < 1024; p++) prediction_mem[p] = rom_prediction(p[13:0], mem[p]);
    end
endmodule
