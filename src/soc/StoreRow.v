module StoreRow (
    input [1023:0] q16,
    input [7:0] sel16,
    input [7:0] selh,
    input [7:0] sell,
    input [9:0] nbytes,
    input [3:0] beat,
    output logic [511:0] seg,
    output logic [63:0] strb
);
    logic [1023:0] q;
    logic [15:0] h_0;
    logic [15:0] h_1;
    logic [15:0] h_2;
    logic [15:0] h_3;
    logic [15:0] h_4;
    logic [15:0] h_5;
    logic [15:0] h_6;
    logic [15:0] h_7;
    logic [15:0] h_8;
    logic [15:0] h_9;
    logic [15:0] h_10;
    logic [15:0] h_11;
    logic [15:0] h_12;
    logic [15:0] h_13;
    logic [15:0] h_14;
    logic [15:0] h_15;
    logic [15:0] h_16;
    logic [15:0] h_17;
    logic [15:0] h_18;
    logic [15:0] h_19;
    logic [15:0] h_20;
    logic [15:0] h_21;
    logic [15:0] h_22;
    logic [15:0] h_23;
    logic [15:0] h_24;
    logic [15:0] h_25;
    logic [15:0] h_26;
    logic [15:0] h_27;
    logic [15:0] h_28;
    logic [15:0] h_29;
    logic [15:0] h_30;
    logic [15:0] h_31;
    logic [511:0] h_seg;
    logic [63:0] segc_0;
    logic [63:0] segc_1;
    logic [63:0] segc_2;
    logic [63:0] segc_3;
    logic [63:0] segc_4;
    logic [63:0] segc_5;
    logic [63:0] segc_6;
    logic [63:0] segc_7;
    logic [11:0] d11;
    logic [6:0] thi;
    logic sb_0;
    logic sb_1;
    logic sb_2;
    logic sb_3;
    logic sb_4;
    logic sb_5;
    logic sb_6;
    logic sb_7;
    logic sb_8;
    logic sb_9;
    logic sb_10;
    logic sb_11;
    logic sb_12;
    logic sb_13;
    logic sb_14;
    logic sb_15;
    logic sb_16;
    logic sb_17;
    logic sb_18;
    logic sb_19;
    logic sb_20;
    logic sb_21;
    logic sb_22;
    logic sb_23;
    logic sb_24;
    logic sb_25;
    logic sb_26;
    logic sb_27;
    logic sb_28;
    logic sb_29;
    logic sb_30;
    logic sb_31;
    logic sb_32;
    logic sb_33;
    logic sb_34;
    logic sb_35;
    logic sb_36;
    logic sb_37;
    logic sb_38;
    logic sb_39;
    logic sb_40;
    logic sb_41;
    logic sb_42;
    logic sb_43;
    logic sb_44;
    logic sb_45;
    logic sb_46;
    logic sb_47;
    logic sb_48;
    logic sb_49;
    logic sb_50;
    logic sb_51;
    logic sb_52;
    logic sb_53;
    logic sb_54;
    logic sb_55;
    logic sb_56;
    logic sb_57;
    logic sb_58;
    logic sb_59;
    logic sb_60;
    logic sb_61;
    logic sb_62;
    logic sb_63;
    logic [15:0] uh_0_res;
    logic [15:0] uh_1_res;
    logic [15:0] uh_2_res;
    logic [15:0] uh_3_res;
    logic [15:0] uh_4_res;
    logic [15:0] uh_5_res;
    logic [15:0] uh_6_res;
    logic [15:0] uh_7_res;
    logic [15:0] uh_8_res;
    logic [15:0] uh_9_res;
    logic [15:0] uh_10_res;
    logic [15:0] uh_11_res;
    logic [15:0] uh_12_res;
    logic [15:0] uh_13_res;
    logic [15:0] uh_14_res;
    logic [15:0] uh_15_res;
    logic [15:0] uh_16_res;
    logic [15:0] uh_17_res;
    logic [15:0] uh_18_res;
    logic [15:0] uh_19_res;
    logic [15:0] uh_20_res;
    logic [15:0] uh_21_res;
    logic [15:0] uh_22_res;
    logic [15:0] uh_23_res;
    logic [15:0] uh_24_res;
    logic [15:0] uh_25_res;
    logic [15:0] uh_26_res;
    logic [15:0] uh_27_res;
    logic [15:0] uh_28_res;
    logic [15:0] uh_29_res;
    logic [15:0] uh_30_res;
    logic [15:0] uh_31_res;

    assign q = q16;
    assign h_0 = uh_0_res;
    assign h_1 = uh_1_res;
    assign h_2 = uh_2_res;
    assign h_3 = uh_3_res;
    assign h_4 = uh_4_res;
    assign h_5 = uh_5_res;
    assign h_6 = uh_6_res;
    assign h_7 = uh_7_res;
    assign h_8 = uh_8_res;
    assign h_9 = uh_9_res;
    assign h_10 = uh_10_res;
    assign h_11 = uh_11_res;
    assign h_12 = uh_12_res;
    assign h_13 = uh_13_res;
    assign h_14 = uh_14_res;
    assign h_15 = uh_15_res;
    assign h_16 = uh_16_res;
    assign h_17 = uh_17_res;
    assign h_18 = uh_18_res;
    assign h_19 = uh_19_res;
    assign h_20 = uh_20_res;
    assign h_21 = uh_21_res;
    assign h_22 = uh_22_res;
    assign h_23 = uh_23_res;
    assign h_24 = uh_24_res;
    assign h_25 = uh_25_res;
    assign h_26 = uh_26_res;
    assign h_27 = uh_27_res;
    assign h_28 = uh_28_res;
    assign h_29 = uh_29_res;
    assign h_30 = uh_30_res;
    assign h_31 = uh_31_res;
    assign h_seg = {h_31, h_30, h_29, h_28, h_27, h_26, h_25, h_24, h_23, h_22, h_21, h_20, h_19, h_18, h_17, h_16,
                    h_15, h_14, h_13, h_12, h_11, h_10, h_9, h_8, h_7, h_6, h_5, h_4, h_3, h_2, h_1, h_0};
    assign segc_0 = (sel16[0] ? h_seg[63:0] : (selh[0] ? q[575:512] : (sell[0] ? q[63:0] : 64'd0)));
    assign segc_1 = (sel16[1] ? h_seg[127:64] : (selh[1] ? q[639:576] : (sell[1] ? q[127:64] : 64'd0)));
    assign segc_2 = (sel16[2] ? h_seg[191:128] : (selh[2] ? q[703:640] : (sell[2] ? q[191:128] : 64'd0)));
    assign segc_3 = (sel16[3] ? h_seg[255:192] : (selh[3] ? q[767:704] : (sell[3] ? q[255:192] : 64'd0)));
    assign segc_4 = (sel16[4] ? h_seg[319:256] : (selh[4] ? q[831:768] : (sell[4] ? q[319:256] : 64'd0)));
    assign segc_5 = (sel16[5] ? h_seg[383:320] : (selh[5] ? q[895:832] : (sell[5] ? q[383:320] : 64'd0)));
    assign segc_6 = (sel16[6] ? h_seg[447:384] : (selh[6] ? q[959:896] : (sell[6] ? q[447:384] : 64'd0)));
    assign segc_7 = (sel16[7] ? h_seg[511:448] : (selh[7] ? q[1023:960] : (sell[7] ? q[511:448] : 64'd0)));
    assign seg = {segc_7, segc_6, segc_5, segc_4, segc_3, segc_2, segc_1, segc_0};
    assign d11 = ({2'd0, nbytes} - {2'd0, {beat, 6'd0}});
    assign thi = (d11[11] ? 7'd0 : ((d11 > 64) ? 7'd64 : d11[6:0]));
    assign sb_0 = (7'd0 < thi);
    assign sb_1 = (7'd1 < thi);
    assign sb_2 = (7'd2 < thi);
    assign sb_3 = (7'd3 < thi);
    assign sb_4 = (7'd4 < thi);
    assign sb_5 = (7'd5 < thi);
    assign sb_6 = (7'd6 < thi);
    assign sb_7 = (7'd7 < thi);
    assign sb_8 = (7'd8 < thi);
    assign sb_9 = (7'd9 < thi);
    assign sb_10 = (7'd10 < thi);
    assign sb_11 = (7'd11 < thi);
    assign sb_12 = (7'd12 < thi);
    assign sb_13 = (7'd13 < thi);
    assign sb_14 = (7'd14 < thi);
    assign sb_15 = (7'd15 < thi);
    assign sb_16 = (7'd16 < thi);
    assign sb_17 = (7'd17 < thi);
    assign sb_18 = (7'd18 < thi);
    assign sb_19 = (7'd19 < thi);
    assign sb_20 = (7'd20 < thi);
    assign sb_21 = (7'd21 < thi);
    assign sb_22 = (7'd22 < thi);
    assign sb_23 = (7'd23 < thi);
    assign sb_24 = (7'd24 < thi);
    assign sb_25 = (7'd25 < thi);
    assign sb_26 = (7'd26 < thi);
    assign sb_27 = (7'd27 < thi);
    assign sb_28 = (7'd28 < thi);
    assign sb_29 = (7'd29 < thi);
    assign sb_30 = (7'd30 < thi);
    assign sb_31 = (7'd31 < thi);
    assign sb_32 = (7'd32 < thi);
    assign sb_33 = (7'd33 < thi);
    assign sb_34 = (7'd34 < thi);
    assign sb_35 = (7'd35 < thi);
    assign sb_36 = (7'd36 < thi);
    assign sb_37 = (7'd37 < thi);
    assign sb_38 = (7'd38 < thi);
    assign sb_39 = (7'd39 < thi);
    assign sb_40 = (7'd40 < thi);
    assign sb_41 = (7'd41 < thi);
    assign sb_42 = (7'd42 < thi);
    assign sb_43 = (7'd43 < thi);
    assign sb_44 = (7'd44 < thi);
    assign sb_45 = (7'd45 < thi);
    assign sb_46 = (7'd46 < thi);
    assign sb_47 = (7'd47 < thi);
    assign sb_48 = (7'd48 < thi);
    assign sb_49 = (7'd49 < thi);
    assign sb_50 = (7'd50 < thi);
    assign sb_51 = (7'd51 < thi);
    assign sb_52 = (7'd52 < thi);
    assign sb_53 = (7'd53 < thi);
    assign sb_54 = (7'd54 < thi);
    assign sb_55 = (7'd55 < thi);
    assign sb_56 = (7'd56 < thi);
    assign sb_57 = (7'd57 < thi);
    assign sb_58 = (7'd58 < thi);
    assign sb_59 = (7'd59 < thi);
    assign sb_60 = (7'd60 < thi);
    assign sb_61 = (7'd61 < thi);
    assign sb_62 = (7'd62 < thi);
    assign sb_63 = (7'd63 < thi);
    assign strb = {sb_63, sb_62, sb_61, sb_60, sb_59, sb_58, sb_57, sb_56, sb_55, sb_54, sb_53, sb_52, sb_51, sb_50,
                   sb_49, sb_48, sb_47, sb_46, sb_45, sb_44, sb_43, sb_42, sb_41, sb_40, sb_39, sb_38, sb_37, sb_36,
                   sb_35, sb_34, sb_33, sb_32, sb_31, sb_30, sb_29, sb_28, sb_27, sb_26, sb_25, sb_24, sb_23, sb_22,
                   sb_21, sb_20, sb_19, sb_18, sb_17, sb_16, sb_15, sb_14, sb_13, sb_12, sb_11, sb_10, sb_9, sb_8, sb_7,
                   sb_6, sb_5, sb_4, sb_3, sb_2, sb_1, sb_0};

    F32ToF16 uh_0 (
        .a(q[31:0]),
        .res(uh_0_res)
    );
    F32ToF16 uh_1 (
        .a(q[63:32]),
        .res(uh_1_res)
    );
    F32ToF16 uh_2 (
        .a(q[95:64]),
        .res(uh_2_res)
    );
    F32ToF16 uh_3 (
        .a(q[127:96]),
        .res(uh_3_res)
    );
    F32ToF16 uh_4 (
        .a(q[159:128]),
        .res(uh_4_res)
    );
    F32ToF16 uh_5 (
        .a(q[191:160]),
        .res(uh_5_res)
    );
    F32ToF16 uh_6 (
        .a(q[223:192]),
        .res(uh_6_res)
    );
    F32ToF16 uh_7 (
        .a(q[255:224]),
        .res(uh_7_res)
    );
    F32ToF16 uh_8 (
        .a(q[287:256]),
        .res(uh_8_res)
    );
    F32ToF16 uh_9 (
        .a(q[319:288]),
        .res(uh_9_res)
    );
    F32ToF16 uh_10 (
        .a(q[351:320]),
        .res(uh_10_res)
    );
    F32ToF16 uh_11 (
        .a(q[383:352]),
        .res(uh_11_res)
    );
    F32ToF16 uh_12 (
        .a(q[415:384]),
        .res(uh_12_res)
    );
    F32ToF16 uh_13 (
        .a(q[447:416]),
        .res(uh_13_res)
    );
    F32ToF16 uh_14 (
        .a(q[479:448]),
        .res(uh_14_res)
    );
    F32ToF16 uh_15 (
        .a(q[511:480]),
        .res(uh_15_res)
    );
    F32ToF16 uh_16 (
        .a(q[543:512]),
        .res(uh_16_res)
    );
    F32ToF16 uh_17 (
        .a(q[575:544]),
        .res(uh_17_res)
    );
    F32ToF16 uh_18 (
        .a(q[607:576]),
        .res(uh_18_res)
    );
    F32ToF16 uh_19 (
        .a(q[639:608]),
        .res(uh_19_res)
    );
    F32ToF16 uh_20 (
        .a(q[671:640]),
        .res(uh_20_res)
    );
    F32ToF16 uh_21 (
        .a(q[703:672]),
        .res(uh_21_res)
    );
    F32ToF16 uh_22 (
        .a(q[735:704]),
        .res(uh_22_res)
    );
    F32ToF16 uh_23 (
        .a(q[767:736]),
        .res(uh_23_res)
    );
    F32ToF16 uh_24 (
        .a(q[799:768]),
        .res(uh_24_res)
    );
    F32ToF16 uh_25 (
        .a(q[831:800]),
        .res(uh_25_res)
    );
    F32ToF16 uh_26 (
        .a(q[863:832]),
        .res(uh_26_res)
    );
    F32ToF16 uh_27 (
        .a(q[895:864]),
        .res(uh_27_res)
    );
    F32ToF16 uh_28 (
        .a(q[927:896]),
        .res(uh_28_res)
    );
    F32ToF16 uh_29 (
        .a(q[959:928]),
        .res(uh_29_res)
    );
    F32ToF16 uh_30 (
        .a(q[991:960]),
        .res(uh_30_res)
    );
    F32ToF16 uh_31 (
        .a(q[1023:992]),
        .res(uh_31_res)
    );
endmodule
