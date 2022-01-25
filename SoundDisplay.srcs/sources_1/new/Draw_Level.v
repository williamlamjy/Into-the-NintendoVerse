`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2021 13:45:50
// Design Name: 
// Module Name: Draw_Level
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


module Draw_Level(
    input clk,
    input [12:0] pixel_index,
    input [3:0] level,
    input borderSW,
    input colorSW,
    input onSW,
    input reset,
    input left,
    input right,
    output reg [15:0] pixel_data,
    output reg EX
    );
    
    reg [12:0] leftedge, rightedge;
    reg [15:0] HIGH, MID, LOW;
    reg [15:0] CHARGE;
    reg [31:0] count;
    
    initial begin
        leftedge = 12'd37;
        rightedge = 12'd59;
        HIGH = 16'b11111_000000_00000;
        MID = 16'b11111_111111_00000;
        LOW = 16'b00000_111111_00000;
        CHARGE = 16'd0; 
        count = 32'd0;
    end
    
    always @ (posedge clk) begin
        if (reset)
            begin
            leftedge = 12'd37;
            rightedge = 12'd59;
            EX = 0;
            count = 0;
            end
        else 
        begin
            if (left)
                begin 
                //leftedge = borderSW? ((leftedge <= 3)? leftedge : leftedge-1) : ((leftedge <=1)? leftedge : leftedge-1);
                leftedge = (leftedge <= 3)? leftedge : leftedge-1;
                rightedge = leftedge + 22; 
                end
            if (right)
                begin
                //rightedge = borderSW? ((rightedge >= 92)? rightedge : rightedge+1) : ((rightedge >= 94)? rightedge : rightedge+1);
                rightedge = (rightedge >= 92)? rightedge : rightedge+1;
                leftedge = rightedge - 22;
                end
            if (level == 15)
                begin
                count <= (count == 32'd9000000)? count : count + 1;
                end
            else
                begin 
                count <= (count == 32'd9000000)? count : 0;
                end
            EX = (count == 32'd9000000)? 1: 0;
        end
    end                    
    
    always @ (*) begin
        CHARGE = count[24]? 16'b11111_000000_00000 : {count[24], count[19], count[15], count[9], count[4]}<<11;
        //CHARGE = {count[25], count[24], count[20], count[15], count[10]}<<11;
        /*
        if (count < 32'd4000000) CHARGE = 16'd0;
        else if (count < 32'd8000000) CHARGE = 16'b01010_000011_00010;
        else if (count < 32'd1200000) CHARGE = 16'b10000_000100_00011;
        else if (count < 32'd1600000) CHARGE = 16'b10101_000101_00010;
        else CHARGE = 16'b11111_000110_00011;
        */
        
        if (onSW)
            begin
            HIGH = CHARGE;
            MID = CHARGE;
            LOW = CHARGE;
            end
        else
        begin
        if (colorSW)
            begin 
            HIGH = 16'b11111_000000_00000;
            MID = 16'b11111_100000_10000;
            LOW = 16'b11111_111100_11100;
            end
        else
            begin
            HIGH = 16'b11111_000000_00000;
            MID = 16'b11111_111111_00000;
            LOW = 16'b00000_111111_00000;
            end
        end
        
        if ((pixel_index%96 > leftedge) && (pixel_index%96 < rightedge) && (pixel_index/96 > 12) && (pixel_index/96 < 57))
            begin 
            if (pixel_index/96 > 56 - level*3)
                begin 
                if (((pixel_index/96)%3) == 0)
                    pixel_data = CHARGE;
                else
                    begin
                    if (pixel_index/96 > 42)  
                        pixel_data = LOW;
                    else if (pixel_index/96 > 27)
                        pixel_data = MID;
                    else if (pixel_index/96 > 12)
                        pixel_data = HIGH;
                    else 
                        pixel_data = CHARGE;
                    end
                end
            else
                pixel_data = CHARGE; 
            end
        else 
            pixel_data = CHARGE;
        end
endmodule
