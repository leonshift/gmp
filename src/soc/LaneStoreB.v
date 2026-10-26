module LaneStoreB (
    input [56:0] sg,
    input [22:0] pk,
    output logic [31:0] r32,
    output logic [15:0] r16
);
    logic [7:0] e;
    logic [15:0] mel;
    logic [15:0] mhl;
    logic [15:0] mhh;
    logic e255;
    logic [15:0] mg;
    logic [3:0] sh;
    logic z;
    logic sn;
    logic [15:0] nrm;
    logic [15:0] mel_s;
    logic [15:0] mhl_s;
    logic [15:0] mhh_s;
    logic e_lo;
    logic h_lo;
    logic h_hi;
    logic e_hi;
    logic zero;
    logic [7:0] ew8;
    logic [7:0] e8;
    logic [22:0] m23;
    logic [31:0] b32;
    logic [4:0] eh5;
    logic [4:0] h5;
    logic [15:0] b16;
    logic [15:0] s16;

    assign e = sg[7:0];
    assign mel = sg[23:8];
    assign mhl = sg[39:24];
    assign mhh = sg[55:40];
    assign e255 = sg[56];
    assign mg = pk[15:0];
    assign sh = pk[19:16];
    assign z = pk[21];
    assign sn = pk[22];
    assign nrm = (mg << sh);
    assign mel_s = (mel >> sh);
    assign mhl_s = (mhl >> sh);
    assign mhh_s = (mhh >> sh);
    assign e_lo = mel_s[0];
    assign h_lo = mhl_s[0];
    assign h_hi = mhh_s[0];
    assign e_hi = (e255 & (sh == 4'd0));
    assign zero = (z | e_lo);
    assign ew8 = (e - {4'd0, sh});
    assign e8 = (e_hi ? 8'd254 : ew8);
    assign m23 = (e_hi ? 23'd8388607 : {nrm[14:0], 8'd0});
    assign b32 = {sn, e8, m23};
    assign r32 = (zero ? {sn, 31'd0} : b32);
    assign eh5 = {(~e[4]), e[3:0]};
    assign h5 = (eh5 - {1'd0, sh});
    assign b16 = {sn, h5, nrm[14:5]};
    assign s16 = {sn, 15'd31744};
    assign r16 = ((zero | h_lo) ? {sn, 15'd0} : ((h_hi | e_hi) ? s16 : b16));
endmodule
