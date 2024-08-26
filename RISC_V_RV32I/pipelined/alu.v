`timescale 1ns / 1ps
module alu (ID_EX_A, ID_EX_BI, alu_type_sel, alucontrol, alucontrol7, EX_MEM_ALU_OUT, branch_cond);
//inputs
input [31:0] ID_EX_A, ID_EX_BI;
input [1:0] alu_type_sel;
input [2:0] alucontrol;
input [6:0] alucontrol7;
//outputs
output reg [31:0] EX_MEM_ALU_OUT;
output reg branch_cond;
always @(*)begin
case(alu_type_sel)
    2'b01: 
        case(alucontrol)
        3'b000: if(alucontrol7==7'b0100000) EX_MEM_ALU_OUT <= ID_EX_A - ID_EX_BI;else EX_MEM_ALU_OUT <= ID_EX_A + ID_EX_BI;
        3'b001: EX_MEM_ALU_OUT <= ID_EX_A & ID_EX_BI;
        3'b010: EX_MEM_ALU_OUT <= ID_EX_A | ID_EX_BI;
        3'b011: EX_MEM_ALU_OUT <= ID_EX_A ^ ID_EX_BI;
        3'b100: EX_MEM_ALU_OUT <= ID_EX_A >> ID_EX_BI;
        3'b101: EX_MEM_ALU_OUT <= ID_EX_A << ID_EX_BI;
        3'b110: EX_MEM_ALU_OUT <= (ID_EX_A > ID_EX_BI)? 1'b1: 1'b0; 
        3'b111: EX_MEM_ALU_OUT <= (ID_EX_A < ID_EX_BI)? 1'b1: 1'b0; 
        endcase
    2'b10:
        case (alucontrol)
        3'b000: branch_cond <= (ID_EX_A == ID_EX_BI) ? 1'b1 : 1'b0;
        3'b001: branch_cond <= (ID_EX_A != ID_EX_BI) ? 1'b1 : 1'b0;
        3'b100: branch_cond <= (ID_EX_A < ID_EX_BI) ? 1'b1 : 1'b0;
        3'b101: branch_cond <= (ID_EX_A >= ID_EX_BI) ? 1'b1 : 1'b0;
        default:branch_cond <= 1'b0; 
        endcase
    default: EX_MEM_ALU_OUT <= ID_EX_A + ID_EX_BI;
endcase
end
endmodule