// Code your design here
`include "cpu.sv"
`include "imem.sv"
`include "dmem.sv"
 
module top(input logic clk,reset,
           output logic [18:0] writedata,dataadr,
           output logic memwrite);
  
  logic [18:0] pc,instr,readdata;
  
  cpu  CPU(clk,reset,pc,instr,memwrite,dataadr,writedata,readdata);
  imem IMEM(pc[7:2],instr);
  dmem DMEM(clk,memwrite,dataadr,writedata,readdata);
  
endmodule