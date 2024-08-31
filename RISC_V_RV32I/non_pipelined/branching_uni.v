`timescale 1ns / 1ps
module branching_unit(branch,IR,IMM,NPC,PC,PC_out);
input [31:0] IMM,NPC,PC,IR;
input branch;
output reg [31:0] PC_out;
parameter B_TYPE = 7'b1100011, JAL=7'b1101111, JALR=7'b1100111;
always @(*) begin
case(IR[6:0])
    B_TYPE: PC_out <= (branch)?PC+IMM:NPC;
    JAL   : PC_out <= PC+IMM;
    JALR  :PC_out  <=  IMM;
    default: PC_out<= NPC;
    endcase
end
endmodule