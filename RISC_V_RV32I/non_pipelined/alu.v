`timescale 1ns / 1ps
module alu(A,B,IMM,IR,PC,ALU_OUT,branch);

input [31:0] A,B,IMM,PC;
input [31:0] IR;
output reg [31:0] ALU_OUT;
output reg branch;

parameter  R_TYPE = 7'b0110011, I_TYPE = 7'b0010011, B_TYPE = 7'b1100011, L_TYPE = 7'b0000011, S_TYPE = 7'b0100011, LUI=7'b0110111, AUIPC=7'b0010111, JAL=7'b1101111, JALR=7'b1100111;
parameter  BEQ = 3'B000, BNE = 3'b001, BLT = 3'b100, BGE = 3'b101 ,BLTU = 3'b110, BGEU = 3'b111;
parameter LB = 3'b000, LH = 3'b001, LW = 3'b010, LBU = 3'b100, LHU = 3'b101;
parameter SB=3'b000, SH=3'b001, SW=3'b010;
parameter ADD=3'b000, SUB=3'b000, SLL=3'b001, SLT=3'b010, SLTU=3'b011, XOR=3'b100, SRL=3'b101, SRA=3'b101, OR=3'b110, AND=3'b111;
parameter ADDI=3'b000, SLTI=3'b010, SLTIU=3'b011, XORI=3'b100, ORI=3'b110, ANDI=3'b111, SLLI=3'b001, SRLI=3'b101, SRAI=3'b101;

always @(*) begin
case(IR[6:0])
    R_TYPE:begin
        case(IR[14:12])
            ADD,SUB: if(IR[31:25]==7'b0100000) ALU_OUT <= A-B; else ALU_OUT <= A+B;
            SLL: ALU_OUT <= A<<B;
            SLT: ALU_OUT <= (A<B)?1:0;
            SLTU: ALU_OUT <= (A<B)?1:0;
            XOR: ALU_OUT <= A^B;
            SRL: ALU_OUT <= A>>B;
            SRA: ALU_OUT <= A>>>B;
            OR: ALU_OUT <= A|B;
            AND: ALU_OUT <= A&B;
        endcase
    end
    I_TYPE:begin
        case(IR[14:12])
            ADDI: ALU_OUT <= A+IMM;
            SLTI: ALU_OUT <= (A<IMM)?1:0;
            SLTIU: ALU_OUT <= (A<IMM)?1:0;
            XORI: ALU_OUT <= A^IMM;
            ORI: ALU_OUT <= A|IMM;
            ANDI: ALU_OUT <= A&IMM;
            SLLI: ALU_OUT <= A<<IMM;
            SRLI: ALU_OUT <= A>>IMM;
            SRAI: ALU_OUT <= A>>>IMM;
        endcase
    end
    S_TYPE,L_TYPE: ALU_OUT <= A+IMM;

    B_TYPE:begin
        case(IR[14:12])
            BEQ: branch <= (A==B)?1'b1:1'b0;
            BNE: branch <= (A!=B)?1'b1:1'b0;
            BLT: branch <= (A<B)?1'b1:1'b0;
            BGE: branch <= (A>=B)?1'b1:1'b0;
            BLTU: branch <= (A<B)?1'b1:1'b0;
            BGEU: branch <= (A>=B)?1'b1:1'b0;
        endcase
    end
    JAL,JALR: begin branch <=1; ALU_OUT <= PC+1; end
    LUI: ALU_OUT <= IMM;
    AUIPC:ALU_OUT <= PC+IMM;
    default: ALU_OUT <= 32'h00000000;
endcase
end
endmodule