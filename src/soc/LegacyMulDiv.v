module LegacyMulDiv #(
    parameter SERIAL = 0
) (
    input clk,
    input rst_n,
    input fast_small,
    input start,
    input consume,
    input [31:0] a,
    input [31:0] b,
    input [2:0] op,
    output logic ready,
    output logic [31:0] result
);
    logic [3:0] phase;
    logic [2:0] fn;
    logic [31:0] ma;
    logic [31:0] mb;
    logic sa;
    logic sb;
    logic [31:0] pp_0;
    logic [31:0] pp_1;
    logic [31:0] pp_2;
    logic [31:0] pp_3;
    logic [31:0] correction;
    logic [63:0] product;
    logic [1:0] mul_index;
    logic [63:0] mul_acc;
    logic [15:0] part_a;
    logic [15:0] part_b;
    logic [2:0] radix_index;
    logic [39:0] radix_product;
    logic [31:0] value;
    logic [63:0] unsigned_product;
    logic [63:0] serial_term;
    logic [63:0] serial_sum;
    logic [39:0] radix_sum;
    logic [63:0] radix_next;
    logic [63:0] radix_value;
    logic fast;
    logic [16:0] fast_product;

    assign unsigned_product = ((({32'd0, pp_0} + ({32'd0, pp_1} << 16)) + ({32'd0, pp_2} << 16))
                               + ({32'd0, pp_3} << 32));
    assign serial_term = (((phase == 8) & (fn != 0)) ? ({32'd0, pp_0} << 32) :
                         ((mul_index == 1) ? {32'd0, pp_0} :
                         ({32'd0, pp_0} << 16)));
    assign serial_sum = (mul_acc + serial_term);
    assign radix_sum = (radix_product + {8'd0, mul_acc[63:32]});
    assign radix_next = ((SERIAL == 2) ? {radix_sum, mul_acc[31:8]} : {radix_sum[35:0], mul_acc[31:4]});
    assign radix_value = ((SERIAL == 2) ? (radix_next >> {radix_index[1:0], 3'd0}) :
                         (radix_next >> {radix_index, 2'd0}));
    assign fast = ((((phase == 0) & start) & (op == 0)) & fast_small);
    assign fast_product = (a[8:0] * b[7:0]);
    assign ready = ((phase == 6) | fast);
    assign result = (fast ? {15'd0, fast_product} : value);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            fn <= 0;
            sa <= 0;
            sb <= 0;
            radix_index <= 0;
            phase <= 0;
            mul_index <= 0;
            value <= 0;
        end else begin
            if ((phase == 0)) begin
                if ((start & (~fast))) begin
                    fn <= op;
                    sa <= (a[31] & ((op == 1) | (op == 2)));
                    sb <= (b[31] & (op == 1));
                    if ((SERIAL >= 2)) begin
                        radix_index <= ((SERIAL == 2) ? 3'd3 : 3'd7);
                        phase <= 9;
                    end else begin
                        if ((SERIAL == 1)) begin
                            mul_index <= 0;
                            phase <= 7;
                        end else begin
                            phase <= 1;
                        end
                    end
                end
            end else begin
                if (((phase == 1) & (SERIAL == 0))) begin
                    phase <= 2;
                end else begin
                    if (((phase == 2) & (SERIAL == 0))) begin
                        if ((fn == 0)) begin
                            value <= unsigned_product[31:0];
                            phase <= 6;
                        end else begin
                            phase <= 3;
                        end
                    end else begin
                        if ((phase == 3)) begin
                            value <= (((SERIAL == 0) & (fn == 0)) ? product[31:0] : (product[63:32] - correction));
                            phase <= 6;
                        end else begin
                            if ((phase == 6)) begin
                                if (consume) begin
                                    phase <= 0;
                                end
                            end else begin
                                if (((phase == 7) & (SERIAL == 1))) begin
                                    mul_index <= (mul_index + 1);
                                    if (((mul_index == 3) | ((fn == 0) & (mul_index == 2)))) begin
                                        phase <= 8;
                                    end
                                end else begin
                                    if (((phase == 8) & (SERIAL == 1))) begin
                                        if ((fn == 0)) begin
                                            value <= serial_sum[31:0];
                                            phase <= 6;
                                        end else begin
                                            phase <= 3;
                                        end
                                    end else begin
                                        if (((phase == 9) & (SERIAL >= 2))) begin
                                            if (((radix_index == 0)
                                                 | ((SERIAL == 2) ? (mb[31:8] == 0) : (mb[31:4] == 0)))) begin
                                                phase <= 10;
                                            end else begin
                                                radix_index <= (radix_index - 1);
                                            end
                                        end else begin
                                            if (((phase == 10) & (SERIAL >= 2))) begin
                                                if ((fn == 0)) begin
                                                    value <= radix_value[31:0];
                                                    phase <= 6;
                                                end else begin
                                                    phase <= 3;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always_ff @(posedge clk) begin
        if ((phase == 0)) begin
            if ((start & (~fast))) begin
                ma <= a;
                mb <= b;
                if ((SERIAL >= 2)) begin
                    mul_acc <= 0;
                end else begin
                    if ((SERIAL == 1)) begin
                        mul_acc <= 0;
                        part_a <= a[15:0];
                        part_b <= b[15:0];
                    end
                end
            end
        end else begin
            if (((phase == 1) & (SERIAL == 0))) begin
                pp_0 <= (ma[15:0] * mb[15:0]);
                pp_1 <= (ma[15:0] * mb[31:16]);
                pp_2 <= (ma[31:16] * mb[15:0]);
                pp_3 <= (ma[31:16] * mb[31:16]);
                correction <= ((sa ? mb : 32'd0) + (sb ? ma : 32'd0));
            end else begin
                if (((phase == 2) & (SERIAL == 0))) begin
                    if ((!(fn == 0))) begin
                        product <= unsigned_product;
                    end
                end else begin
                    if ((!(phase == 3))) begin
                        if ((!(phase == 6))) begin
                            if (((phase == 7) & (SERIAL == 1))) begin
                                pp_0 <= (part_a * part_b);
                                part_a <= ((mul_index == 0) ? ma[15:0] : ma[31:16]);
                                part_b <= ((mul_index == 1) ? mb[15:0] : mb[31:16]);
                                correction <= ((sa ? mb : 32'd0) + (sb ? ma : 32'd0));
                                if ((mul_index != 0)) begin
                                    mul_acc <= serial_sum;
                                end
                            end else begin
                                if (((phase == 8) & (SERIAL == 1))) begin
                                    if ((!(fn == 0))) begin
                                        product <= serial_sum;
                                    end
                                end else begin
                                    if (((phase == 9) & (SERIAL >= 2))) begin
                                        radix_product <= ((SERIAL == 2) ? (ma * mb[7:0]) : (ma * mb[3:0]));
                                        mb <= ((SERIAL == 2) ? (mb >> 8) : (mb >> 4));
                                        if ((radix_index == ((SERIAL == 2) ? 3'd3 : 3'd7))) begin
                                            correction <= ((sa ? mb : 32'd0) + (sb ? ma : 32'd0));
                                        end else begin
                                            mul_acc <= radix_next;
                                        end
                                    end else begin
                                        if (((phase == 10) & (SERIAL >= 2))) begin
                                            if ((!(fn == 0))) begin
                                                product <= radix_value;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
endmodule
