module NocDramModel #(
    parameter HIT_LAT = 30,
    parameter MISS_LAT = 40,
    parameter DRAM_NUM = 3,
    parameter DRAM_DEN_W = 2
) (
    input clk,
    input rst_n,
    input s_ar_valid,
    output logic s_ar_ready,
    input [7:0] s_ar_id,
    input [47:0] s_ar_addr,
    input [7:0] s_ar_len,
    input s_aw_valid,
    output logic s_aw_ready,
    input [7:0] s_aw_id,
    input [47:0] s_aw_addr,
    input [7:0] s_aw_len,
    input s_w_valid,
    output logic s_w_ready,
    input [511:0] s_w_data,
    input [63:0] s_w_strb,
    input s_w_last,
    output logic s_b_valid,
    input s_b_ready,
    output logic [7:0] s_b_id,
    output logic s_r_valid,
    input s_r_ready,
    output logic [7:0] s_r_id,
    output logic [511:0] s_r_data,
    output logic s_r_last,
    input h_we,
    input h_re,
    input [15:0] h_addr,
    input [31:0] h_wdata,
    output logic h_ready,
    output logic h_rvalid,
    output logic [31:0] h_rdata,
    output logic [31:0] dbg_row_hit,
    output logic [31:0] dbg_row_miss,
    output logic busy
);
    logic [7:0] arq_id [0:15];
    logic [47:0] arq_addr [0:15];
    logic [7:0] arq_len [0:15];
    logic [31:0] arq_due [0:15];
    logic [31:0] tick;
    logic [35:0] dram_free;
    logic [3:0] ar_wp;
    logic [3:0] ar_rp;
    logic [4:0] ar_cnt;
    logic [7:0] awq_id [0:3];
    logic [47:0] awq_addr [0:3];
    logic [1:0] aw_wp;
    logic [1:0] aw_rp;
    logic [2:0] aw_cnt;
    logic [7:0] w_beat;
    logic rd_act;
    logic [7:0] rd_id;
    logic [47:0] rd_addr;
    logic [7:0] rd_left;
    logic rv_q;
    logic rlast_q;
    logic [7:0] rid_q;
    logic [15:0] row_0;
    logic [15:0] row_1;
    logic [15:0] row_2;
    logic [15:0] row_3;
    logic [15:0] row_4;
    logic [15:0] row_5;
    logic [15:0] row_6;
    logic [15:0] row_7;
    logic [7:0] rowv;
    logic bv_q;
    logic [7:0] bid_q;
    logic h_rdv;
    logic [3:0] h_word;
    logic [31:0] c_row_hit;
    logic [31:0] c_row_miss;
    logic ar_full;
    logic aw_full;
    logic ar_push;
    logic aw_push;
    logic aw_v;
    logic [47:0] aw_haddr;
    logic [7:0] aw_hid;
    logic w_acc;
    logic [47:0] w_addr;
    logic ar_v;
    logic [47:0] ar_haddr;
    logic [7:0] ar_hid;
    logic [7:0] ar_hlen;
    logic [2:0] in_bank;
    logic [15:0] in_row;
    logic [15:0] cur_row;
    logic row_hit;
    logic [31:0] ar_hdue;
    logic [31:0] ar_lat_due;
    logic [35:0] ar_lat_f;
    logic [35:0] ar_sched_f;
    logic [31:0] ar_sched;
    logic [35:0] ar_dfrac;
    logic [3:0] ar_wp_m1;
    logic ooo_swap;
    logic [7:0] p_id;
    logic [47:0] p_addr;
    logic [7:0] p_len;
    logic [31:0] p_due;
    logic r_free;
    logic rd_go;
    logic rd_fin;
    logic rd_start;
    logic ren;
    logic [11:0] raddr;
    logic wen;
    logic [11:0] waddr;
    logic [511:0] h_wrep;
    logic [63:0] h_wstrb;
    logic [511:0] wdata_in;
    logic [63:0] wstrb_in;
    logic wdone;
    logic [511:0] u_sram_rdata;

    initial begin
        for (int _i = 0; _i < 16; _i++) arq_id[_i] = 0;
        for (int _i = 0; _i < 16; _i++) arq_addr[_i] = 0;
        for (int _i = 0; _i < 16; _i++) arq_len[_i] = 0;
        for (int _i = 0; _i < 16; _i++) arq_due[_i] = 0;
        for (int _i = 0; _i < 4; _i++) awq_id[_i] = 0;
        for (int _i = 0; _i < 4; _i++) awq_addr[_i] = 0;
    end

    assign ar_full = (ar_cnt == 16);
    assign aw_full = (aw_cnt == 4);
    assign s_ar_ready = (~ar_full);
    assign s_aw_ready = (~aw_full);
    assign ar_push = (s_ar_valid & (~ar_full));
    assign aw_push = (s_aw_valid & (~aw_full));
    assign aw_v = (aw_cnt != 0);
    assign aw_haddr = awq_addr[aw_rp];
    assign aw_hid = awq_id[aw_rp];
    assign w_acc = ((s_w_valid & aw_v) & (~h_we));
    assign s_w_ready = (aw_v & (~h_we));
    assign w_addr = (aw_haddr + {w_beat, 6'd0});
    assign ar_v = (ar_cnt != 0);
    assign ar_haddr = arq_addr[ar_rp];
    assign ar_hid = arq_id[ar_rp];
    assign ar_hlen = arq_len[ar_rp];
    assign in_bank = s_ar_addr[16:14];
    assign in_row = s_ar_addr[32:17];
    assign cur_row = ((in_bank == 0) ? row_0 :
                     ((in_bank == 1) ? row_1 :
                     ((in_bank == 2) ? row_2 :
                     ((in_bank == 3) ? row_3 :
                     ((in_bank == 4) ? row_4 :
                     ((in_bank == 5) ? row_5 :
                     ((in_bank == 6) ? row_6 :
                     row_7)))))));
    assign row_hit = (((in_bank == 0) ? rowv[0] :
                      ((in_bank == 1) ? rowv[1] :
                      ((in_bank == 2) ? rowv[2] :
                      ((in_bank == 3) ? rowv[3] :
                      ((in_bank == 4) ? rowv[4] :
                      ((in_bank == 5) ? rowv[5] :
                      ((in_bank == 6) ? rowv[6] :
                      rowv[7]))))))) & (cur_row == in_row));
    assign ar_hdue = arq_due[ar_rp];
    assign ar_lat_due = (tick + (row_hit ? HIT_LAT : MISS_LAT));
    assign ar_lat_f = ({4'd0, ar_lat_due} << DRAM_DEN_W);
    assign ar_sched_f = ((dram_free < ar_lat_f) ? ar_lat_f : dram_free);
    assign ar_sched = (((ar_sched_f + (36'd1 << DRAM_DEN_W)) - 36'd1) >> DRAM_DEN_W);
    assign ar_dfrac = (({28'd0, s_ar_len} + 36'd1) * DRAM_NUM);
    assign ar_wp_m1 = (ar_wp - 1);
    assign ooo_swap = ((1'd0 & (ar_cnt >= 2)) & tick[2]);
    assign p_id = arq_id[ar_wp_m1];
    assign p_addr = arq_addr[ar_wp_m1];
    assign p_len = arq_len[ar_wp_m1];
    assign p_due = arq_due[ar_wp_m1];
    assign r_free = ((~rv_q) | s_r_ready);
    assign rd_go = ((rd_act & r_free) & (~h_re));
    assign rd_fin = (rd_go & (rd_left == 0));
    assign rd_start = ((((~rd_act) | rd_fin) & ar_v) & (tick >= ar_hdue));
    assign s_r_valid = rv_q;
    assign s_r_last = rlast_q;
    assign s_r_id = rid_q;
    assign s_b_valid = bv_q;
    assign s_b_id = bid_q;
    assign h_ready = 1'd1;
    assign h_rvalid = h_rdv;
    assign ren = (rd_go | h_re);
    assign raddr = (h_re ? h_addr[15:4] : rd_addr[17:6]);
    assign wen = (w_acc | h_we);
    assign waddr = (h_we ? h_addr[15:4] : w_addr[17:6]);
    assign h_wrep = {h_wdata, h_wdata, h_wdata, h_wdata, h_wdata, h_wdata, h_wdata, h_wdata, h_wdata, h_wdata, h_wdata,
                     h_wdata, h_wdata, h_wdata, h_wdata, h_wdata};
    assign h_wstrb = (64'd15 << {h_addr[3:0], 2'd0});
    assign wdata_in = (h_we ? h_wrep : s_w_data);
    assign wstrb_in = (h_we ? h_wstrb : s_w_strb);
    assign s_r_data = u_sram_rdata;
    assign h_rdata = ((h_word == 0) ? u_sram_rdata[31:0] :
                     ((h_word == 1) ? u_sram_rdata[63:32] :
                     ((h_word == 2) ? u_sram_rdata[95:64] :
                     ((h_word == 3) ? u_sram_rdata[127:96] :
                     ((h_word == 4) ? u_sram_rdata[159:128] :
                     ((h_word == 5) ? u_sram_rdata[191:160] :
                     ((h_word == 6) ? u_sram_rdata[223:192] :
                     ((h_word == 7) ? u_sram_rdata[255:224] :
                     ((h_word == 8) ? u_sram_rdata[287:256] :
                     ((h_word == 9) ? u_sram_rdata[319:288] :
                     ((h_word == 10) ? u_sram_rdata[351:320] :
                     ((h_word == 11) ? u_sram_rdata[383:352] :
                     ((h_word == 12) ? u_sram_rdata[415:384] :
                     ((h_word == 13) ? u_sram_rdata[447:416] :
                     ((h_word == 14) ? u_sram_rdata[479:448] :
                     u_sram_rdata[511:480])))))))))))))));
    assign dbg_row_hit = c_row_hit;
    assign dbg_row_miss = c_row_miss;
    assign busy = ((((rd_act | ar_v) | aw_v) | rv_q) | bv_q);
    assign wdone = (w_acc & s_w_last);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            tick <= 0;
            ar_wp <= 0;
            dram_free <= 0;
            c_row_hit <= 0;
            c_row_miss <= 0;
            rowv <= 0;
            row_0 <= 0;
            row_1 <= 0;
            row_2 <= 0;
            row_3 <= 0;
            row_4 <= 0;
            row_5 <= 0;
            row_6 <= 0;
            row_7 <= 0;
            ar_cnt <= 0;
            rv_q <= 0;
            rid_q <= 0;
            rlast_q <= 0;
            rd_addr <= 0;
            rd_left <= 0;
            rd_act <= 0;
            ar_rp <= 0;
            rd_id <= 0;
            aw_wp <= 0;
            bv_q <= 0;
            w_beat <= 0;
            aw_rp <= 0;
            bid_q <= 0;
            aw_cnt <= 0;
            h_rdv <= 0;
            h_word <= 0;
        end else begin
            tick <= (tick + 1);
            if (ar_push) begin
                if (ooo_swap) begin
                    arq_id[ar_wp_m1] <= s_ar_id;
                    arq_addr[ar_wp_m1] <= s_ar_addr;
                    arq_len[ar_wp_m1] <= s_ar_len;
                    arq_due[ar_wp_m1] <= ar_sched;
                    arq_id[ar_wp] <= p_id;
                    arq_addr[ar_wp] <= p_addr;
                    arq_len[ar_wp] <= p_len;
                    arq_due[ar_wp] <= p_due;
                end else begin
                    arq_id[ar_wp] <= s_ar_id;
                    arq_addr[ar_wp] <= s_ar_addr;
                    arq_len[ar_wp] <= s_ar_len;
                    arq_due[ar_wp] <= ar_sched;
                end
                ar_wp <= (ar_wp + 1);
                dram_free <= (ar_sched_f + ar_dfrac);
                if (row_hit) begin
                    c_row_hit <= (c_row_hit + 1);
                end else begin
                    c_row_miss <= (c_row_miss + 1);
                end
                rowv <= (rowv | (8'd1 << in_bank));
                if ((in_bank == 0)) begin
                    row_0 <= in_row;
                end
                if ((in_bank == 1)) begin
                    row_1 <= in_row;
                end
                if ((in_bank == 2)) begin
                    row_2 <= in_row;
                end
                if ((in_bank == 3)) begin
                    row_3 <= in_row;
                end
                if ((in_bank == 4)) begin
                    row_4 <= in_row;
                end
                if ((in_bank == 5)) begin
                    row_5 <= in_row;
                end
                if ((in_bank == 6)) begin
                    row_6 <= in_row;
                end
                if ((in_bank == 7)) begin
                    row_7 <= in_row;
                end
            end
            ar_cnt <= ((ar_cnt + {4'd0, ar_push}) - {4'd0, rd_start});
            if (rd_go) begin
                rv_q <= 1;
                rid_q <= rd_id;
                rlast_q <= (rd_left == 0);
                rd_addr <= (rd_addr + 64);
                rd_left <= (rd_left - 1);
                if ((rd_left == 0)) begin
                    rd_act <= 0;
                end
            end else begin
                if ((rv_q & s_r_ready)) begin
                    rv_q <= 0;
                end
            end
            if (rd_start) begin
                ar_rp <= (ar_rp + 1);
                rd_act <= 1;
                rd_id <= ar_hid;
                rd_addr <= ar_haddr;
                rd_left <= ar_hlen;
            end
            if (aw_push) begin
                awq_id[aw_wp] <= s_aw_id;
                awq_addr[aw_wp] <= s_aw_addr;
                aw_wp <= (aw_wp + 1);
            end
            bv_q <= (bv_q & (~s_b_ready));
            if (w_acc) begin
                if (s_w_last) begin
                    w_beat <= 0;
                    aw_rp <= (aw_rp + 1);
                    bv_q <= 1;
                    bid_q <= aw_hid;
                end else begin
                    w_beat <= (w_beat + 1);
                end
            end
            aw_cnt <= ((aw_cnt + {2'd0, aw_push}) - {2'd0, wdone});
            h_rdv <= h_re;
            if (h_re) begin
                h_word <= h_addr[3:0];
            end
        end
    end

    NocDramSram u_sram (
        .clk(clk),
        .wen(wen),
        .waddr(waddr),
        .wdata(wdata_in),
        .wstrb(wstrb_in),
        .ren(ren),
        .raddr(raddr),
        .rdata(u_sram_rdata)
    );
endmodule
