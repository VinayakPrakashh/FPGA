module mux_2_1 (a,b,s,y);

    input [31:0]a,b;
    input s;
    output [31:0] y;

    assign y = (~s) ? a : b ;
endmodule

module mux_3_1 (a,b,c,s,y);

input [31:0] a,b,c;
input [1:0] s;
output [31:0] y;

assign y = (s==2'b00)? a : (s==2'b01) ? b: (s==2'b10)? c: 0;
endmodule
