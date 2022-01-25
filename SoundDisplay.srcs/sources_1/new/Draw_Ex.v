`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 00:25:05
// Design Name: 
// Module Name: Draw_Ex
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


module Draw_Ex(
    input clk,
    input [12:0] pixel_index,
    input reset,
    input left,
    input right,
    input EX,
    output reg [15:0] pixel_ex,
    output reg GAME1
    );
    
    reg [15:0] ex1 [0:6143];
    reg [15:0] ex2 [0:6143]; 
    reg [15:0] ex3 [0:6143];
    reg [15:0] ex4 [0:6143];
    reg [15:0] err;
    reg [15:0] static [0:3];
    reg [15:0] err1 [0:6143];
    reg [15:0] err2 [0:6143];
    reg [31:0] count;
    reg [2:0] static_count;
    reg [31:0] FRAME = 32'd500000;
    
    initial begin
        $readmemh("Explode1.txt", ex1);
        $readmemh("Explode2.txt", ex2);
        $readmemh("Explode3.txt", ex3);
        $readmemh("Explode4.txt", ex4);
        $readmemh("Error1.txt", err1);
        $readmemh("Error2.txt", err2);
        count = 0;
        static_count = 0;
        static[0] = 16'h0000;
        static[1] = 16'ha800;
        static[2] = 16'h03e0;
        static[3] = 16'h000f;
        GAME1 = 0;
    end
    
    always @ (posedge clk) begin
        count = EX? ((count==15*FRAME)? 12*FRAME : count + 1) : 32'd0;
        static_count = count%4;
        err = (count/32'd2000000 % 2 == 0)? err1[pixel_index] : err2[pixel_index];
        GAME1 = (reset)? 0 : EX? (right? 1 : GAME1) : 0;
    end  
    
    always @ (*) begin
        pixel_ex = (count < FRAME)? ex1[pixel_index]: 
        (count < 2*FRAME)? 32'hffff : 
        (count < 3*FRAME)? ex2[pixel_index] :
        (count < 4*FRAME)? 32'hffff : 
        (count < 5*FRAME)? ex3[pixel_index] :
        (count < 6*FRAME)? 32'hffff : 
        (count < 8*FRAME)? ex4[pixel_index] :
        (count < 12*FRAME)? static[static_count] : 
        err;
   end
endmodule
