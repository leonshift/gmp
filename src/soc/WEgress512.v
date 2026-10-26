module WEgress512 (
    input clk,
    input rst_n,
    input i_valid,
    input [3:0] i_id,
    input [511:0] i_data,
    input [63:0] i_strb,
    output logic [7:0] i_ready,
    output logic o_valid,
    output logic [3:0] o_id,
    output logic [511:0] o_data,
    output logic [63:0] o_strb,
    input [7:0] o_ready
);
    logic [3:0] q_id [0:1];
    logic [511:0] q_dat [0:1];
    logic [63:0] q_stb [0:1];
    logic wp;
    logic rp;
    logic [1:0] n;
    logic ir_v;
    logic [3:0] ir_id;
    logic [511:0] ir_dat;
    logic [63:0] ir_stb;
    logic q_free;
    logic xfer;
    logic ir_free;
    logic acc_in;
    logic [3:0] h_id;
    logic [7:0] o_rdy_sh;
    logic acc_out;
    logic [511:0] od;
    logic [63:0] os;
    logic ir_v_nx;
    logic [1:0] n_nx;

    assign xfer = (ir_v & q_free);
    assign acc_in = (i_valid & ir_free);
    assign h_id = q_id[rp];
    assign o_rdy_sh = (o_ready >> h_id[2:0]);
    assign acc_out = ((n != 0) & o_rdy_sh[0]);
    assign i_ready = (acc_in ? (8'd1 << i_id[2:0]) : 8'd0);
    assign o_valid = (n != 0);
    assign o_id = h_id;
    assign o_data = od;
    assign o_strb = os;
    assign ir_v_nx = (acc_in ? 1'd1 : (xfer ? 1'd0 : ir_v));
    assign n_nx = ((xfer & (~acc_out)) ? (n + 2'd1) : ((acc_out & (~xfer)) ? (n - 2'd1) : n));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wp <= 0;
            rp <= 0;
            ir_v <= 0;
            n <= 0;
            q_free <= 1;
            ir_free <= 1;
        end else begin
            if (xfer) begin
                wp <= (wp + 1);
            end
            if (acc_out) begin
                rp <= (rp + 1);
            end
            ir_v <= ir_v_nx;
            n <= n_nx;
            q_free <= (n_nx != 2);
            ir_free <= ((~ir_v_nx) | (n_nx != 2));
        end
    end
    always_ff @(posedge clk) begin
        od <= q_dat[rp];
        os <= q_stb[rp];
        if (q_free) begin
            q_id[wp] <= ir_id;
            q_dat[wp] <= ir_dat;
            q_stb[wp] <= ir_stb;
        end
        if (ir_free) begin
            ir_id <= i_id;
            ir_dat <= i_data;
            ir_stb <= i_strb;
        end
    end
endmodule
