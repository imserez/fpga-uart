`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2026 04:35:15 PM
// Design Name: 
// Module Name: uart_top
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


module uart_top(
    input  logic clk,
    input  logic btnC,
    input  logic btnU,
    output logic uart_txd_out,
    output logic led_tx
);

    logic start;
    logic busy;
    logic btnU_prev;
    logic db_btnU;

    assign led_tx = uart_txd_out;
    
    debouncer db_up (
        .clk(clk),
        .signal(btnU),
        .reset(btnC),
        .debounced_signal(db_btnU)
    );
    
    
    always_ff @(posedge clk) begin
        if (btnC) begin // reset
            btnU_prev <= 0; 
            start <= 0;
        end
        else begin
            if (!busy)
                start <= db_btnU & ~btnU_prev;
            else
                start <= 1'b0;
            btnU_prev <= db_btnU;
        end
    end
    
    uart_tx #(
        .CLK_FREQ (100_000_000),
        .BAUD_RATE(9600)
    ) tx_inst (
        .clk   (clk),
        .reset (btnC),
        .start (start),
        .data  (8'h41), // 'A'
        .tx    (uart_txd_out),
        .busy  (busy)
    );

endmodule

 