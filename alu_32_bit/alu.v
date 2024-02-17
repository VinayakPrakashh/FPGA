`timescale 1ns / 1ps
module alu(y,a,b,opcode,en);
output reg [31:0] y;
input [2:0] opcode;
input [31:0] a,b;
input en;
always @(a,b,opcode,en)
begin
if(en==1)begin
case ({opcode})
3'b000:y = a+b;
3'b001:y = a-b;
3'b010:y = a+1;
3'b011:y = a-1;

3'b100:y = a;
3'b101:y = ~a;
3'b110:y = a&b;
3'b111:y = a|b;
default: y = 32'b0;
endcase
end
else begin
y = 32'bz;
end
end 

endmodule
