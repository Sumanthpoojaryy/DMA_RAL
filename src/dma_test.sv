class dma_test extends uvm_test;
  `uvm_component_utils(dma_test)
  
  dma_env env;
  ctrl_reg_sequence seq;
  
  function new(string name = "dma_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = ctrl_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass

class intr_dma_test extends uvm_test;
  `uvm_component_utils(intr_dma_test)
  
  dma_env env;
  intr_reg_sequence seq;
  
  function new(string name = "intr_dma_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = intr_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass

class ctrl_dma_test extends uvm_test;
  `uvm_component_utils(ctrl_dma_test)
  
  dma_env env;
  ctrl_reg_sequence seq;
  
  function new(string name = "ctrl_dma_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = ctrl_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass

class io_addr_dma_test extends uvm_test;
  `uvm_component_utils(io_addr_dma_test)
  
  dma_env env;
  io_addr_reg_sequence seq;
  
  function new(string name = "io_addr_dma_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = io_addr_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass

class mem_addr_dma_test extends uvm_test;
  `uvm_component_utils(mem_addr_dma_test)
  
  dma_env env;
  mem_addr_reg_sequence seq;
  
  function new(string name = "mem_addr_dma_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = mem_addr_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass

class extra_info_dma_test extends uvm_test;
  `uvm_component_utils(extra_info_dma_test)
  
  dma_env env;
  extra_info_r_reg_sequence seq;
  
  function new(string name = "extra_info_dma_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = extra_info_r_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass

class status_dma_test extends uvm_test;
  `uvm_component_utils(status_dma_test)
  
  dma_env env;
  status_reg_sequence seq;
  
  function new(string name = "status_dma_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = status_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass

class transfer_count_dma_test extends uvm_test;
  `uvm_component_utils(transfer_count_dma_test)
  
  dma_env env;
  transfer_count_reg_sequence seq;
  
  function new(string name = "transfer_count_dma_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = transfer_count_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass

class descriptor_addr_reg_test extends uvm_test;
  `uvm_component_utils(descriptor_addr_reg_test)
  
  dma_env env;
  descriptor_addr_reg_sequence seq;
  
  function new(string name = "descriptor_addr_reg_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = descriptor_addr_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass

class error_status_reg_test extends uvm_test;
  `uvm_component_utils(error_status_reg_test)
  
  dma_env env;
  error_status_reg_sequence seq;
  
  function new(string name = "error_status_reg_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = error_status_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass

class config_reg_test extends uvm_test;
  `uvm_component_utils(config_reg_test)
  
  dma_env env;
  config_reg_sequence seq;
  
  function new(string name = "config_reg_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = config_reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass


class regression_test extends uvm_test;
  `uvm_component_utils(regression_test)
  
  dma_env env;
  regression_sequence seq;
  
  function new(string name = "regression_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = regression_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass


