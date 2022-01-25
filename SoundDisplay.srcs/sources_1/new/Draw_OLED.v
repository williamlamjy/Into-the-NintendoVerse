`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2021 10:47:13
// Design Name: 
// Module Name: Draw_OLED
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


module Draw_OLED(
    input CLK,
    input [3:0] level,
    input [12:0] pixel_index,
    input borderSW,
    input colorSW,
    input onSW,
    input sw5,
    input reset,
    input left,
    input right,
    output [15:0] pixel_data
    );
    wire END;
//    reg [3:0] state;
//    reg [3:0] next_state;
//    parameter [3:0] SOUND = 4'b0000;
//    parameter [3:0] EXPLODE = 4'b0001;
    wire real_reset=(END &&reset)?1:0;
    wire [15:0] pixel_border;
    Draw_Border a1(sw5, pixel_index, borderSW, colorSW, pixel_border);
    wire [15:0] pixel_level;
    wire EX;
    Draw_Level a2(CLK, pixel_index, level, borderSW, colorSW, onSW, real_reset, left, right, pixel_level, EX);
    wire [15:0] pixel_ex;
    wire GAME1;
    Draw_Ex a3(CLK, pixel_index, real_reset, left, right, EX, pixel_ex, GAME1);
    wire [15:0] pixel_nyan;
    wire GAME2;
    Draw_Nyan a4(CLK, pixel_index, real_reset, right, level, GAME1, pixel_nyan, GAME2);
    wire [15:0] pixel_kirby;
    wire GAME3;
    Draw_Kirby a5(CLK, pixel_index, real_reset, right, level, GAME2, pixel_kirby, GAME3);
    wire [15:0] pixel_mario;   
    
    Draw_Mario a6(CLK, pixel_index, reset, right, left, level, GAME3, pixel_mario, END);
    
    wire [15:0] pixel = END? 16'd0 : GAME3? pixel_mario : GAME2? pixel_kirby : GAME1? pixel_nyan : EX? pixel_ex : pixel_level;
    
    assign pixel_data = (pixel_border)? pixel_border : (pixel)? pixel : 16'd0;
    
    
//    initial begin 
//        state = SOUND;
//        next_state = SOUND;
//    end
    
//    always @ (*) begin
//        case (state)
//            SOUND: 
//                begin
//                next_state = EX? EXPLODE: SOUND;
//                pixel_data = (pixel_border)? pixel_border : (pixel_level)? pixel_level : 16'd0;
//                end
//            EXPLODE:
//                begin 
//                next_state = EXPLODE;
//                pixel_data = (pixel_border)? pixel_border : (pixel_ex)? pixel_ex : 16'd0;
//                end
//        endcase
//    end
//    always @ (posedge CLK) begin
//        state <= next_state;
        
    
    
    /*
    always @ (*) begin 
        if (borderSW)
            begin 
            if ((pixel_index/96 < 3) || (pixel_index/96 > 60) || (pixel_index%96 < 3) || (pixel_index%96 > 92))
                pixel_data = 16'd65535;
            end
        else
            begin
            if ((pixel_index/96 < 1) || (pixel_index/96 > 62) || (pixel_index%96 < 1) || (pixel_index%96 > 94))
                pixel_data = 16'd65535;
            end
        
        if ((pixel_index%96 > 37) && (pixel_index%96 < 59) && (pixel_index/96 > 13) && (pixel_index/96 < 58))
            begin 
            if ((level+2) >= (pixel_index/288))
                begin 
                if (((pixel_index/96)%3) == 2)
                    pixel_data = 16'd0;
                else
                    begin
                    if ((pixel_index/288 - 2) < 6)  
                        pixel_data = 16'b00000_111111_00000;
                    else if ((pixel_index/288 - 2) < 11)
                        pixel_data = 16'b11111_111111_00000;
                    else if ((pixel_index/288 - 2) < 16)
                        pixel_data = 16'b11111_000000_00000;
                    end
                end
            else
                pixel_data = 16'd0; 
            end
    
        
            
    end
    */
endmodule
