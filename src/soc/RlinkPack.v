module RlinkPack (
    input clk,
    input rst_n,
    input [7:0] app_tdata,
    input app_tvalid,
    input app_tlast,
    input room,
    output logic app_tready,
    output logic wen,
    output logic [32:0] wdata
);
    logic in_frame;
    logic [1:0] idx;
    logic [23:0] acc;
    logic [31:0] word;
    logic [23:0] acc_next;
    logic hs;

    assign app_tready = (room | in_frame);
    assign word = ((idx == 0) ? {24'd0, app_tdata} :
                  ((idx == 1) ? {16'd0, app_tdata, acc[7:0]} :
                  ((idx == 2) ? {8'd0, app_tdata, acc[15:0]} :
                  {app_tdata, acc})));
    assign acc_next = ((idx == 0) ? {16'd0, app_tdata} :
                      ((idx == 1) ? {8'd0, {app_tdata, acc[7:0]}} :
                      ((idx == 2) ? {app_tdata, acc[15:0]} :
                      acc)));
    assign hs = (app_tvalid & app_tready);
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wen <= 0;
            in_frame <= 0;
            acc <= 0;
            wdata <= 0;
            idx <= 0;
        end else begin
            wen <= 0;
            if (hs) begin
                in_frame <= (~app_tlast);
                acc <= acc_next;
                if (((idx == 3) | app_tlast)) begin
                    wen <= 1;
                    wdata <= {app_tlast, word};
                    idx <= 0;
                end else begin
                    idx <= (idx + 1);
                end
            end
        end
    end
endmodule
