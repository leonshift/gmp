module Decode (
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
    output logic use1,
    output logic use2,
    output logic writes,
    output logic ebreak,
    output logic ecall,
    output logic fence,
    output logic [31:0] imm,
    output logic legal
);
    logic [6:0] f7;
    logic [31:0] imm_i;
    logic [11:0] raw_s;
    logic [31:0] imm_s;
    logic [12:0] raw_b;
    logic [31:0] imm_b;
    logic [20:0] raw_j;
    logic [31:0] imm_j;
    logic legal_reg;
    logic legal_imm;

    assign op = inst[6:0];
    assign rd = inst[11:7];
    assign f3 = inst[14:12];
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign f7 = inst[31:25];
    assign regop = (op == 51);
    assign immop = (op == 19);
    assign load = (op == 3);
    assign store = (op == 35);
    assign br = (op == 99);
    assign jal = (op == 111);
    assign jalr = (op == 103);
    assign lui = (op == 55);
    assign auipc = (op == 23);
    assign md = ((regop & (f7 == 1)) & (~f3[2]));
    assign use1 = (((((regop | immop) | load) | store) | br) | jalr);
    assign use2 = ((regop | store) | br);
    assign writes = ((((((regop | immop) | load) | jal) | jalr) | lui) | auipc);
    assign ebreak = (inst == 1048691);
    assign ecall = (inst == 115);
    assign fence = ((op == 15) & (f3 == 0));
    assign imm_i = {inst[31], inst[31], inst[31], inst[31], inst[31], inst[31], inst[31], inst[31], inst[31], inst[31],
                    inst[31], inst[31], inst[31], inst[31], inst[31], inst[31], inst[31], inst[31], inst[31], inst[31],
                    inst[31:20]};
    assign raw_s = {inst[31:25], inst[11:7]};
    assign imm_s = {raw_s[11], raw_s[11], raw_s[11], raw_s[11], raw_s[11], raw_s[11], raw_s[11], raw_s[11], raw_s[11],
                    raw_s[11], raw_s[11], raw_s[11], raw_s[11], raw_s[11], raw_s[11], raw_s[11], raw_s[11], raw_s[11],
                    raw_s[11], raw_s[11], raw_s};
    assign raw_b = {inst[31], inst[7], inst[30:25], inst[11:8], 1'd0};
    assign imm_b = {raw_b[12], raw_b[12], raw_b[12], raw_b[12], raw_b[12], raw_b[12], raw_b[12], raw_b[12], raw_b[12],
                    raw_b[12], raw_b[12], raw_b[12], raw_b[12], raw_b[12], raw_b[12], raw_b[12], raw_b[12], raw_b[12],
                    raw_b[12], raw_b};
    assign raw_j = {inst[31], inst[19:12], inst[20], inst[30:21], 1'd0};
    assign imm_j = {raw_j[20], raw_j[20], raw_j[20], raw_j[20], raw_j[20], raw_j[20], raw_j[20], raw_j[20], raw_j[20],
                    raw_j[20], raw_j[20], raw_j};
    assign imm = (store ? imm_s : (br ? imm_b : (jal ? imm_j : ((lui | auipc) ? {inst[31:12], 12'd0} : imm_i))));
    assign legal_reg = (regop & (((f7 == 0) | ((f7 == 1) & (~f3[2]))) | ((f7 == 32) & ((f3 == 0) | (f3 == 5)))));
    assign legal_imm = (immop & ((f3 == 1) ? (f7 == 0) : ((f3 == 5) ? ((f7 == 0) | (f7 == 32)) : 1'd1)));
    assign legal = (((((((((((legal_reg | legal_imm) | lui) | auipc) | jal) | (jalr & (f3 == 0)))
                    | (load & (((((f3 == 0) | (f3 == 1)) | (f3 == 2)) | (f3 == 4)) | (f3 == 5)))) | (store & (f3 <= 2)))
                    | (br & (((f3 == 0) | (f3 == 1)) | (f3 >= 4)))) | fence) | ebreak) | ecall);
endmodule
