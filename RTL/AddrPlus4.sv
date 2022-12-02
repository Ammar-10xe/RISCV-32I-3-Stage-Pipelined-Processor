module AddrPlus4 (
  input  logic [31:0] Addr_MW,
  output logic [31:0] AddrPlus4
);

  assign AddrPlus4 = Addr_MW + 4;
  
endmodule
