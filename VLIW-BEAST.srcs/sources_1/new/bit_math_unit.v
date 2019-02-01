`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2019 10:26:13 PM
// Design Name: 
// Module Name: bit_math_unit
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


module bit_math_unit(
		input enabled,
		input [15:0] instr,
		input [255:0] registers,
		
		output [15:0] result,
		output [3:0] register_out
    );
	
	localparam ADD = 7'b0000001;
	localparam XOR = 7'b0000010;
	localparam AND = 7'b0000011;
	localparam OR = 7'b0000100;
	localparam SHL_LIT = 7'b0000101;
	localparam SHR_LIT = 7'b0000110;
	
	wire [15:0] src1_val;
	wire [15:0] src2_val;
	wire [15:0] dest_val;
	wire [15:0] sdreg_val;
	assign src1_val = registers[(255 - (instr[8:6] << 4))-:16];
	assign src2_val = registers[(255 - (instr[5:3] << 4))-:16];
	assign dest_val = registers[(255 - (instr[2:0] << 4))-:16];
	assign sdreg_val = registers[(255 - (instr[7:4] << 4))-:16];
	
	wire [15:0] add_result;
	wire [15:0] xor_result;
	wire [15:0] and_result;
	wire [15:0] or_result;
	wire [15:0] shr_result;
	wire [15:0] shl_result;
	assign add_result = src1_val + src2_val;
	assign xor_result = src1_val ^ src2_val;
	assign and_result = src1_val & src2_val;
	assign or_result = src1_val | src2_val;
	assign shr_result = sdreg_val >> instr[3:0];
	assign shl_result = sdreg_val << instr[3:0];
	
	wire [6:0] header;
	assign header = instr[15:9];
	
	assign result = (header == ADD ? add_result : (header == XOR ? xor_result : (header == AND ? and_result : (header == OR ? or_result : (header == SHL_LIT ? shl_result : (header == SHR_LIT ? shr_result : 'b0))))));
	assign register_out = ((header == SHL_LIT) | (header == SHR_LIT)) ? instr[7:4] : instr[2:0];
	
endmodule
