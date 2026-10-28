# LFSR and Inverse LFSR in Verilog

This project implements a 3-bit Linear Feedback Shift Register (LFSR) and its inverse recurrence using Verilog HDL.

## Polynomial

The characteristic polynomial is `P(x) = x^3 + x + 1`.

The highest power is 3, so the LFSR has three state bits. A nonzero seed is required; this design uses `3'b001`. The all-zero state is avoided because XOR feedback would leave the register stuck at zero.

## Files

| File | Description |
|---|---|
| `rtl/lfsr_1.v` | Forward and inverse LFSR RTL |
| `tb/lfsr_1tb.v` | Testbench with clock, reset, console monitoring, and VCD dump |

## Forward recurrence

The forward LFSR shifts toward the most significant bit and inserts XOR feedback into the least significant bit:

`q_next = {q[1:0], q[2] ^ q[0]}`

Starting from `001`, the sequence is:

`001 -> 011 -> 111 -> 110 -> 101 -> 010 -> 100 -> 001`

It visits all seven nonzero 3-bit states before repeating.

## Inverse recurrence

The inverse recurrence shifts in the opposite direction and recovers the previous feedback bit:

`inv_next = {inv_lfsr[0] ^ inv_lfsr[1], inv_lfsr[2:1]}`

Starting from the same seed `001`, it traverses the states in reverse order:

`001 -> 100 -> 010 -> 101 -> 110 -> 111 -> 011 -> 001`

The forward and inverse registers are independent state machines. Both are reset to `001`.

## Simulation with Icarus Verilog

Run these commands from the repository root:

```bash
iverilog -g2012 -o lfsr_sim rtl/lfsr_1.v tb/lfsr_1tb.v
vvp lfsr_sim
gtkwave lfsr.vcd
```

- `iverilog` compiles the RTL and testbench.
- `-g2012` enables SystemVerilog-2012 language support.
- `-o lfsr_sim` names the simulation executable.
- `vvp lfsr_sim` runs the simulation.
- `gtkwave lfsr.vcd` opens the waveform in GTKWave.

The testbench writes clock, reset, and both LFSR outputs to `lfsr.vcd`.

## Notes

- Reset is active-high and asynchronous.
- The listed sequences are expected behavior; run the simulation to verify them.
- This is an educational RTL example, not a cryptographic random-number generator.
