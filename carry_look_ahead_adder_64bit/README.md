Performing addition on large numbers (like 64 bits) can be slow using a ripple carry adder, where each bit's carry depends on the previous bit's addition. A carry lookahead adder offers a faster approach.
This design breaks down the 64-bit addition problem into smaller, more manageable ones. It utilizes multiple 4-bit carry lookahead adders (CLAs) as building blocks.
A 4-bit CLA takes two 4-bit binary numbers (a and b) and a carry-in (cin) as inputs.
It utilizes internal logic to "look ahead" and anticipate the carry for each bit position based on the input bits (a and b) and the previous carry-in.
This allows the CLA to generate all the sum bits and carry-out simultaneously, speeding up the addition process.
##Cascading 4-bit CLAs:
In this design, we cascade eight 4-bit CLAs to achieve 64-bit addition.
Each 4-bit CLA handles its corresponding 4 bits from the two 64-bit input operands (a and b).
The carry-out from one CLA becomes the carry-in for the next higher-order CLA, efficiently propagating the carry information through all stages.
##Benefits:
This design is implemented using Hardware Description Language (HDL) like Verilog or VHDL.
The code defines the functionality of each 4-bit CLA and how they connect to form the complete 64-bit adder.
Here is the Schematic of 4bit CLA:
![Screenshot 2024-03-19 174841](https://github.com/VinayakPrakashh/FPGA/assets/101159818/0376c79e-2f40-42ac-9693-ced33d4d5caf)
16bit :
![Screenshot 2024-03-19 174903](https://github.com/VinayakPrakashh/FPGA/assets/101159818/f2c8de44-6c81-4581-8aea-57f3b989e9c2)
64bit:
![Screenshot 2024-03-19 174911](https://github.com/VinayakPrakashh/FPGA/assets/101159818/88caf1e3-2ffd-4ecc-868b-96c96c3505dc)
