module RlinkAxiBridge (
    input clk,
    input rst_n,
    input rx_valid,
    input [32:0] rx_data,
    input tx_room,
    input m_awready,
    input m_wready,
    input [1:0] m_bresp,
    input m_bvalid,
    input m_arready,
    input [31:0] m_rdata,
    input [1:0] m_rresp,
    input m_rvalid,
    output logic m_awvalid,
    output logic m_wvalid,
    output logic [31:0] m_wdata,
    output logic m_arvalid,
    output logic [31:0] m_awaddr,
    output logic [31:0] m_araddr,
    output logic [3:0] m_wstrb,
    output logic m_bready,
    output logic m_rready,
    output logic tx_wen,
    output logic [32:0] tx_wdata,
    output logic rx_pop
);
    logic [3:0] st;
    logic [7:0] op;
    logic [15:0] n;
    logic [15:0] cnt;
    logic [31:0] addr;
    logic [31:0] base;
    logic [7:0] err;
    logic last_r;
    logic after_drain;
    logic aw_done;
    logic w_done;
    logic [31:0] rbuf [0:511];
    logic want;
    logic rx_last;
    logic [7:0] hdr_op;
    logic [15:0] hdr_n;
    logic n_ok;

    initial begin
        for (int _i = 0; _i < 512; _i++) rbuf[_i] = 0;
    end

    assign m_awaddr = addr;
    assign m_araddr = addr;
    assign m_wstrb = 4'd15;
    assign m_bready = 1'd1;
    assign m_rready = 1'd1;
    assign want = ((((st == 0) | (st == 1)) | (st == 2)) | (st == 11));
    assign rx_pop = (rx_valid & want);
    assign rx_last = rx_data[32];
    assign hdr_op = rx_data[7:0];
    assign hdr_n = rx_data[31:16];
    assign n_ok = (n <= 366);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            tx_wen <= 0;
            op <= 0;
            n <= 0;
            st <= 0;
            addr <= 0;
            base <= 0;
            cnt <= 0;
            err <= 0;
            after_drain <= 0;
            m_wdata <= 0;
            last_r <= 0;
            m_awvalid <= 0;
            m_wvalid <= 0;
            aw_done <= 0;
            w_done <= 0;
            tx_wdata <= 0;
            m_arvalid <= 0;
        end else begin
            tx_wen <= 0;
            case (st)
                0: begin
                    if ((rx_valid & (~rx_last))) begin
                        op <= hdr_op;
                        n <= hdr_n;
                        st <= 1;
                    end
                end
                1: begin
                    if (rx_valid) begin
                        addr <= rx_data[31:0];
                        base <= rx_data[31:0];
                        cnt <= 0;
                        err <= 0;
                        if (((op == 17) & n_ok)) begin
                            if (rx_last) begin
                                if ((n != 0)) begin
                                    err <= 2;
                                end
                                st <= 4;
                            end else begin
                                if ((n == 0)) begin
                                    err <= 2;
                                    after_drain <= 1;
                                    st <= 11;
                                end else begin
                                    st <= 2;
                                end
                            end
                        end else begin
                            if ((((op == 18) & n_ok) & rx_last)) begin
                                if ((n == 0)) begin
                                    st <= 8;
                                end else begin
                                    st <= 6;
                                end
                            end else begin
                                if (rx_last) begin
                                    st <= 0;
                                end else begin
                                    after_drain <= 0;
                                    st <= 11;
                                end
                            end
                        end
                    end
                end
                2: begin
                    if (rx_valid) begin
                        m_wdata <= rx_data[31:0];
                        last_r <= rx_last;
                        m_awvalid <= 1;
                        m_wvalid <= 1;
                        aw_done <= 0;
                        w_done <= 0;
                        st <= 3;
                    end
                end
                3: begin
                    if ((m_awvalid & m_awready)) begin
                        m_awvalid <= 0;
                        aw_done <= 1;
                    end
                    if ((m_wvalid & m_wready)) begin
                        m_wvalid <= 0;
                        w_done <= 1;
                    end
                    if (m_bvalid) begin
                        err <= (err | {7'd0, m_bresp[1]});
                        cnt <= (cnt + 1);
                        addr <= (addr + 4);
                        if (last_r) begin
                            if (((cnt + 1) != n)) begin
                                err <= (err | 2);
                            end
                            st <= 4;
                        end else begin
                            if (((cnt + 1) == n)) begin
                                err <= (err | 2);
                                after_drain <= 1;
                                st <= 11;
                            end else begin
                                st <= 2;
                            end
                        end
                    end
                end
                4: begin
                    if (tx_room) begin
                        tx_wen <= 1;
                        tx_wdata <= {1'd0, n, err, 8'd145};
                        st <= 5;
                    end
                end
                5: begin
                    if (tx_room) begin
                        tx_wen <= 1;
                        tx_wdata <= {1'd1, base};
                        st <= 0;
                    end
                end
                6: begin
                    m_arvalid <= 1;
                    st <= 7;
                end
                7: begin
                    if ((m_arvalid & m_arready)) begin
                        m_arvalid <= 0;
                    end
                    if (m_rvalid) begin
                        rbuf[cnt[8:0]] <= m_rdata;
                        err <= (err | {7'd0, m_rresp[1]});
                        cnt <= (cnt + 1);
                        addr <= (addr + 4);
                        if (((cnt + 1) == n)) begin
                            st <= 8;
                        end else begin
                            st <= 6;
                        end
                    end
                end
                8: begin
                    if (tx_room) begin
                        tx_wen <= 1;
                        tx_wdata <= {1'd0, n, err, 8'd146};
                        st <= 9;
                    end
                end
                9: begin
                    if (tx_room) begin
                        tx_wen <= 1;
                        tx_wdata <= {(n == 0), base};
                        cnt <= 0;
                        if ((n == 0)) begin
                            st <= 0;
                        end else begin
                            st <= 10;
                        end
                    end
                end
                10: begin
                    if (tx_room) begin
                        tx_wen <= 1;
                        tx_wdata <= {((cnt + 1) == n), rbuf[cnt[8:0]]};
                        cnt <= (cnt + 1);
                        if (((cnt + 1) == n)) begin
                            st <= 0;
                        end
                    end
                end
                11: begin
                    if ((rx_valid & rx_last)) begin
                        if (after_drain) begin
                            st <= 4;
                        end else begin
                            st <= 0;
                        end
                    end
                end
            endcase
        end
    end
endmodule
