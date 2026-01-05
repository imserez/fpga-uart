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

    localparam integer BAUD_TICKS = CLK_FREQ / BAUD_RATE;
    
    typedef enum logic [1:0] {      // FSM
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state_t;
    
    state_t         state;
    logic [15:0]    baud_cnt;
    logic [2:0]     bit_idx;
    logic [7:0]     shift_reg;
    
    always_ff   @(posedge clk or posedge reset) begin
        if (reset) begin
            state       <= IDLE;
            baud_cnt    <= 0;
            bit_idx     <= 0;
            shift_reg   <= 0;
            tx          <= 0;
            busy        <= 0;
        end
        else begin
        
        end
    
    end
    
// TODO: 
/*
   - FSM: [idle] -> [start_bit] -> [data_bits] -> [stop_bit]
   - bauds counter
   - shift_reg for data
   - bit_idx 0..7

*/
endmodule
