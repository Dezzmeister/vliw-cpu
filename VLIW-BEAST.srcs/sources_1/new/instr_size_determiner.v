`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2019 01:41:02 AM
// Design Name: 
// Module Name: instr_size_determiner
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Sets output high when the input opcode expects an operand, so that the dispatcher can append the next quarter word in the cache.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instr_size_determiner(
		input [15:0] quword,
		output wait_for_operand
    );
	
	localparam MOV_LIT_REG = 12'b000000000010;
	localparam MOV_REG_MEM = 12'b000000000001;
	localparam STO_REG_MEM = 12'b000000000011;
	
	localparam JMP = 16'b0001000000000000;
	localparam JNE_HEADER = 8'b00010001;
	localparam JE_HEADER = 8'b00010010;
	localparam JLE_HEADER = 8'b00010011;
	
	assign wait_for_operand = ((quword[15:4] == MOV_LIT_REG) | 
							   (quword[15:4] == MOV_REG_MEM) |
							   (quword[15:4] == STO_REG_MEM) |
							   (quword == JMP) |
							   (quword[15:8] == JNE_HEADER) |
							   (quword[15:8] == JE_HEADER) |
							   (quword[15:8] == JLE_HEADER));
	
endmodule
