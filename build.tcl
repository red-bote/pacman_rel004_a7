open_project proj/xilinx/basys3/pacman.xpr
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
puts "Bitstream: [get_property DIRECTORY [get_runs impl_1]]/rtl_top.bit"
