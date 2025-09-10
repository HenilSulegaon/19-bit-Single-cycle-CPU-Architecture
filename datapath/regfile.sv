module regfile(
  input logic clk,we3,
  input logic [2:0] ra1,ra2,wa3,
  input logic [18:0] wd3,
  output logic [18:0] rd1,rd2
);
  
  logic [18:0] rf [7:0];    // 8x19 register file
  
  always_ff @(posedge clk)
    if(we3) rf[wa3] <= wd3;
  
  assign rd1 = (ra1!=0) ? rf[ra1] : 0;
  assign rd2 = (ra2!=0) ? rf[ra2] : 0;
endmodule