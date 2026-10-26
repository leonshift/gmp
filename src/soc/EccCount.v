module EccCount (
    input clk,
    input rst_n,
    input tog,
    input clr,
    output logic [7:0] cnt
);
    logic tog_s1;
    logic tog_s2;
    logic tog_s3;
    logic [7:0] cnt_q;

    assign cnt = cnt_q;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tog_s1 <= 0;
            tog_s2 <= 0;
            tog_s3 <= 0;
            cnt_q <= 0;
        end else begin
            tog_s1 <= tog;
            tog_s2 <= tog_s1;
            tog_s3 <= tog_s2;
            if (clr) begin
                cnt_q <= 0;
            end else begin
                if (((tog_s2 != tog_s3) & (cnt_q != 255))) begin
                    cnt_q <= (cnt_q + 1);
                end
            end
        end
    end
endmodule
