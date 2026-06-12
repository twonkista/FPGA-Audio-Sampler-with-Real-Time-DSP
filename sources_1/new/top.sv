`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 10:57:07 AM
// Design Name: 
// Module Name: top
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
// this chooses the specific audio sample of the drum pad
//////////////////////////////////////////////////////////////////////////////////


module top(
    input reset,
    input rx,
    input clk,
    input [15:0] data_in,
    //input echo,
    input bit_crush,
    input volume
);

    uart_rx (
        .clk(clk),
        .reset(reset),
        .rx(rx)
    );
    
    audio (
        .clk(clk),
        .data_in(data_in),
        .volume(volume),
        .bit_crush(bit_crush)
    );

endmodule
