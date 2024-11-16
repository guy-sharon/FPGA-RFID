set proj RFID
set projdir D:\\FPGA\\Xilinx\\Projects
set rootdir ${projdir}\\${proj}
set synth_logfile ${rootdir}\\${proj}.runs\\synth_1\\runme.log
set impl_logfile ${rootdir}\\${proj}.runs\\impl_1\\runme.log
set fail_sound misc\\fail_sound.bat
set success_sound misc\\success_sound.bat

open_project D:/FPGA/Xilinx/Projects/RFID/RFID.xpr

reset_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
while {true} {
    set synth_failed 0
    if { [file exists $synth_logfile] == 1} {               
        set fp [open $synth_logfile r]
        set file_data [read $fp]
        close $fp
        
        set data [split $file_data "\n"]
        foreach line $data {
            if {[string first "ERROR" $line] != -1} {
                puts $line
                set synth_failed 1
            }
        }
    }
    if $synth_failed {
        exec $fail_sound
        exit
    }

    if { [file exists $impl_logfile] == 1} {               
        set fp [open $impl_logfile r]
        set file_data [read $fp]
        close $fp
        if {[string first "write_bitstream completed successfully" $file_data] != -1} {
            update_compile_order -fileset sources_1
            exec $success_sound
            break
        }
    }
}

open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
set_property PROGRAM.FILE {D:/FPGA/Xilinx/Projects/RFID/RFID.runs/impl_1/top.bit} [get_hw_devices xc7s25_0]
current_hw_device [get_hw_devices xc7s25_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7s25_0] 0]
set_property PROBES.FILE {} [get_hw_devices xc7s25_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xc7s25_0]
set_property PROGRAM.FILE {D:/FPGA/Xilinx/Projects/RFID/RFID.runs/impl_1/top.bit} [get_hw_devices xc7s25_0]
program_hw_devices [get_hw_devices xc7s25_0]
refresh_hw_device [lindex [get_hw_devices xc7s25_0] 0]
