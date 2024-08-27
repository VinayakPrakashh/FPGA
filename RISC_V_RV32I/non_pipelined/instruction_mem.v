`timescale 1ns / 1ps
module instruction_mem1 (
input [31:0] A,
output [31:0] RD
);
reg [31:0] mem [1023:0];

assign RD=mem[A];
//initial begin
//$readmemh("code.hex",mem);
//end
  initial begin
    mem[0] = 32'b01000000001000011000001010110011;//R_TYPE rd=r5 func=000 rs1=r3 rs2=r2 func7=0100000
    mem[1] = 32'b00000000001100010001001010010011;//I_TYPE rd=r5 func=001 rs1=r2 imm=3 func7=0000000
    mem[2] = 32'b00000000001000101000001011100011;//B_TYPE rs1=r5 rs2=r2 imm=5
    mem[3] = 32'b00000000010100010000001010000011;//L_TYPE rd=5 rs1=r2 imm=5
    mem[4] = 32'b00000000010100010000001010100011;//s_type rs2 =5 rs1 =2 func=000 imm=5 
    mem[5] = 32'b00000000000000000101001011101111;//jal_type rd=r5 imm=5
    mem[6] = 32'b00000000010100011000001011100111;//jalr_type rd=r5 func=000 imm=5 rs1=3
    mem[7] = 32'b00000000000000000101001010110111; //lui rd=5 imm=5
    mem[8] = 32'b00000000000000000101001010010111;//auipc rd=5 imm=5

  end

endmodule