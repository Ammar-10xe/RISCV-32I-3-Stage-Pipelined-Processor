module Hazard_Unit (
    input  logic       reg_wrMW,PCsrc,           //instead of br_taken,I have used PCSrc here
    input  logic [1:0] wb_selMW,                 //used to check the stalling condition
    input  logic [4:0] raddr1,raddr2,waddr_MW,   //instead of giving InstF as an input,I have used raddr1 and raddr2 directly
    output logic       For_A, For_B,Stall,Stall_MW,Flush
    
);

// Check the validity of the source operands from EXE stage
  logic rs1_valid;
  logic rs2_valid;
  assign rs1_valid = |raddr1;
  assign rs2_valid = |raddr2;

// Hazard detection for forwarding 
  always_comb begin
    if (((raddr1 == waddr_MW) && (reg_wrMW)) && (rs1_valid)) begin
      For_A = 1'b0;
    end
    else begin
      For_A = 1'b1;
    end

  end

  always_comb begin
    if (((raddr2 == waddr_MW) & (reg_wrMW)) & (rs2_valid) ) begin
      For_B = 1'b0;
    end
    else begin
      For_B= 1'b1;
    end

  end
  
// Hazard detection for Stalling

  always_comb begin
    if (( wb_selMW == 2'b10 ) & (( raddr1 == waddr_MW ) | ( raddr2 == waddr_MW ))) begin
      Stall     = 1'b1;
      Stall_MW  = Stall;
    end
    else begin
      Stall =1'b0;
      Stall_MW = Stall;  
    end
  end

//Flush When a branch is taken or a load initroduces a bubble
always_comb begin
   if (PCsrc)
      Flush  = 1'b1;
end
 


endmodule