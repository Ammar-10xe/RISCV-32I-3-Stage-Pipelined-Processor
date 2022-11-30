module Control_signals_pipe(
input  logic        clk,rst,    
input  logic reg_wr,wb_sel,Control_stall,
input  logic [2:0]  funct3,
input  logic [6:0]  instr_opcode,
output logic reg_wr_DE,wb_sel_DE,
output logic [2:0]  funct3_DE,
output logic [6:0]  instr_opcode_DE 
);

always_ff @( posedge clk ) begin

    if( rst ) begin
        reg_wr_DE         <= 32'b0;
        wb_sel_DE         <= 32'b0;
        funct3_DE         <= 32'b0;
        instr_opcode_DE   <= 32'b0;
    end
    else if(Control_stall) begin
        reg_wr_DE         <= reg_wr_DE;
        wb_sel_DE         <= wb_sel_DE;
        funct3_DE         <= funct3_DE;
        instr_opcode_DE   <= instr_opcode_DE ;

    end
     
    else begin
        reg_wr_DE         <= reg_wr;
        wb_sel_DE         <= wb_sel;
        funct3_DE         <= funct3;
        instr_opcode_DE   <= instr_opcode;
    end
end 
endmodule

