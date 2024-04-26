`timescale 1ns/ 1ps 

`define clk_period 10

module fifo_tb;
reg clk;
reg rst_n;
reg wr_en_i;
reg [7:0] data_i;
wire full_o;
reg rd_en_i;
wire [7:0] data_o;
wire empty_o;

syn_fifo fifo1(
    .clk(clk),
    .rst_n(rst_n),
    .wr_en_i(wr_en_i),
    .data_i(data_i),
    .full_o(full_o),
    .rd_en_i(rd_en_i),
    .data_o(data_o),
    .empty_o(empty_o)
);
initial clk = 1'b1;
always  #(`clk_period/2) clk = ~clk;
integer i;
initial begin
    //write
    rst_n = 1'b1;
    wr_en_i = 1'b0;
    rd_en_i = 1'b0;
    data_i = 8'b0;

    #10 rst_n = 1'b0;
    #10 rst_n = 1'b1;
    #10 wr_en_i = 1'b1;
    for (int i = 0; i < 8; i = i + 1) begin
        data_i = i;
        #10;
    end
    //read
    wr_en_i = 1'b0;
    rd_en_i = 1'b1;
    for (int i = 0; i < 8; i = i + 1) begin
        #10;
    end
     wr_en_i = 1'b0;
    rd_en_i = 1'b0;
    for (int i = 0; i < 8; i = i + 1) begin
        data_i = i;
        #10;
    end
    #10 
    #10
    #10
    $stop;
end

endmodule