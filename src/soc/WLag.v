module WLag (
    input i_valid,
    input [3:0] i_id,
    input [1023:0] i_data,
    input [127:0] i_strb,
    output logic [7:0] i_ready,
    output logic o_valid,
    output logic [3:0] o_id,
    output logic [1023:0] o_data,
    output logic [127:0] o_strb,
    input [7:0] o_ready,
    input clk
);
    logic [1023:0] od;
    logic [127:0] os;

    assign o_valid = i_valid;
    assign o_id = i_id;
    assign i_ready = o_ready;
    assign o_data = od;
    assign o_strb = os;
    always_ff @(posedge clk) begin
        od <= i_data;
        os <= i_strb;
    end
endmodule
