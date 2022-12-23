module csr (
    input  logic        clk,rst,csr_reg_wrpin,csr_reg_rdpin,
    input  logic [31:0] csr_pc ,
    input  logic [31:0] csr_addr32,
    input  logic [31:0] csr_wdata,
    output logic [31:0] csr_rdata, csr_evec
    );

logic [11:0] csr_addr;
assign csr_addr = csr_addr32[11:0];

logic [11:0] csr_addr_MIP     = 12'h344;
logic [11:0] csr_addr_MIE     = 12'h304;
logic [11:0] csr_addr_MSTATUS = 12'h300;
logic [11:0] csr_addr_MCAUSE  = 12'h342;
logic [11:0] csr_addr_MTVEC   = 12'h305; 
logic [11:0] csr_addr_MEPC    = 12'h341;

logic [31:0] csr_mip_ff;
logic [31:0] csr_mie_ff;
logic [31:0] csr_mstatus_ff;
logic [31:0] csr_mcause_ff;
logic [31:0] csr_mtvec_ff;
logic [31:0] csr_mepc_ff;

logic csr_mip_wr_flag;
logic csr_mie_wr_flag;
logic csr_mstatus_wr_flag;
logic csr_mcause_wr_flag;
logic csr_mtvec_wr_flag;
logic csr_mepc_wr_flag;

//CSR read operation 
always_comb begin 
    csr_rdata = '0;
    if ( csr_reg_rdpin ) begin
        case (csr_addr)
            csr_addr_MIP     : csr_rdata = csr_mip_ff;
            csr_addr_MIE     : csr_rdata = csr_mie_ff;
            csr_addr_MSTATUS : csr_rdata = csr_mstatus_ff;
            csr_addr_MCAUSE  : csr_rdata = csr_mcause_ff;
            csr_addr_MTVEC   : csr_rdata = csr_mtvec_ff;
            csr_addr_MEPC    : csr_rdata = csr_mepc_ff;

        endcase
    end
end

//CSR write operation
always_comb begin

    csr_mip_wr_flag      = 1'b0;
    csr_mie_wr_flag      = 1'b0;
    csr_mstatus_wr_flag  = 1'b0;
    csr_mcause_wr_flag   = 1'b0;
    csr_mtvec_wr_flag    = 1'b0;
    csr_mepc_wr_flag     = 1'b0;

    if ( csr_reg_wrpin ) begin
        case(csr_addr)
            csr_addr_MIP     : csr_mip_wr_flag     = 1'b1;
            csr_addr_MIE     : csr_mie_wr_flag     = 1'b1; 
            csr_addr_MSTATUS : csr_mstatus_wr_flag = 1'b1;
            csr_addr_MCAUSE  : csr_mcause_wr_flag  = 1'b1;
            csr_addr_MTVEC   : csr_mtvec_wr_flag   = 1'b1;
            csr_addr_MEPC    : csr_mepc_wr_flag    = 1'b1;
        endcase
    end
end


//update the mip (machine interrupt pending) CSR
always_ff @( posedge rst, posedge clk ) begin 
    if( rst ) begin
        csr_mip_ff <= 32'b0;
    end
    else if ( csr_mip_wr_flag ) begin 
        csr_mip_ff <= csr_wdata;
    end
end

//update the mie (Machine interrupt-enable register) CSR
always_ff @( posedge rst, posedge clk) begin 
    if( rst ) begin
        csr_mie_ff <= 32'b0 ;
    end
    else if ( csr_mie_wr_flag ) begin 
        csr_mie_ff <= csr_wdata;
    end
end

//update the mstatus ( Machine status register) CSR
always_ff @( posedge rst, posedge clk ) begin 
    if( rst ) begin
        csr_mstatus_ff <= 32'b0;
    end
    else if ( csr_mstatus_wr_flag ) begin 
        csr_mstatus_ff <= csr_wdata;
    end
end

//update the mcause ( Machine trap cause ) CSR
always_ff @( posedge rst, posedge clk ) begin 
    if( rst ) begin
        csr_mcause_ff <= 32'b0;
    end
    else if ( csr_mcause_wr_flag ) begin 
        csr_mcause_ff <= csr_wdata;
    end
end

//update the mtvec ( Machine trap-handler base address ) CSR
always_ff @( posedge rst, posedge clk ) begin 
    if( rst ) begin
        csr_mtvec_ff <= 32'b0;
    end
    else if ( csr_mtvec_wr_flag ) begin 
        csr_mtvec_ff <= csr_wdata;
    end
end

//update the mepc ( Machine exception program counter ) CSR
always_ff @( posedge rst, posedge clk ) begin 
    if( rst ) begin
        csr_mepc_ff <= 32'b0;
    end
    else if ( csr_mepc_wr_flag ) begin 
        csr_mepc_ff <= csr_wdata;
    end
end


endmodule