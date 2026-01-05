`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2026 10:57:22 AM
// Design Name: 
// Module Name: uart_tx
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


module uart_tx #(
    parameter CLK_FREQ = 1_000_000,
    parameter BAUD_RATE = 10_000
)(
    input       logic clk,
    input       logic reset,
    input       logic start,        // start transmission bit
    input       logic [7:0] data,   // byte
    output      logic tx,           // serie
    output      logic busy          // busy-bit
);

// TODO: 
/*
   - FSM: [idle] -> [start_bit] -> [data_bits] -> [stop_bit]
   - bauds counter
   - shift_reg for data
   - bit_idx 0..7

*/
endmodule
