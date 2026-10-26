module Predictor_ENTRIES8 (
    input clk,
    input rst_n,
    input [31:0] query_pc,
    input update,
    input [31:0] update_pc,
    input [31:0] update_target,
    input update_taken,
    input update_control,
    output logic [31:0] next_pc
);
    logic [7:0] present;
    logic [26:0] tags [0:7];
    logic [29:0] targets [0:7];
    logic [1:0] direction [0:7];
    logic [2:0] qi;
    logic [2:0] ui;
    logic hit;
    logic train_hit;
    logic [1:0] counter;
    logic predict;

    initial begin
        for (int _i = 0; _i < 8; _i++) tags[_i] = 0;
        for (int _i = 0; _i < 8; _i++) targets[_i] = 0;
        for (int _i = 0; _i < 8; _i++) direction[_i] = 0;
    end

    assign qi = query_pc[4:2];
    assign ui = update_pc[4:2];
    assign hit = (present[qi] & (tags[qi] == query_pc[31:5]));
    assign train_hit = (present[ui] & (tags[ui] == update_pc[31:5]));
    assign counter = direction[ui];
    assign predict = (hit & direction[qi][1]);
    assign next_pc = (predict ? {targets[qi], 2'd0} : (query_pc + 4));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            present <= 0;
        end else begin
            if (update) begin
                if (update_control) begin
                    present[ui] <= 1;
                    tags[ui] <= update_pc[31:5];
                    if (update_taken) begin
                        targets[ui] <= update_target[31:2];
                    end
                    if ((~train_hit)) begin
                        direction[ui] <= (update_taken ? 2'd2 : 2'd1);
                    end else begin
                        if (update_taken) begin
                            if ((counter != 3)) begin
                                direction[ui] <= (counter + 1);
                            end
                        end else begin
                            if ((counter != 0)) begin
                                direction[ui] <= (counter - 1);
                            end
                        end
                    end
                end else begin
                    if (train_hit) begin
                        present[ui] <= 0;
                    end
                end
            end
        end
    end
endmodule
