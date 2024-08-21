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
    mem[0] = 32'b00000000001000001000001010110011;
    mem[1] = 32'h00832383;
     mem[2] = 32'h0064A423;
     mem[3] = 32'h00B62423;
    mem[4] = 32'h0062E233;
     mem[5] = 32'h00B62423;

  end

endmodule