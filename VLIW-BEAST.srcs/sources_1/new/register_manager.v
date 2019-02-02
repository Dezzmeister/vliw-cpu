`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 03:36:40 AM
// Design Name: 
// Module Name: register_manager
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Combines updated register values from execution units with previous register values to update the register file. A high bit in any execution unit's reg_write_en field signals an updated value for that register from that unit.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_manager(
		input [255:0] original_registers,
		
		input [255:0] registers_0,
		input [255:0] registers_1,
		input [255:0] registers_2,
		input [255:0] registers_3,
		
		input [15:0] reg_write_en_0,
		input [15:0] reg_write_en_1,
		input [15:0] reg_write_en_2,
		input [15:0] reg_write_en_3,
		
		output [255:0] registers_out
    );
	
	//wire [255:0] regs;
	
	/*
	genvar i;
	generate
		for (i=0; i < 16; i=i+1) begin: generate_value_choosers
			register_value_chooser(
				.original_register(original_registers[(255-(i*16))-:16]),
				.register_0(registers_0[(255-(i*16))-:16]),
				.register_1(registers_1[(255-(i*16))-:16]),
				.register_2(registers_2[(255-(i*16))-:16]),
				.register_3(registers_3[(255-(i*16))-:16]),
				
				.write_en_0(reg_write_en_0[15-i]),
				.write_en_1(reg_write_en_1[15-i]),
				.write_en_2(reg_write_en_2[15-i]),
				.write_en_3(reg_write_en_3[15-i]),
				.register_out(regs[15-i])
			);
		end
	endgenerate
	*/
	
	register_value_chooser register_value_choosers[15:0] (
		.original_register(original_registers),
		.register_0(registers_0),
		.register_1(registers_1),
		.register_2(registers_2),
		.register_3(registers_3),
		
		.write_en_0(reg_write_en_0),
		.write_en_1(reg_write_en_1),
		.write_en_2(reg_write_en_2),
		.write_en_3(reg_write_en_3),
		.register_out(registers_out)
	);
	
	//assign registers_out = regs;
	
	/*
	assign registers_out = (regs[15] << 240) | (regs[14] << 224) | (regs[13] << 208) | (regs[12] << 192) | 
						   (regs[11] << 176) | (regs[10] << 160) | (regs[09] << 144) | (regs[08] << 128) |
						   (regs[07] << 112) | (regs[06] << 96)  | (regs[05] << 80)  | (regs[04] << 64)  |
						   (regs[03] << 48)  | (regs[02] << 32)  | (regs[01] << 16)  | (regs[00]);
	*/
	
endmodule
