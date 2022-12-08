module Mux_PC (
    input logic         PCsrc, csr_reg_rdMW, csr_reg_wrMW,              //signal from controller
    input logic  [31:0] PCF,ALUResult, csr_evec,
    output logic [31:0] PC
);

logic [31:0] PCnew;
 always_comb 
 begin 
    case (PCsrc)
        1'b0 :   PCnew = PCF;
        1'b1 :   PCnew = ALUResult; 
        // default: PCnew = PCF;
    endcase
 end 

assign PC = (csr_reg_rdMW & csr_reg_wrMW) ? csr_evec : PCnew;

endmodule