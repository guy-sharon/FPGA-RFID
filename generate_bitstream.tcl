open_project D:/FPGA/Xilinx/Projects/RFID/RFID.xpr
update_compile_order -fileset sources_1
reset_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8