module DmaFanout (
    input clk,
    input rst_n,
    input sc_smem,
    input [7:0] sc_scid,
    input [31:0] sc_saddr,
    input sc_dmem,
    input [7:0] sc_dcid,
    input [31:0] sc_daddr,
    input [15:0] sc_rows,
    input [19:0] sc_bytes,
    input [19:0] sc_sstride,
    input [19:0] sc_dstride,
    input sc_valid,
    output logic sc_ready,
    output logic ch_0_cmd_valid,
    input ch_0_idle,
    input ch_0_rel,
    output logic ch_1_cmd_valid,
    input ch_1_idle,
    input ch_1_rel,
    output logic ch_2_cmd_valid,
    input ch_2_idle,
    input ch_2_rel,
    output logic ch_3_cmd_valid,
    input ch_3_idle,
    input ch_3_rel,
    output logic cmd_smem,
    output logic [7:0] cmd_scid,
    output logic [31:0] cmd_saddr,
    output logic cmd_dmem,
    output logic [7:0] cmd_dcid,
    output logic [31:0] cmd_daddr,
    output logic [15:0] cmd_rows,
    output logic [19:0] cmd_bytes,
    output logic [19:0] cmd_sstride,
    output logic [19:0] cmd_dstride,
    output logic [5:0] dbg_win_n,
    output logic [3:0] dbg_sid_used,
    output logic [2:0] dbg_state,
    output logic busy
);
    logic p_smem [0:31];
    logic [7:0] p_scid [0:31];
    logic [31:0] p_saddr [0:31];
    logic p_dmem [0:31];
    logic [7:0] p_dcid [0:31];
    logic [31:0] p_daddr [0:31];
    logic [15:0] p_rows [0:31];
    logic [19:0] p_bytes [0:31];
    logic [19:0] p_sstride [0:31];
    logic [19:0] p_dstride [0:31];
    logic p_sid_v [0:31];
    logic [7:0] p_sid [0:31];
    logic [4:0] w_wp;
    logic [4:0] w_rp;
    logic [5:0] w_n;
    logic ch_sid_v_0;
    logic ch_sid_v_1;
    logic ch_sid_v_2;
    logic ch_sid_v_3;
    logic [7:0] ch_sid_0;
    logic [7:0] ch_sid_1;
    logic [7:0] ch_sid_2;
    logic [7:0] ch_sid_3;
    logic [1:0] ch_rr;
    logic ca_v;
    logic [4:0] ca_idx;
    logic ca_sid_v;
    logic [7:0] ca_sid;
    logic sc_sid_v;
    logic [7:0] sc_sid;
    logic pool_avail;
    logic enq_ok;
    logic sidb_l_0;
    logic sidb_l_1;
    logic sidb_l_2;
    logic sidb_l_3;
    logic sid_busy;
    logic [3:0] idle_vec;
    logic [1:0] ch_pick_idx;
    logic [3:0] ch_pick_oh;
    logic ch_pick_v;
    logic dispatch;
    logic [4:0] cand_idx;
    logic cand_v;
    logic [4:0] idx;

    assign sc_sid_v = ((~sc_smem) | (~sc_dmem));
    assign sc_sid = ((~sc_smem) ? sc_scid : sc_dcid);
    assign pool_avail = (w_n != 32);
    assign enq_ok = (sc_valid & pool_avail);
    assign sc_ready = enq_ok;
    assign sidb_l_0 = (ch_sid_v_0 & (ch_sid_0 == ca_sid));
    assign sidb_l_1 = (ch_sid_v_1 & (ch_sid_1 == ca_sid));
    assign sidb_l_2 = (ch_sid_v_2 & (ch_sid_2 == ca_sid));
    assign sidb_l_3 = (ch_sid_v_3 & (ch_sid_3 == ca_sid));
    assign sid_busy = (ca_sid_v & ({sidb_l_3, sidb_l_2, sidb_l_1, sidb_l_0} != 0));
    assign idle_vec = {ch_3_idle, ch_2_idle, ch_1_idle, ch_0_idle};
    assign ch_pick_idx = (({ch_rr, idle_vec} == 0) ? 2'd0 :
                         (({ch_rr, idle_vec} == 1) ? 2'd0 :
                         (({ch_rr, idle_vec} == 2) ? 2'd1 :
                         (({ch_rr, idle_vec} == 3) ? 2'd0 :
                         (({ch_rr, idle_vec} == 4) ? 2'd2 :
                         (({ch_rr, idle_vec} == 5) ? 2'd0 :
                         (({ch_rr, idle_vec} == 6) ? 2'd1 :
                         (({ch_rr, idle_vec} == 7) ? 2'd0 :
                         (({ch_rr, idle_vec} == 8) ? 2'd3 :
                         (({ch_rr, idle_vec} == 9) ? 2'd0 :
                         (({ch_rr, idle_vec} == 10) ? 2'd1 :
                         (({ch_rr, idle_vec} == 11) ? 2'd0 :
                         (({ch_rr, idle_vec} == 12) ? 2'd2 :
                         (({ch_rr, idle_vec} == 13) ? 2'd0 :
                         (({ch_rr, idle_vec} == 14) ? 2'd1 :
                         (({ch_rr, idle_vec} == 15) ? 2'd0 :
                         (({ch_rr, idle_vec} == 16) ? 2'd1 :
                         (({ch_rr, idle_vec} == 17) ? 2'd0 :
                         (({ch_rr, idle_vec} == 18) ? 2'd1 :
                         (({ch_rr, idle_vec} == 19) ? 2'd1 :
                         (({ch_rr, idle_vec} == 20) ? 2'd2 :
                         (({ch_rr, idle_vec} == 21) ? 2'd2 :
                         (({ch_rr, idle_vec} == 22) ? 2'd1 :
                         (({ch_rr, idle_vec} == 23) ? 2'd1 :
                         (({ch_rr, idle_vec} == 24) ? 2'd3 :
                         (({ch_rr, idle_vec} == 25) ? 2'd3 :
                         (({ch_rr, idle_vec} == 26) ? 2'd1 :
                         (({ch_rr, idle_vec} == 27) ? 2'd1 :
                         (({ch_rr, idle_vec} == 28) ? 2'd2 :
                         (({ch_rr, idle_vec} == 29) ? 2'd2 :
                         (({ch_rr, idle_vec} == 30) ? 2'd1 :
                         (({ch_rr, idle_vec} == 31) ? 2'd1 :
                         (({ch_rr, idle_vec} == 32) ? 2'd2 :
                         (({ch_rr, idle_vec} == 33) ? 2'd0 :
                         (({ch_rr, idle_vec} == 34) ? 2'd1 :
                         (({ch_rr, idle_vec} == 35) ? 2'd0 :
                         (({ch_rr, idle_vec} == 36) ? 2'd2 :
                         (({ch_rr, idle_vec} == 37) ? 2'd2 :
                         (({ch_rr, idle_vec} == 38) ? 2'd2 :
                         (({ch_rr, idle_vec} == 39) ? 2'd2 :
                         (({ch_rr, idle_vec} == 40) ? 2'd3 :
                         (({ch_rr, idle_vec} == 41) ? 2'd3 :
                         (({ch_rr, idle_vec} == 42) ? 2'd3 :
                         (({ch_rr, idle_vec} == 43) ? 2'd3 :
                         (({ch_rr, idle_vec} == 44) ? 2'd2 :
                         (({ch_rr, idle_vec} == 45) ? 2'd2 :
                         (({ch_rr, idle_vec} == 46) ? 2'd2 :
                         (({ch_rr, idle_vec} == 47) ? 2'd2 :
                         (({ch_rr, idle_vec} == 48) ? 2'd3 :
                         (({ch_rr, idle_vec} == 49) ? 2'd0 :
                         (({ch_rr, idle_vec} == 50) ? 2'd1 :
                         (({ch_rr, idle_vec} == 51) ? 2'd0 :
                         (({ch_rr, idle_vec} == 52) ? 2'd2 :
                         (({ch_rr, idle_vec} == 53) ? 2'd0 :
                         (({ch_rr, idle_vec} == 54) ? 2'd1 :
                         (({ch_rr, idle_vec} == 55) ? 2'd0 :
                         (({ch_rr, idle_vec} == 56) ? 2'd3 :
                         (({ch_rr, idle_vec} == 57) ? 2'd3 :
                         (({ch_rr, idle_vec} == 58) ? 2'd3 :
                         (({ch_rr, idle_vec} == 59) ? 2'd3 :
                         (({ch_rr, idle_vec} == 60) ? 2'd3 :
                         (({ch_rr, idle_vec} == 61) ? 2'd3 :
                         (({ch_rr, idle_vec} == 62) ? 2'd3 :
                         2'd3)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign ch_pick_oh = (({ch_rr, idle_vec} == 0) ? 4'd0 :
                        (({ch_rr, idle_vec} == 1) ? 4'd1 :
                        (({ch_rr, idle_vec} == 2) ? 4'd2 :
                        (({ch_rr, idle_vec} == 3) ? 4'd1 :
                        (({ch_rr, idle_vec} == 4) ? 4'd4 :
                        (({ch_rr, idle_vec} == 5) ? 4'd1 :
                        (({ch_rr, idle_vec} == 6) ? 4'd2 :
                        (({ch_rr, idle_vec} == 7) ? 4'd1 :
                        (({ch_rr, idle_vec} == 8) ? 4'd8 :
                        (({ch_rr, idle_vec} == 9) ? 4'd1 :
                        (({ch_rr, idle_vec} == 10) ? 4'd2 :
                        (({ch_rr, idle_vec} == 11) ? 4'd1 :
                        (({ch_rr, idle_vec} == 12) ? 4'd4 :
                        (({ch_rr, idle_vec} == 13) ? 4'd1 :
                        (({ch_rr, idle_vec} == 14) ? 4'd2 :
                        (({ch_rr, idle_vec} == 15) ? 4'd1 :
                        (({ch_rr, idle_vec} == 16) ? 4'd0 :
                        (({ch_rr, idle_vec} == 17) ? 4'd1 :
                        (({ch_rr, idle_vec} == 18) ? 4'd2 :
                        (({ch_rr, idle_vec} == 19) ? 4'd2 :
                        (({ch_rr, idle_vec} == 20) ? 4'd4 :
                        (({ch_rr, idle_vec} == 21) ? 4'd4 :
                        (({ch_rr, idle_vec} == 22) ? 4'd2 :
                        (({ch_rr, idle_vec} == 23) ? 4'd2 :
                        (({ch_rr, idle_vec} == 24) ? 4'd8 :
                        (({ch_rr, idle_vec} == 25) ? 4'd8 :
                        (({ch_rr, idle_vec} == 26) ? 4'd2 :
                        (({ch_rr, idle_vec} == 27) ? 4'd2 :
                        (({ch_rr, idle_vec} == 28) ? 4'd4 :
                        (({ch_rr, idle_vec} == 29) ? 4'd4 :
                        (({ch_rr, idle_vec} == 30) ? 4'd2 :
                        (({ch_rr, idle_vec} == 31) ? 4'd2 :
                        (({ch_rr, idle_vec} == 32) ? 4'd0 :
                        (({ch_rr, idle_vec} == 33) ? 4'd1 :
                        (({ch_rr, idle_vec} == 34) ? 4'd2 :
                        (({ch_rr, idle_vec} == 35) ? 4'd1 :
                        (({ch_rr, idle_vec} == 36) ? 4'd4 :
                        (({ch_rr, idle_vec} == 37) ? 4'd4 :
                        (({ch_rr, idle_vec} == 38) ? 4'd4 :
                        (({ch_rr, idle_vec} == 39) ? 4'd4 :
                        (({ch_rr, idle_vec} == 40) ? 4'd8 :
                        (({ch_rr, idle_vec} == 41) ? 4'd8 :
                        (({ch_rr, idle_vec} == 42) ? 4'd8 :
                        (({ch_rr, idle_vec} == 43) ? 4'd8 :
                        (({ch_rr, idle_vec} == 44) ? 4'd4 :
                        (({ch_rr, idle_vec} == 45) ? 4'd4 :
                        (({ch_rr, idle_vec} == 46) ? 4'd4 :
                        (({ch_rr, idle_vec} == 47) ? 4'd4 :
                        (({ch_rr, idle_vec} == 48) ? 4'd0 :
                        (({ch_rr, idle_vec} == 49) ? 4'd1 :
                        (({ch_rr, idle_vec} == 50) ? 4'd2 :
                        (({ch_rr, idle_vec} == 51) ? 4'd1 :
                        (({ch_rr, idle_vec} == 52) ? 4'd4 :
                        (({ch_rr, idle_vec} == 53) ? 4'd1 :
                        (({ch_rr, idle_vec} == 54) ? 4'd2 :
                        (({ch_rr, idle_vec} == 55) ? 4'd1 :
                        (({ch_rr, idle_vec} == 56) ? 4'd8 :
                        (({ch_rr, idle_vec} == 57) ? 4'd8 :
                        (({ch_rr, idle_vec} == 58) ? 4'd8 :
                        (({ch_rr, idle_vec} == 59) ? 4'd8 :
                        (({ch_rr, idle_vec} == 60) ? 4'd8 :
                        (({ch_rr, idle_vec} == 61) ? 4'd8 :
                        (({ch_rr, idle_vec} == 62) ? 4'd8 :
                        4'd8)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign ch_pick_v = (idle_vec != 0);
    assign dispatch = ((ca_v & (~sid_busy)) & ch_pick_v);
    assign ch_0_cmd_valid = (dispatch & ch_pick_oh[0]);
    assign ch_1_cmd_valid = (dispatch & ch_pick_oh[1]);
    assign ch_2_cmd_valid = (dispatch & ch_pick_oh[2]);
    assign ch_3_cmd_valid = (dispatch & ch_pick_oh[3]);
    assign cmd_smem = p_smem[ca_idx];
    assign cmd_scid = p_scid[ca_idx];
    assign cmd_saddr = p_saddr[ca_idx];
    assign cmd_dmem = p_dmem[ca_idx];
    assign cmd_dcid = p_dcid[ca_idx];
    assign cmd_daddr = p_daddr[ca_idx];
    assign cmd_rows = p_rows[ca_idx];
    assign cmd_bytes = p_bytes[ca_idx];
    assign cmd_sstride = p_sstride[ca_idx];
    assign cmd_dstride = p_dstride[ca_idx];
    assign cand_idx = (dispatch ? (w_rp + 1) : w_rp);
    assign cand_v = (w_n > {5'd0, dispatch});
    assign dbg_win_n = w_n;
    assign dbg_sid_used = {ch_sid_v_3, ch_sid_v_2, ch_sid_v_1, ch_sid_v_0};
    assign dbg_state = (dispatch ? 3'd1 :
                       ((ca_v & sid_busy) ? 3'd4 :
                       ((ca_v & (~ch_pick_v)) ? 3'd5 :
                       (ca_v ? 3'd3 :
                       3'd0))));
    assign busy = ((w_n != 0) | sc_valid);
    assign idx = w_wp;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ch_sid_v_0 <= 0;
            ch_sid_0 <= 0;
            ch_sid_v_1 <= 0;
            ch_sid_1 <= 0;
            ch_sid_v_2 <= 0;
            ch_sid_2 <= 0;
            ch_sid_v_3 <= 0;
            ch_sid_3 <= 0;
            ca_v <= 0;
            ca_idx <= 0;
            ca_sid_v <= 0;
            ca_sid <= 0;
            ch_rr <= 0;
            w_rp <= 0;
            w_wp <= 0;
            w_n <= 0;
        end else begin
            if (ch_0_rel) begin
                ch_sid_v_0 <= 0;
            end
            if ((dispatch & ch_pick_oh[0])) begin
                ch_sid_v_0 <= ca_sid_v;
                ch_sid_0 <= ca_sid;
            end
            if (ch_1_rel) begin
                ch_sid_v_1 <= 0;
            end
            if ((dispatch & ch_pick_oh[1])) begin
                ch_sid_v_1 <= ca_sid_v;
                ch_sid_1 <= ca_sid;
            end
            if (ch_2_rel) begin
                ch_sid_v_2 <= 0;
            end
            if ((dispatch & ch_pick_oh[2])) begin
                ch_sid_v_2 <= ca_sid_v;
                ch_sid_2 <= ca_sid;
            end
            if (ch_3_rel) begin
                ch_sid_v_3 <= 0;
            end
            if ((dispatch & ch_pick_oh[3])) begin
                ch_sid_v_3 <= ca_sid_v;
                ch_sid_3 <= ca_sid;
            end
            ca_v <= cand_v;
            ca_idx <= cand_idx;
            ca_sid_v <= p_sid_v[cand_idx];
            ca_sid <= p_sid[cand_idx];
            if (dispatch) begin
                ch_rr <= ch_pick_idx;
                w_rp <= (w_rp + 1);
            end
            if (enq_ok) begin
                w_wp <= (w_wp + 1);
            end
            w_n <= ((w_n + {5'd0, enq_ok}) - {5'd0, dispatch});
        end
    end
    always_ff @(posedge clk) begin
        if (enq_ok) begin
            p_smem[idx] <= sc_smem;
            p_scid[idx] <= sc_scid;
            p_saddr[idx] <= sc_saddr;
            p_dmem[idx] <= sc_dmem;
            p_dcid[idx] <= sc_dcid;
            p_daddr[idx] <= sc_daddr;
            p_rows[idx] <= sc_rows;
            p_bytes[idx] <= sc_bytes;
            p_sstride[idx] <= sc_sstride;
            p_dstride[idx] <= sc_dstride;
            p_sid_v[idx] <= sc_sid_v;
            p_sid[idx] <= sc_sid;
        end
    end
    // RawBlock(initial) — forward-direction artifact, preserved verbatim:
    initial begin
        for (int _i = 0; _i < 32; _i++) begin
            p_smem[_i] = 0; p_scid[_i] = 0; p_saddr[_i] = 0; p_dmem[_i] = 0; p_dcid[_i] = 0; p_daddr[_i] = 0;
            p_rows[_i] = 0; p_bytes[_i] = 0; p_sstride[_i] = 0; p_dstride[_i] = 0; p_sid_v[_i] = 0; p_sid[_i] = 0;
        end
    end
endmodule
