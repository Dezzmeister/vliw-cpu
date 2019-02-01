`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 11:19:35 AM
// Design Name: 
// Module Name: led_IO_manager
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


module led_IO_manager(
		input [15:0] current_led,
		
		input [15:0] led_in_0,
		input [15:0] led_in_1,
		input [15:0] led_in_2,
		input [15:0] led_in_3,
		
		input write_en_0,
		input write_en_1,
		input write_en_2,
		input write_en_3,
		
		output [15:0] led_out
    );
	
	assign led_out = (write_en_0 ? led_in_0 : (write_en_1 ? led_in_1 : (write_en_2 ? led_in_2 : (write_en_3 ? led_in_3 : current_led))));
	
endmodule
