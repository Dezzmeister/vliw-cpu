`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 12:02:33 AM
// Design Name: 
// Module Name: dispatcher_delayer
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


module dispatcher_delayer(
		input clk,
		output dispatcher_enabled
    );
	
	reg [3:0] count = 4'b0;
	
	always @(posedge clk) begin
		if (count < 4'd4) begin
			count <= count + 1'b1;
		end else begin
			count <= 4'd4;
		end
	end
	
	assign dispatcher_enabled = (count == 4'd4);
	
endmodule
