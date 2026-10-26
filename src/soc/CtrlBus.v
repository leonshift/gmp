module CtrlBus (
    input clk,
    input rst_n,
    input m_0_cm_valid,
    output logic m_0_cm_ready,
    input [31:0] m_0_cm_addr,
    input [31:0] m_0_cm_wdata,
    input m_0_cm_write,
    input [23:0] m_0_cm_tag,
    output logic m_0_cr_valid,
    input m_0_cr_ready,
    output logic [31:0] m_0_cr_data,
    output logic [23:0] m_0_cr_tag,
    input m_1_cm_valid,
    output logic m_1_cm_ready,
    input [31:0] m_1_cm_addr,
    input [31:0] m_1_cm_wdata,
    input m_1_cm_write,
    input [23:0] m_1_cm_tag,
    output logic m_1_cr_valid,
    input m_1_cr_ready,
    output logic [31:0] m_1_cr_data,
    output logic [23:0] m_1_cr_tag,
    output logic s_0_cm_valid,
    input s_0_cm_ready,
    output logic [31:0] s_0_cm_addr,
    output logic [31:0] s_0_cm_wdata,
    output logic s_0_cm_write,
    output logic [23:0] s_0_cm_tag,
    input s_0_cr_valid,
    output logic s_0_cr_ready,
    input [31:0] s_0_cr_data,
    input [23:0] s_0_cr_tag,
    output logic s_1_cm_valid,
    input s_1_cm_ready,
    output logic [31:0] s_1_cm_addr,
    output logic [31:0] s_1_cm_wdata,
    output logic s_1_cm_write,
    output logic [23:0] s_1_cm_tag,
    input s_1_cr_valid,
    output logic s_1_cr_ready,
    input [31:0] s_1_cr_data,
    input [23:0] s_1_cr_tag,
    output logic s_2_cm_valid,
    input s_2_cm_ready,
    output logic [31:0] s_2_cm_addr,
    output logic [31:0] s_2_cm_wdata,
    output logic s_2_cm_write,
    output logic [23:0] s_2_cm_tag,
    input s_2_cr_valid,
    output logic s_2_cr_ready,
    input [31:0] s_2_cr_data,
    input [23:0] s_2_cr_tag,
    output logic s_3_cm_valid,
    input s_3_cm_ready,
    output logic [31:0] s_3_cm_addr,
    output logic [31:0] s_3_cm_wdata,
    output logic s_3_cm_write,
    output logic [23:0] s_3_cm_tag,
    input s_3_cr_valid,
    output logic s_3_cr_ready,
    input [31:0] s_3_cr_data,
    input [23:0] s_3_cr_tag,
    output logic [3:0] dbg_route_target,
    output logic [7:0] dbg_inflight,
    output logic [3:0] dbg_slave_ready,
    output logic [15:0] dbg_cfg_ack_age
);
    logic rq_v;
    logic [31:0] rq_addr;
    logic [31:0] rq_wdata;
    logic rq_write;
    logic [23:0] rq_tag;
    logic req_rr;
    logic sk_v;
    logic [31:0] sk_addr;
    logic [31:0] sk_wdata;
    logic sk_write;
    logic [23:0] sk_tag;
    logic rt_v;
    logic [3:0] rt_sel;
    logic [31:0] rt_addr;
    logic [31:0] rt_wdata;
    logic rt_write;
    logic [23:0] rt_tag;
    logic lane_0_v0;
    logic lane_0_v1;
    logic lane_0_v2;
    logic lane_0_v3;
    logic lane_0_free0;
    logic lane_0_free1;
    logic lane_0_free2;
    logic lane_0_free3;
    logic lane_0_take0;
    logic lane_0_take1;
    logic lane_0_take2;
    logic lane_0_take3;
    logic lane_1_v0;
    logic lane_1_v1;
    logic lane_1_v2;
    logic lane_1_v3;
    logic lane_1_free0;
    logic lane_1_free1;
    logic lane_1_free2;
    logic lane_1_free3;
    logic lane_1_take0;
    logic lane_1_take1;
    logic lane_1_take2;
    logic lane_1_take3;
    logic [31:0] l0_addr [0:3];
    logic [31:0] l0_wdata [0:3];
    logic l0_write [0:3];
    logic [23:0] l0_tag [0:3];
    logic [31:0] l1_addr [0:3];
    logic [31:0] l1_wdata [0:3];
    logic l1_write [0:3];
    logic [23:0] l1_tag [0:3];
    logic [15:0] age_0;
    logic [15:0] age_1;
    logic [15:0] age_2;
    logic [15:0] age_3;
    logic hole_v;
    logic [23:0] hole_tag;
    logic pv_0;
    logic pv_1;
    logic pv_2;
    logic pv_3;
    logic pv_4;
    logic [31:0] pd_0;
    logic [31:0] pd_1;
    logic [31:0] pd_2;
    logic [31:0] pd_3;
    logic [31:0] pd_4;
    logic [23:0] pt_0;
    logic [23:0] pt_1;
    logic [23:0] pt_2;
    logic [23:0] pt_3;
    logic [23:0] pt_4;
    logic qv_0;
    logic qv_1;
    logic qv_2;
    logic qv_3;
    logic qv_4;
    logic [31:0] qd_0;
    logic [31:0] qd_1;
    logic [31:0] qd_2;
    logic [31:0] qd_3;
    logic [31:0] qd_4;
    logic [23:0] qt_0;
    logic [23:0] qt_1;
    logic [23:0] qt_2;
    logic [23:0] qt_3;
    logic [23:0] qt_4;
    logic [2:0] resp_rr;
    logic lk_v;
    logic [2:0] lk_sel;
    logic rlane_0_v0;
    logic rlane_0_v1;
    logic rlane_0_free0;
    logic rlane_0_free1;
    logic rlane_0_take0;
    logic rlane_0_take1;
    logic rlane_1_v0;
    logic rlane_1_v1;
    logic rlane_1_free0;
    logic rlane_1_free1;
    logic rlane_1_take0;
    logic rlane_1_take1;
    logic [31:0] r0_data [0:1];
    logic [23:0] r0_tag [0:1];
    logic [31:0] r1_data [0:1];
    logic [23:0] r1_tag [0:1];
    logic mfire_0;
    logic mfire_1;
    logic hole_take;
    logic [2:0] rr_sel;
    logic [2:0] m4_sel;
    logic m4_any;
    logic [31:0] m4_data;
    logic [23:0] m4_tag;
    logic [3:0] rc_dst;
    logic rc_bad;
    logic rc_ok;
    logic m4_fire;
    logic m4_take_0;
    logic m4_take_1;
    logic m4_take_2;
    logic m4_take_3;
    logic m4_take_4;
    logic sfire_0;
    logic sfire_1;
    logic sfire_2;
    logic sfire_3;
    logic rt_hole;
    logic rt_lane_ok;
    logic hole_free;
    logic m3_take;
    logic hole_load;
    logic rt_ready;
    logic m2_take;
    logic [15:0] rq_hi16;
    logic decs_0;
    logic decs_1;
    logic decs_2;
    logic decs_3;
    logic [3:0] dec;
    logic m1_sel;
    logic m1_any;
    logic m1_fire;
    logic [31:0] m1_addr;
    logic [31:0] m1_wdata;
    logic m1_write;
    logic [23:0] m1_tag;
    logic [23:0] m1_tag_mid;
    logic [23:0] mb_tag_0;
    logic [23:0] mb_tag_1;
    logic [15:0] age_mx_0;
    logic [15:0] age_mx_1;
    logic [15:0] age_mx_2;
    logic in_v__j0;
    logic [31:0] in_d__j0;
    logic [23:0] in_t__j0;
    logic in_fire__j0;
    logic in_v__j1;
    logic [31:0] in_d__j1;
    logic [23:0] in_t__j1;
    logic in_fire__j1;
    logic in_v__j2;
    logic [31:0] in_d__j2;
    logic [23:0] in_t__j2;
    logic in_fire__j2;
    logic in_v__j3;
    logic [31:0] in_d__j3;
    logic [23:0] in_t__j3;
    logic in_fire__j3;
    logic in_v__j4;
    logic [31:0] in_d__j4;
    logic [23:0] in_t__j4;
    logic in_fire__j4;

    assign mfire_0 = (rlane_1_v0 & m_0_cr_ready);
    assign rlane_1_free0 = ((~rlane_1_v0) | mfire_0);
    assign rlane_1_take0 = (rlane_0_v0 & rlane_1_free0);
    assign rlane_0_free0 = ((~rlane_0_v0) | rlane_1_take0);
    assign mfire_1 = (rlane_1_v1 & m_1_cr_ready);
    assign rlane_1_free1 = ((~rlane_1_v1) | mfire_1);
    assign rlane_1_take1 = (rlane_0_v1 & rlane_1_free1);
    assign rlane_0_free1 = ((~rlane_0_v1) | rlane_1_take1);
    assign s_0_cr_ready = (~qv_0);
    assign s_1_cr_ready = (~qv_1);
    assign s_2_cr_ready = (~qv_2);
    assign s_3_cr_ready = (~qv_3);
    assign hole_take = (hole_v & (~qv_4));
    assign rr_sel = ((resp_rr == 0) ? (pv_0 ? 0 : (pv_1 ? 1 : (pv_2 ? 2 : (pv_3 ? 3 : (pv_4 ? 4 : 0))))) :
                    ((resp_rr == 1) ? (pv_1 ? 1 : (pv_2 ? 2 : (pv_3 ? 3 : (pv_4 ? 4 : (pv_0 ? 0 : 0))))) :
                    ((resp_rr == 2) ? (pv_2 ? 2 : (pv_3 ? 3 : (pv_4 ? 4 : (pv_0 ? 0 : (pv_1 ? 1 : 0))))) :
                    ((resp_rr == 3) ? (pv_3 ? 3 : (pv_4 ? 4 : (pv_0 ? 0 : (pv_1 ? 1 : (pv_2 ? 2 : 0))))) :
                    (pv_4 ? 4 :
                    (pv_0 ? 0 :
                    (pv_1 ? 1 :
                    (pv_2 ? 2 :
                    (pv_3 ? 3 :
                    0)))))))));
    assign m4_sel = (lk_v ? lk_sel : rr_sel);
    assign m4_any = (lk_v | ((((pv_0 | pv_1) | pv_2) | pv_3) | pv_4));
    assign m4_data = ((m4_sel == 0) ? pd_0 :
                     ((m4_sel == 1) ? pd_1 :
                     ((m4_sel == 2) ? pd_2 :
                     ((m4_sel == 3) ? pd_3 :
                     pd_4))));
    assign m4_tag = ((m4_sel == 0) ? pt_0 :
                    ((m4_sel == 1) ? pt_1 :
                    ((m4_sel == 2) ? pt_2 :
                    ((m4_sel == 3) ? pt_3 :
                    pt_4))));
    assign rc_dst = m4_tag[23:20];
    assign rc_bad = (rc_dst >= 2);
    assign rc_ok = (((rc_dst == 0) & rlane_0_free0) | ((rc_dst == 1) & rlane_0_free1));
    assign m4_fire = (m4_any & (rc_bad | rc_ok));
    assign m4_take_0 = (m4_fire & (m4_sel == 0));
    assign m4_take_1 = (m4_fire & (m4_sel == 1));
    assign m4_take_2 = (m4_fire & (m4_sel == 2));
    assign m4_take_3 = (m4_fire & (m4_sel == 3));
    assign m4_take_4 = (m4_fire & (m4_sel == 4));
    assign rlane_0_take0 = ((m4_any & (rc_dst == 0)) & rlane_0_free0);
    assign rlane_0_take1 = ((m4_any & (rc_dst == 1)) & rlane_0_free1);
    assign sfire_0 = (lane_1_v0 & s_0_cm_ready);
    assign lane_1_free0 = ((~lane_1_v0) | sfire_0);
    assign lane_1_take0 = (lane_0_v0 & lane_1_free0);
    assign lane_0_free0 = ((~lane_0_v0) | lane_1_take0);
    assign sfire_1 = (lane_1_v1 & s_1_cm_ready);
    assign lane_1_free1 = ((~lane_1_v1) | sfire_1);
    assign lane_1_take1 = (lane_0_v1 & lane_1_free1);
    assign lane_0_free1 = ((~lane_0_v1) | lane_1_take1);
    assign sfire_2 = (lane_1_v2 & s_2_cm_ready);
    assign lane_1_free2 = ((~lane_1_v2) | sfire_2);
    assign lane_1_take2 = (lane_0_v2 & lane_1_free2);
    assign lane_0_free2 = ((~lane_0_v2) | lane_1_take2);
    assign sfire_3 = (lane_1_v3 & s_3_cm_ready);
    assign lane_1_free3 = ((~lane_1_v3) | sfire_3);
    assign lane_1_take3 = (lane_0_v3 & lane_1_free3);
    assign lane_0_free3 = ((~lane_0_v3) | lane_1_take3);
    assign rt_hole = (rt_sel == 0);
    assign rt_lane_ok = ((((rt_sel[0] & lane_0_free0) | (rt_sel[1] & lane_0_free1)) | (rt_sel[2] & lane_0_free2))
                         | (rt_sel[3] & lane_0_free3));
    assign hole_free = (~hole_v);
    assign m3_take = (rt_v & (rt_hole ? (rt_write | hole_free) : rt_lane_ok));
    assign lane_0_take0 = ((rt_v & rt_sel[0]) & lane_0_free0);
    assign lane_0_take1 = ((rt_v & rt_sel[1]) & lane_0_free1);
    assign lane_0_take2 = ((rt_v & rt_sel[2]) & lane_0_free2);
    assign lane_0_take3 = ((rt_v & rt_sel[3]) & lane_0_free3);
    assign hole_load = (((rt_v & rt_hole) & (~rt_write)) & hole_free);
    assign rt_ready = ((~rt_v) | m3_take);
    assign m2_take = (rq_v & rt_ready);
    assign rq_hi16 = rq_addr[31:16];
    assign decs_0 = (((rq_addr >= 32'd336) & (rq_addr < 32'd400)) | (rq_hi16 == 16'd512));
    assign decs_1 = (((rq_addr >= 32'd400) & (rq_addr < 32'd464)) | (rq_hi16 == 16'd513));
    assign decs_2 = (((rq_addr >= 32'd464) & (rq_addr < 32'd528)) | (rq_hi16 == 16'd514));
    assign decs_3 = ((rq_addr >= 32'd528) & (rq_addr < 32'd1552));
    assign dec = {decs_3, decs_2, decs_1, decs_0};
    assign m1_sel = ((req_rr == 0) ? (m_0_cm_valid ? 0 : (m_1_cm_valid ? 1 : 0)) :
                    (m_1_cm_valid ? 1 :
                    (m_0_cm_valid ? 0 :
                    0)));
    assign m1_any = (m_0_cm_valid | m_1_cm_valid);
    assign m1_fire = ((~sk_v) & m1_any);
    assign m_0_cm_ready = (m1_fire & (m1_sel == 0));
    assign m_1_cm_ready = (m1_fire & (m1_sel == 1));
    assign m1_addr = ((m1_sel == 0) ? m_0_cm_addr : m_1_cm_addr);
    assign m1_wdata = ((m1_sel == 0) ? m_0_cm_wdata : m_1_cm_wdata);
    assign m1_write = ((m1_sel == 0) ? m_0_cm_write : m_1_cm_write);
    assign m1_tag = ((m1_sel == 0) ? m_0_cm_tag : m_1_cm_tag);
    assign m1_tag_mid = {{3'd0, m1_sel}, m1_tag[19:0]};
    assign s_0_cm_valid = lane_1_v0;
    assign s_0_cm_addr = l1_addr[0];
    assign s_0_cm_wdata = l1_wdata[0];
    assign s_0_cm_write = l1_write[0];
    assign s_0_cm_tag = l1_tag[0];
    assign s_1_cm_valid = lane_1_v1;
    assign s_1_cm_addr = l1_addr[1];
    assign s_1_cm_wdata = l1_wdata[1];
    assign s_1_cm_write = l1_write[1];
    assign s_1_cm_tag = l1_tag[1];
    assign s_2_cm_valid = lane_1_v2;
    assign s_2_cm_addr = l1_addr[2];
    assign s_2_cm_wdata = l1_wdata[2];
    assign s_2_cm_write = l1_write[2];
    assign s_2_cm_tag = l1_tag[2];
    assign s_3_cm_valid = lane_1_v3;
    assign s_3_cm_addr = l1_addr[3];
    assign s_3_cm_wdata = l1_wdata[3];
    assign s_3_cm_write = l1_write[3];
    assign s_3_cm_tag = l1_tag[3];
    assign mb_tag_0 = r1_tag[0];
    assign m_0_cr_valid = rlane_1_v0;
    assign m_0_cr_data = r1_data[0];
    assign m_0_cr_tag = {4'd0, mb_tag_0[19:0]};
    assign mb_tag_1 = r1_tag[1];
    assign m_1_cr_valid = rlane_1_v1;
    assign m_1_cr_data = r1_data[1];
    assign m_1_cr_tag = {4'd0, mb_tag_1[19:0]};
    assign dbg_route_target = (rt_v ? rt_sel : 4'd0);
    assign dbg_slave_ready = {s_3_cm_ready, s_2_cm_ready, s_1_cm_ready, s_0_cm_ready};
    assign dbg_inflight = ((((((((((((((((((((((((({7'd0, rq_v} + {7'd0, sk_v}) + {7'd0, rt_v}) + {7'd0, hole_v})
                           + {7'd0, pv_0}) + {7'd0, qv_0}) + {7'd0, pv_1}) + {7'd0, qv_1}) + {7'd0, pv_2})
                           + {7'd0, qv_2}) + {7'd0, pv_3}) + {7'd0, qv_3}) + {7'd0, pv_4}) + {7'd0, qv_4})
                           + {7'd0, lane_0_v0}) + {7'd0, lane_0_v1}) + {7'd0, lane_0_v2}) + {7'd0, lane_0_v3})
                           + {7'd0, rlane_0_v0}) + {7'd0, rlane_0_v1}) + {7'd0, lane_1_v0}) + {7'd0, lane_1_v1})
                           + {7'd0, lane_1_v2}) + {7'd0, lane_1_v3}) + {7'd0, rlane_1_v0}) + {7'd0, rlane_1_v1});
    assign age_mx_0 = ((age_1 > age_0) ? age_1 : age_0);
    assign age_mx_1 = ((age_2 > age_mx_0) ? age_2 : age_mx_0);
    assign age_mx_2 = ((age_3 > age_mx_1) ? age_3 : age_mx_1);
    assign dbg_cfg_ack_age = age_mx_2;
    assign in_v__j0 = s_0_cr_valid;
    assign in_d__j0 = s_0_cr_data;
    assign in_t__j0 = s_0_cr_tag;
    assign in_fire__j0 = (in_v__j0 & (~qv_0));
    assign in_v__j1 = s_1_cr_valid;
    assign in_d__j1 = s_1_cr_data;
    assign in_t__j1 = s_1_cr_tag;
    assign in_fire__j1 = (in_v__j1 & (~qv_1));
    assign in_v__j2 = s_2_cr_valid;
    assign in_d__j2 = s_2_cr_data;
    assign in_t__j2 = s_2_cr_tag;
    assign in_fire__j2 = (in_v__j2 & (~qv_2));
    assign in_v__j3 = s_3_cr_valid;
    assign in_d__j3 = s_3_cr_data;
    assign in_t__j3 = s_3_cr_tag;
    assign in_fire__j3 = (in_v__j3 & (~qv_3));
    assign in_v__j4 = hole_v;
    assign in_d__j4 = 32'd0;
    assign in_t__j4 = hole_tag;
    assign in_fire__j4 = (in_v__j4 & (~qv_4));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            sk_v <= 0;
            rq_v <= 0;
            req_rr <= 0;
            rt_v <= 0;
            rt_sel <= 0;
            lane_0_v0 <= 0;
            lane_1_v0 <= 0;
            age_0 <= 0;
            lane_0_v1 <= 0;
            lane_1_v1 <= 0;
            age_1 <= 0;
            lane_0_v2 <= 0;
            lane_1_v2 <= 0;
            age_2 <= 0;
            lane_0_v3 <= 0;
            lane_1_v3 <= 0;
            age_3 <= 0;
            hole_v <= 0;
            qv_0 <= 0;
            pv_0 <= 0;
            qv_1 <= 0;
            pv_1 <= 0;
            qv_2 <= 0;
            pv_2 <= 0;
            qv_3 <= 0;
            pv_3 <= 0;
            qv_4 <= 0;
            pv_4 <= 0;
            lk_v <= 0;
            resp_rr <= 0;
            lk_sel <= 0;
            rlane_0_v0 <= 0;
            rlane_1_v0 <= 0;
            rlane_0_v1 <= 0;
            rlane_1_v1 <= 0;
        end else begin
            if (m2_take) begin
                if (sk_v) begin
                    sk_v <= 0;
                end else begin
                    if ((!m1_fire)) begin
                        rq_v <= 0;
                    end
                end
            end else begin
                if (m1_fire) begin
                    if (rq_v) begin
                        sk_v <= 1;
                    end else begin
                        rq_v <= 1;
                    end
                end
            end
            if (m1_fire) begin
                req_rr <= (m1_sel + 1);
            end
            if (m3_take) begin
                rt_v <= 0;
            end
            if (m2_take) begin
                rt_v <= 1;
                rt_sel <= dec;
            end
            if (lane_1_take0) begin
                lane_0_v0 <= 0;
            end
            if (lane_0_take0) begin
                lane_0_v0 <= 1;
            end
            if (sfire_0) begin
                lane_1_v0 <= 0;
            end
            if (lane_1_take0) begin
                lane_1_v0 <= 1;
            end
            age_0 <= 0;
            if (((lane_1_v0 & (~sfire_0)) & (age_0 != 65535))) begin
                age_0 <= (age_0 + 1);
            end
            if (lane_1_take1) begin
                lane_0_v1 <= 0;
            end
            if (lane_0_take1) begin
                lane_0_v1 <= 1;
            end
            if (sfire_1) begin
                lane_1_v1 <= 0;
            end
            if (lane_1_take1) begin
                lane_1_v1 <= 1;
            end
            age_1 <= 0;
            if (((lane_1_v1 & (~sfire_1)) & (age_1 != 65535))) begin
                age_1 <= (age_1 + 1);
            end
            if (lane_1_take2) begin
                lane_0_v2 <= 0;
            end
            if (lane_0_take2) begin
                lane_0_v2 <= 1;
            end
            if (sfire_2) begin
                lane_1_v2 <= 0;
            end
            if (lane_1_take2) begin
                lane_1_v2 <= 1;
            end
            age_2 <= 0;
            if (((lane_1_v2 & (~sfire_2)) & (age_2 != 65535))) begin
                age_2 <= (age_2 + 1);
            end
            if (lane_1_take3) begin
                lane_0_v3 <= 0;
            end
            if (lane_0_take3) begin
                lane_0_v3 <= 1;
            end
            if (sfire_3) begin
                lane_1_v3 <= 0;
            end
            if (lane_1_take3) begin
                lane_1_v3 <= 1;
            end
            age_3 <= 0;
            if (((lane_1_v3 & (~sfire_3)) & (age_3 != 65535))) begin
                age_3 <= (age_3 + 1);
            end
            if (hole_take) begin
                hole_v <= 0;
            end
            if (hole_load) begin
                hole_v <= 1;
            end
            if (m4_take_0) begin
                if (qv_0) begin
                    qv_0 <= 0;
                end else begin
                    if ((!in_fire__j0)) begin
                        pv_0 <= 0;
                    end
                end
            end else begin
                if (in_fire__j0) begin
                    if (pv_0) begin
                        qv_0 <= 1;
                    end else begin
                        pv_0 <= 1;
                    end
                end
            end
            if (m4_take_1) begin
                if (qv_1) begin
                    qv_1 <= 0;
                end else begin
                    if ((!in_fire__j1)) begin
                        pv_1 <= 0;
                    end
                end
            end else begin
                if (in_fire__j1) begin
                    if (pv_1) begin
                        qv_1 <= 1;
                    end else begin
                        pv_1 <= 1;
                    end
                end
            end
            if (m4_take_2) begin
                if (qv_2) begin
                    qv_2 <= 0;
                end else begin
                    if ((!in_fire__j2)) begin
                        pv_2 <= 0;
                    end
                end
            end else begin
                if (in_fire__j2) begin
                    if (pv_2) begin
                        qv_2 <= 1;
                    end else begin
                        pv_2 <= 1;
                    end
                end
            end
            if (m4_take_3) begin
                if (qv_3) begin
                    qv_3 <= 0;
                end else begin
                    if ((!in_fire__j3)) begin
                        pv_3 <= 0;
                    end
                end
            end else begin
                if (in_fire__j3) begin
                    if (pv_3) begin
                        qv_3 <= 1;
                    end else begin
                        pv_3 <= 1;
                    end
                end
            end
            if (m4_take_4) begin
                if (qv_4) begin
                    qv_4 <= 0;
                end else begin
                    if ((!in_fire__j4)) begin
                        pv_4 <= 0;
                    end
                end
            end else begin
                if (in_fire__j4) begin
                    if (pv_4) begin
                        qv_4 <= 1;
                    end else begin
                        pv_4 <= 1;
                    end
                end
            end
            if (m4_fire) begin
                lk_v <= 0;
                resp_rr <= ((m4_sel == 4) ? 3'd0 : (m4_sel + 1));
            end else begin
                if (m4_any) begin
                    lk_v <= 1;
                    lk_sel <= m4_sel;
                end
            end
            if (rlane_1_take0) begin
                rlane_0_v0 <= 0;
            end
            if (rlane_0_take0) begin
                rlane_0_v0 <= 1;
            end
            if (mfire_0) begin
                rlane_1_v0 <= 0;
            end
            if (rlane_1_take0) begin
                rlane_1_v0 <= 1;
            end
            if (rlane_1_take1) begin
                rlane_0_v1 <= 0;
            end
            if (rlane_0_take1) begin
                rlane_0_v1 <= 1;
            end
            if (mfire_1) begin
                rlane_1_v1 <= 0;
            end
            if (rlane_1_take1) begin
                rlane_1_v1 <= 1;
            end
        end
    end
    always_ff @(posedge clk) begin
        if (m2_take) begin
            if (sk_v) begin
                rq_addr <= sk_addr;
                rq_wdata <= sk_wdata;
                rq_write <= sk_write;
                rq_tag <= sk_tag;
            end else begin
                if (m1_fire) begin
                    rq_addr <= m1_addr;
                    rq_wdata <= m1_wdata;
                    rq_write <= m1_write;
                    rq_tag <= m1_tag_mid;
                end
            end
        end else begin
            if (m1_fire) begin
                if (rq_v) begin
                    sk_addr <= m1_addr;
                    sk_wdata <= m1_wdata;
                    sk_write <= m1_write;
                    sk_tag <= m1_tag_mid;
                end else begin
                    rq_addr <= m1_addr;
                    rq_wdata <= m1_wdata;
                    rq_write <= m1_write;
                    rq_tag <= m1_tag_mid;
                end
            end
        end
        if (m2_take) begin
            rt_addr <= rq_addr;
            rt_wdata <= rq_wdata;
            rt_write <= rq_write;
            rt_tag <= rq_tag;
        end
        if (lane_0_take0) begin
            l0_addr[0] <= rt_addr;
            l0_wdata[0] <= rt_wdata;
            l0_write[0] <= rt_write;
            l0_tag[0] <= rt_tag;
        end
        if (lane_1_take0) begin
            l1_addr[0] <= l0_addr[0];
            l1_wdata[0] <= l0_wdata[0];
            l1_write[0] <= l0_write[0];
            l1_tag[0] <= l0_tag[0];
        end
        if (lane_0_take1) begin
            l0_addr[1] <= rt_addr;
            l0_wdata[1] <= rt_wdata;
            l0_write[1] <= rt_write;
            l0_tag[1] <= rt_tag;
        end
        if (lane_1_take1) begin
            l1_addr[1] <= l0_addr[1];
            l1_wdata[1] <= l0_wdata[1];
            l1_write[1] <= l0_write[1];
            l1_tag[1] <= l0_tag[1];
        end
        if (lane_0_take2) begin
            l0_addr[2] <= rt_addr;
            l0_wdata[2] <= rt_wdata;
            l0_write[2] <= rt_write;
            l0_tag[2] <= rt_tag;
        end
        if (lane_1_take2) begin
            l1_addr[2] <= l0_addr[2];
            l1_wdata[2] <= l0_wdata[2];
            l1_write[2] <= l0_write[2];
            l1_tag[2] <= l0_tag[2];
        end
        if (lane_0_take3) begin
            l0_addr[3] <= rt_addr;
            l0_wdata[3] <= rt_wdata;
            l0_write[3] <= rt_write;
            l0_tag[3] <= rt_tag;
        end
        if (lane_1_take3) begin
            l1_addr[3] <= l0_addr[3];
            l1_wdata[3] <= l0_wdata[3];
            l1_write[3] <= l0_write[3];
            l1_tag[3] <= l0_tag[3];
        end
        if (hole_load) begin
            hole_tag <= rt_tag;
        end
        if (m4_take_0) begin
            if (qv_0) begin
                pd_0 <= qd_0;
                pt_0 <= qt_0;
            end else begin
                if (in_fire__j0) begin
                    pd_0 <= in_d__j0;
                    pt_0 <= in_t__j0;
                end
            end
        end else begin
            if (in_fire__j0) begin
                if (pv_0) begin
                    qd_0 <= in_d__j0;
                    qt_0 <= in_t__j0;
                end else begin
                    pd_0 <= in_d__j0;
                    pt_0 <= in_t__j0;
                end
            end
        end
        if (m4_take_1) begin
            if (qv_1) begin
                pd_1 <= qd_1;
                pt_1 <= qt_1;
            end else begin
                if (in_fire__j1) begin
                    pd_1 <= in_d__j1;
                    pt_1 <= in_t__j1;
                end
            end
        end else begin
            if (in_fire__j1) begin
                if (pv_1) begin
                    qd_1 <= in_d__j1;
                    qt_1 <= in_t__j1;
                end else begin
                    pd_1 <= in_d__j1;
                    pt_1 <= in_t__j1;
                end
            end
        end
        if (m4_take_2) begin
            if (qv_2) begin
                pd_2 <= qd_2;
                pt_2 <= qt_2;
            end else begin
                if (in_fire__j2) begin
                    pd_2 <= in_d__j2;
                    pt_2 <= in_t__j2;
                end
            end
        end else begin
            if (in_fire__j2) begin
                if (pv_2) begin
                    qd_2 <= in_d__j2;
                    qt_2 <= in_t__j2;
                end else begin
                    pd_2 <= in_d__j2;
                    pt_2 <= in_t__j2;
                end
            end
        end
        if (m4_take_3) begin
            if (qv_3) begin
                pd_3 <= qd_3;
                pt_3 <= qt_3;
            end else begin
                if (in_fire__j3) begin
                    pd_3 <= in_d__j3;
                    pt_3 <= in_t__j3;
                end
            end
        end else begin
            if (in_fire__j3) begin
                if (pv_3) begin
                    qd_3 <= in_d__j3;
                    qt_3 <= in_t__j3;
                end else begin
                    pd_3 <= in_d__j3;
                    pt_3 <= in_t__j3;
                end
            end
        end
        if (m4_take_4) begin
            if (qv_4) begin
                pd_4 <= qd_4;
                pt_4 <= qt_4;
            end else begin
                if (in_fire__j4) begin
                    pd_4 <= in_d__j4;
                    pt_4 <= in_t__j4;
                end
            end
        end else begin
            if (in_fire__j4) begin
                if (pv_4) begin
                    qd_4 <= in_d__j4;
                    qt_4 <= in_t__j4;
                end else begin
                    pd_4 <= in_d__j4;
                    pt_4 <= in_t__j4;
                end
            end
        end
        if (rlane_0_take0) begin
            r0_data[0] <= m4_data;
            r0_tag[0] <= m4_tag;
        end
        if (rlane_1_take0) begin
            r1_data[0] <= r0_data[0];
            r1_tag[0] <= r0_tag[0];
        end
        if (rlane_0_take1) begin
            r0_data[1] <= m4_data;
            r0_tag[1] <= m4_tag;
        end
        if (rlane_1_take1) begin
            r1_data[1] <= r0_data[1];
            r1_tag[1] <= r0_tag[1];
        end
    end
endmodule
