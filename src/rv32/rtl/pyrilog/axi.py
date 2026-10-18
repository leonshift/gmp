"""与 GMP 共用 JTAG 桥连接的 AXI4-Lite 从机，AW/W 独立接收。"""

from pyrilog.ir import Module, Input, Output, Logic, Param
from pyrilog.hdl import bits, mux
from pyrilog.hdl.cycle import State
from .soc import Rv32Soc


class Rv32Axi(Module):
    PREDICT = Param(int, default=2)
    PERF = Param(int, default=0)
    rst_n = Input(1)
    clock_measurement = Input(32)
    s_awaddr = Input(32)
    s_awvalid = Input(1)
    s_wdata = Input(32)
    s_wstrb = Input(4)
    s_wvalid = Input(1)
    s_bready = Input(1)
    s_araddr = Input(32)
    s_arvalid = Input(1)
    s_rready = Input(1)
    aw_pending = State(1, init=0)
    aw_addr = State(32, init=0)
    w_pending = State(1, init=0)
    w_data = State(32, init=0)
    w_strb = State(4, init=0)
    active = State(1, init=0)
    active_write = State(1, init=0)
    bvalid = State(1, init=0)
    bresp = State(2, init=0)
    rvalid = State(1, init=0)
    rresp = State(2, init=0)
    rdata = State(32, init=0)
    idle = Logic(1, ~active & ~bvalid & ~rvalid)
    writing = Logic(1, aw_pending & w_pending)
    request = Logic(1, idle & (writing | (s_arvalid & ~aw_pending & ~w_pending)))
    u_soc = Rv32Soc(
        PREDICT=PREDICT,
        TRACE=0,
        PERF=PERF,
        clock_measurement=clock_measurement,
        h_valid=request,
        h_write=writing,
        h_addr=mux(writing, aw_addr, s_araddr),
        h_data=w_data,
        h_strb=w_strb,
        h_rready=active,
    )
    s_awready = Output(1, idle & ~aw_pending)
    s_wready = Output(1, idle & ~w_pending)
    s_arready = Output(1, idle & ~aw_pending & ~w_pending & u_soc.h_ready)
    s_bvalid = Output(1, bvalid)
    s_bresp = Output(2, bresp)
    s_rvalid = Output(1, rvalid)
    s_rresp = Output(2, rresp)
    s_rdata = Output(32, rdata)
    halted = Output(1, u_soc.halt_o)
    fault = Output(1, u_soc.halt_o & (u_soc.cause_o != 3))

    def cycle(self, reset=rst_n):
        if self.s_awvalid & self.s_awready:
            self.aw_pending = 1
            self.aw_addr = self.s_awaddr
        if self.s_wvalid & self.s_wready:
            self.w_pending = 1
            self.w_data = self.s_wdata
            self.w_strb = self.s_wstrb
        if self.request & self.u_soc.h_ready:
            self.active = 1
            self.active_write = self.writing
            if self.writing:
                self.aw_pending = 0
                self.w_pending = 0
        if self.active & self.u_soc.h_rvalid:
            self.active = 0
            if self.active_write:
                self.bvalid = 1
                self.bresp = mux(self.u_soc.h_error, bits(2, 2), bits(0, 2))
            else:
                self.rvalid = 1
                self.rresp = mux(self.u_soc.h_error, bits(2, 2), bits(0, 2))
                self.rdata = self.u_soc.h_rdata
        if self.bvalid & self.s_bready:
            self.bvalid = 0
        if self.rvalid & self.s_rready:
            self.rvalid = 0
