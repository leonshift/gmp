module NocLane (
    input clk,
    input rst_n,
    input rq_push,
    input [7:0] rq_tk,
    input [47:0] rq_addr,
    input [4:0] rq_slot,
    output logic rq_ok,
    input pop,
    output logic hv,
    output logic [7:0] h_tk,
    output logic [39:0] h_line,
    output logic [4:0] h_slot,
    output logic busy
);
    logic [7:0] q_tk [0:15];
    logic [39:0] q_line [0:15];
    logic [4:0] q_slot [0:15];
    logic [3:0] qwp;
    logic [3:0] qrp;
    logic [4:0] lcnt;
    logic s_v;
    logic [7:0] s_tk;
    logic [39:0] s_line;
    logic [4:0] s_slot;
    logic rq_okq;
    logic [39:0] rq_line;
    logic l_empty;
    logic pop_q;
    logic s_in;
    logic [5:0] occ;
    logic oc_m1;
    logic oc_0;
    logic oc_p1;
    logic rq_ok_n;

    assign rq_line = rq_addr[47:8];
    assign l_empty = (lcnt == 0);
    assign pop_q = (pop & (~l_empty));
    assign s_in = (s_v & (~(pop & l_empty)));
    assign rq_ok = rq_okq;
    assign occ = ({1'd0, lcnt} + {5'd0, s_v});
    assign oc_m1 = (occ != 15);
    assign oc_0 = (occ != 16);
    assign oc_p1 = (occ != 17);
    assign rq_ok_n = ((pop & l_empty) ? 1'd1 : (pop_q ? (rq_push ? oc_0 : oc_p1) : (rq_push ? oc_m1 : oc_0)));
    assign hv = ((~l_empty) | s_v);
    assign h_tk = (l_empty ? s_tk : q_tk[qrp]);
    assign h_line = (l_empty ? s_line : q_line[qrp]);
    assign h_slot = (l_empty ? s_slot : q_slot[qrp]);
    assign busy = ((~l_empty) | s_v);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            s_v <= 0;
            qwp <= 0;
            qrp <= 0;
            lcnt <= 0;
            rq_okq <= 1;
        end else begin
            s_v <= rq_push;
            if (s_in) begin
                qwp <= (qwp + 1);
            end
            if (pop_q) begin
                qrp <= (qrp + 1);
            end
            lcnt <= ((lcnt + {4'd0, s_in}) - {4'd0, pop_q});
            rq_okq <= rq_ok_n;
        end
    end
    always_ff @(posedge clk) begin
        s_tk <= rq_tk;
        s_line <= rq_line;
        s_slot <= rq_slot;
        if (s_in) begin
            q_tk[qwp] <= s_tk;
            q_line[qwp] <= s_line;
            q_slot[qwp] <= s_slot;
        end
    end
endmodule
