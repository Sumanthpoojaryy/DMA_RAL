interface dma_interface(input bit clk, rst_n);
  logic wr_en;
  logic rd_en;  
  logic [31:0] addr;
  logic [31:0] wdata;
  logic [31:0] rdata;
    
  clocking drv_cb@(posedge clk);
    default input #0 output #0;
    output wr_en, rd_en, addr, wdata;
  endclocking
  
  clocking mon_cb@(posedge clk);
    default input #0 output #0;
    input wr_en, rd_en, addr, wdata, rdata;
  endclocking
  
  modport DRV(clocking drv_cb, input clk, rst_n);
  modport MON(clocking mon_cb, input clk, rst_n);
    
endinterface
    
    
  
    
