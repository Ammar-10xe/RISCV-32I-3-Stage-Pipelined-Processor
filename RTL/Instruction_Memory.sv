module Instruction_Memory (
    input logic  [31:0] Addr,
    output logic [31:0] Inst
);

logic [31:0] inst_memory [1023:0]; 

initial begin
    $readmemh("lab.hex", inst_memory); 
end
assign Inst = inst_memory [Addr[ 31:2 ]];//Word Addressable 

endmodule