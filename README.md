# pacman_rel004_a7

MikeJ's rel004 Pacman core, ported to Digilent Basys 3 (`xc7a35tcpg236-1`), Vivado 2020.2. Core sources under `pacman_rel004_sp3e/` are unchanged from the original — I just added the Basys 3 top-level and project.

## Build

Open `proj/xilinx/basys3/pacman.xpr` to synthesize and build a bitstream.

Command line, from the repo root:

```
vivado -mode batch -nojournal -nolog -source build.tcl
```

Bitstream lands at `proj/xilinx/basys3/pacman.runs/impl_1/rtl_top.bit` either way.

- Ships with a Pong-style demo romset, not real Pacman — see `pacman_rel004_sp3e/roms/readme_roms.txt`. For actual Pacman/Puckman, supply your own ROMs: build `romgen` in `pacman_rel004_sp3e/` (`g++ romgen_source/romgen.cpp -o romgen`), then run `build_roms.sh`/`.bat`.
- Verified on hardware with both the demo romset and, separately, the real puckman romset.

## IO

- JA1-4 = right/left/down/up (active-low)
- btnC = reset
- btnL = start 1, btnR = start 2, btnU/btnD = coin
- sw13 = video mode (down: doubled VGA, up: native 15 kHz — needs multisync/CRT, not standard VGA)
- sw14 = audio enable (up = on)
- PmodAMP2 on Pmod JXADC (pins 1/2/4), gain fixed at 6 dB (the lower of the two levels the pin supports)

## Basys 3 port additions

- `pacman.srcs/sources_1/new/rtl_top.vhd` — top-level: clocking, controls, VGA, audio PWM
- `pacman.srcs/sources_1/new/pacman_clocks_wiz.vhd` — clock-enables over the MMCM, replacing the original Spartan-3E DCM generator. Core runs 6.25 MHz vs. arcade-original 6.144 MHz (~1.7% fast).
- `pacman.srcs/sources_1/new/pacman_dblscan_RAMB16.vhd` — scan doubler (adapted from GadgetFactory/Papilio-Arcade)
- `proj/xilinx/basys3/pacman.xpr` — Vivado project

## License

- Apache-2.0 (this port).
- Vendored core/CPU keep their own BSD-style licenses — see `pacman_rel004_sp3e/readme.txt`.
