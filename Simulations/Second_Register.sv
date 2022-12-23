module Second_Register (
    input  logic         clk,rst,Stall_MW, csr_reg_wr, csr_reg_rd,   
    input  logic  [4:0]  waddr,
    input  logic  [31:0] AddrF,ALUResult,SrcBE, SrcAE, ImmExtD,
  
    output logic  [4:0]  waddr_MW,
    output logic  [31:0] Addr_MW,ALUResult_MW,rdata2_MW, SrcA_MW, ImmExt_MW,
    output logic         csr_reg_wrMW, csr_reg_rdMW
);

always_ff @( posedge clk ) begin

    if (rst) begin
        Addr_MW      <= 32'b0;
        ALUResult_MW <= 32'b0;
        rdata2_MW    <= 32'b0;
        waddr_MW     <= 5'b0;
        SrcA_MW      <= 32'b0;
        ImmExt_MW    <= 32'b0;
    end 

    else if (Stall_MW) begin
        Addr_MW      <= Addr_MW;
        ALUResult_MW <= ALUResult_MW;
        rdata2_MW    <= rdata2_MW;
        waddr_MW     <= waddr_MW; 
        SrcA_MW      <= SrcA_MW;  
        ImmExt_MW    <= ImmExt_MW;     
    end 

    else begin
        Addr_MW      <= AddrF;
        ALUResult_MW <= ALUResult;
        rdata2_MW    <= SrcBE;
        waddr_MW     <= waddr; 
        SrcA_MW      <= SrcAE; 
        ImmExt_MW    <= ImmExtD;                     
    end
end
endmodule