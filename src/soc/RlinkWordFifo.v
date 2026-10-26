module RlinkWordFifo (
    input clk,
    input rst_n,
    input rclk,
    input rrst_n,
    input wen,
    input [32:0] wdata,
    output logic wfull,
    output logic room,
    input ren,
    output logic rvalid,
    output logic [32:0] rdata
);
    logic [32:0] mem [0:16383];
    logic [14:0] wptr;
    logic [14:0] wgray;
    logic [14:0] rgray_s1;
    logic [14:0] rgray_s2;
    logic [14:0] rbin_q;
    logic [14:0] rptr;
    logic [14:0] rgray;
    logic [14:0] wgray_s1;
    logic [14:0] wgray_s2;
    logic ovalid;
    logic [32:0] odata;
    logic [14:0] wnext;
    logic [14:0] wgray_next;
    logic [14:0] rnext;
    logic [14:0] rgray_next;
    logic rempty;
    logic [14:0] rbin_w;
    logic [14:0] fill_w;
    logic load;

    assign wnext = (wptr + 1);
    assign wgray_next = (wnext ^ (wnext >> 1));
    assign rnext = (rptr + 1);
    assign rgray_next = (rnext ^ (rnext >> 1));
    assign wfull = (wgray_next == {(~rgray_s2[14]), (~rgray_s2[13]), rgray_s2[12:0]});
    assign rempty = (rgray == wgray_s2);
    assign rbin_w = ((((((((((((((rgray_s2 ^ (rgray_s2 >> 1)) ^ (rgray_s2 >> 2)) ^ (rgray_s2 >> 3)) ^ (rgray_s2 >> 4))
                     ^ (rgray_s2 >> 5)) ^ (rgray_s2 >> 6)) ^ (rgray_s2 >> 7)) ^ (rgray_s2 >> 8)) ^ (rgray_s2 >> 9))
                     ^ (rgray_s2 >> 10)) ^ (rgray_s2 >> 11)) ^ (rgray_s2 >> 12)) ^ (rgray_s2 >> 13)) ^ (rgray_s2 >> 14));
    assign fill_w = (wptr - rbin_q);
    assign room = (fill_w <= 16000);
    assign load = (((~ovalid) | ren) & (~rempty));
    assign rvalid = ovalid;
    assign rdata = odata;
    always_ff @(posedge clk) begin
        if ((!rst_n)) begin
            wptr <= 0;
            wgray <= 0;
            rgray_s1 <= 0;
            rgray_s2 <= 0;
            rbin_q <= 0;
        end else begin
            rgray_s1 <= rgray;
            rgray_s2 <= rgray_s1;
            rbin_q <= rbin_w;
            if ((wen & (!wfull))) begin
                mem[wptr[13:0]] <= wdata;
                wptr <= wnext;
                wgray <= wgray_next;
            end
        end
    end
    always_ff @(posedge rclk) begin
        if ((!rrst_n)) begin
            rptr <= 0;
            rgray <= 0;
            wgray_s1 <= 0;
            wgray_s2 <= 0;
            ovalid <= 0;
        end else begin
            wgray_s1 <= wgray;
            wgray_s2 <= wgray_s1;
            if (load) begin
                odata <= mem[rptr[13:0]];
                rptr <= rnext;
                rgray <= rgray_next;
                ovalid <= 1;
            end else begin
                if (ren) begin
                    ovalid <= 0;
                end
            end
        end
    end
endmodule
