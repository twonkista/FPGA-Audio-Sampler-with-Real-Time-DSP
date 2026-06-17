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

        logic [7:0] key_out;
    uart_rx (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data_out(key_out)
    );
    
    logic [15:0] formula_out;
    logic data_valid;
    logic [15:0] sound_sample;
    
    bram_controller (
        .clk(clk),
        .key_board_in(key_out),
        .data_valid(data_valid),
        .hex_16(sound_sample)
    );
    
    logic [15:0] edited_sample;
    
    audio (
        .clk(clk),
        .data_in(data_in),
        .volume(volume),
        .bit_crush(bit_crush),
        .formula_out(edited_sample)
    );
    
    i2s_module (
        .clk(clk),
        .data_in(edited_sample)
    );

endmodule
