module DmaRdFifo (
    input clk,
    input rst_n,
    input resv,
    input [8:0] resv_n,
    input push,
    input push_l_0,
    input push_l_1,
    input push_l_2,
    input push_l_3,
    input [1023:0] pdata,
    input emit,
    input rd,
    input take,
    input take_l_0,
    input take_l_1,
    input take_l_2,
    input take_l_3,
    input [13:0] side,
    output logic [1023:0] hdata,
    output logic [127:0] hstb,
    output logic avail,
    output logic space,
    output logic empty,
    output logic wv1,
    output logic wv2,
    output logic [8:0] free,
    output logic room_max,
    output logic [8:0] occ
);
    logic [8:0] n_unread;
    logic nu_nz;
    logic [8:0] commit;
    logic [1:0] rc;
    logic rif;
    logic v1;
    logic v2;
    logic [13:0] s_sp_0;
    logic [13:0] s_sp_1;
    logic [13:0] s_sp_2;
    logic [13:0] s_sp_3;
    logic s_rif_0;
    logic s_rif_1;
    logic s_rif_2;
    logic s_rif_3;
    logic s_wp_0;
    logic s_wp_1;
    logic s_wp_2;
    logic s_wp_3;
    logic s_rp_0;
    logic s_rp_1;
    logic s_rp_2;
    logic s_rp_3;
    logic [31:0] s_b0_0;
    logic [31:0] s_b0_1;
    logic [31:0] s_b0_2;
    logic [31:0] s_b0_3;
    logic [31:0] s_b1_0;
    logic [31:0] s_b1_1;
    logic [31:0] s_b1_2;
    logic [31:0] s_b1_3;
    logic [127:0] sp_msk_0;
    logic [127:0] sp_msk_1;
    logic [127:0] sp_msk_2;
    logic [127:0] sp_msk_3;
    logic [31:0] sp_stb_0;
    logic [31:0] sp_stb_1;
    logic [31:0] sp_stb_2;
    logic [31:0] sp_stb_3;
    logic [2:0] nx2;
    logic [8:0] nu_nx;
    logic [159:0] u_lane_3_head;
    logic [287:0] u_lane_2_head;
    logic [287:0] u_lane_1_head;
    logic [287:0] u_lane_0_head;

    assign hdata = {u_lane_3_head, u_lane_2_head, u_lane_1_head, u_lane_0_head};
    assign sp_msk_0 = ((128'd340282366920938463463374607431768211455 << s_sp_0[6:0])
                       & (128'd340282366920938463463374607431768211455 >> (7'd127 - s_sp_0[13:7])));
    assign sp_stb_0 = sp_msk_0[31:0];
    assign sp_msk_1 = ((128'd340282366920938463463374607431768211455 << s_sp_1[6:0])
                       & (128'd340282366920938463463374607431768211455 >> (7'd127 - s_sp_1[13:7])));
    assign sp_stb_1 = sp_msk_1[63:32];
    assign sp_msk_2 = ((128'd340282366920938463463374607431768211455 << s_sp_2[6:0])
                       & (128'd340282366920938463463374607431768211455 >> (7'd127 - s_sp_2[13:7])));
    assign sp_stb_2 = sp_msk_2[95:64];
    assign sp_msk_3 = ((128'd340282366920938463463374607431768211455 << s_sp_3[6:0])
                       & (128'd340282366920938463463374607431768211455 >> (7'd127 - s_sp_3[13:7])));
    assign sp_stb_3 = sp_msk_3[127:96];
    assign hstb = {(s_rp_3 ? s_b1_3 : s_b0_3), (s_rp_2 ? s_b1_2 : s_b0_2), (s_rp_1 ? s_b1_1 : s_b0_1),
                   (s_rp_0 ? s_b1_0 : s_b0_0)};
    assign avail = nu_nz;
    assign space = (({1'd0, rc} + {2'd0, rif}) <= (3'd1 + {2'd0, take}));
    assign empty = ((rc == 0) & (~rif));
    assign wv1 = v1;
    assign wv2 = v2;
    assign free = (9'd256 - commit);
    assign room_max = (commit <= 223);
    assign occ = commit;
    assign nx2 = ((({1'd0, rc} + {2'd0, rif}) - {2'd0, take}) + {2'd0, emit});
    assign nu_nx = ((n_unread + {8'd0, push}) - {8'd0, rd});
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            n_unread <= 0;
            nu_nz <= 0;
            commit <= 0;
            rc <= 0;
            rif <= 0;
            v1 <= 0;
            v2 <= 0;
            s_sp_0 <= 0;
            s_rif_0 <= 0;
            s_wp_0 <= 0;
            s_rp_0 <= 0;
            s_sp_1 <= 0;
            s_rif_1 <= 0;
            s_wp_1 <= 0;
            s_rp_1 <= 0;
            s_sp_2 <= 0;
            s_rif_2 <= 0;
            s_wp_2 <= 0;
            s_rp_2 <= 0;
            s_sp_3 <= 0;
            s_rif_3 <= 0;
            s_wp_3 <= 0;
            s_rp_3 <= 0;
        end else begin
            n_unread <= nu_nx;
            nu_nz <= (nu_nx != 0);
            commit <= ((commit + (resv ? resv_n : 9'd0)) - {8'd0, rd});
            rc <= ((rc + {1'd0, rif}) - {1'd0, take});
            rif <= emit;
            v1 <= (nx2 != 0);
            v2 <= (nx2 >= 2);
            s_sp_0 <= side;
            s_rif_0 <= emit;
            if (s_rif_0) begin
                s_wp_0 <= (~s_wp_0);
            end
            if (take) begin
                s_rp_0 <= (~s_rp_0);
            end
            s_sp_1 <= side;
            s_rif_1 <= emit;
            if (s_rif_1) begin
                s_wp_1 <= (~s_wp_1);
            end
            if (take) begin
                s_rp_1 <= (~s_rp_1);
            end
            s_sp_2 <= side;
            s_rif_2 <= emit;
            if (s_rif_2) begin
                s_wp_2 <= (~s_wp_2);
            end
            if (take) begin
                s_rp_2 <= (~s_rp_2);
            end
            s_sp_3 <= side;
            s_rif_3 <= emit;
            if (s_rif_3) begin
                s_wp_3 <= (~s_wp_3);
            end
            if (take) begin
                s_rp_3 <= (~s_rp_3);
            end
        end
    end
    always_ff @(posedge clk) begin
        if (s_rif_0) begin
            if (s_wp_0) begin
                s_b1_0 <= sp_stb_0;
            end else begin
                s_b0_0 <= sp_stb_0;
            end
        end
        if (s_rif_1) begin
            if (s_wp_1) begin
                s_b1_1 <= sp_stb_1;
            end else begin
                s_b0_1 <= sp_stb_1;
            end
        end
        if (s_rif_2) begin
            if (s_wp_2) begin
                s_b1_2 <= sp_stb_2;
            end else begin
                s_b0_2 <= sp_stb_2;
            end
        end
        if (s_rif_3) begin
            if (s_wp_3) begin
                s_b1_3 <= sp_stb_3;
            end else begin
                s_b0_3 <= sp_stb_3;
            end
        end
    end

    DmaRdFifoLane288 u_lane_0 (
        .clk(clk),
        .rst_n(rst_n),
        .we(push_l_0),
        .wdata(pdata[287:0]),
        .re(rd),
        .emit(emit),
        .take(take_l_0),
        .head(u_lane_0_head)
    );
    DmaRdFifoLane288 u_lane_1 (
        .clk(clk),
        .rst_n(rst_n),
        .we(push_l_1),
        .wdata(pdata[575:288]),
        .re(rd),
        .emit(emit),
        .take(take_l_1),
        .head(u_lane_1_head)
    );
    DmaRdFifoLane288 u_lane_2 (
        .clk(clk),
        .rst_n(rst_n),
        .we(push_l_2),
        .wdata(pdata[863:576]),
        .re(rd),
        .emit(emit),
        .take(take_l_2),
        .head(u_lane_2_head)
    );
    DmaRdFifoLane160 u_lane_3 (
        .clk(clk),
        .rst_n(rst_n),
        .we(push_l_3),
        .wdata(pdata[1023:864]),
        .re(rd),
        .emit(emit),
        .take(take_l_3),
        .head(u_lane_3_head)
    );
endmodule
