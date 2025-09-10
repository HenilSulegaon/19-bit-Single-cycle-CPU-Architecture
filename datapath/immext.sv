module immext(
  input logic [18:5] instr,
  input logic [1:0] immsrc,
  output logic [18:0] extimm
);
  
  always_comb
    case(immsrc)
      2'b00 : extimm={{12{instr[18]}},instr[17:11]};   // I-type
      2'b01 : extimm={{12{instr[18]}},instr[17:14],instr[7:5]}; // S-type
      2'b10 : extimm={{10{instr[18]}},instr[18:14],instr[7:5],1'b0}; // B-type
      2'b11 : extimm={{8{instr[18]}},instr[18:8]};  // J-type
      default:extimm=19'bx;
    endcase
endmodule