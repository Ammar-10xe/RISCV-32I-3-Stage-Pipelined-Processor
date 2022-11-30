module forward_mux2 #(parameter WIDTH =32)(
  input  logic [WIDTH-1:0] rdata2, ALUResultDE,
  input  logic             ForwardBE,
  output logic [WIDTH-1:0] SrcBE
);

 // assign WriteDataE = ForwardBE[1] ? ALUResultM : (ForwardBE[0] ? ResultW : RD2E);


always_comb
begin
case (ForwardBE)
 
 1'b0: SrcBE = rdata2;
 1'b1: SrcBE = ALUResultDE;

 default: SrcBE = rdata2;

endcase

end
endmodule