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

## Supported instructions:

### R-type (Register-Register)
- `ADD`, `SUB`,`MUL`,`DIV`,`INC`,`DEC`,`AND`,`OR`,`XOR`,`NOT`,`REM`
- `SLL`, `SRL`, `SRA` (Shift operations)
- `SLT` (Set less than)

### I-type (Immediate)
- `ADDI`, `SUBI`,`MULI`,`DIVI`
- `ANDI`,`ORI`,`XORI`

### Memory Access Instruction
- `LW`, `SW`

### B-type 
- `BEQ` (Branch if equal)
- `BNE` (Branch if not equal)

### J-type 
- `JAL` (Jump and link)

## Project Structure

```
risc-v-cpu/
├── datapath/
│   ├── adder.sv                  
│   ├── alu.sv          
│   ├── d_ff.sv          
│   ├── immext.sv            
│   ├── mux2.sv          
│   ├── mux3.sv 
│   ├── regfile.sv  
│   ├── datapath.sv             
├── controller/
│   ├── aludec.sv              
|   ├── maindec.sv                  
│   ├── controller.sv
├── top/
│   ├── cpu.sv                 
│   ├── dmem.sv       
│   ├── imem.sv        
│   ├── top.sv                   
├── testbench/
│   ├── tb.sv   
│   └── WaveForm.png            
└── README.md
```

## 19-bit CPU Architecture 

![Architecture](https://github.com/user-attachments/assets/9d87ddee-c520-4350-9506-08babcf39a7f)

### Custom 19-bit Instruction Set Architecture (ISA)

I have designed a custom 19-bit ISA for this project, taking inspiration and reference from the RISC-V 32 ISA.

- Datapath width = 19 bits (ALU,DATA MEMORY)
- Instruction width = 19 bits
- Register file size = 8 Reg.(x0 to x7) , all 3 bits wide
- Opcode = 5 bits
- Sign-extend = 19 bits

  ### Instruction Format 

|   18:14  |   13:11  |   10:8   |   7:5   | 4:0     |  instr. type |
|:--------:|:--------:|:--------:|:-------:|:-------:|:------------:|
| funct5   | rs2      | rs1      |    rd   |   op    |   R-type     |
| imm7:0   |          |   rs1    |   rd    |   op    |   I-type,LW  |
|  imm7:3  |  rs2     |   rs1    |  imm2:0 |   op    |   SW         |
|  imm7:3  |  rs2     |   rs1    |  imm2:0 |   op    |   B-type     |
|  imm10:0 |          |          |    rd   |   op    |   J-type     |

  ### Instruction Encoding

|   instr  |   Type   |   Opcode | funct5  |alucontrol|  
|:--------:|:--------:|:--------:|:-------:|:--------:|
|    ADD   |   R      |   00001  |   0X01  |    0000  |   
|    SUB   |    R     |   00001  |   0X02  |    0001  | 
|    MUL   |    R     |   00001  |   0X03  |    0010  |  
|    DIV   |    R     |   00001  |   0X04  |    0011  |   
|    INC   |    R     |   00001  |   0X05  |    0100  |  
|    DEC   |    R     |   00001  |   0X06  |    0101  |
|    AND   |    R     |   00001  |   0X07  |    0110  |
|    OR    |    R     |   00001  |   0X08  |    0111  |
|    XOR   |    R     |   00001  |   0X09  |    1000  |
|    NOT   |    R     |   00001  |   0X0A  |    1001  |
|    REM   |    R     |   00001  |   0X0B  |    1010  |
|    SLT   |    R     |   00001  |   0X0C  |    1011  |
|    SLL   |    R     |   00001  |   0X0D  |    1100  |
|    SRL   |    R     |   00001  |   0X0E  |    1101  |
|    SRA   |    R     |   00001  |   0X0F  |    1110  |
|   ADDI   |    I     |   00010  |   0X01  |    0000  |
|   SUBI   |    I     |   00101  |   0X02  |    0001  |
|   MULI   |    I     |   00110  |   0X03  |    0010  |
|   DIVI   |    I     |   00111  |   0X04  |    0011  |
|   XORI   |    I     |   01001  |   0X09  |    1000  |
|   ANDI   |    I     |   01010  |   0X07  |    0110  |
|   ORI    |    I     |   01011  |   0X08  |    0111  |
|    LW    |    I     |   00011  |   -     |    0000  |
|    SW    |    S     |   00100  |   -     |    0000  |
|   BEQ    |    B     |   01000  |   -     |    0001  |
|   BNE    |    B     |   01110  |   -     |    0001  |
|   JAL    |    J     |   10000  |   -     |     -    |

## ▶️ Simulation & Testing
- Written in SystemVerilog HDL
- Simulated using **eda Playground**
- Synthesized on **Xilinx Vivado**
- All insructions are Verified by assembly code snippet

## Instruction Verify by Waveform Analysis:

   ```assembly
addi x2,x0,7
addi x3,x0,5
mul x4,x3,x2 
```

### addi,mul output waveform
<img width="1878" height="846" alt="MUL inst" src="https://github.com/user-attachments/assets/9c9893a8-4830-49d6-aa9d-05709c2e8ed9" />

---

```assembly
addi x2,x0,7
addi x3,x0,5
rem x5,x2,x3
div x6,x2,x3
sub x7,x2,x3  
```

### rem,div,sub output waveform Analysis
<img width="1862" height="837" alt="rem,div,sub instr" src="https://github.com/user-attachments/assets/856f5066-05d9-42a6-8f3f-3e0d18280879" />

---

```assembly
addi x3,x0,9
addi x4,x0,9
beq x3,x4,done
andi x5,x3,5
add x1,x3,x4
done: muli x7,x3,a 
```
### beq output waveform Analysis
<img width="1895" height="845" alt="beq instr" src="https://github.com/user-attachments/assets/c37e11cd-a4e5-4f48-9472-1c1350de6730" />


### **Note**: I have successfully verified , if you want to see you can check my eda playground
[![EDA Playground](https://img.shields.io/badge/Tool-EDA_Playground-blue.svg)](https://www.edaplayground.com/x/9x3D/)


  


