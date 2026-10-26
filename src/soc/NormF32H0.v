module NormF32H0 (
    input [36:0] s,
    output logic [5:0] l,
    output logic sz
);
    logic sg;
    logic [39:0] oc;
    logic [7:0] gsig_0;
    logic gsig_1;
    logic gsig_2;
    logic gsig_3;
    logic gsig_4;
    logic [7:0] gsig_5;
    logic gsig_6;
    logic gsig_7;
    logic gsig_8;
    logic gsig_9;
    logic [7:0] gsig_10;
    logic gsig_11;
    logic gsig_12;
    logic gsig_13;
    logic gsig_14;
    logic [7:0] gsig_15;
    logic gsig_16;
    logic gsig_17;
    logic gsig_18;
    logic gsig_19;
    logic [7:0] gsig_20;
    logic gsig_21;
    logic gsig_22;
    logic gsig_23;
    logic gsig_24;
    logic gnz_0;
    logic gnz_1;
    logic gnz_2;
    logic gnz_3;
    logic gnz_4;
    logic [3:0] gbl_0;
    logic [3:0] gbl_1;
    logic [3:0] gbl_2;
    logic [3:0] gbl_3;
    logic [3:0] gbl_4;
    logic [7:0] gv;
    logic hs_0;
    logic hs_1;
    logic hs_2;
    logic [2:0] hi;
    logic [3:0] g;

    assign sg = s[36];
    assign oc = {4'd0, (s[35:0] ^ {36{sg}})};
    assign gsig_0 = oc[7:0];
    assign gnz_0 = (gsig_0 != 0);
    assign gsig_1 = gsig_0[7];
    assign gsig_2 = ((~gsig_0[7]) & (gsig_0[6:3] != 0));
    assign gsig_3 = ((~gsig_0[7]) & ((gsig_0[6:3] != 0) ? (gsig_0[6:5] != 0) : (gsig_0[2:1] != 0)));
    assign gsig_4 = ((~gsig_0[7])
                     & ((gsig_0[6:3] != 0) ? (gsig_0[6] | ((~gsig_0[5]) & gsig_0[4])) :
                       (gsig_0[2] | ((~gsig_0[1]) & gsig_0[0]))));
    assign gbl_0 = {gsig_1, gsig_2, gsig_3, gsig_4};
    assign gsig_5 = oc[15:8];
    assign gnz_1 = (gsig_5 != 0);
    assign gsig_6 = gsig_5[7];
    assign gsig_7 = ((~gsig_5[7]) & (gsig_5[6:3] != 0));
    assign gsig_8 = ((~gsig_5[7]) & ((gsig_5[6:3] != 0) ? (gsig_5[6:5] != 0) : (gsig_5[2:1] != 0)));
    assign gsig_9 = ((~gsig_5[7])
                     & ((gsig_5[6:3] != 0) ? (gsig_5[6] | ((~gsig_5[5]) & gsig_5[4])) :
                       (gsig_5[2] | ((~gsig_5[1]) & gsig_5[0]))));
    assign gbl_1 = {gsig_6, gsig_7, gsig_8, gsig_9};
    assign gsig_10 = oc[23:16];
    assign gnz_2 = (gsig_10 != 0);
    assign gsig_11 = gsig_10[7];
    assign gsig_12 = ((~gsig_10[7]) & (gsig_10[6:3] != 0));
    assign gsig_13 = ((~gsig_10[7]) & ((gsig_10[6:3] != 0) ? (gsig_10[6:5] != 0) : (gsig_10[2:1] != 0)));
    assign gsig_14 = ((~gsig_10[7])
                      & ((gsig_10[6:3] != 0) ? (gsig_10[6] | ((~gsig_10[5]) & gsig_10[4])) :
                        (gsig_10[2] | ((~gsig_10[1]) & gsig_10[0]))));
    assign gbl_2 = {gsig_11, gsig_12, gsig_13, gsig_14};
    assign gsig_15 = oc[31:24];
    assign gnz_3 = (gsig_15 != 0);
    assign gsig_16 = gsig_15[7];
    assign gsig_17 = ((~gsig_15[7]) & (gsig_15[6:3] != 0));
    assign gsig_18 = ((~gsig_15[7]) & ((gsig_15[6:3] != 0) ? (gsig_15[6:5] != 0) : (gsig_15[2:1] != 0)));
    assign gsig_19 = ((~gsig_15[7])
                      & ((gsig_15[6:3] != 0) ? (gsig_15[6] | ((~gsig_15[5]) & gsig_15[4])) :
                        (gsig_15[2] | ((~gsig_15[1]) & gsig_15[0]))));
    assign gbl_3 = {gsig_16, gsig_17, gsig_18, gsig_19};
    assign gsig_20 = oc[39:32];
    assign gnz_4 = (gsig_20 != 0);
    assign gsig_21 = gsig_20[7];
    assign gsig_22 = ((~gsig_20[7]) & (gsig_20[6:3] != 0));
    assign gsig_23 = ((~gsig_20[7]) & ((gsig_20[6:3] != 0) ? (gsig_20[6:5] != 0) : (gsig_20[2:1] != 0)));
    assign gsig_24 = ((~gsig_20[7])
                      & ((gsig_20[6:3] != 0) ? (gsig_20[6] | ((~gsig_20[5]) & gsig_20[4])) :
                        (gsig_20[2] | ((~gsig_20[1]) & gsig_20[0]))));
    assign gbl_4 = {gsig_21, gsig_22, gsig_23, gsig_24};
    assign gv = {3'd0, {gnz_4, gnz_3, gnz_2, gnz_1, gnz_0}};
    assign hs_0 = (gv[7:4] != 0);
    assign hs_1 = (hs_0 ? (gv[7:6] != 0) : (gv[3:2] != 0));
    assign hs_2 = (hs_0 ? (hs_1 ? gv[7] : gv[5]) : (hs_1 ? gv[3] : gv[1]));
    assign hi = {hs_0, hs_1, hs_2};
    assign g = ((hi == 0) ? gbl_0 : ((hi == 1) ? gbl_1 : ((hi == 2) ? gbl_2 : ((hi == 3) ? gbl_3 : gbl_4))));
    assign l = {(hi + {2'd0, g[3]}), g[2:0]};
    assign sz = ((gv == 0) & (~sg));
endmodule
