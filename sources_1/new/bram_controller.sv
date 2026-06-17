`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2026 08:39:33 AM
// Design Name: 
// Module Name: bram_controller
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


module bram_controller(
    input clk,
    input logic [7:0] key_board_in,
    input data_valid_in,
    output [15:0] hex_16
    );
    
    logic [11:0] sample_rate_cnt;
    logic [14:0] bram_addr;
    logic [15:0] empty_vec = 16'd0;
    logic [2:0] sel = key_board_in[2:0];
    
    
    logic address_reset;
    always_ff @(posedge clk) begin
        if (data_valid_in) begin
            address_reset <= 1'b1; // Pulse high for exactly 1 cycle
        end else begin
            address_reset <= 1'b0; // Immediately drop back to low
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            sample_rate_cnt <= 0; 
            bram_addr <= 0;
        end
        else if (sample_rate_cnt == 12'h8DA) begin
            sample_rate_cnt <= 0;
            bram_addr <= bram_addr + 1;
        end
        else begin
            sample_rate_cnt <= sample_rate_cnt + 1;
        end
    end
    

    logic [15:0] douta_clap,douta_hihat, douta_kick, douta_note = 16'd0;
    blk_mem_gen_0 clap_blk( .clk(clk), .ena(1'b1), .addra(bram_addr), .dina(16'd0), .douta(douta_clap));
    blk_mem_gen_1 hihat_blk( .clk(clk), .ena(1'b1), .addra(bram_addr), .dina(16'd0), .douta(douta_hihat));
    blk_mem_gen_2 kick_blk( .clk(clk), .ena(1'b1), .addra(bram_addr), .dina(16'd0), .douta(douta_kick));
    blk_mem_gen_3 note_blk( .clk(clk), .ena(1'b1), .addra(bram_addr), .dina(16'd0), .douta(douta_note));
    
    logic reset;
    logic [15:0] data_out;
    
    always_ff @(posedge clk) begin 
        reset <= 0;
        case (sel)
            3'b001: begin
                reset <= 1; 
                data_out <= douta_clap;
            end
            3'b010: begin 
                reset <= 1; 
                data_out <= douta_hihat;
            end
            3'b011: begin
                reset <= 1; 
                data_out <= douta_kick;
            end
            3'b100: begin
                reset <= 1; 
                data_out = douta_note;
            end
            default: begin
                data_out <= 16'd0;       
            end
        endcase
    end
    
    assign hex_16 = data_out;
    
endmodule
