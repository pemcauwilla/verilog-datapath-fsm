# Multi-Cycle Datapath & FSM Controller (Verilog HDL)

A digital hardware architecture implementing a multi-cycle arithmetic processing datapath coordinated by a Finite State Machine (FSM) control unit. Synthesized and mapped for the **Intel MAX 10 (10M50DAF484C7G)** FPGA on the Terasic DE10-Lite development board using Intel Quartus Prime.

---

## Architecture Overview

The system processes 4-bit external inputs extended to a 6-bit internal datapath, executing sequence-controlled arithmetic operations and displaying internal register states on four 7-segment displays.

```
                  +-----------------------------------+
                  |             UDC (FSM)             |
                  +---+-------+-------+---+---+---+---+
                      |enA    |enB    |enC|   |   |   |
                      v       v       v   |   |   |   |
  Dados [3:0] -> [SEL_IN]                 |   |   |   |
                   |                      |   |   |   |
                   +---> [Reg A] --------> [  ULA  ]  |
                   |                        ^         |
                   +---> [Reg B] -\         |         |
                   |               +->[SEL_R]         |
                   +---> [Reg C] -/                   |
                                                      |
                   [Reg D] (Shift / Div / Out) <------+
                      |
                      v
             Displays (HexA, HexB, HexC, Hex)
```

### Key Components

- **Control Unit (`UDC.v`):** A 10-state Moore/Mealy FSM that sequences data loading (`loadA`, `loadB`, `loadC`), multi-cycle arithmetic operations (`sumB1`, `sumB2`, `sumC`, `subC`), and conditional logic based on an external `instrucao` flag.
- **Arithmetic Logic Unit (`ULA.v`):** 6-bit ALU supporting addition, subtraction, pass-through, and bitwise NOT operations.
- **Register File (`registrador.v`):** Three synchronous registers (`regA`, `regB`, `regC`) with independent clock-enable lines and asynchronous active-low reset.
- **Output & Shifter Register (`registradorD.v`):** Supports register hold, parallel load, logical right shift (division by 2), and left shift.
- **Multiplexers (`sel_in.v`):** Input steering between external data bus and ALU write-back, as well as operand selection between `regB` and `regC`.
- **Display Controllers (`display.v`):** Four combinational 7-segment display decoders mapping internal 6-bit registers to active-low 7-segment outputs (`HexA`, `HexB`, `HexC`, `Hex`).

---

## File Structure

| File | Description |
| :--- | :--- |
| `projetofinal.v` | Top-level structural module connecting datapath and control unit |
| `UDC.v` | Finite State Machine (FSM) control unit |
| `ULA.v` | 6-bit Arithmetic Logic Unit (ALU) |
| `registrador.v` | 6-bit synchronous register with asynchronous reset |
| `registradorD.v` | 6-bit shift/storage register (hold, load, shift right/left) |
| `sel_in.v` | 2-to-1 6-bit multiplexer |
| `display.v` | 6-bit binary to 7-segment display decoder |
| `projetofinal_TB.v` | Cycle-accurate Verilog testbench (`timescale 1ns/100ps`) |
| `projetofinalpinos.csv` | Pin assignment file for Intel Quartus Prime (DE10-Lite FPGA) |

---

## Simulation

The design includes a functional testbench (`projetofinal_TB.v`) with clock generation, reset sequencing, and stimulus generation.

To simulate using ModelSim / Questa:

```bash
vlib work
vlog *.v
vsim work.projetofinal_TB
run 150ns
```

---

## FPGA Synthesis & Target Hardware

- **Target Device:** Intel MAX 10 FPGA (`10M50DAF484C7G`)
- **Board:** Terasic DE10-Lite
- **Toolchain:** Intel Quartus Prime (Lite Edition)
- **Pin Mapping:** Defined in `projetofinalpinos.csv` for onboard push-buttons (clock, reset), toggle switches (`Dados`, `instrucao`), and 7-segment displays (`HEX0` through `HEX3`).
