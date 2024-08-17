`timescale 1ns / 1ps
module ALU (
 A,B,func,Y,ALU_EN,opcode
);
 parameter R_TYPE = 7'b0110011, I_TYPE = 7'b0010011, B_TYPE = 7'b1100011, L_TYPE = 7'b0000001, S_TYPE = 7'b0100011;
 parameter ADD = 3'b000, SUB = 3'b001, AND = 3'b010, OR = 3'B011, XOR = 3'B100, SLL = 3'b101,SRL = 3'b110;
input ALU_EN;
input [31:0] A,B;
input [2:0] func;
input [6:0] opcode;
output reg [31:0] Y;

always @(*) begin
case (opcode)
R_TYPE,I_TYPE:begin 
           case (func)
            ADD: Y <= A + B;
            SUB: Y <= A - B;
            AND: Y <= A & B;
            OR: Y <= A | B;
            XOR: Y <= A ^ B;
            SLL: Y <= A << B;
            SRL: Y <= A >> B;
            default: Y = 32'h00000000;
           endcase
end
L_TYPE,S_TYPE:Y <= A+B;
endcase
end
endmodule