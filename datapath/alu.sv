module alu #(parameter WIDTH=19)
  (input logic [WIDTH-1:0] a,b,
   input logic [3:0] alu_cntrl,
   output logic [WIDTH-1:0] alu_out,
   output logic zero);
  
  assign zero = (!alu_out);
  
  always_ff @(a,b,alu_cntrl) // this block statement are written after design of main decoder and alu decoder. so now left empty.
    begin
      case(alu_cntrl)
        4'b0000 : alu_out <= a + b;    // ADD,ADDI
        4'b0001 : alu_out <= a - b;    // SUB,SUBI
        4'b0010 : alu_out <= a * b;    // MUL,MULI
        4'b0011 : alu_out <= a / b;    // DIV,DIVI
        4'b0100 : alu_out <= a + 1;    // INC
        4'b0101 : alu_out <= a - 1;    // DEC
        4'b0110 : alu_out <= a & b;    // AND,ANDI
        4'b0111 : alu_out <= a | b;    // OR,ORI
        4'b1000 : alu_out <= a ^ b;    // XOR,XORI
        4'b1001 : alu_out <= ~a;       // NOT
        4'b1010 : alu_out <= a % b;    // REM
        4'b1011 : alu_out <= (a<b)?1:0;    // SLT
        4'b1100 : alu_out <= a << b;    // SLL
        4'b1101 : alu_out <= a >> b;    // SRL
        4'b1110 : alu_out <= a >>> b;    // SRA
        default : alu_out <= 0;
      endcase
    end
endmodule