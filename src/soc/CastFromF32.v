module CastFromF32 (
    input [31:0] a,
    input [2:0] dt,
    output logic [31:0] res
);
    logic f_z;
    logic [9:0] h10;
    logic h_undf;
    logic h_ovf;
    logic [15:0] h_v;
    logic [31:0] u_i_res;

    assign f_z = (a[30:23] == 0);
    assign h10 = ({2'd0, a[30:23]} - 10'd112);
    assign h_undf = ((f_z | h10[9]) | (h10 == 0));
    assign h_ovf = (((~h10[9]) & (h10 >= 31)) & (~h_undf));
    assign h_v = (h_undf ? {a[31], 15'd0} : (h_ovf ? {a[31], 15'd31744} : {a[31], h10[4:0], a[22:13]}));
    assign res = ((dt == 1) ? a : ((dt == 2) ? u_i_res : {16'd0, h_v}));

    F32ToI32 u_i (
        .a(a),
        .res(u_i_res)
    );
endmodule
