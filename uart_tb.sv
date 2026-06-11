`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2026 10:39:21 AM
// Design Name: 
// Module Name: uart_tb
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


module uart_tb;

    logic rx_t;
    logic clk_t;
    logic reset_t;
    
    logic [7:0] data_t;
    logic [2:0] count_t;
    
    uart_rx UUT(
        .rx(rx_t),
        .clk(clk_t),
        .reset(reset_t),
        .data_out(data_t),
        .count(count_t)
    );
    
    always #5 clk_t = ~clk_t;
    
    initial begin
        clk_t = 0;
        reset_t = 1;
        rx_t = 1;    // idle high
    
        #10
        reset_t = 0;
    
        #10
        rx_t = 0;   // start bit
        #8670 
        rx_t = 1;
        #8670 
        rx_t = 0;
        #8670 
        rx_t = 1;
        #8670 
        rx_t = 0;
        #8670 
        rx_t = 0;
        #8670 
        rx_t = 1;
        #8670 
        rx_t = 0;   
        #8670 
        rx_t = 1;   
        #8670 
        
        rx_t = 1;
        #8670 
        
        #50        
        
        if(data_t == 8'hA5)
            $display("PASS");
        else
            $display("FAIL: got %h", data_t);
        
        $finish;
    end
        
        
    
endmodule
