// Code your testbench here
// or browse Examples

module tb;
  logic clk;
  logic reset;
  logic [18:0] writedata,dataadr;
  logic memwrite;
  
  top dut(clk,reset,writedata,dataadr,memwrite);
  
  initial begin
    reset<= 1; #22; reset<=0;
  end
  
  always begin
    clk<=1; #5; clk<=0; #5;
  end
  
  initial begin
    $dumpfile("cpu.vcd");
    $dumpvars;
    #1000 $finish;
  end
endmodule