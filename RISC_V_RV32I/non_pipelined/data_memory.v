`timescale 1ns / 1ps
module data_memory(
addr,RD,wr_en,WD
);
input [31:0] addr,WD; 
input wr_en;
output [31:0] RD;

reg [31:0] mem[1023:0];
assign RD = (wr_en==1'b0)? mem[addr]: 32'h00000000;

always @(*) begin
if (wr_en==1'b1) mem[addr] <= WD;
end
    initial begin
        mem[0] = 32'h00000055;
        mem[1] = 32'h00000001;
        mem[2] = 32'h00000002;
        mem[3] = 32'h00000005;
    end
endmodule