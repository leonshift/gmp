module NocAfifoWs577 (
    input clk,
    input rst_n,
    input rclk,
    input rrst_n,
    input wen,
    input [576:0] wdata,
    output logic wfull,
    input ren,
    output logic [576:0] rdata,
    output logic rempty
);
    logic [576:0] mem [0:15];
    logic [4:0] wptr;
    logic [4:0] wagray;
    logic [4:0] wgray;
    logic ws_v;
    logic [3:0] ws_a;
    logic [576:0] ws_d;
    logic [4:0] rgray_s1;
    logic [4:0] rgray_s2;
    logic [4:0] rptr;
    logic [4:0] rgray;
    logic [4:0] wgray_s1;
    logic [4:0] wgray_s2;
    logic [4:0] wnext;
    logic [4:0] rnext;
    logic [4:0] wgray_next;
    logic [4:0] rgray_next;
    logic [4:0] wnext2;
    logic [4:0] wgray_next2;
    logic wacc;
    logic wfull_n;
    logic wfull_q;
    logic wf_e1;
    logic wf_e2;

    always_comb begin
        rdata = mem[rptr[3:0]];
        wnext = (wptr + 1);
        wgray_next = (wnext ^ (wnext >> 1));
        wnext2 = (wptr + 2);
        wgray_next2 = (wnext2 ^ (wnext2 >> 1));
        rnext = (rptr + 1);
        rgray_next = (rnext ^ (rnext >> 1));
        wacc = (wen & (!wfull));
        wf_e2 = (wgray_next2 == {(~rgray_s2[4]), (~rgray_s2[3]), rgray_s2[2:0]});
        wf_e1 = (wgray_next == {(~rgray_s2[4]), (~rgray_s2[3]), rgray_s2[2:0]});
        if (wacc) begin
            wfull_n = wf_e2;
        end else begin
            wfull_n = wf_e1;
        end
        rempty = (rgray == wgray_s2);
        wfull = wfull_q;
    end
    always_ff @(posedge clk) begin
        if ((!rst_n)) begin
            wptr <= 0;
            wagray <= 0;
            wgray <= 0;
            ws_v <= 0;
            rgray_s1 <= 0;
            rgray_s2 <= 0;
            wfull_q <= 0;
        end else begin
            rgray_s1 <= rgray;
            rgray_s2 <= rgray_s1;
            wfull_q <= wfull_n;
            ws_v <= wacc;
            wgray <= wagray;
            if (wacc) begin
                wptr <= wnext;
                wagray <= wgray_next;
            end
        end
    end
    always_ff @(posedge clk) begin
        if (ws_v) begin
            mem[ws_a] <= ws_d;
        end
        ws_a <= wptr[3:0];
        ws_d <= wdata;
    end
    always_ff @(posedge rclk) begin
        if ((!rrst_n)) begin
            rptr <= 0;
            rgray <= 0;
            wgray_s1 <= 0;
            wgray_s2 <= 0;
        end else begin
            wgray_s1 <= wgray;
            wgray_s2 <= wgray_s1;
            if ((ren & (!rempty))) begin
                rptr <= rnext;
                rgray <= rgray_next;
            end
        end
    end
endmodule
