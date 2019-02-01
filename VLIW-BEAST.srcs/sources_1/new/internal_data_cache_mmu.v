`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2019 10:54:22 PM
// Design Name: 
// Module Name: internal_data_cache_mmu
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


module internal_data_cache_mmu(
		input clk,
		input [DATA_CACHE_ADDR_WIDTH-1:0] cache_addr,
		input [DATA_CACHE_WIDTH-1:0] cache_in,
		
		input [15:0] data_in_0,
		input [11:0] data_addr_0,
		input data_write_en_0,
		
		input [15:0] data_in_1,
		input [11:0] data_addr_1,
		input data_write_en_1,
		
		inout data_cache_reload,
		output [DATA_CACHE_ADDR_WIDTH-1:0] data_cache_reload_addr,
		output [DATA_CACHE_WIDTH-1:0] cache_out
    );
	parameter DATA_CACHE_ADDR_WIDTH = 6;
	parameter DATA_CACHE_WIDTH = 512;
	
	localparam DATA_CACHE_WORD_LENGTH = DATA_CACHE_WIDTH / 16;
	localparam DATA_CACHE_WORD_SHIFT = $clog2(DATA_CACHE_WORD_LENGTH);
	
	wire [11:0] main_memory_base_addr;
	wire [11:0] main_memory_end_addr;
	assign main_memory_base_addr = (cache_addr * DATA_CACHE_WIDTH) >> 4;
	assign main_memory_end_addr = main_memory_base_addr + DATA_CACHE_WORD_LENGTH;
	
	wire cache_reload_0;
	wire cache_reload_1;
	
	assign cache_reload_0 = data_write_en_0 & ~((data_addr_0 >= main_memory_base_addr) & (data_addr_0 < main_memory_end_addr));
	assign cache_reload_1 = data_write_en_1 & ~((data_addr_1 >= main_memory_base_addr) & (data_addr_1 < main_memory_end_addr));
	
	assign data_cache_reload = cache_reload_0 | cache_reload_1;
	
	wire [DATA_CACHE_ADDR_WIDTH-1:0] cache_addr_0;
	
	assign data_cache_reload_addr = (cache_reload_0 ? (data_addr_0 >> 5) : (cache_reload_1 ? (data_addr_1 >> 5) : 'b0));
	
	
endmodule
