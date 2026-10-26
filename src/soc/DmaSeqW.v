module DmaSeqW (
    input clk,
    input rst_n,
    input isram_we,
    input [11:0] isram_waddr,
    input [31:0] isram_wdata,
    input launch_valid,
    input [15:0] launch_kid,
    input [23:0] launch_off,
    input [15:0] launch_len,
    output logic launch_ready,
    output logic sc_smem,
    output logic [7:0] sc_scid,
    output logic [31:0] sc_saddr,
    output logic sc_dmem,
    output logic [7:0] sc_dcid,
    output logic [31:0] sc_daddr,
    output logic [15:0] sc_rows,
    output logic [19:0] sc_bytes,
    output logic [19:0] sc_sstride,
    output logic [19:0] sc_dstride,
    output logic sc_valid,
    input sc_ready,
    output logic busy,
    output logic [15:0] dbg_groups_left
);
    logic [31:0] im0 [0:1023];
    logic [31:0] im1 [0:1023];
    logic [31:0] im2 [0:1023];
    logic [31:0] im3 [0:1023];
    logic [127:0] rd_q;
    logic ls_v;
    logic [15:0] ls_kid;
    logic [23:0] ls_off;
    logic [15:0] ls_len;
    logic scv;
    logic sc_smem_q;
    logic [7:0] sc_scid_q;
    logic [31:0] sc_saddr_q;
    logic sc_dmem_q;
    logic [7:0] sc_dcid_q;
    logic [31:0] sc_daddr_q;
    logic [15:0] sc_rows_q;
    logic [19:0] sc_bytes_q;
    logic [19:0] sc_sstride_q;
    logic [19:0] sc_dstride_q;
    logic [9:0] wr_addr;
    logic take;
    logic lc_go;
    logic wbusy;
    logic [127:0] bw;
    logic bw_smem;
    logic [5:0] svid;
    logic [27:0] bw_soff;
    logic bw_dmem;
    logic [5:0] dvid;
    logic [21:0] bw_doff;
    logic [31:0] sv;
    logic [31:0] dv;
    logic [7:0] s_cid;
    logic [7:0] d_cid;
    logic [31:0] s_l1;
    logic [31:0] d_l1;
    logic [31:0] s_eff;
    logic [31:0] d_eff;
    logic [1:0] lane;
    logic [9:0] row;
    logic [11:0] u_w_im_addr;
    logic u_w_lc_ready;
    logic u_w_busy;
    logic [127:0] u_w_out_inst;
    logic [31:0] u_w_rda_val;
    logic [31:0] u_w_rdb_val;
    logic u_w_im_req;
    logic u_w_out_v;

    initial begin
        for (int _i = 0; _i < 1024; _i++) im0[_i] = 0;
        for (int _i = 0; _i < 1024; _i++) im1[_i] = 0;
        for (int _i = 0; _i < 1024; _i++) im2[_i] = 0;
        for (int _i = 0; _i < 1024; _i++) im3[_i] = 0;
    end

    assign launch_ready = (~ls_v);
    assign sc_valid = scv;
    assign sc_smem = sc_smem_q;
    assign sc_scid = sc_scid_q;
    assign sc_saddr = sc_saddr_q;
    assign sc_dmem = sc_dmem_q;
    assign sc_dcid = sc_dcid_q;
    assign sc_daddr = sc_daddr_q;
    assign sc_rows = sc_rows_q;
    assign sc_bytes = sc_bytes_q;
    assign sc_sstride = sc_sstride_q;
    assign sc_dstride = sc_dstride_q;
    assign busy = ((ls_v | wbusy) | scv);
    assign dbg_groups_left = 16'd0;
    assign take = ((~scv) | sc_ready);
    assign wr_addr = u_w_im_addr[9:0];
    assign lc_go = (ls_v & u_w_lc_ready);
    assign wbusy = u_w_busy;
    assign bw = u_w_out_inst;
    assign bw_smem = bw[5];
    assign svid = bw[12:7];
    assign bw_soff = bw[42:15];
    assign bw_dmem = bw[43];
    assign dvid = bw[50:45];
    assign bw_doff = bw[74:53];
    assign sv = u_w_rda_val;
    assign dv = u_w_rdb_val;
    assign s_cid = (({2'd0, sv[28:23]} * 4) + {5'd0, sv[22:20]});
    assign d_cid = (({2'd0, dv[28:23]} * 4) + {5'd0, dv[22:20]});
    assign s_l1 = {4'd0, s_cid, (sv[19:0] + bw_soff[19:0])};
    assign d_l1 = {4'd0, d_cid, (dv[19:0] + bw_doff[19:0])};
    assign s_eff = (bw_smem ? (sv + {4'd0, bw_soff}) : s_l1);
    assign d_eff = (bw_dmem ? (dv + {10'd0, bw_doff}) : d_l1);
    assign lane = isram_waddr[1:0];
    assign row = isram_waddr[11:2];
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            rd_q <= 0;
            ls_v <= 0;
            ls_kid <= 0;
            ls_off <= 0;
            ls_len <= 0;
            scv <= 0;
            sc_smem_q <= 0;
            sc_scid_q <= 0;
            sc_saddr_q <= 0;
            sc_dmem_q <= 0;
            sc_dcid_q <= 0;
            sc_daddr_q <= 0;
            sc_rows_q <= 0;
            sc_bytes_q <= 0;
            sc_sstride_q <= 0;
            sc_dstride_q <= 0;
        end else begin
            if (isram_we) begin
                if ((lane == 0)) begin
                    im0[row] <= isram_wdata;
                end else begin
                    if ((lane == 1)) begin
                        im1[row] <= isram_wdata;
                    end else begin
                        if ((lane == 2)) begin
                            im2[row] <= isram_wdata;
                        end else begin
                            im3[row] <= isram_wdata;
                        end
                    end
                end
            end
            if (u_w_im_req) begin
                rd_q <= {im3[wr_addr], im2[wr_addr], im1[wr_addr], im0[wr_addr]};
            end
            if ((launch_valid & (~ls_v))) begin
                ls_v <= 1;
                ls_kid <= launch_kid;
                ls_off <= launch_off;
                ls_len <= launch_len;
            end else begin
                if ((ls_v & u_w_lc_ready)) begin
                    ls_v <= 0;
                end
            end
            if ((scv & sc_ready)) begin
                scv <= 0;
            end
            if ((u_w_out_v & take)) begin
                scv <= 1;
                sc_smem_q <= bw_smem;
                sc_scid_q <= s_eff[27:20];
                sc_saddr_q <= s_eff;
                sc_dmem_q <= bw_dmem;
                sc_dcid_q <= d_eff[27:20];
                sc_daddr_q <= d_eff;
                sc_rows_q <= {9'd0, bw[81:75]};
                sc_bytes_q <= {2'd0, bw[99:82]};
                sc_sstride_q <= {6'd0, bw[113:100]};
                sc_dstride_q <= {6'd0, bw[127:114]};
            end
        end
    end

    KSeqWalker u_w (
        .clk(clk),
        .rst_n(rst_n),
        .im_data(rd_q),
        .lc_v(lc_go),
        .lc_id(ls_kid),
        .lc_first(ls_off),
        .lc_len(ls_len),
        .out_rdy(take),
        .rd_idx(6'd0),
        .rda_idx(svid),
        .rdb_idx(dvid),
        .inval(isram_we),
        .im_addr(u_w_im_addr),
        .lc_ready(u_w_lc_ready),
        .busy(u_w_busy),
        .out_inst(u_w_out_inst),
        .rda_val(u_w_rda_val),
        .rdb_val(u_w_rdb_val),
        .im_req(u_w_im_req),
        .out_v(u_w_out_v)
    );
endmodule
