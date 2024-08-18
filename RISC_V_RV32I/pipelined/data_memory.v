`timescale 1ns / 1ps
module data_memory(clk,rst,WE,WD,A,RD);

    input clk,rst,WE;
    input [31:0]A,WD;
    output [31:0]RD;

    reg [31:0] mem [1023:0];

    always @ (posedge clk)
    begin
        if(WE==1'b1)
            mem[A] <= WD;
    end

    assign RD = (rst==1'b1) ? 32'd0 : mem[A];

     initial begin
         mem[0] = 32'h00f0f000;
         //mem[40] = 32'h00000002;
     end
endmodule