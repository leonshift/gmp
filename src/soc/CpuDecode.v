module CpuDecode (
    input [31:0] inst,
    output logic [6:0] op,
    output logic [4:0] rd,
    output logic [2:0] f3,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic regop,
    output logic immop,
    output logic load,
    output logic store,
    output logic br,
    output logic jal,
    output logic jalr,
    output logic lui,
    output logic auipc,
    output logic md,
    output logic ebreak,
    output logic ecall,
    output logic fence,
    output logic [31:0] imm,
    output logic csr,
    output logic use1,
    output logic use2,
    output logic writes,
    output logic legal
);
    logic [6:0] u_base_op;
    logic [4:0] u_base_rd;
    logic [2:0] u_base_f3;
    logic [4:0] u_base_rs1;
    logic [4:0] u_base_rs2;
    logic u_base_regop;
    logic u_base_immop;
    logic u_base_load;
    logic u_base_store;
    logic u_base_br;
    logic u_base_jal;
    logic u_base_jalr;
    logic u_base_lui;
    logic u_base_auipc;
    logic u_base_md;
    logic u_base_ebreak;
    logic u_base_ecall;
    logic u_base_fence;
    logic [31:0] u_base_imm;
    logic u_base_use1;
    logic u_base_use2;
    logic u_base_writes;
    logic u_base_legal;

    assign op = u_base_op;
    assign rd = u_base_rd;
    assign f3 = u_base_f3;
    assign rs1 = u_base_rs1;
    assign rs2 = u_base_rs2;
    assign regop = u_base_regop;
    assign immop = u_base_immop;
    assign load = u_base_load;
    assign store = u_base_store;
    assign br = u_base_br;
    assign jal = u_base_jal;
    assign jalr = u_base_jalr;
    assign lui = u_base_lui;
    assign auipc = u_base_auipc;
    assign md = u_base_md;
    assign ebreak = u_base_ebreak;
    assign ecall = u_base_ecall;
    assign fence = u_base_fence;
    assign imm = u_base_imm;
    assign csr = (((op == 115) & (f3 != 0)) & (f3 != 4));
    assign use1 = (u_base_use1 | (csr & (~f3[2])));
    assign use2 = u_base_use2;
    assign writes = (u_base_writes | csr);
    assign legal = (u_base_legal | csr);

    Decode u_base (
        .inst(inst),
        .op(u_base_op),
        .rd(u_base_rd),
        .f3(u_base_f3),
        .rs1(u_base_rs1),
        .rs2(u_base_rs2),
        .regop(u_base_regop),
        .immop(u_base_immop),
        .load(u_base_load),
        .store(u_base_store),
        .br(u_base_br),
        .jal(u_base_jal),
        .jalr(u_base_jalr),
        .lui(u_base_lui),
        .auipc(u_base_auipc),
        .md(u_base_md),
        .ebreak(u_base_ebreak),
        .ecall(u_base_ecall),
        .fence(u_base_fence),
        .imm(u_base_imm),
        .use1(u_base_use1),
        .use2(u_base_use2),
        .writes(u_base_writes),
        .legal(u_base_legal)
    );
endmodule
