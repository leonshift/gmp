module RlinkUnpack (
    input clk,
    input rst_n,
    input rvalid,
    input [32:0] rdata,
    input app_tready,
    output logic app_tvalid,
    output logic [7:0] app_tdata,
    output logic app_tlast,
    output logic ren
);
    logic [1:0] idx;
    logic hs;

    assign app_tvalid = rvalid;
    assign app_tdata = ((idx == 0) ? rdata[7:0] :
                       ((idx == 1) ? rdata[15:8] :
                       ((idx == 2) ? rdata[23:16] :
                       rdata[31:24])));
    assign app_tlast = (rdata[32] & (idx == 3));
    assign hs = (rvalid & app_tready);
    assign ren = (hs & (idx == 3));
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            idx <= 0;
        end else begin
            if (hs) begin
                idx <= (idx + 1);
            end
        end
    end
endmodule
