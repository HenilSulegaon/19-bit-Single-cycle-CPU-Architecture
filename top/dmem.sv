
module dmem(input logic clk,we,
            input logic [18:0] a,wd,
            output logic [18:0] rd);
  
  logic [18:0] DRAM [63:0];   // 64x19 ram
  
  assign rd= DRAM[a[18:2]];
  
  always_ff @(posedge clk)
    if(we)
      DRAM[a[18:2]] <= wd;
endmodule