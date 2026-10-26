module GrpEmaxE (
    input [30:0] th,
    output logic [4:0] e
);
    logic eb_0;
    logic eb_1;
    logic eb_2;
    logic eb_3;
    logic eb_4;

    assign eb_0 = ((((((((((((((((1'd0 | (th[0] & (~th[1]))) | (th[2] & (~th[3]))) | (th[4] & (~th[5])))
                   | (th[6] & (~th[7]))) | (th[8] & (~th[9]))) | (th[10] & (~th[11]))) | (th[12] & (~th[13])))
                   | (th[14] & (~th[15]))) | (th[16] & (~th[17]))) | (th[18] & (~th[19]))) | (th[20] & (~th[21])))
                   | (th[22] & (~th[23]))) | (th[24] & (~th[25]))) | (th[26] & (~th[27]))) | (th[28] & (~th[29])))
                   | th[30]);
    assign eb_1 = ((((((((1'd0 | (th[1] & (~th[3]))) | (th[5] & (~th[7]))) | (th[9] & (~th[11])))
                   | (th[13] & (~th[15]))) | (th[17] & (~th[19]))) | (th[21] & (~th[23]))) | (th[25] & (~th[27])))
                   | th[29]);
    assign eb_2 = ((((1'd0 | (th[3] & (~th[7]))) | (th[11] & (~th[15]))) | (th[19] & (~th[23]))) | th[27]);
    assign eb_3 = ((1'd0 | (th[7] & (~th[15]))) | th[23]);
    assign eb_4 = (1'd0 | th[15]);
    assign e = {eb_4, eb_3, eb_2, eb_1, eb_0};
endmodule
