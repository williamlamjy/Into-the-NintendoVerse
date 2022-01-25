`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2021 10:57:44
// Design Name: 
// Module Name: Draw_Border
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


module Draw_Border(
    input sw5,
    input [12:0] pixel_index,
    input borderSW,
    input colorSW,
    output reg [15:0] pixel_data
    );
    
    always @ (*) begin 
    if(sw5==0)begin
        if (borderSW)
            begin 
            if ((pixel_index/96 < 3) || (pixel_index/96 > 60) || (pixel_index%96 < 3) || (pixel_index%96 > 92))
                pixel_data = colorSW? 16'b11111_011000_01100 : 16'd65535;
            else 
                pixel_data = 16'd0;
            end
        else
            begin
            if ((pixel_index/96 < 1) || (pixel_index/96 > 62) || (pixel_index%96 < 1) || (pixel_index%96 > 94))
                pixel_data = colorSW? 16'b11111_011000_01100 : 16'd65535;
            else 
                pixel_data = 16'd0;
            end
     end
     else begin
     pixel_data=16'd0;end
    end
endmodule
