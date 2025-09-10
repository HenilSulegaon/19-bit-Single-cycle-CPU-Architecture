`include "adder.sv"
`include "d_ff.sv"
`include "mux2.sv"
`include "mux3.sv"
`include "regfile.sv"
`include "immext.sv"
`include "alu.sv"

module datapath(
  input logic clk,reset,
  input logic [1:0] resultsrc,
  input logic pcsrc,alusrc,
  input logic regwrite,
  input logic [1:0] immsrc,
  input logic [3:0] alucontrol,
  output logic zero,
  output logic [18:0] pc,
  input logic [18:0] instr,
  output logic [18:0] aluresult,writedata,
  input logic [18:0] readdata);
  
  logic [18:0] pcnext,pcplus4,pcbranch;
  logic [18:0] immext;
  logic [18:0] srca,srcb;
  logic [18:0] result;
  
  // next pc logic
  d_ff #(19) PCreg(clk,reset,pcnext,pc);
  adder      PC4(pc,19'd4,pcplus4);
  adder      PCBRANCH(pc,immext,pcbranch);
  mux2 #(19) PCMUX(pcplus4,pcbranch,pcsrc,pcnext);
  
  // register file logic
  regfile rf(clk,regwrite,instr[10:8],instr[13:11],instr[7:5],result,srca,writedata);
  immext ie(instr[18:5],immsrc,immext);
  
  // ALU Logic
  mux2 #(19) srcbmux(writedata,immext,alusrc,srcb);
  alu        ALU(srca,srcb,alucontrol,aluresult,zero);
  mux3 #(19) resultmux(aluresult,readdata,pcplus4,resultsrc,result);
  
endmodule