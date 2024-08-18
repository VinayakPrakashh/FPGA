module pc(clk,rst,PC,PC_Next);
    input clk,rst;
    input [31:0] PC_Next;
    output reg [31:0] PC;

    always @(posedge clk)
    begin
        if(rst == 1'b1)
            PC <= 32'h00000000;
        else
            PC <= PC_Next;
    end
endmodule