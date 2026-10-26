module CpuHost (
    input clk,
    input rst_n,
    input hs_valid,
    input [3:0] hs_op,
    input [31:0] hs_addr,
    input [31:0] hs_wdata,
    input [11:0] hs_tag,
    input hr_ready,
    input [31:0] csr_rdata,
    input hq_ready,
    input cdma_busy,
    input [31:0] core_pc,
    input [31:0] x_rdata,
    input stopped,
    input lm_grant,
    input [31:0] lm_rdata,
    output logic hs_ready,
    output logic hr_valid,
    output logic [31:0] hr_data,
    output logic [11:0] hr_tag,
    output logic [11:0] csr_addr,
    output logic csr_gp,
    output logic [4:0] csr_gi,
    output logic [31:0] csr_wdata,
    output logic csr_wen,
    output logic hq_valid,
    output logic [2:0] hq_kind,
    output logic [31:0] hq_data,
    output logic [4:0] x_idx,
    output logic x_wen,
    output logic pc_wen,
    output logic [31:0] dbg_wdata,
    output logic lm_re,
    output logic lm_we,
    output logic [13:0] lm_addr,
    output logic lm_rom,
    output logic lm_dlm,
    output logic lm_ilm,
    output logic [31:0] lm_wdata
);
    logic e_op [0:1];
    logic [31:0] e_addr [0:1];
    logic [31:0] e_wdata [0:1];
    logic [11:0] e_tag [0:1];
    logic e_rp;
    logic e_wp;
    logic [1:0] e_cnt;
    logic [31:0] r_data [0:1];
    logic [11:0] r_tag [0:1];
    logic r_rp;
    logic r_wp;
    logic [1:0] r_cnt;
    logic x_v;
    logic x_op;
    logic [31:0] x_addr;
    logic [31:0] x_wd;
    logic [11:0] x_tag;
    logic x_csrw;
    logic x_cdma;
    logic x_gp;
    logic [4:0] x_gi;
    logic x_cdmawr;
    logic x_pc;
    logic x_x;
    logic x_lm;
    logic x_rlm;
    logic x_rom;
    logic x_dlm;
    logic x_ilm;
    logic [13:0] x_lma;
    logic x_hq_ack;
    logic x_lm_ack;
    logic h_act;
    logic h_op_w;
    logic [31:0] h_addr_w;
    logic in_csrw;
    logic [11:0] h_num;
    logic csr_cdma;
    logic [5:0] h_gidx;
    logic in_pc;
    logic in_x;
    logic in_rom;
    logic in_dlm;
    logic in_ilm;
    logic in_lm;
    logic x_load;
    logic [11:0] csr_num;
    logic [5:0] x_i6;
    logic x_room;
    logic x_imm;
    logic x_done;
    logic [31:0] h_rd_other;
    logic [31:0] h_rd_val;
    logic e_push;
    logic r_pop;

    initial begin
        for (int _i = 0; _i < 2; _i++) e_op[_i] = 0;
        for (int _i = 0; _i < 2; _i++) e_addr[_i] = 0;
        for (int _i = 0; _i < 2; _i++) e_wdata[_i] = 0;
        for (int _i = 0; _i < 2; _i++) e_tag[_i] = 0;
        for (int _i = 0; _i < 2; _i++) r_data[_i] = 0;
        for (int _i = 0; _i < 2; _i++) r_tag[_i] = 0;
    end

    assign h_act = (e_cnt != 0);
    assign h_op_w = e_op[e_rp];
    assign h_addr_w = e_addr[e_rp];
    assign in_csrw = (h_addr_w[31:14] == 128);
    assign h_num = h_addr_w[13:2];
    assign csr_cdma = (h_num[11:6] == 47);
    assign h_gidx = (h_num[5:0] - 16);
    assign in_pc = (h_addr_w == 32'd2113536);
    assign in_x = ((h_addr_w >= 32'd2113540) & (h_addr_w <= 32'd2113667));
    assign in_rom = (h_addr_w[31:12] == 256);
    assign in_dlm = (h_addr_w[31:14] == 256);
    assign in_ilm = ((h_addr_w >= 32'd8388608) & (h_addr_w < 32'd8437760));
    assign in_lm = ((in_rom | in_dlm) | in_ilm);
    assign x_load = (h_act & (~x_v));
    assign csr_num = x_addr[13:2];
    assign x_i6 = (x_addr[7:2] - 1);
    assign x_room = (r_cnt != 2);
    assign x_imm = (((x_v & x_room) & (~x_lm)) & (~(x_op & x_cdmawr)));
    assign x_done = ((x_imm | x_hq_ack) | x_lm_ack);
    assign h_rd_other = (x_op ? 0 :
                        (x_csrw ? (x_cdma ? ((csr_num == 3013) ? {31'd0, cdma_busy} : 0) : csr_rdata) :
                        (x_pc ? core_pc :
                        (x_x ? x_rdata :
                        0))));
    assign h_rd_val = (x_rlm ? lm_rdata : h_rd_other);
    assign hs_ready = (e_cnt != 2);
    assign hr_valid = (r_cnt != 0);
    assign hr_data = r_data[r_rp];
    assign hr_tag = r_tag[r_rp];
    assign csr_addr = csr_num;
    assign csr_gp = x_gp;
    assign csr_gi = x_gi;
    assign csr_wdata = x_wd;
    assign csr_wen = (((x_imm & x_op) & x_csrw) & (~x_cdma));
    assign hq_valid = ((((x_v & x_room) & x_op) & x_cdmawr) & (~x_hq_ack));
    assign hq_kind = csr_num[2:0];
    assign hq_data = x_wd;
    assign x_idx = x_i6[4:0];
    assign x_wen = (((x_imm & x_op) & x_x) & stopped);
    assign pc_wen = (((x_imm & x_op) & x_pc) & stopped);
    assign dbg_wdata = x_wd;
    assign lm_re = ((((x_v & x_room) & x_lm) & (~x_op)) & (~x_lm_ack));
    assign lm_we = ((((x_v & x_room) & x_lm) & x_op) & (~x_lm_ack));
    assign lm_addr = x_lma;
    assign lm_rom = x_rom;
    assign lm_dlm = x_dlm;
    assign lm_ilm = x_ilm;
    assign lm_wdata = x_wd;
    assign e_push = (hs_valid & (e_cnt != 2));
    assign r_pop = ((r_cnt != 0) & hr_ready);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            e_wp <= 0;
            e_rp <= 0;
            x_v <= 0;
            x_op <= 0;
            x_addr <= 0;
            x_wd <= 0;
            x_tag <= 0;
            x_csrw <= 0;
            x_cdma <= 0;
            x_gp <= 0;
            x_gi <= 16;
            x_cdmawr <= 0;
            x_pc <= 0;
            x_x <= 0;
            x_lm <= 0;
            x_rlm <= 0;
            x_rom <= 0;
            x_dlm <= 0;
            x_ilm <= 0;
            x_lma <= 0;
            e_cnt <= 0;
            x_hq_ack <= 0;
            x_lm_ack <= 0;
            r_wp <= 0;
            r_rp <= 0;
            r_cnt <= 0;
        end else begin
            if (e_push) begin
                e_op[e_wp] <= hs_op[0];
                e_addr[e_wp] <= hs_addr;
                e_wdata[e_wp] <= hs_wdata;
                e_tag[e_wp] <= hs_tag;
                e_wp <= (e_wp + 1);
            end
            if (x_load) begin
                e_rp <= (e_rp + 1);
                x_v <= 1;
                x_op <= h_op_w;
                x_addr <= h_addr_w;
                x_wd <= e_wdata[e_rp];
                x_tag <= e_tag[e_rp];
                x_csrw <= in_csrw;
                x_cdma <= csr_cdma;
                x_gp <= ((h_num >= 2000) & (h_num <= 2031));
                x_gi <= h_gidx[4:0];
                x_cdmawr <= ((in_csrw & csr_cdma) & (h_num[5:0] <= 4));
                x_pc <= in_pc;
                x_x <= in_x;
                x_lm <= in_lm;
                x_rlm <= ((((in_lm & (~h_op_w)) & (~in_csrw)) & (~in_pc)) & (~in_x));
                x_rom <= in_rom;
                x_dlm <= in_dlm;
                x_ilm <= in_ilm;
                x_lma <= h_addr_w[15:2];
            end
            if ((e_push & (~x_load))) begin
                e_cnt <= (e_cnt + 1);
            end else begin
                if ((x_load & (~e_push))) begin
                    e_cnt <= (e_cnt - 1);
                end
            end
            x_hq_ack <= (hq_valid & hq_ready);
            x_lm_ack <= ((lm_re | lm_we) & lm_grant);
            if (x_done) begin
                x_v <= 0;
                r_data[r_wp] <= h_rd_val;
                r_tag[r_wp] <= x_tag;
                r_wp <= (r_wp + 1);
            end
            if (r_pop) begin
                r_rp <= (r_rp + 1);
            end
            if ((x_done & (~r_pop))) begin
                r_cnt <= (r_cnt + 1);
            end else begin
                if ((r_pop & (~x_done))) begin
                    r_cnt <= (r_cnt - 1);
                end
            end
        end
    end
endmodule
