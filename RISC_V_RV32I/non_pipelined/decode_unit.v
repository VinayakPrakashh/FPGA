`timescale 1ns / 1ps
//`include "reg_file.v"
module decode_unit (
IR,A,B,IMM
);
 parameter I_TYPE = 7'b0010011, B_TYPE = 7'b1100011, L_TYPE = 7'b0000001, S_TYPE = 7'b0100011, J_TYPE = 7'b1101111 ;
input [31:0] IR;
output  [31:0] A,B;
output reg  [31:0] IMM;
reg_file rg(.WE(0),.RE(1),.RW_addr(IR[19:15]),.RD1_addr(IR[24:20]),.RD1(A),.RD2(B),.WR1(0));
always @(*) begin
    case(IR[6:0])
    I_TYPE: IMM <= {{20{IR[31]}},IR[31:20]};
    L_TYPE: IMM <= {{20{1'b0}},IR[31:20]};
    S_TYPE: IMM <= {{20{1'b0}},IR[31:25],IR[11:7]};
    B_TYPE: IMM <= {{19{1'b0}},IR[31:25],IR[11:7]};
    J_TYPE: IMM <= {{12{1'b0}},IR[31:12]};
    default: begin
        IMM <= 0;
    end 
endcase
end
endmodule