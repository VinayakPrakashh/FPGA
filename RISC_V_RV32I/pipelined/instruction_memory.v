module Instruction_mem(rst,A,RD);

  input rst;
  input [31:0] A;
  output [31:0] RD;

  reg [31:0] mem [1023:0];
  
  assign RD = (rst == 1'b1) ? {32{1'b0}} : mem[A];

//  initial begin
//    $readmemh("memfile.hex",mem);
//  end



  initial begin
    mem[0] = 32'b01000000001000011000001010110011;//R_TYPE A+B
    mem[1] = 32'b00000000000000010001001010010011;//I_TYPR 5 & A
     mem[2] = 32'b0000000001000101000001011100011;//B_TYPE reg[2],reg[5] beq
     mem[3] = 32'b0000000010100010000001010000011;//L_TYPe rd=5 rs=2 imm=5
    mem[4] = 32'b00000000010100010000001010100011;//s_type rs2 =5 rs1 =2 
     mem[5] = 32'b0000000000000000101000001101111;//j_type

  end

endmodule