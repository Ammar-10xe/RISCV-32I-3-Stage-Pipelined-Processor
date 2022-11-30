module Fowrard_unit (
    input  logic       PCsrc,reg_wr_DE,
    input  logic [4:0] raddr1,raddr2,waddr,waddrDE,
    input  logic [1:0] wb_sel_DE,

    output logic       ForwardAE, ForwardBE,Control_stall,
    output logic       StallE, StallD, FlushD
    
);

  logic rs1_valid;
  logic rs2_valid;
  logic lwStall;


// Check the validity of the source operands from EXE stage
  assign rs1_valid = |raddr1;
  assign rs2_valid = |raddr2;

// Hazard detection
  always_comb begin
    if ((raddr1 == waddrDE) & (reg_wr_DE) & rs1_valid ) begin
      ForwardAE = 1;
    end
    else begin
      ForwardAE = 0;
    end

  end

  always_comb begin
    if ((raddr2 == waddrDE) & (reg_wr_DE) & rs2_valid ) begin
      ForwardBE = 1'b1;
    end
    else begin
      ForwardBE = 1'b0;
    end

  end

  always_comb begin//Stall when a load hazard occur
    lwStall      = (wb_sel_DE[1] & ((raddr1 == waddrDE) | (raddr2 == waddrDE)));//Page 450 
    StallD       = lwStall;
    StallE       = lwStall;
    Control_stall= lwStall;
    //Flush When a branch is taken or a load initroduces a bubble
    if (PCsrc) begin
    FlushD  = 1'b1;
    end
  end

endmodule