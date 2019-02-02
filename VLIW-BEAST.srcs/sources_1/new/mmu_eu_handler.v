`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2019 06:00:38 PM
// Design Name: 
// Module Name: mmu_eu_handler
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Not finished
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mmu_eu_handler(
		input [11:0] main_memory_base_addr,
		
		input [15:0] data_in,
		input [11:0] data_addr,
		input data_write,
		
		output [DATA_CACHE_WIDTH-1:0] cache_out,
		inout data_cache_reload
    );
	parameter DATA_CACHE_WIDTH = 512;
	localparam DATA_CACHE_WORD_LENGTH = DATA_CACHE_WIDTH / 16;
	
	always @(posedge data_in or posedge data_addr or negedge data_cache_reload) begin
		if (data_write_en) begin
			if ((data_addr >= main_memory_base_addr) & (data_addr < main_memory_base_addr + DATA_CACHE_WIDTH)) begin
				cache_out[DATA_CACHE_WIDTH-1 - (data_addr % DATA_CACHE_WORD_LENGTH)-:16] <= data_in;
			end else begin
				data_cache_reload <= 1'b1;
			end
		end
	end
	
endmodule
