module adder(
  input logic [18:0] a,b,
  output logic [18:0] y
);
  
  assign y = a + b;
endmodule