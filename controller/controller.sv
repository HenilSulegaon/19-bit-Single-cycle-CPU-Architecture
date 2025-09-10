
`include "maindec.sv"
`include "aludec.sv"

module controller(
  input logic f7b5,
  input logic [4:0] funct5,
  input logic [4:0] op,
  input logic zero,
  output logic [1:0] resultsrc,   // memtoreg
  output logic memwrite,
  output logic pcsrc,alusrc,
  output logic regwrite,jump,
  output logic [1:0] immsrc,
  output logic [3:0] alucontrol); 
  
  logic [1:0] aluop;
  logic branch,notbranch;
  
  maindec md(op,resultsrc,memwrite,branch,notbranch,alusrc,regwrite,jump,immsrc,aluop);
  aludec  ad(f7b5,op,funct5,aluop,alucontrol);
  
  assign pcsrc = (branch&zero) | jump | notbranch ;
  
endmodule