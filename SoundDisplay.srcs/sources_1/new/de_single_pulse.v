`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2021 10:32:22
// Design Name: 
// Module Name: de_single_pulse
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


module de_single_pulse(
    input CLK,
    input PB,
    output OUT
    );
    
    wire Q1, Q2;
    dff d1(CLK, PB, Q1);
    dff d2(CLK, Q1, Q2);
    assign OUT = Q1 & ~Q2;
    
endmodule
