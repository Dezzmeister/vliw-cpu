`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2019 11:14:25 PM
// Design Name: 
// Module Name: dispatcher
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


module dispatcher(
		input clk,
		input enabled,
		input branching,
		input [6:0] new_cache_addr,
		input [3:0] forced_count,
		input [511:0] cache,
		
		output reg [31:0] semi_word_0 = 'b0,
		output reg [31:0] semi_word_1 = 'b0,
		output reg [31:0] semi_word_2 = 'b0,
		output reg [31:0] semi_word_3 = 'b0,
		
		output reg [6:0] cache_addr_out = 'b0
    );
	
	localparam MOV_LIT_REG = 12'b000000000010;
	localparam MOV_REG_MEM = 12'b000000000001;
	localparam STO_REG_MEM = 12'b000000000011;
	
	localparam JMP = 16'b0001000000000000;
	localparam JNE_HEADER = 8'b00010001;
	localparam JE_HEADER = 8'b00010010;
	localparam JLE_HEADER = 8'b00010011;
	
	reg [3:0] count = 4'b0;
	reg [3:0] count_stall_0 = 4'd8;
	
	wire [63:0] word;
	assign word = cache[(511-(count*64))-:64];
	
	wire [15:0] quword_0;
	wire [15:0] quword_1;
	wire [15:0] quword_2;
	wire [15:0] quword_3;
	assign quword_0 = word[63:48];
	assign quword_1 = word[47:32];
	assign quword_2 = word[31:16];
	assign quword_3 = word[15:0];
	
	wire wait_for_0;
	wire wait_for_2;
	
	instr_size_determiner quword_0_determiner(
		.quword(quword_0),
		.wait_for_operand(wait_for_0)
	);
	
	instr_size_determiner quword_2_determiner(
		.quword(quword_2),
		.wait_for_operand(wait_for_2)
	);
	
	reg wait_for_branch = 1'b0;
	reg wait_for_branch_stall_0 = 1'b1;
	reg wait_for_branch_stall_1 = 1'b1;
	
	always @(posedge clk) begin
		if (enabled) begin
			if (~branching) begin
				if (count == 4'd7) begin
					cache_addr_out <= cache_addr_out + 1;
				end
			
				if (count == 4'd8) begin			
					count_stall_0 <= 3'b0;
					count <= count_stall_0;
				end else begin
			
					count_stall_0 <= 4'd8;
			
					count <= count + 1;
				end
		
				if (count != 4'd8) begin
					if (wait_for_0) begin
						semi_word_0 <= (quword_0 << 16) | quword_1;
						semi_word_1 <= 32'b0;
					end else begin
						semi_word_0 <= quword_0 << 16;
						semi_word_1 <= quword_1 << 16;
					end
					if (wait_for_2) begin
						semi_word_2 <= (quword_2 << 16) | quword_3;
						semi_word_3 <= 32'b0;
					end else begin
						semi_word_2 <= quword_2 << 16;
						semi_word_3 <= quword_3 << 16;
					end
				end else begin
					semi_word_0 <= 'b0;
					semi_word_1 <= 'b0;
					semi_word_2 <= 'b0;
					semi_word_3 <= 'b0;
				end
			end else if (wait_for_branch) begin
				wait_for_branch_stall_0 <= 1'b0;
				wait_for_branch_stall_1 <= wait_for_branch_stall_0;
				wait_for_branch <= wait_for_branch_stall_1;
			end else begin				
				count <= forced_count;
				cache_addr_out <= new_cache_addr;
				
				wait_for_branch_stall_0 <= 1'b1;
				wait_for_branch_stall_1 <= 1'b1;
				if (cache_addr_out != new_cache_addr) begin
					wait_for_branch <= 1'b1;
				end
			end
		end
	end
	
	//assign cache_reload = (count == 4'd7);
	
endmodule
