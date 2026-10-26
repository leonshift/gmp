module StoreCastBeatA (
    input [511:0] li,
    output logic [735:0] pk
);
    logic [22:0] t_31_pk;
    logic [22:0] t_30_pk;
    logic [22:0] t_29_pk;
    logic [22:0] t_28_pk;
    logic [22:0] t_27_pk;
    logic [22:0] t_26_pk;
    logic [22:0] t_25_pk;
    logic [22:0] t_24_pk;
    logic [22:0] t_23_pk;
    logic [22:0] t_22_pk;
    logic [22:0] t_21_pk;
    logic [22:0] t_20_pk;
    logic [22:0] t_19_pk;
    logic [22:0] t_18_pk;
    logic [22:0] t_17_pk;
    logic [22:0] t_16_pk;
    logic [22:0] t_15_pk;
    logic [22:0] t_14_pk;
    logic [22:0] t_13_pk;
    logic [22:0] t_12_pk;
    logic [22:0] t_11_pk;
    logic [22:0] t_10_pk;
    logic [22:0] t_9_pk;
    logic [22:0] t_8_pk;
    logic [22:0] t_7_pk;
    logic [22:0] t_6_pk;
    logic [22:0] t_5_pk;
    logic [22:0] t_4_pk;
    logic [22:0] t_3_pk;
    logic [22:0] t_2_pk;
    logic [22:0] t_1_pk;
    logic [22:0] t_0_pk;

    assign pk = {t_31_pk, t_30_pk, t_29_pk, t_28_pk, t_27_pk, t_26_pk, t_25_pk, t_24_pk, t_23_pk, t_22_pk, t_21_pk,
                 t_20_pk, t_19_pk, t_18_pk, t_17_pk, t_16_pk, t_15_pk, t_14_pk, t_13_pk, t_12_pk, t_11_pk, t_10_pk,
                 t_9_pk, t_8_pk, t_7_pk, t_6_pk, t_5_pk, t_4_pk, t_3_pk, t_2_pk, t_1_pk, t_0_pk};

    LaneStoreA t_0 (
        .f(li[15:0]),
        .pk(t_0_pk)
    );
    LaneStoreA t_1 (
        .f(li[31:16]),
        .pk(t_1_pk)
    );
    LaneStoreA t_2 (
        .f(li[47:32]),
        .pk(t_2_pk)
    );
    LaneStoreA t_3 (
        .f(li[63:48]),
        .pk(t_3_pk)
    );
    LaneStoreA t_4 (
        .f(li[79:64]),
        .pk(t_4_pk)
    );
    LaneStoreA t_5 (
        .f(li[95:80]),
        .pk(t_5_pk)
    );
    LaneStoreA t_6 (
        .f(li[111:96]),
        .pk(t_6_pk)
    );
    LaneStoreA t_7 (
        .f(li[127:112]),
        .pk(t_7_pk)
    );
    LaneStoreA t_8 (
        .f(li[143:128]),
        .pk(t_8_pk)
    );
    LaneStoreA t_9 (
        .f(li[159:144]),
        .pk(t_9_pk)
    );
    LaneStoreA t_10 (
        .f(li[175:160]),
        .pk(t_10_pk)
    );
    LaneStoreA t_11 (
        .f(li[191:176]),
        .pk(t_11_pk)
    );
    LaneStoreA t_12 (
        .f(li[207:192]),
        .pk(t_12_pk)
    );
    LaneStoreA t_13 (
        .f(li[223:208]),
        .pk(t_13_pk)
    );
    LaneStoreA t_14 (
        .f(li[239:224]),
        .pk(t_14_pk)
    );
    LaneStoreA t_15 (
        .f(li[255:240]),
        .pk(t_15_pk)
    );
    LaneStoreA t_16 (
        .f(li[271:256]),
        .pk(t_16_pk)
    );
    LaneStoreA t_17 (
        .f(li[287:272]),
        .pk(t_17_pk)
    );
    LaneStoreA t_18 (
        .f(li[303:288]),
        .pk(t_18_pk)
    );
    LaneStoreA t_19 (
        .f(li[319:304]),
        .pk(t_19_pk)
    );
    LaneStoreA t_20 (
        .f(li[335:320]),
        .pk(t_20_pk)
    );
    LaneStoreA t_21 (
        .f(li[351:336]),
        .pk(t_21_pk)
    );
    LaneStoreA t_22 (
        .f(li[367:352]),
        .pk(t_22_pk)
    );
    LaneStoreA t_23 (
        .f(li[383:368]),
        .pk(t_23_pk)
    );
    LaneStoreA t_24 (
        .f(li[399:384]),
        .pk(t_24_pk)
    );
    LaneStoreA t_25 (
        .f(li[415:400]),
        .pk(t_25_pk)
    );
    LaneStoreA t_26 (
        .f(li[431:416]),
        .pk(t_26_pk)
    );
    LaneStoreA t_27 (
        .f(li[447:432]),
        .pk(t_27_pk)
    );
    LaneStoreA t_28 (
        .f(li[463:448]),
        .pk(t_28_pk)
    );
    LaneStoreA t_29 (
        .f(li[479:464]),
        .pk(t_29_pk)
    );
    LaneStoreA t_30 (
        .f(li[495:480]),
        .pk(t_30_pk)
    );
    LaneStoreA t_31 (
        .f(li[511:496]),
        .pk(t_31_pk)
    );
endmodule
