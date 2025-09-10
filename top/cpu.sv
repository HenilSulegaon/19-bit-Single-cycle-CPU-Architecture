`include "controller.sv"
`include "datapath.sv"

module cpu
  (input logic clk,reset,
   output logic [18:0] pc,
   input logic [18:0] instr,
   output logic memwrite,
   output logic [18:0] aluresult,writedata,
   input logic [18:0] readdata);
  
  logic alusrc,regwrite,jump;
  logic [1:0] resultsrc,immsrc;
  logic [3:0] alucontrol;
//   logic zero,pcsrc;
  
  controller CNTRL(instr[17],instr[18:14],instr[4:0],zero,resultsrc,memwrite,pcsrc,alusrc,regwrite,jump,immsrc,alucontrol);
  datapath dp(clk,reset,resultsrc,pcsrc,alusrc,regwrite,immsrc,alucontrol,zero,pc,instr,aluresult,writedata,readdata);
endmodule