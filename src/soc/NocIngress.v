module NocIngress (
    input clk,
    input rst_n,
    input ar_valid,
    output logic ar_ready,
    input [3:0] ar_id,
    input [15:0] ar_tag,
    input [47:0] ar_addr,
    input [19:0] ar_bytes,
    input [15:0] ar_rows,
    input [19:0] ar_stride,
    input ar_first,
    input ar_last,
    input aw_valid,
    output logic aw_ready,
    input [3:0] aw_id,
    input [15:0] aw_tag,
    input [47:0] aw_addr,
    input [19:0] aw_bytes,
    input [15:0] aw_rows,
    input [19:0] aw_stride,
    input aw_first,
    input aw_last,
    output logic rd_v,
    output logic rd_nz,
    output logic rd_n1,
    output logic rd_nm,
    output logic rd_psh,
    input rd_pop,
    output logic rd_loc,
    output logic [3:0] rd_id,
    output logic [15:0] rd_tag,
    output logic [47:0] rd_addr,
    output logic [19:0] rd_bytes,
    output logic [15:0] rd_rows,
    output logic [19:0] rd_stride,
    output logic wr_v,
    output logic wr_nz,
    output logic wr_n1,
    output logic wr_nm,
    output logic wr_psh,
    input wr_pop,
    output logic wr_loc,
    output logic [3:0] wr_id,
    output logic [15:0] wr_tag,
    output logic [47:0] wr_addr,
    output logic [19:0] wr_bytes,
    output logic [15:0] wr_rows,
    output logic [19:0] wr_stride,
    output logic [3:0] occ
);
    logic [3:0] qrd_id [0:3];
    logic [15:0] qrd_tag [0:3];
    logic [47:0] qrd_addr [0:3];
    logic [19:0] qrd_bytes [0:3];
    logic [15:0] qrd_rows [0:3];
    logic [19:0] qrd_stride [0:3];
    logic [3:0] qwr_id [0:3];
    logic [15:0] qwr_tag [0:3];
    logic [47:0] qwr_addr [0:3];
    logic [19:0] qwr_bytes [0:3];
    logic [15:0] qwr_rows [0:3];
    logic [19:0] qwr_stride [0:3];
    logic [1:0] rd_wp;
    logic [1:0] rd_rp;
    logic [2:0] rd_cnt;
    logic [1:0] wr_wp;
    logic [1:0] wr_rp;
    logic [2:0] wr_cnt;
    logic rd_vq;
    logic wr_vq;
    logic rd_full;
    logic wr_full;
    logic rd_push;
    logic rd_v_n;
    logic rd_full_n;
    logic wr_push;
    logic wr_v_n;
    logic wr_full_n;

    assign occ = ({1'd0, rd_cnt} + {1'd0, wr_cnt});
    assign ar_ready = (~rd_full);
    assign rd_push = (ar_valid & (~rd_full));
    assign rd_v = rd_vq;
    assign rd_nz = (rd_cnt != 0);
    assign rd_n1 = (rd_cnt != 1);
    assign rd_nm = (rd_cnt != 7);
    assign rd_psh = rd_push;
    assign rd_v_n = (rd_pop ? (rd_push ? rd_nz : rd_n1) : (rd_push ? rd_nm : rd_nz));
    assign rd_full_n = ((rd_push & (~rd_pop)) ? (rd_cnt == 3) : ((rd_pop & (~rd_push)) ? (rd_cnt == 5) : (rd_cnt == 4)));
    assign rd_id = qrd_id[rd_rp];
    assign rd_tag = qrd_tag[rd_rp];
    assign rd_addr = qrd_addr[rd_rp];
    assign rd_bytes = qrd_bytes[rd_rp];
    assign rd_rows = qrd_rows[rd_rp];
    assign rd_stride = qrd_stride[rd_rp];
    assign rd_loc = (rd_addr[47:12] == 12288);
    assign aw_ready = (~wr_full);
    assign wr_push = (aw_valid & (~wr_full));
    assign wr_v = wr_vq;
    assign wr_nz = (wr_cnt != 0);
    assign wr_n1 = (wr_cnt != 1);
    assign wr_nm = (wr_cnt != 7);
    assign wr_psh = wr_push;
    assign wr_v_n = (wr_pop ? (wr_push ? wr_nz : wr_n1) : (wr_push ? wr_nm : wr_nz));
    assign wr_full_n = ((wr_push & (~wr_pop)) ? (wr_cnt == 3) : ((wr_pop & (~wr_push)) ? (wr_cnt == 5) : (wr_cnt == 4)));
    assign wr_id = qwr_id[wr_rp];
    assign wr_tag = qwr_tag[wr_rp];
    assign wr_addr = qwr_addr[wr_rp];
    assign wr_bytes = qwr_bytes[wr_rp];
    assign wr_rows = qwr_rows[wr_rp];
    assign wr_stride = qwr_stride[wr_rp];
    assign wr_loc = (wr_addr[47:12] == 12288);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            rd_wp <= 0;
            rd_rp <= 0;
            rd_cnt <= 0;
            rd_vq <= 0;
            rd_full <= 0;
            wr_wp <= 0;
            wr_rp <= 0;
            wr_cnt <= 0;
            wr_vq <= 0;
            wr_full <= 0;
        end else begin
            if (rd_push) begin
                rd_wp <= (rd_wp + 1);
            end
            if (rd_pop) begin
                rd_rp <= (rd_rp + 1);
            end
            rd_cnt <= ((rd_cnt + {4'd0, rd_push}) - {4'd0, rd_pop});
            rd_vq <= rd_v_n;
            rd_full <= rd_full_n;
            if (wr_push) begin
                wr_wp <= (wr_wp + 1);
            end
            if (wr_pop) begin
                wr_rp <= (wr_rp + 1);
            end
            wr_cnt <= ((wr_cnt + {4'd0, wr_push}) - {4'd0, wr_pop});
            wr_vq <= wr_v_n;
            wr_full <= wr_full_n;
        end
    end
    always_ff @(posedge clk) begin
        if (rd_push) begin
            qrd_id[rd_wp] <= ar_id;
            qrd_tag[rd_wp] <= ar_tag;
            qrd_addr[rd_wp] <= ar_addr;
            qrd_bytes[rd_wp] <= ar_bytes;
            qrd_rows[rd_wp] <= ar_rows;
            qrd_stride[rd_wp] <= ar_stride;
        end
        if (wr_push) begin
            qwr_id[wr_wp] <= aw_id;
            qwr_tag[wr_wp] <= aw_tag;
            qwr_addr[wr_wp] <= aw_addr;
            qwr_bytes[wr_wp] <= aw_bytes;
            qwr_rows[wr_wp] <= aw_rows;
            qwr_stride[wr_wp] <= aw_stride;
        end
    end
endmodule
