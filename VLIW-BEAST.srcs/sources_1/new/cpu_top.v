`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2019 09:45:32 PM
// Design Name: 
// Module Name: cpu_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_top(
		input clk_100mhz,
		output [15:0] led
    );
	
	wire clk;
	assign clk = clk_100mhz;
	
	reg [15:0] led_state = 'b0;
	wire [15:0] led_state_out;
	assign led = led_state;
	
	wire write_enable_b;
	wire [11:0] addr_b;
	wire [15:0] data_in_b;
	wire [15:0] data_out_b;
	
	wire [6:0] cache_addr;
	wire [511:0] cache_out;
	
	main_memory main_program_ram(
		.clka(clk),
		.ena(1'b1),
		.wea(1'b0),
		.addra(cache_addr),
		.dina('b0),
		.douta(cache_out),
		
		.clkb(clk),
		.enb(1'b1),
		.web(write_enable_b),
		.addrb(addr_b),
		.dinb(data_in_b),
		.doutb(data_out_b)
	);
	
	/*
	localparam DATA_CACHE_ADDR_WIDTH = 6;
	localparam DATA_CACHE_WIDTH = 512;
	
	wire [DATA_CACHE_ADDR_WIDTH-1:0] data_cache_addr;
	wire [DATA_CACHE_WIDTH-1:0] data_cache_out;
	
	wire data_cache_write_enable_b;
	wire [DATA_CACHE_ADDR_WIDTH-1:0] data_cache_addr_b;
	wire [DATA_CACHE_WIDTH-1:0] data_cache_in_b;
	wire [DATA_CACHE_WIDTH-1:0] data_cache_out_b;
	data_ram main_data_ram(
		.clka(clk),
		.ena(1'b1),
		.wea(1'b0),
		.addra(data_cache_addr),
		.dina('b0),
		.douta(data_cache_out),
		
		.clkb(clk),
		.enb(1'b1),
		.web(data_cache_write_enable_b),
		.addrb(data_cache_addr_b),
		.dinb(data_cache_in_b),
		.doutb(data_cache_out_b)
	);
	*/
	
	/*
	wire cache_reload;
	cache_reloader main_cache_reloader(
		.cache_reload_in(cache_reload),
		.cache_addr_out(cache_addr)
	);
	*/
	
	wire dispatcher_enabled;
	
	wire [31:0] semi_word_0;
	wire [31:0] semi_word_1;
	wire [31:0] semi_word_2;
	wire [31:0] semi_word_3;
	
	dispatcher main_dispatcher(
		.clk(clk),
		.enabled(dispatcher_enabled),
		.cache(cache_out),
		.semi_word_0(semi_word_0),
		.semi_word_1(semi_word_1),
		.semi_word_2(semi_word_2),
		.semi_word_3(semi_word_3),
		.cache_addr_out(cache_addr)
		
		//.cache_reload(cache_reload)
	);
	
	dispatcher_delayer initial_dispatcher_delayer(
		.clk(clk),
		.dispatcher_enabled(dispatcher_enabled)
	);
	
	reg [255:0] registers = 'b0;
	
	wire [255:0] registers_out_0;
	wire [15:0] reg_write_enable_0;
	wire [15:0] led_out_0;
	wire led_write_enable_0;
	wire [15:0] data_out_0;
	wire [11:0] addr_out_0;
	wire data_write_en_0;
	wire [11:0] jump_addr_0;
	wire jump_en_0;
	execution_core execution_core_0(
		.clk(clk),
		.semi_word(semi_word_0),
		.registers_in(registers),
		.registers_out(registers_out_0),
		.reg_write_enable(reg_write_enable_0),
		.led_out(led_out_0),
		.led_write_enable(led_write_enable_0),
		.data_out(data_out_0),
		.addr_out(addr_out_0),
		.data_write_enable(data_write_en_0),
		.jump_addr(jump_addr_0),
		.jump_enable(jump_en_0)
	);
	
	wire [255:0] registers_out_1;
	wire [15:0] reg_write_enable_1;
	wire [15:0] led_out_1;
	wire led_write_enable_1;
	wire [15:0] data_out_1;
	wire [11:0] addr_out_1;
	wire data_write_en_1;
	wire [11:0] jump_addr_1;
	wire jump_en_1;
	execution_core execution_core_1(
		.clk(clk),
		.semi_word(semi_word_1),
		.registers_in(registers),
		.registers_out(registers_out_1),
		.reg_write_enable(reg_write_enable_1),
		.led_out(led_out_1),
		.led_write_enable(led_write_enable_1),
		.data_out(data_out_1),
		.addr_out(addr_out_1),
		.data_write_enable(data_write_en_1),
		.jump_addr(jump_addr_1),
		.jump_enable(jump_en_1)
	);
	
	wire [255:0] registers_out_2;
	wire [15:0] reg_write_enable_2;
	wire [15:0] led_out_2;
	wire led_write_enable_2;
	wire [15:0] data_out_2;
	wire [11:0] addr_out_2;
	wire data_write_en_2;
	wire [11:0] jump_addr_2;
	wire jump_en_2;
	execution_core execution_core_2(
		.clk(clk),
		.semi_word(semi_word_2),
		.registers_in(registers),
		.registers_out(registers_out_2),
		.reg_write_enable(reg_write_enable_2),
		.led_out(led_out_2),
		.led_write_enable(led_write_enable_2),
		.data_out(data_out_2),
		.addr_out(addr_out_2),
		.data_write_enable(data_write_en_2),
		.jump_addr(jump_addr_2),
		.jump_enable(jump_en_2)
	);
	
	wire [255:0] registers_out_3;
	wire [15:0] reg_write_enable_3;
	wire [15:0] led_out_3;
	wire led_write_enable_3;
	wire [15:0] data_out_3;
	wire [11:0] addr_out_3;
	wire data_write_en_3;
	wire [11:0] jump_addr_3;
	wire jump_en_3;
	execution_core execution_core_3(
		.clk(clk),
		.semi_word(semi_word_3),
		.registers_in(registers),
		.registers_out(registers_out_3),
		.reg_write_enable(reg_write_enable_3),
		.led_out(led_out_3),
		.led_write_enable(led_write_enable_3),
		.data_out(data_out_3),
		.addr_out(addr_out_3),
		.data_write_enable(data_write_en_3),
		.jump_addr(jump_addr_3),
		.jump_enable(jump_en_3)
	);
	
	wire [255:0] updated_registers;
	
	register_manager main_register_manager(
		.original_registers(registers),
		.registers_0(registers_out_0),
		.registers_1(registers_out_1),
		.registers_2(registers_out_2),
		.registers_3(registers_out_3),
		
		.reg_write_en_0(reg_write_enable_0),
		.reg_write_en_1(reg_write_enable_1),
		.reg_write_en_2(reg_write_enable_2),
		.reg_write_en_3(reg_write_enable_3),
		
		.registers_out(updated_registers)
	);
	
	led_IO_manager main_led_IO_manager(
		.current_led(led_state),
		.led_in_0(led_out_0),
		.led_in_1(led_out_1),
		.led_in_2(led_out_2),
		.led_in_3(led_out_3),
		
		.write_en_0(led_write_enable_0),
		.write_en_1(led_write_enable_1),
		.write_en_2(led_write_enable_2),
		.write_en_3(led_write_enable_3),
		
		.led_out(led_state_out)
	);
	
	single_port_data_manager main_data_write_manager(
		.data_in_0(data_out_0),
		.data_in_1(data_out_1),
		.data_in_2(data_out_2),
		.data_in_3(data_out_3),
		
		.addr_in_0(addr_out_0),
		.addr_in_1(addr_out_1),
		.addr_in_2(addr_out_2),
		.addr_in_3(addr_out_3),
		
		.en_0(data_write_en_0),
		.en_1(data_write_en_1),
		.en_2(data_write_en_2),
		.en_3(data_write_en_3),
		
		.data_out(data_in_b),
		.addr_out(addr_b),
		.write_enable(write_enable_b)
	);
	
	always @(negedge clk) begin
		if (dispatcher_enabled) begin
			registers <= updated_registers;
			led_state <= led_state_out;
		end
	end
	
endmodule
