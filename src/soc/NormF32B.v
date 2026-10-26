module NormF32B (
    input [47:0] mg,
    input [3:0] lsh,
    input sg,
    input za,
    input zb,
    input oa,
    input ob,
    input [7:0] ea,
    input [7:0] eb,
    output logic [31:0] res
);
    logic [47:0] nrmx;
    logic up;
    logic [31:0] res_a;
    logic [31:0] res_b;

    assign nrmx = (mg << lsh);
    assign up = nrmx[47];
    assign res_a = (oa ? {sg, 31'd2139095040} : {sg, ea, nrmx[45:23]});
    assign res_b = (ob ? {sg, 31'd2139095040} : {sg, eb, nrmx[46:24]});
    assign res = (up ? (zb ? 32'd0 : res_b) : (za ? 32'd0 : res_a));
endmodule
