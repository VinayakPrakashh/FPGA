`timescale 1ns / 1ps
module branching_unit(
ID_EX_A,ID_EX_B,ID_EX_NPC,ID_EX_IMM,br_en,EX_MEM_PC,ID_EX_IR
    );
    input br_en;
    input [31:0] ID_EX_A,ID_EX_B,ID_EX_NPC,ID_EX_IMM,ID_EX_IR;
    output reg [31:0] EX_MEM_PC;
    parameter BEQ = 3'B000, BNE = 3'B001, BLT = 3'B010, BGT = 3'B011;
    parameter B_TYPE = 7'b1100011,J_TYPE = 7'b1101111 ;
    always @(posedge br_en) begin
        case (ID_EX_IR[6:0])
            B_TYPE:begin
                case (ID_EX_IR[14:12])
                    BEQ:EX_MEM_PC<=(ID_EX_A==ID_EX_B)?(ID_EX_NPC+ID_EX_IMM):ID_EX_NPC;
                    BNE:EX_MEM_PC<=(ID_EX_A!=ID_EX_B)?ID_EX_NPC+ID_EX_IMM:ID_EX_NPC;
                    BLT:EX_MEM_PC<=(ID_EX_A<ID_EX_B)?ID_EX_NPC+ID_EX_IMM:ID_EX_NPC;
                    BGT:EX_MEM_PC<=(ID_EX_A>ID_EX_B)?ID_EX_NPC+ID_EX_IMM:ID_EX_NPC; 
                endcase
            end
            J_TYPE: EX_MEM_PC = ID_EX_NPC + ID_EX_IMM;
            default: EX_MEM_PC <= ID_EX_NPC; 
        endcase        
    end
endmodule
