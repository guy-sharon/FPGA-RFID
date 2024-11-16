@echo off
cd /d %~dp0

del /f vivado*.jou vivado*.log
rmdir /S /Q .Xil

set vivado=D:\Xilinx\Vivado/2024.1\bin\vivado.bat
set cli=%vivado% -mode batch -source
set generate_and_program="D:\FPGA\Xilinx\Projects\RFID\Scripts\generate_and_program.tcl"

%cli% %generate_and_program%

del /f vivado*.jou vivado*.log
rmdir /S /Q .Xil