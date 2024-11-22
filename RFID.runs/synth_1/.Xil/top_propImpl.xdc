set_property SRC_FILE_INFO {cfile:D:/git/FPGA-RFID/RFID.srcs/constrs_1/new/constraints.xdc rfile:../../../RFID.srcs/constrs_1/new/constraints.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:7 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN M9    IOSTANDARD LVCMOS33 } [get_ports { clk_12Mhz }]; #IO_L13P_T2_MRCC_14 Sch=gclk
set_property src_info {type:XDC file:1 line:37 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN L12   IOSTANDARD LVCMOS33 } [get_ports { uart_tx }]; #IO_L6N_T0_D08_VREF_14 Sch=uart_rxd_out
set_property src_info {type:XDC file:1 line:65 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { pio27 }]; #IO_L4P_T0_D04_14 Sch=pio[27]
