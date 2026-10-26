module StoreCastBeatB (
    input [735:0] pk,
    input [455:0] sg,
    input is32d,
    output logic [511:0] res
);
    logic [31:0] w_0;
    logic [31:0] w_1;
    logic [31:0] w_2;
    logic [31:0] w_3;
    logic [31:0] w_4;
    logic [31:0] w_5;
    logic [31:0] w_6;
    logic [31:0] w_7;
    logic [31:0] w_8;
    logic [31:0] w_9;
    logic [31:0] w_10;
    logic [31:0] w_11;
    logic [31:0] w_12;
    logic [31:0] w_13;
    logic [31:0] w_14;
    logic [31:0] w_15;
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
    logic [511:0] b32;
    logic [511:0] b16;
    logic [31:0] t_0_r32;
    logic [15:0] t_0_r16;
    logic [31:0] t_1_r32;
    logic [15:0] t_1_r16;
    logic [31:0] t_2_r32;
    logic [15:0] t_2_r16;
    logic [31:0] t_3_r32;
    logic [15:0] t_3_r16;
    logic [31:0] t_4_r32;
    logic [15:0] t_4_r16;
    logic [31:0] t_5_r32;
    logic [15:0] t_5_r16;
    logic [31:0] t_6_r32;
    logic [15:0] t_6_r16;
    logic [31:0] t_7_r32;
    logic [15:0] t_7_r16;
    logic [31:0] t_8_r32;
    logic [15:0] t_8_r16;
    logic [31:0] t_9_r32;
    logic [15:0] t_9_r16;
    logic [31:0] t_10_r32;
    logic [15:0] t_10_r16;
    logic [31:0] t_11_r32;
    logic [15:0] t_11_r16;
    logic [31:0] t_12_r32;
    logic [15:0] t_12_r16;
    logic [31:0] t_13_r32;
    logic [15:0] t_13_r16;
    logic [31:0] t_14_r32;
    logic [15:0] t_14_r16;
    logic [31:0] t_15_r32;
    logic [15:0] t_15_r16;
    logic [15:0] t_16_r16;
    logic [15:0] t_17_r16;
    logic [15:0] t_18_r16;
    logic [15:0] t_19_r16;
    logic [15:0] t_20_r16;
    logic [15:0] t_21_r16;
    logic [15:0] t_22_r16;
    logic [15:0] t_23_r16;
    logic [15:0] t_24_r16;
    logic [15:0] t_25_r16;
    logic [15:0] t_26_r16;
    logic [15:0] t_27_r16;
    logic [15:0] t_28_r16;
    logic [15:0] t_29_r16;
    logic [15:0] t_30_r16;
    logic [15:0] t_31_r16;

    assign w_0 = t_0_r32;
    assign h_0 = t_0_r16;
    assign w_1 = t_1_r32;
    assign h_1 = t_1_r16;
    assign w_2 = t_2_r32;
    assign h_2 = t_2_r16;
    assign w_3 = t_3_r32;
    assign h_3 = t_3_r16;
    assign w_4 = t_4_r32;
    assign h_4 = t_4_r16;
    assign w_5 = t_5_r32;
    assign h_5 = t_5_r16;
    assign w_6 = t_6_r32;
    assign h_6 = t_6_r16;
    assign w_7 = t_7_r32;
    assign h_7 = t_7_r16;
    assign w_8 = t_8_r32;
    assign h_8 = t_8_r16;
    assign w_9 = t_9_r32;
    assign h_9 = t_9_r16;
    assign w_10 = t_10_r32;
    assign h_10 = t_10_r16;
    assign w_11 = t_11_r32;
    assign h_11 = t_11_r16;
    assign w_12 = t_12_r32;
    assign h_12 = t_12_r16;
    assign w_13 = t_13_r32;
    assign h_13 = t_13_r16;
    assign w_14 = t_14_r32;
    assign h_14 = t_14_r16;
    assign w_15 = t_15_r32;
    assign h_15 = t_15_r16;
    assign h_16 = t_16_r16;
    assign h_17 = t_17_r16;
    assign h_18 = t_18_r16;
    assign h_19 = t_19_r16;
    assign h_20 = t_20_r16;
    assign h_21 = t_21_r16;
    assign h_22 = t_22_r16;
    assign h_23 = t_23_r16;
    assign h_24 = t_24_r16;
    assign h_25 = t_25_r16;
    assign h_26 = t_26_r16;
    assign h_27 = t_27_r16;
    assign h_28 = t_28_r16;
    assign h_29 = t_29_r16;
    assign h_30 = t_30_r16;
    assign h_31 = t_31_r16;
    assign b32 = {w_15, w_14, w_13, w_12, w_11, w_10, w_9, w_8, w_7, w_6, w_5, w_4, w_3, w_2, w_1, w_0};
    assign b16 = {h_31, h_30, h_29, h_28, h_27, h_26, h_25, h_24, h_23, h_22, h_21, h_20, h_19, h_18, h_17, h_16, h_15,
                  h_14, h_13, h_12, h_11, h_10, h_9, h_8, h_7, h_6, h_5, h_4, h_3, h_2, h_1, h_0};
    assign res = (is32d ? b32 : b16);

    LaneStoreB t_0 (
        .sg(sg[56:0]),
        .pk(pk[22:0]),
        .r32(t_0_r32),
        .r16(t_0_r16)
    );
    LaneStoreB t_1 (
        .sg(sg[56:0]),
        .pk(pk[45:23]),
        .r32(t_1_r32),
        .r16(t_1_r16)
    );
    LaneStoreB t_2 (
        .sg(sg[56:0]),
        .pk(pk[68:46]),
        .r32(t_2_r32),
        .r16(t_2_r16)
    );
    LaneStoreB t_3 (
        .sg(sg[56:0]),
        .pk(pk[91:69]),
        .r32(t_3_r32),
        .r16(t_3_r16)
    );
    LaneStoreB t_4 (
        .sg(sg[113:57]),
        .pk(pk[114:92]),
        .r32(t_4_r32),
        .r16(t_4_r16)
    );
    LaneStoreB t_5 (
        .sg(sg[113:57]),
        .pk(pk[137:115]),
        .r32(t_5_r32),
        .r16(t_5_r16)
    );
    LaneStoreB t_6 (
        .sg(sg[113:57]),
        .pk(pk[160:138]),
        .r32(t_6_r32),
        .r16(t_6_r16)
    );
    LaneStoreB t_7 (
        .sg(sg[113:57]),
        .pk(pk[183:161]),
        .r32(t_7_r32),
        .r16(t_7_r16)
    );
    LaneStoreB t_8 (
        .sg(sg[170:114]),
        .pk(pk[206:184]),
        .r32(t_8_r32),
        .r16(t_8_r16)
    );
    LaneStoreB t_9 (
        .sg(sg[170:114]),
        .pk(pk[229:207]),
        .r32(t_9_r32),
        .r16(t_9_r16)
    );
    LaneStoreB t_10 (
        .sg(sg[170:114]),
        .pk(pk[252:230]),
        .r32(t_10_r32),
        .r16(t_10_r16)
    );
    LaneStoreB t_11 (
        .sg(sg[170:114]),
        .pk(pk[275:253]),
        .r32(t_11_r32),
        .r16(t_11_r16)
    );
    LaneStoreB t_12 (
        .sg(sg[227:171]),
        .pk(pk[298:276]),
        .r32(t_12_r32),
        .r16(t_12_r16)
    );
    LaneStoreB t_13 (
        .sg(sg[227:171]),
        .pk(pk[321:299]),
        .r32(t_13_r32),
        .r16(t_13_r16)
    );
    LaneStoreB t_14 (
        .sg(sg[227:171]),
        .pk(pk[344:322]),
        .r32(t_14_r32),
        .r16(t_14_r16)
    );
    LaneStoreB t_15 (
        .sg(sg[227:171]),
        .pk(pk[367:345]),
        .r32(t_15_r32),
        .r16(t_15_r16)
    );
    LaneStoreB t_16 (
        .sg(sg[284:228]),
        .pk(pk[390:368]),
        .r16(t_16_r16)
    );
    LaneStoreB t_17 (
        .sg(sg[284:228]),
        .pk(pk[413:391]),
        .r16(t_17_r16)
    );
    LaneStoreB t_18 (
        .sg(sg[284:228]),
        .pk(pk[436:414]),
        .r16(t_18_r16)
    );
    LaneStoreB t_19 (
        .sg(sg[284:228]),
        .pk(pk[459:437]),
        .r16(t_19_r16)
    );
    LaneStoreB t_20 (
        .sg(sg[341:285]),
        .pk(pk[482:460]),
        .r16(t_20_r16)
    );
    LaneStoreB t_21 (
        .sg(sg[341:285]),
        .pk(pk[505:483]),
        .r16(t_21_r16)
    );
    LaneStoreB t_22 (
        .sg(sg[341:285]),
        .pk(pk[528:506]),
        .r16(t_22_r16)
    );
    LaneStoreB t_23 (
        .sg(sg[341:285]),
        .pk(pk[551:529]),
        .r16(t_23_r16)
    );
    LaneStoreB t_24 (
        .sg(sg[398:342]),
        .pk(pk[574:552]),
        .r16(t_24_r16)
    );
    LaneStoreB t_25 (
        .sg(sg[398:342]),
        .pk(pk[597:575]),
        .r16(t_25_r16)
    );
    LaneStoreB t_26 (
        .sg(sg[398:342]),
        .pk(pk[620:598]),
        .r16(t_26_r16)
    );
    LaneStoreB t_27 (
        .sg(sg[398:342]),
        .pk(pk[643:621]),
        .r16(t_27_r16)
    );
    LaneStoreB t_28 (
        .sg(sg[455:399]),
        .pk(pk[666:644]),
        .r16(t_28_r16)
    );
    LaneStoreB t_29 (
        .sg(sg[455:399]),
        .pk(pk[689:667]),
        .r16(t_29_r16)
    );
    LaneStoreB t_30 (
        .sg(sg[455:399]),
        .pk(pk[712:690]),
        .r16(t_30_r16)
    );
    LaneStoreB t_31 (
        .sg(sg[455:399]),
        .pk(pk[735:713]),
        .r16(t_31_r16)
    );
endmodule
