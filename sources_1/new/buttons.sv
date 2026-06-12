`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2026 09:29:53 AM
// Design Name: 
// Module Name: buttons
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


module audio(
    input logic [15:0] data_in, 
    input clk,
    //input echo,
    input volume,
    input bit_crush,
    //input logic [2:0] pitch_step,
    output logic [15:0] formula_out
    );
    
    logic [15:0] process;
    localparam int delay = 1;
    localparam int volume_control = 2;
    
    always_comb begin
        process = data_in; 
        if(volume) process = process<<volume_control;
        if(bit_crush) process = {process[15:8], 8'd0};
    end
    
    //always_ff @(posedge clk) begin
      //  if(echo)
    //end
    
    assign formula_out = process;
endmodule
