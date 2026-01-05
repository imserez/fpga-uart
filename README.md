# FPGA UART TX

Simple UART transmitter implemented in SystemVerilog for Nexys A7.

## Current Status
- FSM-based UART TX (8N1).
- Parameterized by clock frequency and baud rate.
- Behavioral simulation passing (sending 'A' / 0x41).

## Files
- `uart_tx.sv`: UART transmitter module.
- `uart_tx_tb.sv`: Testbench that sends one byte and checks the waveform.

## How to Run (Vivado)
1. Open project.
2. Add `uart_tx.sv` as Design Source and `uart_tx_tb.sv` as Simulation Source.
3. Run Behavioral Simulation.

## Next Steps
- Add top module and clock divider for 100 MHz → 9600 baud.
- Map TX to Nexys A7 UART pin and test with serial terminal.

