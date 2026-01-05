`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2026 11:19:43 AM
// Design Name: 
// Module Name: uart_tx_tb
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


module uart_tx_tb;


    logic   clk;
    logic   reset;
    logic   start;
    logic   [7:0] data;
    logic   tx;
    logic   busy;


    uart_tx #(.CLK_FREQ(1_000_000), .BAUD_RATE(10_000)) dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data(data),
        .tx(tx),
        .busy(busy)
    );
    
    initial clk = 0;
    always #10 clk = ~clk;  // 50 kHz
    
    initial begin
        reset = 1;
        start = 0;
        data = 8'h41;   // A= 0b0101_0001
        
        #100;
        
        reset = 0;
        
        #100;
        start = 1;      // start transmission
        #20;
        start = 0;
        wait (!busy);
        #200;
        $finish;
    end

endmodule
