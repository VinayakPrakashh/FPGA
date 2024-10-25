`timescale 1ns / 1ps
module Register_File(clk,rst,WE3,WD3,A1,A2,A3,RD1,RD2);

    input clk,rst,WE3;
    input [4:0]A1,A2,A3;
    input [31:0]WD3;
    output [31:0]RD1,RD2;

    reg [31:0] Register [31:0];

    always @ (posedge clk)
    begin
        if(WE3 & (A3 != 5'h00))
            Register[A3] <= WD3;
    end

    assign RD1 = (rst==1'b1) ? 32'd0 : Register[A1];
    assign RD2 = (rst==1'b1) ? 32'd0 : Register[A2];

    initial begin
        Register[0] = 32'h00000000;
        Register[1] = 32'h00000004;
        Register[2] = 32'h00000002;
        Register[3] = 32'h00000006;
        Register[4] = 32'h00000007;
        Register[5] = 32'h00000008;
        Register[6] = 32'h00000001;
        Register[7] = 32'h00000009;
        Register[8] = 32'h00000002;
        Register[9] = 32'h00000003;
    end

endmodule