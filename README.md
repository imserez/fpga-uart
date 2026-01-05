# FPGA UART TX (Nexys A7)

UART transmitter in SystemVerilog, tested in simulation and on Nexys A7.

## Features
- UART TX (8N1) with parametrizable clock and baud rate.
- FSM-based implementation with baud tick counter.
- Simulated at 1 MHz / 10 kbaud and 100 MHz / 9600 baud.
- Button-triggered transmission of 'A' to PC over USB-UART.

## Files
- `uart_tx.sv`: UART transmitter module.
- `uart_tx_tb.sv`: Fast simulation testbench (1 MHz / 10 kbaud).
- `uart_tx_tb_100M.sv`: 100 MHz / 9600 baud testbench.
- `uart_top.sv`: Nexys A7 top-level (btnU sends 'A').
- `constraints.xdc`: Pin mapping for clock, buttons and USB-UART.
- `debouncer.sv`: Debounce the btnU signal, used to flag start

## What I Learned
- UART protocol basics (8N1, baud rate, bit timing).
- Implementing a timed FSM in SystemVerilog.
- Integrating and testing a peripheral on real FPGA hardware.
- Using a serial terminal (minicom) to debug hardware.

## How to test

- Display the available ports using `ls /dev/ttyUSB*`
- Connect using `sudo minicom -D /dev/ttyUSB[X] -b [9600]` **select the right USB[X]** **confirm baud rate[9600]**
- If you're using Nexys A7 make sure is in JTAG mode
- Disable `Hardware Flow Control` and `Software Flow Control` in minicom

