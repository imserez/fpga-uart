`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2026 03:22:50 PM
// Design Name: 
// Module Name: uart_tx_100M_tb
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


module uart_tx_100M_tb;

    logic   clk;
    logic   reset;
    logic   start;
    logic   [7:0] data;
    logic   tx;
    logic   busy;

    // 100_000_000 ||  9600 / 115200
    uart_tx #(.CLK_FREQ(100_000_000), .BAUD_RATE(115200)) dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data(data),
        .tx(tx),
        .busy(busy)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;  // 100 MHz
    
    initial begin
        reset = 1;
        start = 0;
        data = 8'h41;   // A= 0b0101_0001
        #100;
        reset = 0;
        #100;
        
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;

        #10_000_000;
        $finish;
    end

endmodule