set proj RFID
set projdir D:\\FPGA\\Xilinx\\Projects
set rootdir ${projdir}\\${proj}
set projfile ${rootdir}\\${proj}.xpr
if { [file exists $projfile] == 0} {
    set rootdir D:\\git\\FPGA-RFID
    set projfile ${rootdir}\\${proj}.xpr
}
set src_folder ${rootdir}\\${proj}.srcs\\sources_1\\new
set synth_logfile ${rootdir}\\${proj}.runs\\synth_1\\runme.log
set impl_logfile ${rootdir}\\${proj}.runs\\impl_1\\runme.log
set fail_sound misc\\fail_sound.bat
set success_sound misc\\success_sound.bat
set synth_complete misc\\synth_complete.bat
set synth_complete_sound_played 0

open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
set_property PROGRAM.FILE $rootdir/RFID.runs/impl_1/top.bit [get_hw_devices xc7s25_0]
current_hw_device [get_hw_devices xc7s25_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7s25_0] 0]
set_property PROBES.FILE {} [get_hw_devices xc7s25_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xc7s25_0]
set_property PROGRAM.FILE $rootdir/RFID.runs/impl_1/top.bit [get_hw_devices xc7s25_0]
program_hw_devices [get_hw_devices xc7s25_0]
refresh_hw_device [lindex [get_hw_devices xc7s25_0] 0]
exec $success_sound