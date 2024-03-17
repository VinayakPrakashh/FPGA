module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] w1,w2;
    wire c1,c2;
    add16 int1(a[15:0],b[15:0],0,sum[15:0],c1);
    add16 int2(a[31:16],b[31:16],c1,sum[31:16],c2);
endmodule