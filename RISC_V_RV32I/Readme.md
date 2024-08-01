# Single Instruction Execution Cycle Pipeline in Verilog for RISC-V RV32I
**This project implements a pipeline for the single instruction execution cycle of a processor using Verilog in Xilinx Vivado. It targets the RISC-V RV32I instruction set architecture (ISA).**
### RISC-V RV32I: A Detailed Overview
RISC-V (Reduced Instruction Set Computer - V) is an open-standard instruction set architecture (ISA) based on simplified computer architecture principles. The RV32I variant is a 32-bit base integer instruction set, providing a foundation for various computing applications.


### Core Architecture
Load-Store Architecture: RV32I is a load-store architecture, meaning data movement between the processor and memory is explicitly handled by load and store instructions.

   
32-bit Data Path: All data operations, including arithmetic, logical, and data transfer, are performed on 32-bit registers.
Fixed-Length Instructions: The architecture employs a fixed-length instruction format for efficient decoding and execution.
Simple Instruction Set: RV32I focuses on a reduced set of essential instructions, leading to a simpler processor design and higher performance.
### Instruction Set
RV32I includes instructions for:

Arithmetic and Logical Operations: Addition, subtraction, multiplication, division, bitwise operations (AND, OR, XOR, NOT), shifts, and comparisons.
Data Transfer: Loading and storing data between registers and memory.   
Control Flow: Branching, jumps, and calls to subroutines.
Register File
RV32I typically has a 32-register file, where each register is 32 bits wide. These registers are used to store data for computations and program execution.   
<img width="959" alt="2-1-1" src="https://github.com/user-attachments/assets/45756907-9130-42e2-9d4e-712c8d7f6106">
### Addressing Modes
RV32I supports a limited set of addressing modes:

Register Direct: Operands are directly specified by register names.
Immediate: Operands are constant values embedded within the instruction.
Base + Offset: Memory addresses are calculated by adding an offset to the contents of a base register.
### Key Features
Modularity: RISC-V is designed to be modular, allowing for the addition of custom instructions and extensions.   
Open Standard: The ISA is freely available, promoting innovation and development.   
Efficiency: The reduced instruction set and simple architecture contribute to efficient hardware implementation.   
Flexibility: RV32I can be used as a basis for various processor designs, from embedded systems to high-performance computing

## Disclaimer:
This project is a work in progress and may not yet implement all RISC-V RV32I instructions. Please refer to the future enhancements section for planned additions.
