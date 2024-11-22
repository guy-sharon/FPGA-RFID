import os
import glob
import time

def clean_up():
    for f in glob.glob("vivado*.jou") + glob.glob("vivado*.log"):
        os.remove(f)
    if os.path.exists(".Xil"):
        os.rmdir(".Xil")

def get_last_mtime_of_srcs():
    last_modified_vhd = 0
    for f in glob.glob(f"{src_folder}\\*.vhd"):
        mtime = os.path.getmtime(f)
        if mtime > last_modified_vhd:
            last_modified_vhd = mtime
    return last_modified_vhd

cd = os.path.dirname(os.path.realpath(__file__))
os.chdir(cd)
clean_up()

vivado="D:\\Xilinx\\Vivado\\2024.1\\bin\\vivado.bat"
cli=f"{vivado} -mode batch -source"
generate_and_program=f"{cd}\\generate_and_program.tcl"
program=f"{cd}\\program_device.tcl"
src_folder=f"{cd}\\..\\RFID.srcs\\sources_1\\new"
top_bin_file=f"{cd}\\..\\RFID.runs\\impl_1\\top.bit"
top_bin_file_mtime = os.path.getmtime(top_bin_file)
last_modified_vhd = get_last_mtime_of_srcs()

if last_modified_vhd > top_bin_file_mtime:
    print('synthesize!')
    os.system(f"{cli} {generate_and_program}")
else:
    print('only prog')
    os.system(f"{cli} {program}")

clean_up()