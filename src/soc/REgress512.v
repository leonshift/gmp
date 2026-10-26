module REgress512 (
    input clk,
    input rst_n,
    input i_valid,
    output logic i_ready,
    input [511:0] i_data,
    input [3:0] i_id,
    input [15:0] i_tag,
    input i_last,
    output logic o_valid,
    input o_ready,
    output logic [511:0] o_data,
    output logic [3:0] o_id,
    output logic [15:0] o_tag,
    output logic o_last
);
    logic [511:0] q_dat [0:1];
    logic [3:0] q_id [0:1];
    logic [15:0] q_tag [0:1];
    logic q_last [0:1];
    logic wp;
    logic rp;
    logic [1:0] n;
    logic [511:0] od;
    logic [3:0] oi;
    logic [15:0] ot;
    logic ol;
    logic ov;
    logic q_free;
    logic push;
    logic take;
    logic [1:0] n_nx;

    assign push = (i_valid & q_free);
    assign take = ((n != 0) & ((~ov) | o_ready));
    assign i_ready = q_free;
    assign o_valid = ov;
    assign o_data = od;
    assign o_id = oi;
    assign o_tag = ot;
    assign o_last = ol;
    assign n_nx = ((push & (~take)) ? (n + 2'd1) : ((take & (~push)) ? (n - 2'd1) : n));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wp <= 0;
            rp <= 0;
            ov <= 0;
            n <= 0;
            q_free <= 1;
        end else begin
            if (push) begin
                wp <= (wp + 1);
            end
            if (take) begin
                rp <= (rp + 1);
                ov <= 1;
            end else begin
                if (o_ready) begin
                    ov <= 0;
                end
            end
            n <= n_nx;
            q_free <= (n_nx != 2);
        end
    end
    always_ff @(posedge clk) begin
        if (q_free) begin
            q_dat[wp] <= i_data;
            q_id[wp] <= i_id;
            q_tag[wp] <= i_tag;
            q_last[wp] <= i_last;
        end
        if (take) begin
            od <= q_dat[rp];
            oi <= q_id[rp];
            ot <= q_tag[rp];
            ol <= q_last[rp];
        end
    end
endmodule
