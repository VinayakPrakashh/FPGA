module mux_2_1 (a,b,s,y);

    input [31:0]a,b;
    input s;
    output [31:0] y;

    assign y = (~s) ? a : b ;
endmodule