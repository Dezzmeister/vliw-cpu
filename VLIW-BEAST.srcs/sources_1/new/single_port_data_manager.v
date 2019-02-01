`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2019 09:52:07 PM
// Design Name: 
// Module Name: single_port_data_manager
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


module single_port_data_manager(
		input [15:0] data_in_0,
		input [15:0] data_in_1,
		input [15:0] data_in_2,
		input [15:0] data_in_3,
		
		input [11:0] addr_in_0,
		input [11:0] addr_in_1,
		input [11:0] addr_in_2,
		input [11:0] addr_in_3,
		
		input en_0,
		input en_1,
		input en_2,
		input en_3,
		
		output [15:0] data_out,
		output [11:0] addr_out,
		output write_enable
    );
	
	wire [11:0] raw_addr_out;
	
	assign write_enable = en_0 | en_1 | en_2 | en_3;
	
	assign data_out = en_0 ? data_in_0 : (en_1 ? data_in_1 : (en_2 ? data_in_2 : (en_3 ? data_in_3 : 'b0)));
	assign raw_addr_out = en_0 ? addr_in_0 : (en_1 ? addr_in_1 : (en_2 ? addr_in_2 : (en_3 ? addr_in_3 : 'b0)));
	
	assign addr_out = (32 - (raw_addr_out >> 4)) + raw_addr_out + 1;
	
endmodule
