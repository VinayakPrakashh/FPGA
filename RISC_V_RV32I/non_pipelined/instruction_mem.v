`timescale 1ns / 1ps
module instruction_mem1 (
input [31:0] A,
output [31:0] RD
);
reg [31:0] mem [1023:0];

assign RD=mem[A];
initial begin
$readmemh("code.hex",mem);
end
//initial begin
//      mem[0] = 32'b00000000001000001101001010010011;
//    mem[1] = 32'b00000000111100001000001010010011;
//    mem[2] = 32'b00000000101100001000001010010011;
//    mem[3] = 32'b00000000100100001000001010010011;
//    mem[4] = 32'b00000001111100001000001010010011;
//    mem[5] = 32'b00000011111100001000001010010011;

//end

endmodule