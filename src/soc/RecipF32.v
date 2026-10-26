module RecipF32 (
    input clk,
    input rst_n,
    input [31:0] b,
    output logic [31:0] res
);
    logic sg;
    logic [7:0] e8;
    logic is_z;
    logic is_i;
    logic [18:0] d;
    logic [5:0] tix;
    logic [9:0] y0c;
    logic [9:0] p1_y0;
    logic [18:0] p1_d;
    logic [24:0] p2_q1;
    logic [9:0] p2_y0;
    logic [18:0] p2_d;
    logic [14:0] p3_y1;
    logic [18:0] p3_d;
    logic [33:0] p4_q2;
    logic [14:0] p4_y1;
    logic [20:0] p5_y2;
    logic pm_0_sg;
    logic [7:0] pm_0_e;
    logic pm_0_z;
    logic pm_0_i;
    logic pm_1_sg;
    logic [7:0] pm_1_e;
    logic pm_1_z;
    logic pm_1_i;
    logic pm_2_sg;
    logic [7:0] pm_2_e;
    logic pm_2_z;
    logic pm_2_i;
    logic pm_3_sg;
    logic [7:0] pm_3_e;
    logic pm_3_z;
    logic pm_3_i;
    logic pm_4_sg;
    logic [7:0] pm_4_e;
    logic pm_4_z;
    logic pm_4_i;
    logic [14:0] d14;
    logic [24:0] mm1;
    logic [24:0] q1n;
    logic [34:0] mm2;
    logic [14:0] y1n;
    logic [33:0] mm3;
    logic [33:0] q2n;
    logic [48:0] mm4;
    logic [20:0] y2n;
    logic one;
    logic [22:0] mo;
    logic [9:0] e10;
    logic undf;
    logic ovf;
    logic [31:0] zres;
    logic [31:0] ires;
    logic [31:0] nres;

    assign sg = b[31];
    assign e8 = b[30:23];
    assign is_z = (e8 == 0);
    assign is_i = (e8 == 255);
    assign d = {1'd1, b[22:5]};
    assign tix = b[22:17];
    assign y0c = ((tix == 0) ? 10'd508 :
                 ((tix == 1) ? 10'd500 :
                 ((tix == 2) ? 10'd493 :
                 ((tix == 3) ? 10'd485 :
                 ((tix == 4) ? 10'd478 :
                 ((tix == 5) ? 10'd471 :
                 ((tix == 6) ? 10'd465 :
                 ((tix == 7) ? 10'd458 :
                 ((tix == 8) ? 10'd452 :
                 ((tix == 9) ? 10'd446 :
                 ((tix == 10) ? 10'd440 :
                 ((tix == 11) ? 10'd434 :
                 ((tix == 12) ? 10'd428 :
                 ((tix == 13) ? 10'd423 :
                 ((tix == 14) ? 10'd417 :
                 ((tix == 15) ? 10'd412 :
                 ((tix == 16) ? 10'd407 :
                 ((tix == 17) ? 10'd402 :
                 ((tix == 18) ? 10'd397 :
                 ((tix == 19) ? 10'd392 :
                 ((tix == 20) ? 10'd388 :
                 ((tix == 21) ? 10'd383 :
                 ((tix == 22) ? 10'd379 :
                 ((tix == 23) ? 10'd374 :
                 ((tix == 24) ? 10'd370 :
                 ((tix == 25) ? 10'd366 :
                 ((tix == 26) ? 10'd362 :
                 ((tix == 27) ? 10'd358 :
                 ((tix == 28) ? 10'd354 :
                 ((tix == 29) ? 10'd350 :
                 ((tix == 30) ? 10'd347 :
                 ((tix == 31) ? 10'd343 :
                 ((tix == 32) ? 10'd340 :
                 ((tix == 33) ? 10'd336 :
                 ((tix == 34) ? 10'd333 :
                 ((tix == 35) ? 10'd329 :
                 ((tix == 36) ? 10'd326 :
                 ((tix == 37) ? 10'd323 :
                 ((tix == 38) ? 10'd320 :
                 ((tix == 39) ? 10'd317 :
                 ((tix == 40) ? 10'd314 :
                 ((tix == 41) ? 10'd311 :
                 ((tix == 42) ? 10'd308 :
                 ((tix == 43) ? 10'd305 :
                 ((tix == 44) ? 10'd302 :
                 ((tix == 45) ? 10'd299 :
                 ((tix == 46) ? 10'd297 :
                 ((tix == 47) ? 10'd294 :
                 ((tix == 48) ? 10'd291 :
                 ((tix == 49) ? 10'd289 :
                 ((tix == 50) ? 10'd286 :
                 ((tix == 51) ? 10'd284 :
                 ((tix == 52) ? 10'd281 :
                 ((tix == 53) ? 10'd279 :
                 ((tix == 54) ? 10'd277 :
                 ((tix == 55) ? 10'd274 :
                 ((tix == 56) ? 10'd272 :
                 ((tix == 57) ? 10'd270 :
                 ((tix == 58) ? 10'd267 :
                 ((tix == 59) ? 10'd265 :
                 ((tix == 60) ? 10'd263 :
                 ((tix == 61) ? 10'd261 :
                 ((tix == 62) ? 10'd259 :
                 10'd257)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign d14 = p1_d[18:4];
    assign mm1 = ({10'd0, d14} * {15'd0, p1_y0});
    assign q1n = (25'd16777216 - mm1);
    assign mm2 = ({25'd0, p2_y0} * {10'd0, p2_q1});
    assign y1n = mm2[32:18];
    assign mm3 = ({15'd0, p3_d} * {19'd0, p3_y1});
    assign q2n = (34'd8589934592 - mm3);
    assign mm4 = ({34'd0, p4_y1} * {15'd0, p4_q2});
    assign y2n = mm4[46:26];
    assign one = p5_y2[20];
    assign mo = (one ? 23'd0 : {p5_y2[18:1], 5'd0});
    assign e10 = ((10'd253 - {2'd0, pm_4_e}) + {9'd0, one});
    assign undf = (e10[9] | (e10 == 0));
    assign ovf = ((~e10[9]) & (e10 >= 255));
    assign zres = {pm_4_sg, 31'd0};
    assign ires = {pm_4_sg, 31'd2139095040};
    assign nres = {pm_4_sg, e10[7:0], mo};
    assign res = (pm_4_z ? ires : (pm_4_i ? zres : (undf ? zres : (ovf ? ires : nres))));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            p1_y0 <= 0;
            p1_d <= 0;
            pm_0_sg <= 0;
            pm_0_e <= 0;
            pm_0_z <= 0;
            pm_0_i <= 0;
            p2_q1 <= 0;
            p2_y0 <= 0;
            p2_d <= 0;
            p3_y1 <= 0;
            p3_d <= 0;
            p4_q2 <= 0;
            p4_y1 <= 0;
            p5_y2 <= 0;
            pm_1_sg <= 0;
            pm_1_e <= 0;
            pm_1_z <= 0;
            pm_1_i <= 0;
            pm_2_sg <= 0;
            pm_2_e <= 0;
            pm_2_z <= 0;
            pm_2_i <= 0;
            pm_3_sg <= 0;
            pm_3_e <= 0;
            pm_3_z <= 0;
            pm_3_i <= 0;
            pm_4_sg <= 0;
            pm_4_e <= 0;
            pm_4_z <= 0;
            pm_4_i <= 0;
        end else begin
            p1_y0 <= y0c;
            p1_d <= d;
            pm_0_sg <= sg;
            pm_0_e <= e8;
            pm_0_z <= is_z;
            pm_0_i <= is_i;
            p2_q1 <= q1n;
            p2_y0 <= p1_y0;
            p2_d <= p1_d;
            p3_y1 <= y1n;
            p3_d <= p2_d;
            p4_q2 <= q2n;
            p4_y1 <= p3_y1;
            p5_y2 <= y2n;
            pm_1_sg <= pm_0_sg;
            pm_1_e <= pm_0_e;
            pm_1_z <= pm_0_z;
            pm_1_i <= pm_0_i;
            pm_2_sg <= pm_1_sg;
            pm_2_e <= pm_1_e;
            pm_2_z <= pm_1_z;
            pm_2_i <= pm_1_i;
            pm_3_sg <= pm_2_sg;
            pm_3_e <= pm_2_e;
            pm_3_z <= pm_2_z;
            pm_3_i <= pm_2_i;
            pm_4_sg <= pm_3_sg;
            pm_4_e <= pm_3_e;
            pm_4_z <= pm_3_z;
            pm_4_i <= pm_3_i;
        end
    end
endmodule
