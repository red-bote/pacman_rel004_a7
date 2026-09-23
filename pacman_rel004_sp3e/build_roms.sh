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


# Be sure to build the romgen executable on your system, e.g. 
#  cd romgen_source/ ; g++ romgen.cpp -o romgen

rom_path=roms
romgen_path=romgen_source

# uncomment to use actual puckman roms
USE_PUCK_ROMS=1
if [ ! -z $USE_PUCK_ROMS ]
then
  echo "Using roms in $rom_path/puckman ......."
  cp $rom_path/puckman/82s123.7f  $rom_path/pacrom_7f.bin
  cp $rom_path/puckman/82s126.1m  $rom_path/pacrom_1m.bin
  cp $rom_path/puckman/82s126.3m  $rom_path/pacrom_3m.bin  # unused ?
  cp $rom_path/puckman/82s126.4a  $rom_path/pacrom_4a.bin
  cp $rom_path/puckman/namcopac.6e  $rom_path/pacrom_6e.bin
  cp $rom_path/puckman/namcopac.6f  $rom_path/pacrom_6f.bin
  cp $rom_path/puckman/namcopac.6h  $rom_path/pacrom_6h.bin
  cp $rom_path/puckman/namcopac.6j  $rom_path/pacrom_6j.bin
  cp $rom_path/puckman/pacman.5e  $rom_path/pacrom_5e.bin
  cp $rom_path/puckman/pacman.5f  $rom_path/pacrom_5f.bin
fi


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


