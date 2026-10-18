module Rv32Soc #(
    parameter PREDICT = 2,
    parameter TRACE = 1,
    parameter PERF = 0
) (
    input clk,
    input rst_n,
    input [31:0] clock_measurement,
    input h_valid,
    input h_write,
    input [31:0] h_addr,
    input [31:0] h_data,
    input [3:0] h_strb,
    input h_rready,
    output logic h_ready,
    output logic h_rvalid,
    output logic [31:0] h_rdata,
    output logic h_error,
    output logic halt_o,
    output logic [3:0] cause_o,
    output logic trace_valid,
    output logic [31:0] trace_pc,
    output logic [31:0] trace_inst,
    output logic [4:0] trace_rd,
    output logic [31:0] trace_data,
    output logic trace_store,
    output logic [31:0] trace_addr,
    output logic [31:0] trace_wdata,
    output logic [3:0] trace_mask,
    output logic trace_trap
);
    logic go;
    logic [31:0] seeds_0;
    logic [31:0] seeds_1;
    logic [31:0] seeds_2;
    logic [31:0] seeds_3;
    logic [31:0] ticks;
    logic [7:0] prescaler;
    logic [63:0] cycles;
    logic [63:0] timer_cycles [0:31];
    logic [31:0] timer_ticks [0:31];
    logic [5:0] timer_count;
    logic timer_overflow;
    logic [7:0] uart [0:127];
    logic [6:0] uart_wp;
    logic [6:0] uart_rp;
    logic [7:0] uart_count;
    logic rsp_v;
    logic [31:0] rsp_d;
    logic rsp_mem;
    logic rsp_error;
    logic cpu_mem_q;
    logic [31:0] cpu_mmio_q;
    logic cpu_error_q;
    logic fetch_error_q;
    logic fetch_retry_q;
    logic uart_pending;
    logic [7:0] uart_pending_data;
    logic timer_pending;
    logic [63:0] timer_cycles_q;
    logic [31:0] timer_ticks_q;
    logic invalid_pending;
    logic [31:0] invalid;
    logic host_fire;
    logic host_ram;
    logic host_mem;
    logic host_regs;
    logic [11:0] host_off;
    logic host_cfg;
    logic host_control;
    logic start_run;
    logic stop_run;
    logic uart_pop;
    logic [31:0] cpu_load_data;
    logic cpu_ram;
    logic cpu_mmio_region;
    logic cpu_read_word;
    logic cpu_write_byte;
    logic config_offset;
    logic timer_offset;
    logic uart_offset;
    logic cpu_timer;
    logic cpu_uart;
    logic cpu_access_valid;
    logic uart_capacity;
    logic cpu_ready;
    logic cpu_fire;
    logic uart_accept;
    logic uart_push;
    logic timer_commit;
    logic invalid_access;
    logic fetch_collision;
    logic fetch_fire;
    logic [14:0] memory_b_base;
    logic memory_b_ram_grant;
    logic [14:0] memory_b_address;
    logic [1:0] config_index;
    logic [1:0] host_index;
    logic [4:0] history_index;
    logic [63:0] history_cycles;
    logic [31:0] history_ticks;
    logic [31:0] history_word;
    logic [31:0] status;
    logic [31:0] counter_word;
    logic [31:0] read_value;
    logic [31:0] u_ilm_dlm_a_q;
    logic [17:0] u_ilm_dlm_a_prediction;
    logic [1:0] u_ilm_dlm_b_zero_hint_q;
    logic [31:0] u_core_i_addr;
    logic u_core_d_store_valid;
    logic u_core_d_store_local;
    logic [3:0] u_core_d_wstrb;
    logic [31:0] u_core_d_wdata;
    logic [17:0] u_core_program_prediction;
    logic [1:0] u_core_d_zero_encode;
    logic [1:0] u_core_program_zero_encode;
    logic [31:0] u_ilm_dlm_b_q;
    logic [31:0] u_core_d_addr;
    logic u_core_d_write;
    logic [2:0] u_core_d_f3;
    logic u_core_d_valid;
    logic [14:0] u_core_d_store_word;
    logic u_core_i_valid;
    logic u_core_d_address_forward;
    logic u_core_halt_o;
    logic [3:0] u_core_cause_o;
    logic [63:0] u_core_retired_o;
    logic [31:0] u_core_trap_pc_o;
    logic [31:0] u_core_trap_value_o;
    logic [63:0] u_core_load_stalls_o;
    logic [63:0] u_core_muldiv_stalls_o;
    logic [63:0] u_core_redirects_o;
    logic u_core_trace_valid;
    logic [31:0] u_core_trace_pc;
    logic [31:0] u_core_trace_inst;
    logic [4:0] u_core_trace_rd;
    logic [31:0] u_core_trace_data;
    logic u_core_trace_store;
    logic [31:0] u_core_trace_addr;
    logic [31:0] u_core_trace_wdata;
    logic [3:0] u_core_trace_mask;
    logic u_core_trace_trap;
    logic [7:0] u_core_d_byte;

    initial begin
        for (int _i = 0; _i < 32; _i++) timer_cycles[_i] = 0;
        for (int _i = 0; _i < 32; _i++) timer_ticks[_i] = 0;
        for (int _i = 0; _i < 128; _i++) uart[_i] = 0;
    end

    assign h_ready = (~rsp_v);
    assign h_rvalid = rsp_v;
    assign h_rdata = (rsp_mem ? u_ilm_dlm_b_q : rsp_d);
    assign h_error = rsp_error;
    assign host_fire = (h_valid & h_ready);
    assign host_ram = (h_addr < 131072);
    assign host_mem = (((host_fire & host_ram) & (~go)) & (h_addr[1:0] == 0));
    assign host_regs = ((h_addr[31:12] == 131072) & (h_addr[1:0] == 0));
    assign host_off = h_addr[11:0];
    assign host_cfg = ((host_off >= 48) & (host_off <= 60));
    assign host_control = ((((host_fire & host_regs) & h_write) & (host_off == 4)) & (h_strb == 15));
    assign start_run = ((host_control & h_data[0]) & (~go));
    assign stop_run = (host_control & (~h_data[0]));
    assign uart_pop = ((((host_fire & host_regs) & (~h_write)) & (host_off == 20)) & (uart_count != 0));
    assign cpu_load_data = (cpu_mem_q ? u_ilm_dlm_b_q : cpu_mmio_q);
    assign cpu_ram = (u_core_d_addr < 131072);
    assign cpu_mmio_region = (u_core_d_addr[31:6] == 26'd67108863);
    assign cpu_read_word = ((~u_core_d_write) & (u_core_d_f3 == 2));
    assign cpu_write_byte = (u_core_d_write & (u_core_d_f3 == 0));
    assign config_offset = ((u_core_d_addr[5:4] == 2'd1) & (u_core_d_addr[1:0] == 0));
    assign timer_offset = (u_core_d_addr[5:0] == 6'd56);
    assign uart_offset = (u_core_d_addr[5:0] == 6'd60);
    assign cpu_timer = ((cpu_mmio_region & cpu_read_word) & timer_offset);
    assign cpu_uart = ((cpu_mmio_region & cpu_write_byte) & uart_offset);
    assign cpu_access_valid = (cpu_ram | (cpu_mmio_region & ((cpu_read_word & (config_offset | timer_offset)) | (cpu_write_byte & uart_offset))));
    assign uart_capacity = ((uart_count < 127) | ((uart_count == 127) & (~uart_pending)));
    assign cpu_ready = (((~u_core_d_write) | (u_core_d_f3 != 0)) | uart_capacity);
    assign cpu_fire = ((go & u_core_d_valid) & cpu_ready);
    assign uart_accept = (cpu_fire & cpu_uart);
    assign uart_push = (uart_pending & go);
    assign timer_commit = (timer_pending & go);
    assign invalid_access = (cpu_fire & (~cpu_access_valid));
    assign fetch_collision = (((u_core_d_store_valid & cpu_ready) & u_core_d_store_local) & (u_core_i_addr[7:2] == u_core_d_store_word[5:0]));
    assign fetch_fire = ((go & u_core_i_valid) & 1'd1);
    assign memory_b_base = ((((~go) ? h_addr[16:2] : 0) | (((go & u_core_d_address_forward) & (~cpu_mem_q)) ? cpu_mmio_q[16:2] : 0)) | ((go & (~u_core_d_address_forward)) ? u_core_d_store_word : 0));
    assign memory_b_ram_grant = ((go & u_core_d_address_forward) & cpu_mem_q);
    assign memory_b_address = (memory_b_base | (u_ilm_dlm_b_q[16:2] & {15{memory_b_ram_grant}}));
    assign config_index = u_core_d_addr[3:2];
    assign host_index = host_off[3:2];
    assign history_index = {(~host_off[8]), host_off[7:4]};
    assign history_cycles = timer_cycles[history_index];
    assign history_ticks = timer_ticks[history_index];
    assign history_word = ((host_off[3:2] == 0) ? history_cycles[31:0] : ((host_off[3:2] == 1) ? history_cycles[63:32] : ((host_off[3:2] == 2) ? history_ticks : 32'd0)));
    assign status = {29'd0, (u_core_halt_o & (u_core_cause_o != 3)), u_core_halt_o, go};
    assign counter_word = ((host_off[5:2] == 0) ? 32'd0 : ((host_off[5:2] == 1) ? 32'd0 : ((host_off[5:2] == 2) ? 32'd0 : ((host_off[5:2] == 3) ? 32'd0 : ((host_off[5:2] == 4) ? 32'd0 : ((host_off[5:2] == 5) ? 32'd0 : ((host_off[5:2] == 6) ? 32'd0 : ((host_off[5:2] == 7) ? cycles[31:0] : ((host_off[5:2] == 8) ? cycles[63:32] : ((host_off[5:2] == 9) ? u_core_retired_o[31:0] : ((host_off[5:2] == 10) ? u_core_retired_o[63:32] : ((host_off[5:2] == 11) ? invalid : ((host_off[5:2] == 12) ? 32'd0 : ((host_off[5:2] == 13) ? 32'd0 : ((host_off[5:2] == 14) ? 32'd0 : 32'd0)))))))))))))));
    assign read_value = ((host_off == 0) ? 32'd1381380914 : ((host_off == 4) ? {31'd0, go} : ((host_off == 8) ? status : ((host_off == 12) ? {28'd0, u_core_cause_o} : ((host_off == 16) ? u_core_trap_pc_o : ((host_off == 20) ? {23'd0, (uart_count != 0), uart[uart_rp]} : ((host_off == 24) ? {24'd0, uart_count} : (host_cfg ? ((host_index == 0) ? seeds_0 : ((host_index == 1) ? seeds_1 : ((host_index == 2) ? seeds_2 : seeds_3))) : ((host_off == 64) ? {26'd0, timer_count} : ((host_off == 68) ? {31'd0, timer_overflow} : ((host_off == 72) ? u_core_trap_value_o : ((host_off == 76) ? clock_measurement : (((host_off >= 256) & (host_off < 768)) ? history_word : ((host_off == 80) ? u_core_load_stalls_o[31:0] : ((host_off == 84) ? u_core_muldiv_stalls_o[31:0] : ((host_off == 88) ? u_core_redirects_o[31:0] : counter_word))))))))))))))));
    assign halt_o = u_core_halt_o;
    assign cause_o = u_core_cause_o;
    assign trace_valid = u_core_trace_valid;
    assign trace_pc = u_core_trace_pc;
    assign trace_inst = u_core_trace_inst;
    assign trace_rd = u_core_trace_rd;
    assign trace_data = u_core_trace_data;
    assign trace_store = u_core_trace_store;
    assign trace_addr = u_core_trace_addr;
    assign trace_wdata = u_core_trace_wdata;
    assign trace_mask = u_core_trace_mask;
    assign trace_trap = u_core_trace_trap;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            uart_pending <= 0;
            timer_pending <= 0;
            invalid_pending <= 0;
            rsp_v <= 0;
            rsp_mem <= 0;
            rsp_error <= 0;
            rsp_d <= 0;
            seeds_0 <= 0;
            seeds_1 <= 0;
            seeds_2 <= 102;
            seeds_3 <= 0;
            go <= 0;
            cycles <= 0;
            ticks <= 0;
            prescaler <= 0;
            timer_count <= 0;
            timer_overflow <= 0;
            uart_wp <= 0;
            uart_rp <= 0;
            uart_count <= 0;
            invalid <= 0;
            fetch_error_q <= 0;
            fetch_retry_q <= 0;
            cpu_error_q <= 0;
            cpu_mem_q <= 0;
            cpu_mmio_q <= 0;
        end else begin
            uart_pending <= uart_accept;
            timer_pending <= (cpu_fire & cpu_timer);
            invalid_pending <= invalid_access;
            if ((start_run | stop_run)) begin
                uart_pending <= 0;
                timer_pending <= 0;
                invalid_pending <= 0;
            end
            if ((rsp_v & h_rready)) begin
                rsp_v <= 0;
            end
            if (host_fire) begin
                rsp_v <= 1;
                rsp_mem <= (host_mem & (~h_write));
                rsp_error <= (~(host_mem | host_regs));
                rsp_d <= read_value;
                if ((host_regs & h_write)) begin
                    rsp_error <= ((~((host_off == 4) | (host_cfg & (~go)))) | (h_strb != 15));
                    if (((host_cfg & (~go)) & (h_strb == 15))) begin
                        if ((host_index == 0)) begin
                            seeds_0 <= h_data;
                        end
                        if ((host_index == 1)) begin
                            seeds_1 <= h_data;
                        end
                        if ((host_index == 2)) begin
                            seeds_2 <= h_data;
                        end
                        if ((host_index == 3)) begin
                            seeds_3 <= h_data;
                        end
                    end
                end
            end
            if (start_run) begin
                go <= 1;
                cycles <= 0;
                ticks <= 0;
                prescaler <= 0;
                timer_count <= 0;
                timer_overflow <= 0;
                uart_wp <= 0;
                uart_rp <= 0;
                uart_count <= 0;
                invalid <= 0;
            end else begin
                if ((go & (~u_core_halt_o))) begin
                    cycles <= (cycles + 1);
                    if ((prescaler == 199)) begin
                        prescaler <= 0;
                        ticks <= (ticks + 1);
                    end else begin
                        prescaler <= (prescaler + 1);
                    end
                end
            end
            if (stop_run) begin
                go <= 0;
            end
            if (fetch_fire) begin
                fetch_error_q <= ((u_core_i_addr >= 131072) | (u_core_i_addr[1:0] != 0));
                fetch_retry_q <= fetch_collision;
            end
            cpu_error_q <= 0;
            if (cpu_fire) begin
                cpu_mem_q <= cpu_ram;
                cpu_error_q <= (~cpu_access_valid);
                cpu_mmio_q <= (u_core_d_addr[5] ? ticks : ((config_index == 0) ? seeds_0 : ((config_index == 1) ? seeds_1 : ((config_index == 2) ? seeds_2 : seeds_3))));
            end
            if ((invalid_pending & (~start_run))) begin
                invalid <= (invalid + 1);
            end
            if (timer_commit) begin
                if ((timer_count < 32)) begin
                    timer_cycles[timer_count[4:0]] <= timer_cycles_q;
                    timer_ticks[timer_count[4:0]] <= timer_ticks_q;
                    timer_count <= (timer_count + 1);
                end else begin
                    timer_overflow <= 1;
                end
            end
            if (uart_push) begin
                uart[uart_wp] <= uart_pending_data;
                uart_wp <= (uart_wp + 1);
            end
            if (uart_pop) begin
                uart_rp <= (uart_rp + 1);
            end
            if ((uart_push & (~uart_pop))) begin
                uart_count <= (uart_count + 1);
            end else begin
                if ((uart_pop & (~uart_push))) begin
                    uart_count <= (uart_count - 1);
                end
            end
        end
    end
    always_ff @(posedge clk) begin
        timer_cycles_q <= cycles;
        timer_ticks_q <= ticks;
        uart_pending_data <= u_core_d_byte;
    end

    Rv32Core #(.PREDICT(PREDICT), .TRACE(TRACE), .PERF(PERF)) u_core (
        .clk(clk),
        .rst_n((rst_n & go)),
        .i_ready(1'd1),
        .i_data(u_ilm_dlm_a_q),
        .i_prediction(u_ilm_dlm_a_prediction),
        .program_word(h_addr[16:2]),
        .program_data(h_data),
        .i_error(fetch_error_q),
        .i_retry(fetch_retry_q),
        .d_ready(1'd1),
        .d_byte_pause((~uart_capacity)),
        .d_data(cpu_load_data),
        .d_error(cpu_error_q),
        .d_zero_hint(u_ilm_dlm_b_zero_hint_q),
        .i_addr(u_core_i_addr),
        .d_store_valid(u_core_d_store_valid),
        .d_store_local(u_core_d_store_local),
        .d_wstrb(u_core_d_wstrb),
        .d_wdata(u_core_d_wdata),
        .program_prediction(u_core_program_prediction),
        .d_zero_encode(u_core_d_zero_encode),
        .program_zero_encode(u_core_program_zero_encode),
        .d_addr(u_core_d_addr),
        .d_write(u_core_d_write),
        .d_f3(u_core_d_f3),
        .d_valid(u_core_d_valid),
        .d_store_word(u_core_d_store_word),
        .i_valid(u_core_i_valid),
        .d_address_forward(u_core_d_address_forward),
        .halt_o(u_core_halt_o),
        .cause_o(u_core_cause_o),
        .retired_o(u_core_retired_o),
        .trap_pc_o(u_core_trap_pc_o),
        .trap_value_o(u_core_trap_value_o),
        .load_stalls_o(u_core_load_stalls_o),
        .muldiv_stalls_o(u_core_muldiv_stalls_o),
        .redirects_o(u_core_redirects_o),
        .trace_valid(u_core_trace_valid),
        .trace_pc(u_core_trace_pc),
        .trace_inst(u_core_trace_inst),
        .trace_rd(u_core_trace_rd),
        .trace_data(u_core_trace_data),
        .trace_store(u_core_trace_store),
        .trace_addr(u_core_trace_addr),
        .trace_wdata(u_core_trace_wdata),
        .trace_mask(u_core_trace_mask),
        .trace_trap(u_core_trace_trap),
        .d_byte(u_core_d_byte)
    );
    IlmDlmRam u_ilm_dlm (
        .clk(clk),
        .a_en(fetch_fire),
        .a_addr(u_core_i_addr[16:2]),
        .a_mask(4'd0),
        .a_data(32'd0),
        .b_en((host_mem | go)),
        .b_addr(memory_b_address),
        .b_mask(((~go) ? (h_write ? h_strb : 4'd0) : (((u_core_d_store_valid & cpu_ready) & u_core_d_store_local) ? u_core_d_wstrb : 4'd0))),
        .b_data((go ? u_core_d_wdata : h_data)),
        .b_prediction((((~go) & (h_strb == 15)) ? u_core_program_prediction : 18'd0)),
        .b_zero_hint((go ? u_core_d_zero_encode : ((h_strb == 15) ? u_core_program_zero_encode : 2'd0))),
        .b_prediction_write((go ? ((u_core_d_store_valid & cpu_ready) & u_core_d_store_local) : (h_write & (h_strb != 0)))),
        .a_q(u_ilm_dlm_a_q),
        .a_prediction(u_ilm_dlm_a_prediction),
        .b_zero_hint_q(u_ilm_dlm_b_zero_hint_q),
        .b_q(u_ilm_dlm_b_q)
    );
endmodule
