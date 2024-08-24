module top_fetch (clk,rst,IF_ID_IR,IF_ID_PC,PC_sel,PCtarget);

//inputs
input clk,rst;
input PC_sel;
input [31:0] PCtarget;

//outputs
output [31:0] IF_ID_IR;
output [31:0] IF_ID_PC;

//instantiate
instruction_fetch instruction_fetch(.clk(clk),
                                    .rst(rst),
                                    .PCSrcE(PC_sel),
                                    .PCTargetE(PCtarget),
                                    .IF_ID_IR(IF_ID_IR),
                                    .IF_ID_PC(IF_ID_PC));

endmodule
