# pacman_rel004_a7

Pacman hardware (MikeJ's "A simulation model of Pacman hardware", release 004)
as a Digilent Basys 3 (Artix-7 `xc7a35tcpg236-1`) project in Vivado 2020.2.
Top-level wrapper and project files by Red~Bote; the core sources are the
pristine upstream rel004 Spartan-3E tree, kept unchanged.

## Provenance

- Core: MikeJ (www.fpgaarcade.com), rel004 for the Xilinx Spartan-3E Starter
  Kit, BSD-style license (see `pacman_rel004_sp3e/readme.txt`). T80 CPU core by
  Daniel Wallner (2001-2002, BSD-style, from opencores.org); audio DAC is an
  XAPP154 delta-sigma stage (`$Id ... arnim`).
- Vendored pristine from the GadgetFactory Papilio-Arcade archive:
  https://github.com/GadgetFactory/Papilio-Arcade/blob/master/pacman_rel004_sp3e_papilio/original_sources/pacman_rel004_sp3e.zip
- Basys 3 port by Red~Bote (source-file headers, 2024-04-20): new `rtl_top`
  wrapper, MMCM clocking, and a RAMB16 scan doubler following the Papilio
  adaptation in the same GadgetFactory tree (`pacman_rel004_sp3e_papilio`).

## Board IO

- Controls: JA joystick (active-low; wire buttons or a joystick to a JA pin
  and a JA GND pin), remapped to the repo-standard layout: JA1 = right,
  JA2 = left, JA3 = down, JA4 = up. btnC = reset. No other pushbuttons are
  wired (btnU/btnL/btnD/btnR are constrained in the XDC but unused). P1 and P2
  share the four direction inputs.
- Switch bank:

  | switch | function |
  |---|---|
  | sw0 | display mode: up = progressive VGA (internal scan doubler, LED0 lit); down = 15 kHz video |
  | sw1 | start1 |
  | sw2 | start2 |
  | sw3 | credit |
  | sw14 | PmodAMP2 shutdown (up = audio on) |
  | sw15 | PmodAMP2 gain (up = 6 dB, down = 12 dB) |

- Video: VGA 4-4-4 RGB on the VGA connector (core drives the three MSBs, LSB
  tied low); HSYNC/VSYNC pass through from the core. With sw0 down there is no
  VGA picture on a monitor-flip sw0 up.
- Audio: mono delta-sigma PWM to PmodAMP2 channel A (`O_PMODAMP2_AIN`);
  enable audio with sw14 up.
- LED0 lights in VGA mode; LED1-LED3 unlit.

## Build

No Makefile; this tree is a self-contained Vivado project (part
`xc7a35tcpg236-1`, board `digilentinc.com:basys3:part0:1.2`, top `rtl_top`):

1. Open `proj/xilinx/basys3/pacman.xpr` in Vivado 2020.2. Source references in
   the project are relative (`$PPRDIR`, `$PSRCDIR`), so keep `proj/` beside
   `pacman_rel004_sp3e/`.
2. Run Synthesis, then Implementation, then Write Bitstream. The bitstream
   lands at `proj/xilinx/basys3/pacman.runs/impl_1/rtl_top.bit`.

ROMs are not staged by a script; the project consumes the romgen VHDL already
in `pacman_rel004_sp3e/roms/`. To use a different romset, build romgen
(`g++ romgen_source/romgen.cpp -o romgen` in `pacman_rel004_sp3e/`) and run
`build_roms.sh` (or `build_roms.bat`).

## Clocking

The 100 MHz Basys 3 oscillator feeds `clk_wiz_0`, a Vivado Clocking Wizard MMCM
(`clk_wiz_0_clk_wiz.v`, 100 -> 25 MHz). `pacman_clocks_wiz.vhd` (a port file)
replaces the upstream DCM-based generator (`source/pacman_clocks_xilinx.vhd`)
and derives the ENA_12 (12.5 MHz) and ENA_6 (6.25 MHz) clock-enable rates; the
core therefore runs at 6.25 MHz, about 1.7% fast versus the original 6.144 MHz
(comment retained from upstream).

## Rom images

`pacman_rel004_sp3e/roms/readme_roms.txt` notes the shipped `.bin` files are
**not** the original arcade images but a demonstration romset (a Pong-style
program by David Widel). The committed bitstream was verified on hardware
running that homebrew romset, and brought up with the **puckman romset**
(joystick U/D/L/R remapped to the standard JA layout). No original arcade
image was used during bring-up. Supply your own images and rerun
`build_roms.sh` (see Build) for a different romset.

## Files added (outside the pristine `pacman_rel004_sp3e/` tree)

| file | reason | origin |
|---|---|---|
| `proj/xilinx/basys3/pacman.xpr` | Vivado 2020.2 project for part `xc7a35tcpg236-1` | Red~Bote (new) |
| `pacman.srcs/sources_1/new/rtl_top.vhd` | Basys 3 top-level: 100 MHz clock in, controls, VGA, audio PWM to PmodAMP2 | Red~Bote (new) |
| `pacman.srcs/sources_1/new/pacman_clocks_wiz.vhd` | clock-enable generator over the MMCM; replaces upstream DCM generator | Red~Bote (new) |
| `pacman.srcs/sources_1/new/pacman_dblscan_RAMB16.vhd` | scan doubler with RAMB16_S9_S9 line buffers, per the Papilio adaptation | Red~Bote (adapted from GadgetFactory/Papilio-Arcade) |
| `pacman.srcs/sources_1/imports/clk_wiz_0/` | Vivado Clocking Wizard MMCM IP (100 -> 25 MHz) | Vivado 2020.2 generated |
| `pacman.srcs/constrs_1/imports/digilent-xdc-master/Basys-3-Master.xdc` | Digilent master constraints, targeted pins uncommented | Digilent (imported) |

## License

The tree's `LICENSE` is Apache-2.0. The vendored MikeJ sources and the T80 core
carry their own BSD-style license headers (see `pacman_rel004_sp3e/readme.txt`
and `source/T80_Pack.vhd`); the audio DAC follows Xilinx XAPP154; the
constraint file is Digilent's master XDC.