# 19-bit Single Cycle CPU Architecture

I implemented a 19-bit Single Cycle CPU Architecture that executes 19-bit instructions in a single clock cycle.

It follows a custom 19-bit instruction format and combines all five stages of instruction execution—Instruction Fetch, Decode, Execute, Memory Access, and Write Back—into one cycle.

## Features

- Custom 19-bit Instruction Set Architecture (ISA)
- Executes one instruction per clock cycle
- Unified datapath covering all execution stages
- Register file for data storage and retrieval
- ALU supporting arithmetic and logical operations
- Control Unit for instruction decoding
- Memory module (data + instruction memory)

## List of Instructions that i have implemented: 

- R-type (add, sub, mul, div, inc, dec, and, or, xor, not, rem, slt, sll, srl, sra)
- I-type (addi, subi, muli, divi, xori, andi, ori)
- LW,SW
- B-type (beq,bne)
- J-type (jal)
