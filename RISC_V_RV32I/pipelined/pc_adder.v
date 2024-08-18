module PC_adder (a,c);

    input [31:0]a;
    output [31:0]c;

    assign c = a + 1;
    
endmodule