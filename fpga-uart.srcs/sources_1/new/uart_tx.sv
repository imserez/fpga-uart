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
            case(state)         // FSM implementation
                IDLE: begin
                    tx              <= 1;
                    busy            <= 0;
                    baud_cnt        <= 0;
                    if (start) begin
                        shift_reg   <= data;
                        state       <= START_BIT;
                        busy        <= 1;
                    end
                 end
                 
                 START_BIT: begin
                    tx  <= 0;
                    if (baud_cnt == BAUD_TICKS - 1) begin
                        baud_cnt    <= 0;
                        bit_idx     <= 0;
                        state       <= DATA_BITS;
                    end 
                    else begin
                        baud_cnt    <= baud_cnt + 1;
                    end
                 end
                 
                 DATA_BITS: begin
                    tx  <= shift_reg[bit_idx];
                    if (baud_cnt == BAUD_TICKS - 1) begin
                        baud_cnt    <= 0;
                        if (bit_idx == 3'd7) 
                            state <= STOP_BIT;
                        else
                            bit_idx <= bit_idx + 1;
                    end
                    else
                        baud_cnt <= baud_cnt + 1;
                 end
                 
                 STOP_BIT: begin
                    tx      <= 1;
                    if (baud_cnt == BAUD_TICKS - 1) begin
                        baud_cnt    <= 0;
                        state       <= IDLE;
                    end
                    else
                        baud_cnt <= baud_cnt + 1;
                 end
              endcase
        end
    
    end

endmodule
