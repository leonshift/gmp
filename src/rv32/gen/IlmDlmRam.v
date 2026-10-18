module IlmDlmRam (
    input clk,
    input a_en,
    input [14:0] a_addr,
    input [3:0] a_mask,
    input [31:0] a_data,
    input b_en,
    input [14:0] b_addr,
    input [3:0] b_mask,
    input [31:0] b_data,
    input [17:0] b_prediction,
    input [1:0] b_zero_hint,
    input b_prediction_write,
    output logic [1:0] b_zero_hint_q,
    output logic [17:0] a_prediction,
    output logic [31:0] a_q,
    output logic [31:0] b_q
);
    logic zero_planes_1_b_q;
    logic zero_planes_0_b_q;
    logic [8:0] prediction_words_1_a_q;
    logic [8:0] prediction_words_0_a_q;
    logic planes_31_a_q;
    logic planes_30_a_q;
    logic planes_29_a_q;
    logic planes_28_a_q;
    logic planes_27_a_q;
    logic planes_26_a_q;
    logic planes_25_a_q;
    logic planes_24_a_q;
    logic planes_23_a_q;
    logic planes_22_a_q;
    logic planes_21_a_q;
    logic planes_20_a_q;
    logic planes_19_a_q;
    logic planes_18_a_q;
    logic planes_17_a_q;
    logic planes_16_a_q;
    logic planes_15_a_q;
    logic planes_14_a_q;
    logic planes_13_a_q;
    logic planes_12_a_q;
    logic planes_11_a_q;
    logic planes_10_a_q;
    logic planes_9_a_q;
    logic planes_8_a_q;
    logic planes_7_a_q;
    logic planes_6_a_q;
    logic planes_5_a_q;
    logic planes_4_a_q;
    logic planes_3_a_q;
    logic planes_2_a_q;
    logic planes_1_a_q;
    logic planes_0_a_q;
    logic planes_31_b_q;
    logic planes_30_b_q;
    logic planes_29_b_q;
    logic planes_28_b_q;
    logic planes_27_b_q;
    logic planes_26_b_q;
    logic planes_25_b_q;
    logic planes_24_b_q;
    logic planes_23_b_q;
    logic planes_22_b_q;
    logic planes_21_b_q;
    logic planes_20_b_q;
    logic planes_19_b_q;
    logic planes_18_b_q;
    logic planes_17_b_q;
    logic planes_16_b_q;
    logic planes_15_b_q;
    logic planes_14_b_q;
    logic planes_13_b_q;
    logic planes_12_b_q;
    logic planes_11_b_q;
    logic planes_10_b_q;
    logic planes_9_b_q;
    logic planes_8_b_q;
    logic planes_7_b_q;
    logic planes_6_b_q;
    logic planes_5_b_q;
    logic planes_4_b_q;
    logic planes_3_b_q;
    logic planes_2_b_q;
    logic planes_1_b_q;
    logic planes_0_b_q;

    assign b_zero_hint_q = {zero_planes_1_b_q, zero_planes_0_b_q};
    assign a_prediction = {prediction_words_1_a_q, prediction_words_0_a_q};
    assign a_q = {planes_31_a_q, planes_30_a_q, planes_29_a_q, planes_28_a_q, planes_27_a_q, planes_26_a_q, planes_25_a_q, planes_24_a_q, planes_23_a_q, planes_22_a_q, planes_21_a_q, planes_20_a_q, planes_19_a_q, planes_18_a_q, planes_17_a_q, planes_16_a_q, planes_15_a_q, planes_14_a_q, planes_13_a_q, planes_12_a_q, planes_11_a_q, planes_10_a_q, planes_9_a_q, planes_8_a_q, planes_7_a_q, planes_6_a_q, planes_5_a_q, planes_4_a_q, planes_3_a_q, planes_2_a_q, planes_1_a_q, planes_0_a_q};
    assign b_q = {planes_31_b_q, planes_30_b_q, planes_29_b_q, planes_28_b_q, planes_27_b_q, planes_26_b_q, planes_25_b_q, planes_24_b_q, planes_23_b_q, planes_22_b_q, planes_21_b_q, planes_20_b_q, planes_19_b_q, planes_18_b_q, planes_17_b_q, planes_16_b_q, planes_15_b_q, planes_14_b_q, planes_13_b_q, planes_12_b_q, planes_11_b_q, planes_10_b_q, planes_9_b_q, planes_8_b_q, planes_7_b_q, planes_6_b_q, planes_5_b_q, planes_4_b_q, planes_3_b_q, planes_2_b_q, planes_1_b_q, planes_0_b_q};

    IlmDlmBitPlane planes_0 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[0]),
        .a_data(a_data[0]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[0]),
        .b_data(b_data[0]),
        .a_q(planes_0_a_q),
        .b_q(planes_0_b_q)
    );
    IlmDlmBitPlane planes_1 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[0]),
        .a_data(a_data[1]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[0]),
        .b_data(b_data[1]),
        .a_q(planes_1_a_q),
        .b_q(planes_1_b_q)
    );
    IlmDlmBitPlane planes_2 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[0]),
        .a_data(a_data[2]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[0]),
        .b_data(b_data[2]),
        .a_q(planes_2_a_q),
        .b_q(planes_2_b_q)
    );
    IlmDlmBitPlane planes_3 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[0]),
        .a_data(a_data[3]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[0]),
        .b_data(b_data[3]),
        .a_q(planes_3_a_q),
        .b_q(planes_3_b_q)
    );
    IlmDlmBitPlane planes_4 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[0]),
        .a_data(a_data[4]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[0]),
        .b_data(b_data[4]),
        .a_q(planes_4_a_q),
        .b_q(planes_4_b_q)
    );
    IlmDlmBitPlane planes_5 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[0]),
        .a_data(a_data[5]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[0]),
        .b_data(b_data[5]),
        .a_q(planes_5_a_q),
        .b_q(planes_5_b_q)
    );
    IlmDlmBitPlane planes_6 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[0]),
        .a_data(a_data[6]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[0]),
        .b_data(b_data[6]),
        .a_q(planes_6_a_q),
        .b_q(planes_6_b_q)
    );
    IlmDlmBitPlane planes_7 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[0]),
        .a_data(a_data[7]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[0]),
        .b_data(b_data[7]),
        .a_q(planes_7_a_q),
        .b_q(planes_7_b_q)
    );
    IlmDlmBitPlane planes_8 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[1]),
        .a_data(a_data[8]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[1]),
        .b_data(b_data[8]),
        .a_q(planes_8_a_q),
        .b_q(planes_8_b_q)
    );
    IlmDlmBitPlane planes_9 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[1]),
        .a_data(a_data[9]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[1]),
        .b_data(b_data[9]),
        .a_q(planes_9_a_q),
        .b_q(planes_9_b_q)
    );
    IlmDlmBitPlane planes_10 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[1]),
        .a_data(a_data[10]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[1]),
        .b_data(b_data[10]),
        .a_q(planes_10_a_q),
        .b_q(planes_10_b_q)
    );
    IlmDlmBitPlane planes_11 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[1]),
        .a_data(a_data[11]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[1]),
        .b_data(b_data[11]),
        .a_q(planes_11_a_q),
        .b_q(planes_11_b_q)
    );
    IlmDlmBitPlane planes_12 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[1]),
        .a_data(a_data[12]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[1]),
        .b_data(b_data[12]),
        .a_q(planes_12_a_q),
        .b_q(planes_12_b_q)
    );
    IlmDlmBitPlane planes_13 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[1]),
        .a_data(a_data[13]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[1]),
        .b_data(b_data[13]),
        .a_q(planes_13_a_q),
        .b_q(planes_13_b_q)
    );
    IlmDlmBitPlane planes_14 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[1]),
        .a_data(a_data[14]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[1]),
        .b_data(b_data[14]),
        .a_q(planes_14_a_q),
        .b_q(planes_14_b_q)
    );
    IlmDlmBitPlane planes_15 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[1]),
        .a_data(a_data[15]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[1]),
        .b_data(b_data[15]),
        .a_q(planes_15_a_q),
        .b_q(planes_15_b_q)
    );
    IlmDlmBitPlane planes_16 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[2]),
        .a_data(a_data[16]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[2]),
        .b_data(b_data[16]),
        .a_q(planes_16_a_q),
        .b_q(planes_16_b_q)
    );
    IlmDlmBitPlane planes_17 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[2]),
        .a_data(a_data[17]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[2]),
        .b_data(b_data[17]),
        .a_q(planes_17_a_q),
        .b_q(planes_17_b_q)
    );
    IlmDlmBitPlane planes_18 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[2]),
        .a_data(a_data[18]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[2]),
        .b_data(b_data[18]),
        .a_q(planes_18_a_q),
        .b_q(planes_18_b_q)
    );
    IlmDlmBitPlane planes_19 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[2]),
        .a_data(a_data[19]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[2]),
        .b_data(b_data[19]),
        .a_q(planes_19_a_q),
        .b_q(planes_19_b_q)
    );
    IlmDlmBitPlane planes_20 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[2]),
        .a_data(a_data[20]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[2]),
        .b_data(b_data[20]),
        .a_q(planes_20_a_q),
        .b_q(planes_20_b_q)
    );
    IlmDlmBitPlane planes_21 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[2]),
        .a_data(a_data[21]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[2]),
        .b_data(b_data[21]),
        .a_q(planes_21_a_q),
        .b_q(planes_21_b_q)
    );
    IlmDlmBitPlane planes_22 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[2]),
        .a_data(a_data[22]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[2]),
        .b_data(b_data[22]),
        .a_q(planes_22_a_q),
        .b_q(planes_22_b_q)
    );
    IlmDlmBitPlane planes_23 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[2]),
        .a_data(a_data[23]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[2]),
        .b_data(b_data[23]),
        .a_q(planes_23_a_q),
        .b_q(planes_23_b_q)
    );
    IlmDlmBitPlane planes_24 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[3]),
        .a_data(a_data[24]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[3]),
        .b_data(b_data[24]),
        .a_q(planes_24_a_q),
        .b_q(planes_24_b_q)
    );
    IlmDlmBitPlane planes_25 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[3]),
        .a_data(a_data[25]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[3]),
        .b_data(b_data[25]),
        .a_q(planes_25_a_q),
        .b_q(planes_25_b_q)
    );
    IlmDlmBitPlane planes_26 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[3]),
        .a_data(a_data[26]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[3]),
        .b_data(b_data[26]),
        .a_q(planes_26_a_q),
        .b_q(planes_26_b_q)
    );
    IlmDlmBitPlane planes_27 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[3]),
        .a_data(a_data[27]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[3]),
        .b_data(b_data[27]),
        .a_q(planes_27_a_q),
        .b_q(planes_27_b_q)
    );
    IlmDlmBitPlane planes_28 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[3]),
        .a_data(a_data[28]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[3]),
        .b_data(b_data[28]),
        .a_q(planes_28_a_q),
        .b_q(planes_28_b_q)
    );
    IlmDlmBitPlane planes_29 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[3]),
        .a_data(a_data[29]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[3]),
        .b_data(b_data[29]),
        .a_q(planes_29_a_q),
        .b_q(planes_29_b_q)
    );
    IlmDlmBitPlane planes_30 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[3]),
        .a_data(a_data[30]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[3]),
        .b_data(b_data[30]),
        .a_q(planes_30_a_q),
        .b_q(planes_30_b_q)
    );
    IlmDlmBitPlane planes_31 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(a_mask[3]),
        .a_data(a_data[31]),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_mask[3]),
        .b_data(b_data[31]),
        .a_q(planes_31_a_q),
        .b_q(planes_31_b_q)
    );
    IlmDlmPredictionWord prediction_words_0 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr[11:0]),
        .b_en(b_en),
        .b_addr(b_addr[11:0]),
        .b_write((b_prediction_write & (b_addr[14:12] == 0))),
        .b_data(b_prediction[8:0]),
        .a_q(prediction_words_0_a_q)
    );
    IlmDlmPredictionWord prediction_words_1 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr[11:0]),
        .b_en(b_en),
        .b_addr(b_addr[11:0]),
        .b_write((b_prediction_write & (b_addr[14:12] == 0))),
        .b_data(b_prediction[17:9]),
        .a_q(prediction_words_1_a_q)
    );
    IlmDlmBitPlane zero_planes_0 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(1'd0),
        .a_data(1'd0),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_prediction_write),
        .b_data(b_zero_hint[0]),
        .b_q(zero_planes_0_b_q)
    );
    IlmDlmBitPlane zero_planes_1 (
        .clk(clk),
        .a_en(a_en),
        .a_addr(a_addr),
        .a_write(1'd0),
        .a_data(1'd0),
        .b_en(b_en),
        .b_addr(b_addr),
        .b_write(b_prediction_write),
        .b_data(b_zero_hint[1]),
        .b_q(zero_planes_1_b_q)
    );
endmodule
