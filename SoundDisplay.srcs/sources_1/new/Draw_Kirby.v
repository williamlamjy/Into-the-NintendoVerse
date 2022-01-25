`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2021 21:15:34
// Design Name: 
// Module Name: Draw_Kirby
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


module Draw_Kirby(
    input CLK, 
    input [12:0] pixel_index, 
    input reset, 
    input right, 
    input [3:0] level, 
    input GAME2, 
    output reg [15:0] pixel_kirby, 
    output reg GAME3
    );
    
    // Implement delay for win animation. Sort out GAME1, GAME2, GAME3 (GAME3 doesn't work). Implement reset.
    
    reg [31:0] FRAME = 32'd450000;
    reg [15:0] game_pixel; 
    reg [31:0] intro_count = 32'd0;
    reg [31:0] game_count = 32'd0;
    reg win = 0;
    reg [31:0] win_count = 32'd0;
    
    //initialize frames
    reg [15:0] wind [0:6143];
    reg [15:0] intro [0:6143];
    reg [15:0] charged [0:6143];
    reg [15:0] beam3 [0:6143];
    reg [15:0] beam2 [0:6143];
    reg [15:0] beam1 [0:6143];
    reg [15:0] marathon [0:6143];
    
    initial begin
        $readmemh("kirby_wind.txt", wind);
        $readmemh("kirby_intro.txt", intro);
        $readmemh("kirby_charged.txt", charged);
        $readmemh("kirby_beam.txt", beam3);
        $readmemh("kirby_miss_middle.txt", beam2);
        $readmemh("kirby_missed_low.txt", beam1);
        $readmemh("marathon_animation2.txt", marathon);
        GAME3 = 0;
    end
    
    always @ (posedge CLK) begin
        if (reset)
        begin
            intro_count = 0;
            game_count = 0;
            win_count = 0;
            GAME3 = 0;
        end
        else if (GAME2 && win && right)
            GAME3 = 1;
        else
        begin
            intro_count = GAME2? ((intro_count < 16*FRAME)? intro_count + 1 : intro_count) : 32'd0; 
            game_count = GAME2? ((game_count < 80*FRAME)? game_count + 1 : 32'd0) : 32'd0;
            win_count = GAME2? ((win)? ((win_count < 40*FRAME)? win_count + 1 : win_count) : 32'd0) : 32'd0;
        end
    end
    
    always @ (*) begin
    if (reset)
    begin
        win = 0;
    end
    else 
    begin
        pixel_kirby = (win)? 
        ((win_count < 12*FRAME)? beam3[pixel_index] : marathon[pixel_index]) : 
        (intro_count < 16*FRAME)? intro[pixel_index] : game_pixel;
        
        if (game_count/FRAME % 32 < 31)
        begin
            game_pixel = wind[pixel_index];
        end
        else if (game_count/FRAME % 32 > 30)
        begin 
            if (level > 4'd14)
            begin
                win = (GAME2 && intro_count == 16*FRAME)? 1 : 0;
            end
            else if (level > 4'd8)
                game_pixel = beam2[pixel_index];
            else if (level > 4'd1)
                game_pixel = beam1[pixel_index];
            else
                game_pixel = charged[pixel_index]; 
        end
    end
    end
        
        
        
endmodule
