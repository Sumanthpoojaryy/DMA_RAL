class dma_env extends uvm_env;
  `uvm_component_utils(dma_env)

  dma_agent agt;
  dma_reg_block reg_model;
  top_adapter adapter;
  uvm_reg_predictor#(dma_seq_item) predictor;
  dma_subscriber sub;

  function new(string name = "dma_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    agt = dma_agent::type_id::create("agt", this);

    reg_model = dma_reg_block::type_id::create("reg_model", this);
    reg_model.build();

    adapter = top_adapter::type_id::create("adapter", this);
    predictor = uvm_reg_predictor#(dma_seq_item)::type_id::create("predictor", this);
    sub = dma_subscriber::type_id::create("sub", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    reg_model.default_map.set_sequencer(agt.sqr, adapter);

    predictor.map = reg_model.default_map;
    predictor.adapter = adapter;

    agt.mon.ap.connect(predictor.bus_in);
    agt.mon.ap.connect(sub.analysis_export);
    reg_model.default_map.set_auto_predict(0);
    endfunction


endclass

