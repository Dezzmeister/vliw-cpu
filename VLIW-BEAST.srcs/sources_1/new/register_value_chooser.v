`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 03:37:15 AM
// Design Name: 
// Module Name: register_value_chooser
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


module register_value_chooser(
		input [15:0] original_register,
		
		input [15:0] register_0,
		input [15:0] register_1,
		input [15:0] register_2,
		input [15:0] register_3,
		
		input write_en_0,
		input write_en_1,
		input write_en_2,
		input write_en_3,
		
		output [15:0] register_out
    );
	
	assign register_out = (write_en_0 ? register_0 : (write_en_1 ? register_1 : (write_en_2 ? register_2 : (write_en_3 ? register_3 : original_register))));
	
endmodule
