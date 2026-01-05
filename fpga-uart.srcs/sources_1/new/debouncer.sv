`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2026 05:11:05 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer #(
    parameter LIMIT = 1_000_000, 
    parameter N = 20            
)(
    input  logic clk,
    input  logic signal,
    input  logic reset,
    output logic debounced_signal
);

    logic [N-1:0] count;
    logic sync_0, sync_1; 

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            sync_0 <= 0;
            sync_1 <= 0;
        end else begin
            sync_0 <= signal;
            sync_1 <= sync_0;
        end
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            debounced_signal <= 0;
        end else begin
            if (sync_1 != debounced_signal) begin
                if (count >= LIMIT) begin
                    debounced_signal <= sync_1;
                    count <= 0;
                end else begin
                    count <= count + 1;
                end
            end 
            else begin
                count <= 0;
            end
        end
    end
    
endmodule