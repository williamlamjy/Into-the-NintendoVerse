`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2021 17:55:46
// Design Name: 
// Module Name: Draw_Nyan
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


module Draw_Nyan(
    input CLK, 
    input [12:0] pixel_index, 
    input reset, 
    input right,
    input [3:0] level,
    input GAME1, 
    output reg [15:0] pixel_nyan, 
    output reg GAME2
    );
    
    reg [31:0] FRAME = 32'd900000;
    reg [31:0] start_count = 32'd0;
    reg [31:0] dead_count = 32'd0;
    reg dead = 0;
    reg [31:0] win_count = 32'd0;
    reg win = 0;
    reg [31:0] sunset_count = 32'd0;
    reg [15:0] game_pixel;
    
    //Frames
    reg [15:0] dead1 [0:6143];
    reg [15:0] dead2 [0:6143];
    reg [15:0] gameover [0:6143];
    reg [15:0] marathon [0:6143];
    reg [15:0] nyan_mid [0:6143];
    reg [15:0] nyan_top [0:6143];
    reg [15:0] sunset1 [0:6143];
    reg [15:0] sunset2 [0:6143];
    reg [15:0] sunset3 [0:6143];
    //reg [15:0] nyan_intro [0:6143];
    
    initial begin 
        $readmemh("deadanimationnyan.txt", dead1);
        $readmemh("deadanimationnyan_norain.txt", dead2);
        $readmemh("game_over2.txt", gameover);
        $readmemh("marathon_animation1.txt", marathon);
        $readmemh("nyan_game_mid.txt", nyan_mid);
        $readmemh("nyan_game_top.txt", nyan_top);
        $readmemh("nyan_sunset1.txt", sunset1);
        $readmemh("nyan_sunset2.txt", sunset2);
        $readmemh("nyan_sunset3.txt", sunset3);
        //$readmemh("nyan_game_intro.txt", sunset3);
        GAME2 = 0;
    end
    
    always @ (posedge CLK) begin
        if (reset)
        begin
            start_count = 0;
            dead_count = 0;
            win_count = 0;
            dead_count = 0;
            GAME2 = 0;
        end
        else if (GAME1 && right && dead) 
        begin 
            start_count = 0;
            dead_count = 0;
            win_count = 0;
            dead_count = 0;
        end
        else if (GAME1 && right && win)
            GAME2 = 1;
        else
        begin 
            start_count = GAME1? ((start_count == 20*FRAME)? start_count : start_count + 1 ) : 32'd0;
            dead_count = GAME1? ((dead)? ((dead_count == 9*FRAME)? dead_count : dead_count + 1) : 32'd0) : 32'd0;
            win_count = GAME1? ((win_count == 32'd20000000)? win_count : win_count + 1) : 32'd0;
            sunset_count = GAME1? ((win)? ((sunset_count == 4*FRAME)? sunset_count : sunset_count + 1) : 32'd0) : 32'd0; 
        end
    end
    
    always @ (*) begin 
    if (reset)
    begin
    win = 0;
    end
    else
    begin
        pixel_nyan = (win)? 
        ((sunset_count < FRAME)? sunset1[pixel_index] : 
        (sunset_count < 2*FRAME)? sunset2[pixel_index] : 
        (sunset_count < 3*FRAME)? sunset3[pixel_index] : 
        marathon[pixel_index]) : game_pixel;
            
        if (level > 4'd9 && dead==0) 
        begin
            win = (win_count > 32'd18000000)? 1 : 0;
            game_pixel = nyan_top[pixel_index];
        end
        else if (level > 4'd2 && level < 4'd10 && dead==0) 
        begin 
            game_pixel = nyan_mid[pixel_index];
        end
        else
        begin 
            dead = (start_count > 32'd8*FRAME)? 1: 0;
            game_pixel = (dead)? ((dead_count < FRAME)? dead1[pixel_index] : 
            (dead_count < 2*FRAME)? dead2[pixel_index] :
            (dead_count < 3*FRAME)? dead1[pixel_index] :
            (dead_count < 4*FRAME)? dead2[pixel_index] :
            (dead_count < 5*FRAME)? dead1[pixel_index] :
            (dead_count < 6*FRAME)? dead2[pixel_index] :
            (dead_count < 7*FRAME)? dead1[pixel_index] :
            (dead_count < 8*FRAME)? dead2[pixel_index] :
            gameover[pixel_index]) : nyan_mid[pixel_index];
        end
    end
    end
endmodule
