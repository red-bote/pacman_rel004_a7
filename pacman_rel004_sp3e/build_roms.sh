#!/bin/bash
#@echo off
#set rom_path=roms\
#
#romgen %rom_path%pacrom_5e.bin PACROM_5E 12 l r e > %rom_path%pacrom_5e.vhd
#romgen %rom_path%pacrom_5f.bin PACROM_5F 12 l r e > %rom_path%pacrom_5f.vhd
#romgen %rom_path%pacrom_6e.bin PACROM_6E 12 l r e > %rom_path%pacrom_6e.vhd
#romgen %rom_path%pacrom_6f.bin PACROM_6F 12 l r e > %rom_path%pacrom_6f.vhd
#romgen %rom_path%pacrom_6h.bin PACROM_6H 12 l r e > %rom_path%pacrom_6h.vhd
#romgen %rom_path%pacrom_6j.bin PACROM_6J 12 l r e > %rom_path%pacrom_6j.vhd
#
#romgen %rom_path%pacrom_1m.bin PACROM_1M 9 l r e > %rom_path%pacrom_1m.vhd
#romgen %rom_path%pacrom_4a.bin PACROM_4A_DST 8 c > %rom_path%pacrom_4a_dst.vhd
#romgen %rom_path%pacrom_7f.bin PACROM_7F_DST 4 c > %rom_path%pacrom_7f_dst.vhd
#
#echo done


# mv 82s123.7f  pacrom_7f.bin
# mv 82s126.1m  pacrom_1m.bin
# mv 82s126.3m  pacrom_3m.bin  # unused ?
# mv 82s126.4a  pacrom_4a.bin
# mv namcopac.6e  pacrom_6e.bin
# mv namcopac.6f  pacrom_6f.bin
# mv namcopac.6h  pacrom_6h.bin
# mv namcopac.6j  pacrom_6j.bin
# mv pacman.5e  pacrom_5e.bin
# mv pacman.5f  pacrom_5f.bin


# Be sure to build the romgen executable on your system, e.g. 
#  cd romgen_source/ ; g++ romgen.cpp -o romgen

rom_path=roms
romgen_path=romgen_source

$romgen_path/romgen $rom_path/pacrom_5e.bin PACROM_5E 12 l r e > $rom_path/pacrom_5e.vhd
$romgen_path/romgen $rom_path/pacrom_5f.bin PACROM_5F 12 l r e > $rom_path/pacrom_5f.vhd
$romgen_path/romgen $rom_path/pacrom_6e.bin PACROM_6E 12 l r e > $rom_path/pacrom_6e.vhd
$romgen_path/romgen $rom_path/pacrom_6f.bin PACROM_6F 12 l r e > $rom_path/pacrom_6f.vhd
$romgen_path/romgen $rom_path/pacrom_6h.bin PACROM_6H 12 l r e > $rom_path/pacrom_6h.vhd
$romgen_path/romgen $rom_path/pacrom_6j.bin PACROM_6J 12 l r e > $rom_path/pacrom_6j.vhd

$romgen_path/romgen $rom_path/pacrom_1m.bin PACROM_1M 9 l r e > $rom_path/pacrom_1m.vhd
$romgen_path/romgen $rom_path/pacrom_4a.bin PACROM_4A_DST 8 c > $rom_path/pacrom_4a_dst.vhd
$romgen_path/romgen $rom_path/pacrom_7f.bin PACROM_7F_DST 4 c > $rom_path/pacrom_7f_dst.vhd

echo done


