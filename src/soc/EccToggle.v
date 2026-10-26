module EccToggle (
    input clk,
    input rst_n,
    input [7:0] err,
    output logic tog
);
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tog <= 0;
        end else begin
            if ((err != 0)) begin
                tog <= (~tog);
            end
        end
    end
endmodule
