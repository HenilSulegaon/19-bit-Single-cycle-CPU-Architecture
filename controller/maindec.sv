module maindec(
  input logic [4:0] op,
  output logic [1:0] resultsrc,
  output logic memwrite,branch,notbranch,alusrc,
  output logic regwrite,jump,
  output logic [1:0] immsrc,
  output logic [1:0] aluop
);
  
  logic [11:0] controls;
  
  assign {regwrite,immsrc,alusrc,branch,memwrite,resultsrc,jump,aluop,notbranch}=controls;
  
  always_comb
    case(op)
      5'b00001 : controls <= 12'b 1_xx_0_0_0_00_0_10_0;     // R-type
      5'b00010,5'b00101,5'b00110,5'b00111,5'b01001,5'b01010,5'b01011 : controls <= 12'b 1_00_1_0_0_00_0_10_0;     // I-type
      5'b00011 : controls <= 12'b 1_00_1_0_0_01_0_00_0;     // LW
      5'b00100 : controls <= 12'b 0_01_1_0_1_00_0_00_0;     // SW
      5'b01000 : controls <= 12'b 0_10_0_1_0_00_0_01_0;     // BEQ
      5'b10000 : controls <= 12'b 1_11_0_0_0_10_1_00_0;     // JAL
      5'b01110 : controls <= 12'b 0_10_0_1_0_00_0_01_1;
      default  : controls <= 12'bx;
    endcase
endmodule