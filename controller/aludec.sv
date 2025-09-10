

module aludec(
  input logic f7b5,
  input  logic [4:0] op,
  input  logic [4:0] funct5,
  input  logic [1:0] aluop,
  output logic [3:0] alucontrol
);
  
  always_comb begin
    case(aluop)
      2'b00 : alucontrol = 4'b0000;   // add (lw, sw)
      2'b01 : alucontrol = 4'b0001;   // sub (beq)
      2'b10 : begin
        // check funct5 for R-type
        case(funct5)
          5'h01: alucontrol = 4'b0000;  // ADD
          5'h02: alucontrol = 4'b0001;  // SUB
          5'h03: alucontrol = 4'b0010;  // MUL
          5'h04: alucontrol = 4'b0011;  // DIV
          5'h05: alucontrol = 4'b0100;  // INC
          5'h06: alucontrol = 4'b0101;  // DEC
          5'h07: alucontrol = 4'b0110;  // AND
          5'h08: alucontrol = 4'b0111;  // OR
          5'h09: alucontrol = 4'b1000;  // XOR
          5'h0A: alucontrol = 4'b1001;  // NOT
          5'h0B: alucontrol = 4'b1010;  // REM
          5'h0C: alucontrol = 4'b1011;  // SLT
          5'h0D: alucontrol = 4'b1100;  // SLL
          5'h0E: alucontrol = 4'b1101;  // SRL
          5'h0F: alucontrol = 4'b1110;  // SRA
          default: alucontrol = 4'bxxxx;
        endcase

        // check op for I-type
        case(op)
          5'h02: alucontrol = 4'b0000;  // ADDI
          5'h05: alucontrol = 4'b0001;  // SUBI
          5'h06: alucontrol = 4'b0010;  // MULI
          5'h07: alucontrol = 4'b0011;  // DIVI
          5'h09: alucontrol = 4'b1000;  // XORI
          5'h0A: alucontrol = 4'b0110;  // ANDI
          5'h0B: alucontrol = 4'b0111;  // ORI
          default: ;
        endcase
      end
      default: alucontrol = 4'bxxxx;
    endcase
  end
endmodule
