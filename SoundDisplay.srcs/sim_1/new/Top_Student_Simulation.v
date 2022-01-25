`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2021 22:32:43
// Design Name: 
// Module Name: Top_Student_Simulation
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


module Top_Student_Simulation(

    );
    
    reg sw0;
    reg sw1;
    reg sw2;
    reg sw3;
    reg  J_MIC3_Pin3;   // Connect from this signal to Audio_Capture.v
    wire J_MIC3_Pin1;  // Connect to this signal from Audio_Capture.v
    wire J_MIC3_Pin4;
    wire [15:0]led;
    wire [3:0]an;
    wire [7:0]seg;
    reg CLK;
    reg BTNC;
    reg BTNL;
    reg BTNR;
    wire OLED_cs, OLED_sdin, OLED_sclk, OLED_dcn, OLED_resn, OLED_vccen, OLED_pmoden;
    
    Top_Student dut(    
        sw0,
        sw1,
        sw2,
        J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
        J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
        J_MIC3_Pin4,
        led,
        an,
        seg,
        CLK,
        BTNC,
        BTNL,
        BTNR,
        OLED_cs, OLED_sdin, OLED_sclk, OLED_dcn, OLED_resn, OLED_vccen, OLED_pmoden
        );
        
    initial begin 
        sw0 = 1; sw1 = 0; sw2 = 0; sw3 = 1;
        CLK = 0;
        BTNC = 0;
        BTNL = 0;
        BTNR = 0;
        J_MIC3_Pin3 = 0;
    end
    
    always begin
        CLK = ~CLK; #1;
    end
endmodule
