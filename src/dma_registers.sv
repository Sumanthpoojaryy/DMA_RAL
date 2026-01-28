//============================================================
// INTR REGISTER
//============================================================

class intr_reg extends uvm_reg;
  `uvm_object_utils(intr_reg)
  
  uvm_reg_field intr_status;
  rand uvm_reg_field intr_mask;


  covergroup intr_cov;
    option.per_instance = 1;

    intr_done_cp : coverpoint intr_status.value[0] {
      bins not_done = {0};
    }

    intr_mask_cp : coverpoint intr_mask.value {
      bins masked  = {0};
      bins enabled = {[1:$]};
    }

    intr_done_x_intr_mask : cross intr_done_cp, intr_mask_cp;
  endgroup
  
  function new(string name = "intr_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      intr_cov = new();
  endfunction
  
  function void build();
    intr_status = uvm_reg_field::type_id::create("intr_status");
    intr_status.configure(
      .parent(this),
      .size(16),
      .lsb_pos(0),
      .access("RO"),
      .volatile(0),
      .reset(0),
      .has_reset(1),
      .is_rand(1),
      .individually_accessible(1)
    );
    
    intr_mask = uvm_reg_field::type_id::create("intr_mask");
    intr_mask.configure(
      .parent(this),
      .size(16),
      .lsb_pos(16),
      .access("RW"),
      .volatile(0),
      .reset(0),
      .has_reset(1),
      .is_rand(1),
      .individually_accessible(1)
    );

  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    intr_cov.sample();
  endfunction
endclass
  

//============================================================
// CTRL REGISTER
//============================================================

class ctrl_reg extends uvm_reg;
  `uvm_object_utils(ctrl_reg)

  rand uvm_reg_field start_dma;
  rand uvm_reg_field w_count;
  rand uvm_reg_field io_mem;
  uvm_reg_field reserved;

  covergroup ctrl_cov;
    option.per_instance = 1;

    start_cp : coverpoint start_dma.value {
      bins idle  = {0};
      bins start = {1};
    }

    dir_cp : coverpoint io_mem.value {
      bins io_to_mem = {0};
      bins mem_to_io = {1};
    }

    wcount_cp : coverpoint w_count.value {
      bins zero  = {0};
      bins small_bin = {[1:15]};
      bins large_bin = {[16:$]};
    }

    start_x_dir : cross start_cp, dir_cp;
  endgroup

  function new(string name="ctrl_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      ctrl_cov = new();
  endfunction

  function void build();

    start_dma = uvm_reg_field::type_id::create("start_dma");
    start_dma.configure(
      .parent(this),
      .size(1),
      .lsb_pos(0),
      .access("RW"),
      .volatile(0),
      .reset(0),
      .has_reset(1),
      .is_rand(1),
      .individually_accessible(1)
    );

    w_count = uvm_reg_field::type_id::create("w_count");
    w_count.configure(
      .parent(this),
      .size(15),
      .lsb_pos(1),  
      .access("RW"),
      .volatile(0),
      .reset(0),
      .has_reset(1),
      .is_rand(1),
      .individually_accessible(1)
    );

    io_mem = uvm_reg_field::type_id::create("io_mem");
    io_mem.configure(
      .parent(this),
      .size(1),
      .lsb_pos(16),
      .access("RW"),
      .volatile(0),
      .reset(0),
      .has_reset(1),
      .is_rand(1),
      .individually_accessible(1)
    );

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(
      .parent(this),
      .size(15),
      .lsb_pos(17),
      .access("RO"),
      .volatile(0),
      .reset(0),
      .has_reset(1),
      .is_rand(0),
      .individually_accessible(0)
    );

  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    ctrl_cov.sample();
  endfunction

  endclass

//============================================================
// IO ADDRESS REGISTER
//============================================================

class io_addr_reg extends uvm_reg;
  `uvm_object_utils(io_addr_reg)
  
  rand uvm_reg_field io_addr;

  covergroup io_addr_cov;
    option.per_instance = 1;

    addr_range_cp : coverpoint io_addr.value {
      bins low_range  = {[32'h0000_0000 : 32'h0000_FFFF]};
      bins mid_range  = {[32'h0001_0000 : 32'h0FFF_FFFF]};
      bins high_range = {[32'h1000_0000 : 32'hFFFF_FFFF]};
    }


  endgroup
  
  function new(string name="io_addr_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      io_addr_cov = new();
  endfunction
  
  function void build();
    io_addr = uvm_reg_field::type_id::create("io_addr");
    io_addr.configure(.parent(this),
                          .size(32),
                          .lsb_pos(0),
                          .access("RW"),
                          .volatile(0),
                          .reset(0),
                          .has_reset(1),
                          .is_rand(1),
                          .individually_accessible(1));

    
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    io_addr_cov.sample();
  endfunction

  endclass

//============================================================
// MEMORY ADDRESS REGISTER
//============================================================

class mem_addr_reg extends uvm_reg;
  `uvm_object_utils(mem_addr_reg)
  
  rand uvm_reg_field mem_addr;
  
  covergroup mem_addr_cov;
    option.per_instance = 1;

    addr_range_cp : coverpoint mem_addr.value {
      bins low_mem  = {[32'h0000_0000 : 32'h0000_FFFF]};
      bins mid_mem  = {[32'h0001_0000 : 32'h0FFF_FFFF]};
      bins high_mem = {[32'h1000_0000 : 32'hFFFF_FFFF]};
    }


  endgroup

  function new(string name="mem_addr_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      mem_addr_cov = new();
  endfunction


  function void build();
    mem_addr = uvm_reg_field::type_id::create("mem_addr");
    mem_addr.configure(.parent(this),
                          .size(32),
                          .lsb_pos(0),
                          .access("RW"),
                          .volatile(0),
                          .reset(0),
                          .has_reset(1),
                          .is_rand(1),
                          .individually_accessible(1));
    
   
  endfunction


  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    mem_addr_cov.sample();
  endfunction

  

endclass

//============================================================
 
// EXTRA INFO REGISTER 
//============================================================

class extra_info_reg extends uvm_reg;
  `uvm_object_utils(extra_info_reg)
  
  rand uvm_reg_field extra_info;

  covergroup extra_info_cov;
    option.per_instance = 1;

    addr_range_cp : coverpoint extra_info.value {
      bins low_mem  = {[32'h0000_0000 : 32'h0000_FFFF]};
      bins mid_mem  = {[32'h0001_0000 : 32'h0FFF_FFFF]};
      bins high_mem = {[32'h1000_0000 : 32'hFFFF_FFFF]};
    }


  endgroup
  
  function new(string name = "extra_info_reg");
    super.new(name, 32,UVM_CVR_FIELD_VALS );
    if (has_coverage(UVM_CVR_FIELD_VALS))
       extra_info_cov = new();
  endfunction
  
  function void build();
    extra_info = uvm_reg_field::type_id::create("extra_info");
    extra_info.configure(.parent(this),
                          .size(32),
                          .lsb_pos(0),
                          .access("RW"),
                          .volatile(0),
                          .reset(0),
                          .has_reset(1),
                          .is_rand(1),
                          .individually_accessible(1));
    
   
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    extra_info_cov.sample();
  endfunction

  
endclass

//============================================================
// STATUS REGISTER
//============================================================

class status_reg extends uvm_reg;
  `uvm_object_utils(status_reg)
  
  rand uvm_reg_field busy;
  rand uvm_reg_field done;
  rand uvm_reg_field error;
  rand uvm_reg_field paused;
  rand uvm_reg_field current_state;
  rand uvm_reg_field fifo_level;
  rand uvm_reg_field reserved;

  function new(string name="status_reg");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction
  
  function void build();
    busy = uvm_reg_field::type_id::create("busy");
    busy.configure(.parent(this),
                        .size(1),
                        .lsb_pos(0),
                        .access("RO"),
                        .volatile(0),
                        .reset(0),
                        .has_reset(1),
                        .is_rand(1),
                        .individually_accessible(1));
    
    done = uvm_reg_field::type_id::create("done");
    done.configure(.parent(this),
                      .size(1),
                      .lsb_pos(1),
                      .access("RO"),
                      .volatile(0),
                      .reset(0),
                      .has_reset(1),
                      .is_rand(1),
                      .individually_accessible(1));
    
    error = uvm_reg_field::type_id::create("error");
    error.configure(.parent(this),
                     .size(1),
                     .lsb_pos(2),
                     .access("RO"),
                     .volatile(0),
                     .reset(0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(1));
    
    paused = uvm_reg_field::type_id::create("paused");
    paused.configure(.parent(this),
                     .size(1),
                     .lsb_pos(3),
                     .access("RO"),
                     .volatile(0),
                     .reset(0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(1));
    
    current_state = uvm_reg_field::type_id::create("current_state");
    current_state.configure(.parent(this),
                            .size(4),
                            .lsb_pos(4),
                            .access("RO"),
                            .volatile(0),
                            .reset(0),
                            .has_reset(1),
                            .is_rand(1),
                            .individually_accessible(1));
    
    fifo_level = uvm_reg_field::type_id::create("fifo_level");
    fifo_level.configure(.parent(this),
                         .size(8),
                         .lsb_pos(8),
                         .access("RO"),
                         .volatile(0),
                         .reset(0),
                         .has_reset(1),
                         .is_rand(1),
                         .individually_accessible(1));
    
    reserved = uvm_reg_field::type_id::create("resered");
    reserved.configure(.parent(this),
                       .size(16),
                       .lsb_pos(16),
                       .access("RO"),
                       .volatile(0),
                       .reset(0),
                       .has_reset(1),
                       .is_rand(1),
                       .individually_accessible(1));
  endfunction


endclass

//============================================================
// TRANSFER COUNT REGISTER
//============================================================

class transfer_count_reg extends uvm_reg;
  `uvm_object_utils(transfer_count_reg)
  
  rand uvm_reg_field transfer_count;

  function new(string name = "transfer_count_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction
  
  function void build();
    transfer_count = uvm_reg_field::type_id::create("transfer_count");
    transfer_count.configure(.parent(this),
                             .size(32),
                             .lsb_pos(0),
                             .access("RO"),
                             .volatile(0),
                             .reset(0),
                             .has_reset(1),
                             .is_rand(1),
                             .individually_accessible(1));
    
   
  endfunction


endclass

//============================================================
// DESCRIPTOR ADDRESS REGISTER
//============================================================


class descriptor_addr_reg extends uvm_reg;
  `uvm_object_utils(descriptor_addr_reg)
  
  rand uvm_reg_field descriptor_addr;

  covergroup descriptor_addr_cov;
    option.per_instance = 1;

    addr_range_cp : coverpoint descriptor_addr.value {
      bins low_mem  = {[32'h0000_0000 : 32'h0000_FFFF]};
      bins mid_mem  = {[32'h0001_0000 : 32'h0FFF_FFFF]};
      bins high_mem = {[32'h1000_0000 : 32'hFFFF_FFFF]};
    }


  endgroup

  
  function new(string name = "descriptor_addr_reg");
    super.new(name, 32,UVM_CVR_FIELD_VALS );
    if (has_coverage(UVM_CVR_FIELD_VALS))
      descriptor_addr_cov = new();

  endfunction
  
  function void build();
    descriptor_addr = uvm_reg_field::type_id::create("descriptor_addr");
    descriptor_addr.configure(.parent(this),
                             .size(32),
                             .lsb_pos(0),
                             .access("RW"),
                             .volatile(0),
                             .reset(0),
                             .has_reset(1),
                             .is_rand(1),
                             .individually_accessible(1));
    
   
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    descriptor_addr_cov.sample();
  endfunction

  
endclass

//============================================================
// ERROR STATUS REGISTER (W1C)
//============================================================

class error_status_reg extends uvm_reg;
  `uvm_object_utils(error_status_reg)
  
  rand uvm_reg_field bus_error;
  rand uvm_reg_field timeout_error;
  rand uvm_reg_field alignment_error;
  rand uvm_reg_field overflow_error;
  rand uvm_reg_field underflow_error;
  rand uvm_reg_field reserved;
  rand uvm_reg_field error_code;
  rand uvm_reg_field error_addr_offset;

  covergroup error_cov;
    option.per_instance = 1;

    bus_cp      : coverpoint bus_error.value{
        bins error = {1};
        bins no_error = {0};
    }
    timeout_cp  : coverpoint timeout_error.value{
       bins no_error = {0};
       bins error    = {1};
    }
    align_cp    : coverpoint alignment_error.value{
        bins no_error = {0};
        bins error    = {1};
    }
    overflow_cp : coverpoint overflow_error.value{
        bins no_error = {0};
        bins error    = {1};
    }
    underflow_cp: coverpoint underflow_error.value{
        bins no_error = {0};
        bins error    = {1};
    }

  endgroup
  
  function new(string name="error_status_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      error_cov = new();
  endfunction
  
  function void build();
    bus_error = uvm_reg_field::type_id::create("bus_error");
    bus_error.configure(.parent(this),
                        .size(1),
                        .lsb_pos(0),
                        .access("W1C"),
                        .volatile(0),
                        .reset(0),
                        .has_reset(1),
                        .is_rand(1),
                        .individually_accessible(1));
    
    timeout_error = uvm_reg_field::type_id::create("timeout_error");
    timeout_error.configure(.parent(this),
                      .size(1),
                      .lsb_pos(1),
                      .access("W1C"),
                      .volatile(0),
                      .reset(0),
                      .has_reset(1),
                      .is_rand(1),
                      .individually_accessible(1));
    
    alignment_error = uvm_reg_field::type_id::create("alignment_error");
    alignment_error.configure(.parent(this),
                     .size(1),
                     .lsb_pos(2),
                     .access("W1C"),
                     .volatile(0),
                     .reset(0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(1));
    
    overflow_error = uvm_reg_field::type_id::create("overflow_error");
    overflow_error.configure(.parent(this),
                     .size(1),
                     .lsb_pos(3),
                     .access("W1C"),
                     .volatile(0),
                     .reset(0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(1));
    
    underflow_error = uvm_reg_field::type_id::create("underflow_error");
    underflow_error.configure(.parent(this),
                              .size(1),
                            .lsb_pos(4),
                            .access("W1C"),
                            .volatile(0),
                            .reset(0),
                            .has_reset(1),
                            .is_rand(1),
                            .individually_accessible(1));
    
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(.parent(this),
                       .size(3),
                       .lsb_pos(5),
                       .access("RO"),
                         .volatile(0),
                         .reset(0),
                         .has_reset(1),
                         .is_rand(1),
                         .individually_accessible(1));
    
    error_code = uvm_reg_field::type_id::create("error_code");
    error_code.configure(.parent(this),
                         .size(8),
                         .lsb_pos(8),
                       .access("RO"),
                       .volatile(0),
                       .reset(0),
                       .has_reset(1),
                       .is_rand(1),
                       .individually_accessible(1));
    
    error_addr_offset = uvm_reg_field::type_id::create("error_addr_offset");
    error_addr_offset.configure(.parent(this),
                                .size(16),
                                .lsb_pos(16),
                       .access("RO"),
                       .volatile(0),
                       .reset(0),
                       .has_reset(1),
                       .is_rand(1),
                       .individually_accessible(1));
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    error_cov.sample();
  endfunction

  

endclass

//============================================================
// CONFIG REGISTER
//============================================================

class config_reg extends uvm_reg;
  `uvm_object_utils(config_reg)
  
  rand uvm_reg_field priority_field;
  rand uvm_reg_field auto_restart;
  rand uvm_reg_field interrupt_enable;
  rand uvm_reg_field burst_size;
  rand uvm_reg_field data_width;
  rand uvm_reg_field descriptor_mode;
  rand uvm_reg_field reserved;

  covergroup config_cov;
    option.per_instance = 1;

    priority_cp : coverpoint priority_field.value { bins p[] = {[0:3]}; }
    burst_cp    : coverpoint burst_size.value    { bins b[] = {[0:3]}; }
    width_cp    : coverpoint data_width.value    { bins w[] = {[0:3]}; }

    auto_cp : coverpoint auto_restart.value{
        bins no_auto_restart = {0};
        bins auto_restart    = {1};
    }
    intr_cp : coverpoint interrupt_enable.value{
        bins no_intr_en = {0};
        bins intr_en    = {1};
    }
    desc_cp : coverpoint descriptor_mode.value{
        bins desc_mode_deassert = {0};
        bins desc_mode_assert    = {1};
    }

    
  endgroup
  
  function new(string name="config_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      config_cov = new();
  endfunction
  
  function void build();
    priority_field = uvm_reg_field::type_id::create("priority_field");
    priority_field.configure(.parent(this),
                             .size(2),
                        .lsb_pos(0),
                             .access("RW"),
                        .volatile(0),
                        .reset(0),
                        .has_reset(1),
                        .is_rand(1),
                        .individually_accessible(1));
    
    auto_restart = uvm_reg_field::type_id::create("auto_restart");
    auto_restart.configure(.parent(this),
                      .size(1),
                            .lsb_pos(2),
                      .access("RW"),
                      .volatile(0),
                      .reset(0),
                      .has_reset(1),
                      .is_rand(1),
                      .individually_accessible(1));
    
    interrupt_enable = uvm_reg_field::type_id::create("interrupt_enable");
    interrupt_enable.configure(.parent(this),
                     .size(1),
                               .lsb_pos(3),
                     .access("RW"),
                     .volatile(0),
                     .reset(0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(1));
    
    burst_size = uvm_reg_field::type_id::create("burst_size");
    burst_size.configure(.parent(this),
                         .size(2),
                         .lsb_pos(4),
                     .access("RW"),
                     .volatile(0),
                     .reset(0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(1));
    
    data_width = uvm_reg_field::type_id::create("data_width");
    data_width.configure(.parent(this),
                         .size(2),
                         .lsb_pos(6),
                            .access("RW"),
                            .volatile(0),
                            .reset(0),
                            .has_reset(1),
                            .is_rand(1),
                            .individually_accessible(1));
    
    descriptor_mode = uvm_reg_field::type_id::create("descriptor_mode");
    descriptor_mode.configure(.parent(this),
                              .size(1),
                              .lsb_pos(8),
                       .access("RW"),
                         .volatile(0),
                         .reset(0),
                         .has_reset(1),
                         .is_rand(1),
                         .individually_accessible(1));
    
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(.parent(this),
                       .size(23),
                       .lsb_pos(9),
                       .access("RW"),
                       .volatile(0),
                       .reset(0),
                       .has_reset(1),
                       .is_rand(1),
                       .individually_accessible(1));
    
   
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    config_cov.sample();
  endfunction

  

endclass
