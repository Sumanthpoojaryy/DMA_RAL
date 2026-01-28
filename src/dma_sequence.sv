class reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "reg_sequence");
    super.new(name);
  endfunction

  task body();
    
    reg_model.mem_addr.write(status, 32'h100, UVM_FRONTDOOR);
    #20;
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)
    
    reg_model.mem_addr.read(status, read_d, UVM_BACKDOOR);
    #20;
    
    reg_model.mem_addr.mirror(status, UVM_CHECK);
    

    reg_model.intr.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model.intr.get();
    mir = reg_model.intr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.intr.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.intr.get();
    mir = reg_model.intr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)
    
    reg_model.intr.mirror(status, UVM_CHECK);
    
    
    reg_model.ctrl.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.ctrl.get();
    mir = reg_model.ctrl.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)
    reg_model.ctrl.mirror(status, UVM_CHECK);

    reg_model.ctrl.read(status, read_d, UVM_BACKDOOR);
    des = reg_model.ctrl.get();
    mir = reg_model.ctrl.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL read des= 0x%0h mir= 0x%0h rdata 0x%0h",des, mir, read_d),UVM_NONE)
    reg_model.ctrl.mirror(status, UVM_CHECK);

    reg_model.io_addr.write(status, 32'hA5A5_A5A5);
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)
    reg_model.io_addr.mirror(status, UVM_CHECK);

    reg_model.io_addr.read(status, read_d);
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR read  des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)
    reg_model.io_addr.mirror(status, UVM_CHECK);

    reg_model.mem_addr.write(status, 32'h1234_5678);
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)
    reg_model.mem_addr.mirror(status, UVM_CHECK);


    reg_model.mem_addr.read(status, read_d);
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR READ des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)
    reg_model.mem_addr.mirror(status, UVM_CHECK);


    reg_model.error_status.read(status, read_d);
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("ERROR_STATUS before des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)
    reg_model.error_status.mirror(status, UVM_CHECK);
    

    reg_model.error_status.write(status, 32'h0000_001F);
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("ERROR_STATUS write des= 0x%0h mir= 0x%0h",des, mir),UVM_NONE)
    reg_model.error_status.mirror(status, UVM_CHECK);

    reg_model.error_status.read(status, read_d);
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("ERROR_STATUS read  des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)

    reg_model.configer.write(status, 32'h0000_01AF);
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CONFIG write des= 0x%0h mir= 0x%0h",des, mir),UVM_NONE)

    reg_model.configer.read(status, read_d);
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CONFIG read des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)

  endtask

endclass

class intr_reg_sequence extends reg_sequence;
  `uvm_object_utils(intr_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "intr_reg_sequence");
    super.new(name);
  endfunction

  task body();
    reg_model.intr.reset();
        
    reg_model.intr.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.intr.get();
    mir = reg_model.intr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.intr.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.intr.get();
    mir = reg_model.intr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.intr.mirror(status, UVM_CHECK);
    
    reg_model.intr.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    des = reg_model.intr.get();
    mir = reg_model.intr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.intr.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.intr.get();
    mir = reg_model.intr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.intr.mirror(status, UVM_CHECK);
    
    repeat(5)begin
      reg_model.intr.write(status,$random,UVM_FRONTDOOR);
      des = reg_model.intr.get();
      mir = reg_model.intr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("INTR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.intr.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.intr.get();
      mir = reg_model.intr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("INTR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.intr.mirror(status, UVM_CHECK);
    end
    
  endtask
endclass

class ctrl_reg_sequence extends reg_sequence;
  `uvm_object_utils(ctrl_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "ctrl_reg_sequence");
    super.new(name);
  endfunction

  task body();
    reg_model.ctrl.reset();
        
    reg_model.ctrl.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.ctrl.get();
    mir = reg_model.ctrl.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.ctrl.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.ctrl.get();
    mir = reg_model.ctrl.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.ctrl.mirror(status, UVM_CHECK);
    
    reg_model.ctrl.write(status, 32'h0000_000A, UVM_FRONTDOOR);
    des = reg_model.ctrl.get();
    mir = reg_model.ctrl.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.ctrl.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.ctrl.get();
    mir = reg_model.ctrl.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.ctrl.mirror(status, UVM_CHECK);
    
    repeat(5)begin
      reg_model.ctrl.write(status, $random, UVM_FRONTDOOR);
      des = reg_model.ctrl.get();
      mir = reg_model.ctrl.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("CTRL write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.ctrl.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.ctrl.get();
      mir = reg_model.ctrl.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("CTRL read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.ctrl.mirror(status, UVM_CHECK);
    end
    reg_model.ctrl.write(status, 1, UVM_FRONTDOOR);
      des = reg_model.ctrl.get();
      mir = reg_model.ctrl.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("CTRL write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.ctrl.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.ctrl.get();
      mir = reg_model.ctrl.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("CTRL read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.ctrl.mirror(status, UVM_CHECK);
  endtask
endclass

class io_addr_reg_sequence extends reg_sequence;
  `uvm_object_utils(io_addr_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "io_addr_reg_sequence");
    super.new(name);
  endfunction

  task body();
    reg_model.io_addr.reset();
        
    reg_model.io_addr.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR  write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.io_addr.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.io_addr.mirror(status, UVM_CHECK);
    
    reg_model.io_addr.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.io_addr.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.io_addr.mirror(status, UVM_CHECK);
    
    repeat(5)begin
      reg_model.io_addr.randomize();
      reg_model.io_addr.write(status,reg_model.io_addr.io_addr.value);
      des = reg_model.io_addr.get();
      mir = reg_model.io_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("IO_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.io_addr.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.io_addr.get();
      mir = reg_model.io_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("IO_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.io_addr.mirror(status, UVM_CHECK);
    end
    reg_model.io_addr.write(status, 1, UVM_FRONTDOOR);
      des = reg_model.io_addr.get();
      mir = reg_model.io_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("IO_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.io_addr.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.io_addr.get();
      mir = reg_model.io_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("IO_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.io_addr.mirror(status, UVM_CHECK);
  endtask
endclass

class mem_addr_reg_sequence extends reg_sequence;
  `uvm_object_utils(mem_addr_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "mem_addr_reg_sequence");
    super.new(name);
  endfunction

  task body();
    reg_model.mem_addr.reset();
        
    reg_model.mem_addr.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR  write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.mem_addr.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.mem_addr.mirror(status, UVM_CHECK);
   
     reg_model.mem_addr.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.mem_addr.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.mem_addr.mirror(status, UVM_CHECK);

    reg_model.mem_addr.write(status, 32'h0FFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.mem_addr.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.mem_addr.mirror(status, UVM_CHECK);
    
    repeat(5)begin
      reg_model.mem_addr.randomize();
      reg_model.mem_addr.write(status,reg_model.mem_addr.mem_addr.value);
      des = reg_model.mem_addr.get();
      mir = reg_model.mem_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("MEM_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.mem_addr.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.mem_addr.get();
      mir = reg_model.mem_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("MEM_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.mem_addr.mirror(status, UVM_CHECK);
    end
  endtask
endclass


class extra_info_r_reg_sequence extends reg_sequence;
  `uvm_object_utils(extra_info_r_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "extra_info_r_reg_sequence");
    super.new(name);
  endfunction

  task body();
    reg_model.extra_info.reset();
        
    reg_model.extra_info.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.extra_info.get();
    mir = reg_model.extra_info.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("extra_info  write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.extra_info.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.extra_info.get();
    mir = reg_model.extra_info.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("extra_info read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.extra_info.mirror(status, UVM_CHECK);
    
    reg_model.extra_info.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    des = reg_model.extra_info.get();
    mir = reg_model.extra_info.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("extra_info write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.extra_info.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.extra_info.get();
    mir = reg_model.extra_info.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("extra_info read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.extra_info.mirror(status, UVM_CHECK);
    
    repeat(5)begin
      reg_model.extra_info.randomize();
      reg_model.extra_info.write(status,reg_model.extra_info.extra_info.value);
      des = reg_model.extra_info.get();
      mir = reg_model.extra_info.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("extra_info write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.extra_info.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.extra_info.get();
      mir = reg_model.extra_info.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("extra_info read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.extra_info.mirror(status, UVM_CHECK);
    end
  endtask
endclass



class status_reg_sequence extends reg_sequence;
  `uvm_object_utils(status_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "status_reg_sequence");
    super.new(name);
  endfunction

  task body();
    reg_model.status.reset();
        
    reg_model.status.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.status.get();
    mir = reg_model.status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("status  write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.status.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.status.get();
    mir = reg_model.status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("status read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.status.mirror(status, UVM_CHECK);
    
    reg_model.status.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    des = reg_model.status.get();
    mir = reg_model.status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("status write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.status.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.status.get();
    mir = reg_model.status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("status read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.status.mirror(status, UVM_CHECK);
    
    repeat(5)begin
      data = $random;
      reg_model.status.write(status, data, UVM_FRONTDOOR);
      $display("data = %0d",data);
      des = reg_model.status.get();
      mir = reg_model.status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("status write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.status.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.status.get();
      mir = reg_model.status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("status read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.status.mirror(status, UVM_CHECK);
    end
    $display("backdoor");
    reg_model.status.poke(status, 10);
      des = reg_model.status.get();
      mir = reg_model.status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("status write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.status.read(status, read_d);
      des = reg_model.status.get();
      mir = reg_model.status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("status read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.status.mirror(status, UVM_CHECK);
  endtask
endclass

class transfer_count_reg_sequence extends reg_sequence;
  `uvm_object_utils(transfer_count_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "transfer_count_reg_sequence");
    super.new(name);
  endfunction

  task body();

        
    reg_model.transfer_count.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.transfer_count.get();
    mir = reg_model.transfer_count.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("transfer_count  write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.transfer_count.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.transfer_count.get();
    mir = reg_model.transfer_count.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("transfer_count read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.transfer_count.mirror(status, UVM_CHECK);
    
    reg_model.transfer_count.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    des = reg_model.transfer_count.get();
    mir = reg_model.transfer_count.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("transfer_count write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.transfer_count.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.transfer_count.get();
    mir = reg_model.transfer_count.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("transfer_count read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.transfer_count.mirror(status, UVM_CHECK);
    
    repeat(5)begin
      data = $random;
      reg_model.transfer_count.write(status, data, UVM_FRONTDOOR);
      $display("data=%0d",data);
      des = reg_model.transfer_count.get();
      mir = reg_model.transfer_count.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("transfer_count write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.transfer_count.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.transfer_count.get();
      mir = reg_model.transfer_count.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("transfer_count read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.transfer_count.mirror(status, UVM_CHECK);
    end
    $display("backdoor");
    reg_model.transfer_count.poke(status, 10);
      des = reg_model.transfer_count.get();
      mir = reg_model.transfer_count.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("transfer_count write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.transfer_count.read(status, read_d,UVM_FRONTDOOR);
      des = reg_model.transfer_count.get();
      mir = reg_model.transfer_count.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("transfer_count read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.transfer_count.mirror(status, UVM_CHECK);
  endtask
endclass


class descriptor_addr_reg_sequence extends reg_sequence;
  `uvm_object_utils(descriptor_addr_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "descriptor_addr_reg_sequence");
    super.new(name);
  endfunction

  task body();
    reg_model.descriptor_addr.reset();    

    reg_model.descriptor_addr.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.descriptor_addr.get();
    mir = reg_model.descriptor_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("descriptor_addr  write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.descriptor_addr.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.descriptor_addr.get();
    mir = reg_model.descriptor_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("descriptor_addr read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.descriptor_addr.mirror(status, UVM_CHECK);

    reg_model.descriptor_addr.write(status, 32'h0001_0000, UVM_FRONTDOOR);
    des = reg_model.descriptor_addr.get();
    mir = reg_model.descriptor_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("descriptor_addr  write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.descriptor_addr.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.descriptor_addr.get();
    mir = reg_model.descriptor_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("descriptor_addr read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.descriptor_addr.mirror(status, UVM_CHECK);
    
    reg_model.descriptor_addr.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    des = reg_model.descriptor_addr.get();
    mir = reg_model.descriptor_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("descriptor_addr write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.descriptor_addr.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.descriptor_addr.get();
    mir = reg_model.descriptor_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("descriptor_addr read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.descriptor_addr.mirror(status, UVM_CHECK);
    
    repeat(5)begin
      reg_model.descriptor_addr.randomize();
      reg_model.descriptor_addr.write(status,reg_model.descriptor_addr.descriptor_addr.value);
      des = reg_model.descriptor_addr.get();
      mir = reg_model.descriptor_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("descriptor_addr write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.descriptor_addr.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.descriptor_addr.get();
      mir = reg_model.descriptor_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("descriptor_addr read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.descriptor_addr.mirror(status, UVM_CHECK);
    end
    $display("backdoor");
    reg_model.descriptor_addr.poke(status, 10);
      des = reg_model.descriptor_addr.get();
      mir = reg_model.descriptor_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("descriptor_addr write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.descriptor_addr.read(status, read_d,UVM_FRONTDOOR);
      des = reg_model.descriptor_addr.get();
      mir = reg_model.descriptor_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("descriptor_addr read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.descriptor_addr.mirror(status, UVM_CHECK);
  endtask
endclass

class error_status_reg_sequence extends reg_sequence;
  `uvm_object_utils(error_status_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "error_status_reg_sequence");
    super.new(name);
  endfunction

  task body();
    reg_model.error_status.reset();
        
    reg_model.error_status.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("error_status  write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.error_status.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("error_status read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.status.mirror(status, UVM_CHECK);
    
    reg_model.error_status.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("error_status write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.error_status.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("error_status read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.error_status.mirror(status, UVM_CHECK);

    reg_model.error_status.write(status, 32'h0000_001F, UVM_FRONTDOOR);
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("error_status write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.error_status.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("error_status read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.error_status.mirror(status, UVM_CHECK);
    
    repeat(5)begin
      reg_model.error_status.randomize();
      reg_model.error_status.write(status,reg_model.descriptor_addr.descriptor_addr.value);
      des = reg_model.error_status.get();
      mir = reg_model.error_status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("error_status write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.error_status.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.error_status.get();
      mir = reg_model.error_status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("error_status read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.error_status.mirror(status, UVM_CHECK);
    end
    $display("backdoor");
    reg_model.error_status.poke(status, 10);
      des = reg_model.error_status.get();
      mir = reg_model.error_status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("error_status write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.error_status.read(status, read_d,UVM_FRONTDOOR);
      des = reg_model.error_status.get();
      mir = reg_model.error_status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("error_status read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.error_status.mirror(status, UVM_CHECK);

      reg_model.error_status.poke(status, 32'h0000_001F);
      des = reg_model.error_status.get();
      mir = reg_model.error_status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("error_status write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.error_status.read(status, read_d,UVM_FRONTDOOR);
      des = reg_model.error_status.get();
      mir = reg_model.error_status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("error_status read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.error_status.mirror(status, UVM_CHECK);


    
  endtask
endclass

class config_reg_sequence extends reg_sequence;
  `uvm_object_utils(config_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "config_reg_sequence");
    super.new(name);
  endfunction

  task body();

    reg_model.configer.reset();
        
    reg_model.configer.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("configer  write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.configer.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("configer read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.configer.mirror(status, UVM_CHECK);
    
    reg_model.configer.write(status, 32'h0000_0010, UVM_FRONTDOOR);
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("configer  write des= %b mir= %b", des, mir),UVM_NONE)

    reg_model.configer.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("configer read des= %b mir= %b rdata = %b",des, mir, read_d),UVM_NONE)    
    reg_model.configer.mirror(status, UVM_CHECK);
    

    reg_model.configer.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("configer write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.configer.read(status, read_d, UVM_FRONTDOOR);
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("configer read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.configer.mirror(status, UVM_CHECK);
    
    repeat(5)begin
      reg_model.configer.write(status,$random,UVM_FRONTDOOR);
      des = reg_model.configer.get();
      mir = reg_model.configer.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("configer write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.configer.read(status, read_d, UVM_FRONTDOOR);
      des = reg_model.configer.get();
      mir = reg_model.configer.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("configer read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.configer.mirror(status, UVM_CHECK);
    end
    $display("backdoor");
    reg_model.configer.poke(status, 10);
      des = reg_model.configer.get();
      mir = reg_model.configer.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("configer write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.configer.read(status, read_d,UVM_FRONTDOOR);
      des = reg_model.configer.get();
      mir = reg_model.configer.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("configer read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.configer.mirror(status, UVM_CHECK);
  endtask
endclass

class regression_sequence extends reg_sequence;
  `uvm_object_utils(regression_sequence)
  dma_reg_block reg_model;
  intr_reg_sequence            intr_seq;
  ctrl_reg_sequence            ctrl_seq;
  io_addr_reg_sequence         io_addr_seq;
  mem_addr_reg_sequence        mem_addr_seq;
  transfer_count_reg_sequence  tc_seq;
  descriptor_addr_reg_sequence desc_seq;
  status_reg_sequence          status_seq;
  error_status_reg_sequence    err_seq;
  config_reg_sequence          cfg_seq;
  extra_info_r_reg_sequence    info_seq;

  function new(string name = "regression_sequence");
    super.new(name);
  endfunction

  task body();

    intr_seq    = intr_reg_sequence::type_id::create("intr_seq");
    ctrl_seq    = ctrl_reg_sequence::type_id::create("ctrl_seq");
    io_addr_seq = io_addr_reg_sequence::type_id::create("io_addr_seq");
    mem_addr_seq= mem_addr_reg_sequence::type_id::create("mem_addr_seq");
    tc_seq      = transfer_count_reg_sequence::type_id::create("tc_seq");
    desc_seq    = descriptor_addr_reg_sequence::type_id::create("desc_seq");
    status_seq  = status_reg_sequence::type_id::create("status_seq");
    err_seq     = error_status_reg_sequence::type_id::create("err_seq");
    cfg_seq     = config_reg_sequence::type_id::create("cfg_seq");
    info_seq    = extra_info_r_reg_sequence::type_id::create("info_seq");

  
    intr_seq.reg_model    = reg_model;
    ctrl_seq.reg_model    = reg_model;
    io_addr_seq.reg_model = reg_model;
    mem_addr_seq.reg_model= reg_model;
    tc_seq.reg_model      = reg_model;
    desc_seq.reg_model    = reg_model;
    status_seq.reg_model  = reg_model;
    err_seq.reg_model     = reg_model;
    cfg_seq.reg_model     = reg_model;
    info_seq.reg_model    = reg_model;

    
    
    intr_seq.start(m_sequencer);
    ctrl_seq.start(m_sequencer);

    io_addr_seq.start(m_sequencer);
    mem_addr_seq.start(m_sequencer);
    tc_seq.start(m_sequencer);
    desc_seq.start(m_sequencer);

    
    status_seq.start(m_sequencer);
    err_seq.start(m_sequencer);
    cfg_seq.start(m_sequencer);
    info_seq.start(m_sequencer);

  endtask
endclass


