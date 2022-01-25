`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2021 10:29:16
// Design Name: 
// Module Name: P_CLK
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


module P_CLK(
    input CLOCK,
    input [31:0]MAX,
    output reg OUT
    );
        
    reg [31:0]count = 32'b0;
        
    initial begin 
        OUT = 0;
    end
        
    always @(posedge CLOCK) begin
        count <= (count == MAX)? 32'b0 : count+1;
        OUT <= (count == 32'b0)? ~OUT : OUT;
    end
endmodule
