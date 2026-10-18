module BscanAxiBridge (
    input drck,
    input sel,
    input shift,
    input capture,
    input update,
    input tdi,
    output logic tdo,
    input clk,
    input rst_n,
    output logic [31:0] m_awaddr,
    output logic m_awvalid,
    input m_awready,
    output logic [31:0] m_wdata,
    output logic [3:0] m_wstrb,
    output logic m_wvalid,
    input m_wready,
    input [1:0] m_bresp,
    input m_bvalid,
    output logic m_bready,
    output logic [31:0] m_araddr,
    output logic m_arvalid,
    input m_arready,
    input [31:0] m_rdata,
    input [1:0] m_rresp,
    input m_rvalid,
    output logic m_rready
);
    logic [65:0] sr;
    logic ack_s1;
    logic ack_s2;
    logic [15:0] bn;
    logic [4:0] bbit;
    logic [31:0] wsr;
    logic wtgl;
    logic [31:0] wadr;
    logic bsync;
    logic [31:0] rsr;
    logic rcons;
    logic [31:0] b_addr;
    logic [15:0] b_len;
    logic b_rd;
    logic [1:0] req_cmd;
    logic [31:0] req_addr;
    logic [31:0] req_wdata;
    logic req_tgl;
    logic req_s1;
    logic req_s2;
    logic req_s3;
    logic ack_tgl;
    logic awvalid_q;
    logic wvalid_q;
    logic arvalid_q;
    logic [31:0] rdata_q;
    logic err_q;
    logic wtgl_s1;
    logic wtgl_s2;
    logic wtgl_s3;
    logic b_busy;
    logic bov;
    logic rcons_s1;
    logic rcons_s2;
    logic rcons_s3;
    logic [31:0] rb_addr;
    logic [15:0] rb_left;
    logic [31:0] rpf_data;
    logic done;
    logic [31:0] wnext;

    always_comb begin
        tdo = ((b_rd & (bn != 0)) ? rsr[0] : sr[0]);
        m_awaddr = (b_busy ? wadr : req_addr);
        m_awvalid = awvalid_q;
        m_wdata = (b_busy ? wsr : req_wdata);
        m_wstrb = 15;
        m_wvalid = wvalid_q;
        m_bready = 1;
        m_araddr = ((rb_left != 0) ? rb_addr : req_addr);
        m_arvalid = arvalid_q;
        m_rready = 1;
    end
    assign done = (~(req_tgl ^ ack_s2));
    assign wnext = {tdi, wsr[31:1]};
    always_ff @(posedge drck) begin
        ack_s1 <= ack_tgl;
        ack_s2 <= ack_s1;
        if ((sel & capture)) begin
            sr <= {32'd0, rdata_q, err_q, done};
            bn <= b_len;
            bbit <= 0;
            if (b_rd) begin
                rsr <= rpf_data;
                rcons <= (~rcons);
                bsync <= 0;
            end else begin
                bsync <= (b_len != 0);
            end
        end else begin
            if ((sel & shift)) begin
                if ((bn != 0)) begin
                    if (b_rd) begin
                        if ((bbit == 31)) begin
                            rsr <= rpf_data;
                            rcons <= (~rcons);
                            bbit <= 0;
                            bn <= (bn - 1);
                        end else begin
                            rsr <= {1'd0, rsr[31:1]};
                            bbit <= (bbit + 1);
                        end
                    end else begin
                        if (bsync) begin
                            wsr <= wnext;
                            if ((wnext == 32'd2779077210)) begin
                                bsync <= 0;
                                bbit <= 0;
                            end
                        end else begin
                            wsr <= {tdi, wsr[31:1]};
                            if ((bbit == 31)) begin
                                bbit <= 0;
                                wadr <= (b_addr + ((b_len - bn) << 2));
                                wtgl <= (~wtgl);
                                bn <= (bn - 1);
                            end else begin
                                bbit <= (bbit + 1);
                            end
                        end
                    end
                end else begin
                    sr <= {tdi, sr[65:1]};
                end
            end
        end
    end
    always_ff @(posedge update) begin
        if (sel) begin
            if ((b_len != 0)) begin
                b_len <= 0;
                b_rd <= 0;
            end else begin
                if ((sr[1:0] == 3)) begin
                    b_addr <= sr[33:2];
                    b_len <= sr[49:34];
                    b_rd <= sr[50];
                    if (sr[50]) begin
                        req_cmd <= 3;
                        req_addr <= sr[33:2];
                        req_tgl <= (~req_tgl);
                    end
                end else begin
                    req_cmd <= sr[1:0];
                    req_addr <= sr[33:2];
                    req_wdata <= sr[65:34];
                    if ((sr[1:0] != 0)) begin
                        req_tgl <= (~req_tgl);
                    end
                end
            end
        end
    end
    always_ff @(posedge clk) begin
        if ((!rst_n)) begin
            req_s1 <= 0;
            req_s2 <= 0;
            req_s3 <= 0;
            ack_tgl <= 0;
            awvalid_q <= 0;
            wvalid_q <= 0;
            arvalid_q <= 0;
            err_q <= 0;
            wtgl_s1 <= 0;
            wtgl_s2 <= 0;
            wtgl_s3 <= 0;
            b_busy <= 0;
            bov <= 0;
            rcons_s1 <= 0;
            rcons_s2 <= 0;
            rcons_s3 <= 0;
            rb_left <= 0;
        end else begin
            req_s1 <= req_tgl;
            req_s2 <= req_s1;
            req_s3 <= req_s2;
            wtgl_s1 <= wtgl;
            wtgl_s2 <= wtgl_s1;
            wtgl_s3 <= wtgl_s2;
            rcons_s1 <= rcons;
            rcons_s2 <= rcons_s1;
            rcons_s3 <= rcons_s2;
            if ((wtgl_s2 ^ wtgl_s3)) begin
                if (b_busy) begin
                    bov <= 1;
                end else begin
                    awvalid_q <= 1;
                    wvalid_q <= 1;
                    b_busy <= 1;
                end
            end
            if ((req_s2 ^ req_s3)) begin
                if ((req_cmd == 3)) begin
                    rb_addr <= req_addr;
                    rb_left <= b_len;
                    arvalid_q <= 1;
                end else begin
                    if ((req_cmd == 2)) begin
                        awvalid_q <= 1;
                        wvalid_q <= 1;
                    end else begin
                        if ((req_cmd == 1)) begin
                            arvalid_q <= 1;
                        end
                    end
                end
            end
            if ((rcons_s2 ^ rcons_s3)) begin
                if ((rb_left != 0)) begin
                    arvalid_q <= 1;
                end
            end
            if ((awvalid_q & m_awready)) begin
                awvalid_q <= 0;
            end
            if ((wvalid_q & m_wready)) begin
                wvalid_q <= 0;
            end
            if ((arvalid_q & m_arready)) begin
                arvalid_q <= 0;
            end
            if (m_bvalid) begin
                err_q <= (m_bresp[1] | bov);
                b_busy <= 0;
                if ((!b_busy)) begin
                    ack_tgl <= (~ack_tgl);
                end
            end
            if (m_rvalid) begin
                if ((rb_left != 0)) begin
                    rpf_data <= m_rdata;
                    rb_addr <= (rb_addr + 4);
                    rb_left <= (rb_left - 1);
                    err_q <= m_rresp[1];
                    if ((rb_left == 1)) begin
                        ack_tgl <= (~ack_tgl);
                    end
                end else begin
                    rdata_q <= m_rdata;
                    err_q <= m_rresp[1];
                    ack_tgl <= (~ack_tgl);
                end
            end
        end
    end
endmodule
