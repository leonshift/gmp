module DmaRdFifoLane288 (
    input clk,
    input rst_n,
    input we,
    input [287:0] wdata,
    input re,
    input emit,
    input take,
    output logic [287:0] head
);
    logic [7:0] wp;
    logic [7:0] rp;
    logic [287:0] mem [0:255];
    logic [287:0] rq;
    logic rif_0;
    logic rif_1;
    logic rif_2;
    logic rif_3;
    logic rif_4;
    logic rif_5;
    logic rif_6;
    logic rif_7;
    logic owp_0;
    logic owp_1;
    logic owp_2;
    logic owp_3;
    logic owp_4;
    logic owp_5;
    logic owp_6;
    logic owp_7;
    logic orp_0;
    logic orp_1;
    logic orp_2;
    logic orp_3;
    logic orp_4;
    logic orp_5;
    logic orp_6;
    logic orp_7;
    logic [35:0] e0_0;
    logic [35:0] e0_1;
    logic [35:0] e0_2;
    logic [35:0] e0_3;
    logic [35:0] e0_4;
    logic [35:0] e0_5;
    logic [35:0] e0_6;
    logic [35:0] e0_7;
    logic [35:0] e1_0;
    logic [35:0] e1_1;
    logic [35:0] e1_2;
    logic [35:0] e1_3;
    logic [35:0] e1_4;
    logic [35:0] e1_5;
    logic [35:0] e1_6;
    logic [35:0] e1_7;

    assign head = {(orp_7 ? e1_7 : e0_7), (orp_6 ? e1_6 : e0_6), (orp_5 ? e1_5 : e0_5), (orp_4 ? e1_4 : e0_4),
                   (orp_3 ? e1_3 : e0_3), (orp_2 ? e1_2 : e0_2), (orp_1 ? e1_1 : e0_1), (orp_0 ? e1_0 : e0_0)};
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wp <= 0;
            rp <= 0;
            rif_0 <= 0;
            owp_0 <= 0;
            orp_0 <= 0;
            rif_1 <= 0;
            owp_1 <= 0;
            orp_1 <= 0;
            rif_2 <= 0;
            owp_2 <= 0;
            orp_2 <= 0;
            rif_3 <= 0;
            owp_3 <= 0;
            orp_3 <= 0;
            rif_4 <= 0;
            owp_4 <= 0;
            orp_4 <= 0;
            rif_5 <= 0;
            owp_5 <= 0;
            orp_5 <= 0;
            rif_6 <= 0;
            owp_6 <= 0;
            orp_6 <= 0;
            rif_7 <= 0;
            owp_7 <= 0;
            orp_7 <= 0;
        end else begin
            if (we) begin
                wp <= (wp + 1);
            end
            if (re) begin
                rp <= (rp + 1);
            end
            rif_0 <= emit;
            if (rif_0) begin
                owp_0 <= (~owp_0);
            end
            if (take) begin
                orp_0 <= (~orp_0);
            end
            rif_1 <= emit;
            if (rif_1) begin
                owp_1 <= (~owp_1);
            end
            if (take) begin
                orp_1 <= (~orp_1);
            end
            rif_2 <= emit;
            if (rif_2) begin
                owp_2 <= (~owp_2);
            end
            if (take) begin
                orp_2 <= (~orp_2);
            end
            rif_3 <= emit;
            if (rif_3) begin
                owp_3 <= (~owp_3);
            end
            if (take) begin
                orp_3 <= (~orp_3);
            end
            rif_4 <= emit;
            if (rif_4) begin
                owp_4 <= (~owp_4);
            end
            if (take) begin
                orp_4 <= (~orp_4);
            end
            rif_5 <= emit;
            if (rif_5) begin
                owp_5 <= (~owp_5);
            end
            if (take) begin
                orp_5 <= (~orp_5);
            end
            rif_6 <= emit;
            if (rif_6) begin
                owp_6 <= (~owp_6);
            end
            if (take) begin
                orp_6 <= (~orp_6);
            end
            rif_7 <= emit;
            if (rif_7) begin
                owp_7 <= (~owp_7);
            end
            if (take) begin
                orp_7 <= (~orp_7);
            end
        end
    end
    always_ff @(posedge clk) begin
        rq <= mem[rp];
        if (we) begin
            mem[wp] <= wdata;
        end
        if (rif_0) begin
            if (owp_0) begin
                e1_0 <= rq[35:0];
            end else begin
                e0_0 <= rq[35:0];
            end
        end
        if (rif_1) begin
            if (owp_1) begin
                e1_1 <= rq[71:36];
            end else begin
                e0_1 <= rq[71:36];
            end
        end
        if (rif_2) begin
            if (owp_2) begin
                e1_2 <= rq[107:72];
            end else begin
                e0_2 <= rq[107:72];
            end
        end
        if (rif_3) begin
            if (owp_3) begin
                e1_3 <= rq[143:108];
            end else begin
                e0_3 <= rq[143:108];
            end
        end
        if (rif_4) begin
            if (owp_4) begin
                e1_4 <= rq[179:144];
            end else begin
                e0_4 <= rq[179:144];
            end
        end
        if (rif_5) begin
            if (owp_5) begin
                e1_5 <= rq[215:180];
            end else begin
                e0_5 <= rq[215:180];
            end
        end
        if (rif_6) begin
            if (owp_6) begin
                e1_6 <= rq[251:216];
            end else begin
                e0_6 <= rq[251:216];
            end
        end
        if (rif_7) begin
            if (owp_7) begin
                e1_7 <= rq[287:252];
            end else begin
                e0_7 <= rq[287:252];
            end
        end
    end
endmodule
