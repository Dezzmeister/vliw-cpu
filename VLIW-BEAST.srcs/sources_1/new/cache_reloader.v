`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2019 10:19:21 PM
// Design Name: 
// Module Name: cache_reloader
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


module cache_reloader(
		input cache_reload_in,
		output reg [6:0] cache_addr_out
    );
	
	always @(posedge cache_reload_in) begin
		cache_addr_out <= cache_addr_out + 1'b1;
	end
	
endmodule
