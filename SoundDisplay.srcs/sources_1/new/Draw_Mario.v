`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2021 16:10:37
// Design Name: 
// Module Name: Draw_Mario
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


module Draw_Mario(
    input CLK, 
    input [12:0] pixel_index, 
    input reset, 
    input right, 
    input left, 
    input [3:0] level, 
    input GAME3, 
    output reg [15:0] pixel_mario, 
    output reg END
    );
    
    //reg [31:0] FRAME = 32'd900000;
    //reg [2:0] count = 2'b00;
    //reg [31:0] frame_counter = 32'd0;

    reg [2:0]counter=3'b0;
    reg [31:0]game_count=32'd0;
    reg blow;
    //initialize frames
    reg [15:0] mario1 [0:6143];
    reg [15:0] mario2 [0:6143];
    reg [15:0] mario3 [0:6143];
    reg [15:0] mario_jump [0:6143];
    reg [15:0] mario_past [0:6143];
    reg [15:0] mario_flag1 [0:6143];
    reg [15:0] peach1 [0:6143];
    reg [15:0] peach2 [0:6143];
    reg [15:0] peach3 [0:6143];
    reg [15:0] peach4 [0:6143];
    reg [15:0] gameover [0:6143];
    reg [15:0] mario_flag2 [0:6143];
    reg [15:0] mario_intube[0:6143];
    reg [15:0] marathon[0:6143];
    initial begin
    blow=0;
        $readmemh("mario_far_pipe.txt", mario1);
        $readmemh("mario_middle_pipe.txt", mario2);
        $readmemh("mario_close_pipe.txt", mario3);
        $readmemh("mario_jumping2.txt", mario_jump);
        $readmemh("mario_past.txt", mario_past);
        $readmemh("mario_flag_far.txt", mario_flag1);
        $readmemh("mario_intube.txt", mario_intube);
        $readmemh("mario_flag_jump.txt", mario_flag2);
        $readmemh("peach_animation1.txt", peach1);
        $readmemh("peach_animation2.txt", peach2);
        $readmemh("peach_animation3.txt", peach3);
        $readmemh("princess_animation4.txt", peach4);
        $readmemh("game_over2.txt", gameover);
        $readmemh("marathon_animation.txt", marathon);
        END = 0;
    end
    
    always @ (posedge CLK) begin
    if(GAME3==1)begin
    game_count= (game_count==32'd7500000)?0:(counter==3'd5)?game_count:game_count +1;
    /*if(pixel_mario==gameover[pixel_index])begin
    counter=3'd0;end*/
    if(level>4'd12)begin
    blow=1;
    end
    if(game_count==32'd7500000)begin
    blow=0;
    counter= counter+1;end
    if(counter>3'd4)begin
    END=1;end
    if(reset)begin
    counter=3'd0;
    END=0;end
    if(blow==0 && game_count>32'd6000000 && game_count<32'd7500000 && counter<3'd3)begin
    counter=3'd0;end
        //frame_counter = GAME3? ((level == 4'd15)? 32'd0 : (frame_counter == 5*FRAME)? frame_counter : frame_counter + 1) : 32'd0;
        //count = GAME3? ((frame_counter == 32'd0)? count + 1 : count) : 32'd0;   
    end
    end
    always @ (*) begin
    pixel_mario= (game_count<32'd1500000 && counter<3'd3)?mario1[pixel_index]:(game_count<32'd3000000&& counter<3'd3)?mario2[pixel_index]: (game_count<32'd4500000 && counter<3'd3)?mario3[pixel_index]:
    (blow==1 && game_count<32'd6000000 && game_count>32'd4500000 && counter<3'd3)?mario_jump[pixel_index]:(blow==0 && game_count<32'd6000000 && game_count>32'd4500000 && counter<3'd3)?mario3[pixel_index]:
    (blow==0 && game_count>32'd6000000 && counter<3'd3)?gameover[pixel_index]:(blow==1 && game_count<32'd7500000 && game_count>32'd6000_000 && counter<3'd3)?mario_past[pixel_index]:
    (counter==3'd3 && game_count<32'd1500000 )?mario_flag1[pixel_index]:
    (counter==3'd3 && game_count<32'd3000000 && game_count>32'd1500000)?mario_flag2[pixel_index]:
    (counter==3'd3 && game_count<32'd5000000 && game_count>32'd3000000)?mario_intube[pixel_index]:
    (counter==3'd3 && game_count>32'd5000000 && game_count<32'd7500000)?peach1[pixel_index]:(counter==3'd4 && game_count<32'd2000000 && blow==1)?peach2[pixel_index]:
    (counter==3'd4 && blow==0)?peach1[pixel_index]: (counter==3'd4 && blow==1 && game_count<32'd4000000 && game_count>32'd2000000)?peach3[pixel_index]: 
    (counter==3'd4 && blow==1 && game_count>32'd4000000 && game_count<32'd7500000)?peach4[pixel_index]:(counter==3'd5)?marathon[pixel_index]:pixel_mario ;
       
       
        /*pixel_mario = (count == 2'b11)? mario_flag1[pixel_index] : ((frame_counter < FRAME)? mario_jump[pixel_index] : 
                        (frame_counter < 2*FRAME)? mario_past[pixel_index] : 
                        (frame_counter < 3*FRAME)? mario1[pixel_index] :
                        (frame_counter < 4*FRAME)? mario2[pixel_index] :
                        mario3[pixel_index]);*/
                        //if(GAME3==1)begin
          //pixel_mario= marathon[pixel_index];
    end
endmodule
