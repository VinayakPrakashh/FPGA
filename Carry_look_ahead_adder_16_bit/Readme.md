This is a 16 bit Carry Look Ahead (CLA) adder which can add two 16bit values with carry.
In ripple carry adders, for each adder block, the two bits that are to be added are available instantly. However, each adder block waits for the carry to arrive from its previous block. So, it is not possible to generate the sum and carry of any block until the input carry is known. The i^{th}     block waits for the i-1^{th}     block to produce its carry. So there will be a considerable time delay which is carry propagation delay. 
![digital_Logic1](https://github.com/VinayakPrakashh/FPGA/assets/101159818/9d0a49c1-5a31-4569-a776-58ac26dea163)
But in the case of Carry Look Ahead adder it is different.
A carry look-ahead adder reduces the propagation delay by introducing more complex hardware. In this design, the ripple carry design is suitably transformed such that the carry logic over fixed groups of bits of the adder is reduced to two-level logic.
Refer this link to know how CLA works: https://www.geeksforgeeks.org/carry-look-ahead-adder/
Here we are implemented this CLA in such a way that output carry of the first 4 bit CLA is fed to the next 4 bit CLA.
![Screenshot 2024-03-17 221321](https://github.com/VinayakPrakashh/FPGA/assets/101159818/aead412b-277d-4a20-8c0d-2074fecb2826)
I have implemented this circuit using VHDL, all files are in the Repository.
