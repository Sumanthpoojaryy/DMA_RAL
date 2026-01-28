class top_adapter extends uvm_reg_adapter;
  `uvm_object_utils(top_adapter)

  function new(string name = "top_adapter");
    super.new(name);
  endfunction

  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    dma_seq_item tr;
    tr = dma_seq_item::type_id::create("tr");

    tr.wr_en = (rw.kind == UVM_WRITE);
    tr.rd_en = (rw.kind == UVM_READ);
    tr.addr  = rw.addr;

    if(tr.wr_en) tr.wdata = rw.data;
    return tr;
  endfunction

  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    dma_seq_item tr;
    assert($cast(tr, bus_item));

    if (tr.wr_en) begin
    rw.kind = UVM_WRITE;
    rw.data = tr.wdata;
  end
  else begin
    rw.kind = UVM_READ;
    rw.data = tr.rdata;
  end

  rw.addr   = tr.addr;
  rw.status = UVM_IS_OK;
  endfunction

endclass

