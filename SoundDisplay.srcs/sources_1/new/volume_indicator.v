`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 09:26:19
// Design Name: 
// Module Name: volume_indicator
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


module volume_indicator (
    input [11:0]mic_in, 
    input cs,input fast, 
    input sw0,
    input sw3,
    output reg[15:0]ledtemp,
    output reg[3:0]antemp, 
    output reg[7:0]segtemp,
    output reg[3:0]level
    );
    
    reg [11:0]max= 12'b0;
    //reg [32:0] max = 32'd0;
    reg [10:0]count=11'd0;
    reg [11:0]max_led=12'b0;
    reg [1:0]sound_lev=2'b0;
    reg [1:0]fast_count= 2'b0;

    always @(posedge cs)begin
    
    if(mic_in>max)begin
        max<=mic_in;
    end
    
    
    //max = max + mic_in;
    count <= count+1;
    if(count==11'd2000)begin
        count<=11'd0;
        max_led <= max;
    //ledtemp=16'b1000_0000_0000_0000;
        max<=12'b0;
    end 
    
//    if (sw0 == 0) begin
//        level=4'd15;end
//    else if(max_led<12'd100)begin
//        level=4'd0;end
//    else if(max_led<12'd200 && max_led>12'd100)begin
//        level=4'd1;end
//    else if(max_led<12'd400 && max_led>12'd200)begin
//        level=4'd2;end
//    else if(max_led<12'd600 && max_led>12'd400)begin
//        level=4'd3;end
//    else if(max_led<12'd800 && max_led>12'd600)begin
//        level=4'd4;end
//    else if(max_led<12'd1000 && max_led>12'd800)begin
//        level=4'd5;end
//    else if(max_led<12'd1200 && max_led>12'd1000)begin
//        level=4'd6;end
//    else if(max_led<12'd1300 && max_led>12'd1200)begin
//        level=4'd7;end
//    else if(max_led<12'd1400 && max_led>12'd1300)begin
//        level=4'd8;end
//    else if(max_led<12'd2000 && max_led>12'd1400)begin
//        level=4'd9;end
//    else if(max_led<12'd2100 && max_led>12'd2000)begin
//        level=4'd10;end
//    else if(max_led<12'd2200 && max_led>12'd2100)begin
//        level=4'd11;end
//    else if(max_led<12'd2300 && max_led>12'd2200)begin
//        level=4'd12;end
//    else if(max_led<12'd2400 && max_led>12'd2300)begin
//        level=4'd13;end
//    else if(max_led<12'd2500 && max_led>12'd2400)begin
//        level=4'd14;end
//    else if(max_led>12'd2500)begin
//        level=4'd15;end
    if (sw0 == 0) begin
        level=4'd15;end
    else if(max_led<12'd2177)begin
        level=4'd0;end
    else if(max_led<12'd2305 && max_led>12'd2176)begin
        level=4'd1;end
    else if(max_led<12'd2433 && max_led>12'd2304)begin
        level=4'd2;end
    else if(max_led<12'd2561 && max_led>12'd2432)begin
        level=4'd3;end
    else if(max_led<12'd2689 && max_led>12'd2560)begin
        level=4'd4;end
    else if(max_led<12'd2817 && max_led>12'd2688)begin
        level=4'd5;end
    else if(max_led<12'd2945 && max_led>12'd2816)begin
        level=4'd6;end
    else if(max_led<12'd3073 && max_led>12'd2944)begin
        level=4'd7;end
    else if(max_led<12'd3201 && max_led>12'd3072)begin
        level=4'd8;end
    else if(max_led<12'd3329 && max_led>12'd3200)begin
        level=4'd9;end
    else if(max_led<12'd3457 && max_led>12'd3328)begin
        level=4'd10;end
    else if(max_led<12'd3585 && max_led>12'd3456)begin
        level=4'd11;end
    else if(max_led<12'd3713 && max_led>12'd3584)begin
        level=4'd12;end
    else if(max_led<12'd3841 && max_led>12'd3712)begin
        level=4'd13;end
    else if(max_led<12'd3969 && max_led>12'd3840)begin
        level=4'd14;end
    else if(max_led>12'd3968)begin
        level=4'd15;end

    case(level)
        4'd0:begin
            ledtemp=16'b0000_0000_0000_0001;
            sound_lev=2'b01;
        end
        4'd1:begin
            ledtemp=16'b0000_0000_0000_0011;
            sound_lev=2'b01;
        end
        4'd2:begin
            ledtemp=16'b0000_0000_0000_0111;
            sound_lev=2'b01;
        end
        4'd3:begin
            ledtemp=16'b0000_0000_0000_1111;
            sound_lev=2'b01;
        end
        4'd4:begin
            ledtemp=16'b0000_0000_0001_1111;
            sound_lev=2'b01;
        end
        4'd5:begin
            ledtemp=16'b0000_0000_0011_1111;
            sound_lev=2'b10;
        end
        4'd6:begin
            ledtemp=16'b0000_0000_0111_1111;
            sound_lev=2'b10;
        end
        4'd7:begin
            ledtemp=16'b0000_0000_1111_11111;
            sound_lev=2'b10;
        end
        4'd8:begin
            ledtemp=16'b0000_0001_1111_1111;
            sound_lev=2'b10;
        end
        4'd9:begin
            ledtemp=16'b0000_0011_1111_1111;
            sound_lev=2'b10;
        end
        4'd10:begin
            ledtemp=16'b0000_0111_1111_1111;
            sound_lev=2'b11;
        end
        4'd11:begin
            ledtemp=16'b0000_1111_1111_1111;
            sound_lev=2'b11;
        end
        4'd12:begin
            ledtemp=16'b0001_1111_1111_1111;
            sound_lev=2'b11;
        end
        4'd13:begin
            ledtemp=16'b0011_1111_1111_1111;
            sound_lev=2'b11;
        end
        4'd14:begin
            ledtemp=16'b0111_1111_1111_1111;
            sound_lev=2'b11;
        end
        4'd15:begin
            ledtemp=16'b1111_1111_1111_1111;
        sound_lev=2'b11;
        end

    endcase
    end
    always @(posedge fast)begin
        fast_count <= fast_count+1;
        case(fast_count)
        2'd1:begin
        antemp<=4'b1110;
        if(level==4'd1 || level==4'd11)begin
        segtemp<=8'b1111_1001;end
        else if(level==4'd2 || level==4'd12)begin
        segtemp<=8'b1010_0100;end
        else if(level==4'd3 || level==4'd13)begin
        segtemp<=8'b1011_0000;end
        else if(level==4'd4 || level==4'd14)begin
        segtemp<=8'b1001_1001;end
        else if(level==4'd5 || level==4'd15)begin
        segtemp<=8'b1001_0010;end
        else if(level==4'd6)begin
        segtemp<=8'b1000_0010;end
        else if(level==4'd7)begin
        segtemp<=8'b1111_1000;end
        else if(level==4'd8)begin
        segtemp<=8'b1000_0000;end
        else if(level==4'd9)begin
        segtemp<=8'b1111_1001;end
        else if(level==4'd10 || level==4'd0)begin
        segtemp<=8'b1100_0000;end
        end
        2'd2:begin
        antemp<=4'b1101;
        if(level==4'd10 || level==4'd11 || level==4'd12 || level==4'd13 || level==4'd14 || level==4'd15)begin
        segtemp<=8'b1111_1001;end
        else begin
        segtemp<=8'b11111111;end
        end
        2'd3:begin
        if (sw3 == 1) begin
        antemp<=4'b0111;
        case(sound_lev)
        2'b01:begin
        segtemp<=8'b1100_0111;end
        2'b10:begin
        segtemp<=8'b1110_1010;end
        2'b11:begin
        segtemp<=8'b1000_1001;end
        endcase
        end
    end
    endcase


end
endmodule
