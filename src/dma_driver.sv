class dma_driver extends uvm_driver #(dma_seq_item);
  `uvm_component_utils(dma_driver)

  virtual dma_interface vif;
  dma_seq_item req;

  function new(string name = "dma_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual dma_interface)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "vif not set");
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done();
    end
  endtask

  task drive(dma_seq_item tx);
    vif.wr_en <= 0;
    vif.rd_en <= 0;
    vif.addr  <= '0;
    vif.wdata <= '0;
    @(posedge vif.clk);

    if(tx.wr_en && !tx.rd_en) begin
      vif.wr_en <= 1;
      vif.addr  <= tx.addr;
      vif.wdata <= tx.wdata;

      @(posedge vif.clk);  
      vif.wr_en <= 0;
    end

    else if(tx.rd_en && !tx.wr_en) begin
      vif.rd_en <= 1;
      vif.addr  <= tx.addr;

      repeat(2)@(posedge vif.clk);
      tx.rdata = vif.rdata;

      vif.rd_en <= 0;
    end
    tx.print();
  endtask

endclass

