`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input sw0,
    input sw1,
    input sw2,
    input sw3, 
    input sw4,
    input sw5,
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,
    output [15:0]led,
    output [3:0]an,
    output [7:0]seg,
    input CLK,
    input BTNC,
    input BTNL,
    input BTNR,
    output OLED_cs, OLED_sdin, OLED_sclk, OLED_dcn, OLED_resn, OLED_vccen, OLED_pmoden
    );

wire cs;
wire [11:0]mic_in;
wire [15:0]ledtemp;
wire [7:0]segtemp;
wire [3:0]antemp;
wire fast;

wire clk6p25m;
P_CLK c6p25m(CLK, 32'd8, clk6p25m);
wire clk3p125m;
P_CLK c3p125m(CLK, 32'd16, clk3p125m);
wire reset, left, right;
de_single_pulse d1(clk3p125m, BTNC, reset);
de_single_pulse d2(clk3p125m, BTNL, left);
de_single_pulse d3(clk3p125m, BTNR, right);

wire frame_begin;
wire sending_pixels;
wire sample_pixel;
wire [12:0]pixel_index;
wire [15:0]pixel_data;
wire teststate;
wire [3:0]level;

Oled_Display a1(
    clk6p25m,
    reset,
    frame_begin, 
    sending_pixels,
    sample_pixel, 
    pixel_index, 
    pixel_data, 
    OLED_cs, 
    OLED_sdin, 
    OLED_sclk, 
    OLED_dcn, 
    OLED_resn, 
    OLED_vccen,
    OLED_pmoden,
    teststate
    );
    
Draw_OLED a3(clk3p125m, level, pixel_index, sw1, sw2, sw4,sw5, reset, left, right, pixel_data);

P_CLK dut1(CLK, 32'd2499, cs);
P_CLK dut2(CLK, 32'd131232, fast);

Audio_Capture dut3(CLK, cs, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, mic_in);
volume_indicator dut4(mic_in, cs, fast, sw0, sw3, ledtemp, antemp, segtemp, level);
assign led = ledtemp;
assign an = antemp;
assign seg = segtemp;


endmodule