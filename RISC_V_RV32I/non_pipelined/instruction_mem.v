`timescale 1ns / 1ps
module instruction_mem1 (
input [31:0] A,
output [31:0] RD
);
reg [31:0] mem [1023:0];

assign RD=mem[A];
initial begin
    mem[0] = 32'b00000000000100000000000000010011;
    mem[1] = 32'h00832383;
     mem[2] = 32'h0064A423;
     mem[3] = 32'h00B62423;
    mem[4] = 32'h0062E233;
    mem[5] = 32'h00B62423;

end

endmodule