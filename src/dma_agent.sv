class dma_agent extends uvm_agent;
  `uvm_component_utils(dma_agent)
  
  dma_driver drv;
  dma_sequencer sqr;
  dma_monitor mon;
  
  function new(string name = "dma_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = dma_driver::type_id::create("drv", this);
    sqr = dma_sequencer::type_id::create("sqr", this);
    mon = dma_monitor::type_id::create("mon", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
  
endclass
