`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 12:07:08 AM
// Design Name: 
// Module Name: execution_core
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Runs a stream of instructions obtained from the dispatcher. Each instruction should execute in one clock cycle except for memory read/writes and future instructions.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module execution_core(
		input clk,
		input [31:0] semi_word,
		input [255:0] registers_in,
		output reg [255:0] registers_out = 'b0,
		output reg [15:0] reg_write_enable = 'b0,
		output reg [15:0] led_out = 'b0,
		output reg led_write_enable = 1'b0,
		output reg [15:0] data_out = 'b0,
		output reg [11:0] addr_out = 'b0,
		output reg data_write_enable = 1'b0,
		output reg [11:0] jump_addr,
		output reg jump_enable
    );
	
	localparam MOV_LIT_REG_HEADER = 12'b000000000010;
	localparam STO_REG_MEM_HEADER = 12'b000000000011;
	localparam SETLED_INSTR_HEADER = 12'b000000000100;
	localparam FUTURE_SETLED_INSTR_HEADER = 12'b100000000100;
	localparam MOV_REG_REG_HEADER = 8'b00000001;
	
	localparam ADD_SRC1_SRC2_DEST_HEADER = 7'b0000001;
	localparam XOR_SRC1_SRC2_DEST_HEADER = 7'b0000010;
	localparam AND_SRC1_SRC2_DEST_HEADER = 7'b0000011;
	localparam OR_SRC1_SRC2_DEST_HEADER = 7'b0000100;
	localparam SHL_LIT_REG_HEADER = 7'b0000101;
	localparam SHR_LIT_REG_HEADER = 7'b0000110;
	
	localparam JMP = 16'b0001000000000000;
	localparam JNE_HEADER = 8'b00010001;
	localparam JE_HEADER = 8'b00010010;
	localparam JLE_HEADER = 8'b00010011;
	
	wire [15:0] instr;
	wire [15:0] operands;
	
	assign instr = semi_word[31:16];
	assign operands = semi_word[15:0];
	
	wire [7:0] src_reg;
	wire [7:0] dest_reg;
	assign src_reg = (255 - (instr[7:4] << 4));
	assign dest_reg = (255 - (instr[3:0] << 4));
	
	wire [15:0] bit_calc_result;
	wire [3:0] bit_calc_reg_out;
	bit_math_unit bit_math_unit_0(
		.enabled(1'b1),
		.instr(instr),
		.registers(registers_in),
		.result(bit_calc_result),
		.register_out(bit_calc_reg_out)
	);
	
	reg [7:0] old_dest_reg = 'b0;
	reg [7:0] old_src_reg = 'b0;
	
	reg future_led = 1'b0;
	
	always @(posedge clk) begin
		if (instr[15:4] == STO_REG_MEM_HEADER) begin
			addr_out <= operands[11:0];
			data_out <= registers_in[dest_reg-:16];
			data_write_enable = 1'b1;
			jump_enable <= 1'b0;
		end else if (instr == JMP) begin	
			jump_addr <= operands;
			jump_enable <= 1'b1;
		end else if (instr[15:8] == JNE_HEADER) begin	
			jump_addr <= operands;
			jump_enable <= (registers_in[src_reg-:16] != registers_in[dest_reg-:16]);
		end else if (instr[15:8] == JE_HEADER) begin
			jump_addr <= operands;
			jump_enable <= (registers_in[src_reg-:16] == registers_in[dest_reg-:16]);
		end else if (instr[15:8] == JLE_HEADER) begin
			jump_addr <= operands;
			jump_enable <= (registers_in[src_reg-:16] < registers_in[dest_reg-:16]);
		end else begin
			jump_enable <= 1'b0;
			data_write_enable = 1'b0;
			
			if (instr[15:4] == MOV_LIT_REG_HEADER) begin
				registers_out[dest_reg-:16] <= operands;
				reg_write_enable <= 12'b0 | (1'b1 << (15 - instr[3:0]));
				
				led_write_enable <= 1'b0;
			end else if (instr[15:8] == MOV_REG_REG_HEADER) begin
				registers_out[dest_reg-:16] <= registers_in[src_reg-:16];
				reg_write_enable <= 12'b0 | (1'b1 << (15 - instr[3:0]));
				
				led_write_enable <= 1'b0;
			end else if ((instr[15:12] == 4'b0000) & (instr[11:9] <= 3'b110) & ~(instr[11:9] == 3'b000)) begin
				registers_out[(255 - (bit_calc_reg_out << 4))-:16] <= bit_calc_result;
				reg_write_enable <= 12'b0 | (1'b1 << (15 - bit_calc_reg_out));
				
				led_write_enable <= 1'b0;
			end else begin
				registers_out <= 'b0;
				reg_write_enable <= 'b0;
				
				if (instr[15:4] == SETLED_INSTR_HEADER) begin
					led_out <= registers_in[dest_reg-:16];
					led_write_enable <= 1'b1;
				end else if (future_led) begin
					future_led <= 1'b0;
					led_out <= registers_in[old_dest_reg-:16];
					led_write_enable <= 1'b1;
				end else if (instr[15:4] == FUTURE_SETLED_INSTR_HEADER) begin
					future_led <= 1'b1;
				end
			end
		end
		
		old_dest_reg <= dest_reg;
		old_src_reg <= src_reg;
	end
	
endmodule
