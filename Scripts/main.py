import serial
import glob
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Button, Slider
import re
import os
import math

###############################################################################################
############################################ Utils ############################################
###############################################################################################
class RCCircuit(object):
    
    def __init__(self, R, C):
        self.R = R
        self.C = C
        self.tau = R*C
        self.v = 0
        
    def step(self, vin, t):
        self.v = (self.v - vin) * np.exp(-t / self.tau) + vin


def read_consts_from_vhdl(vhdl_file_path):
    with open(vhdl_file_path, 'r') as f:
        mapping = {}
        for line in f.readlines():
            if ":=" not in line: continue
            if 'constant' in line:
                val_name = line.strip().split("constant")[1].split(":")[0].strip()
            elif 'CONSTANT' in line:
                val_name = line.strip().split("CONSTANT")[1].split(":")[0].strip()
            else: continue
            val_str = line.strip().split(":=")[-1].strip(";").strip()
            mapping[val_name] = val_str
            
    for key in mapping:
        try:
            mapping[key] = int(eval(mapping[key]))
        except:
            try:
                known_words = {"gcd": "math.gcd"}
                eval_str = mapping[key]
                subkeys = sorted(mapping.keys(), key=lambda x: -len(x))
                for subkey in subkeys:
                    str_to_rep = "mapping['{}']".format(subkey)
                    if subkey in eval_str and len(re.findall("mapping\['{}.*\]".format(subkey), eval_str)) == 0:
                        eval_str = eval_str.replace(subkey, "mapping['{}']".format(subkey))
                for known_word in known_words:
                    if known_word in eval_str:
                        eval_str = eval_str.replace(known_word, known_words[known_word])
                mapping[key] = int(eval(eval_str))
            except:
                print('could not parse constant "{}"'.format(key))
                
    return mapping
        

        
def read_sim_results():
    with open(glob.glob("**/output_results.txt", recursive=True)[0]) as f:
        return list(map(int, f.readlines()))
###############################################################################################
############################################ Utils ############################################
###############################################################################################      



###############################################################################################
############################################ Tests ############################################
###############################################################################################       
def test_read_serial():
    with serial.Serial('COM6', baudrate=115200) as ser:
        print(ser.read(20))
        
        
def test_plot_RC_circuit_sim_results(config):
    sim_results = read_sim_results()[1:1000]
    clk_freq = 12.0e6
    Rs = np.linspace(10, 1000, 1000)
    Cs = np.linspace(25, 100, 100)*1e-9
    dt = 1 / clk_freq
    
    def update(val):
        C = Cs[np.argmin(np.abs(Cs - C_slider.val))]
        R = Rs[np.argmin(np.abs(Rs - R_slider.val))]
        circuit = RCCircuit(R=R, C=C)
        voltages = []
        for val in sim_results:
            circuit.step(val, dt)
            voltages.append(circuit.v)
        line.set_ydata(voltages)
        fig.canvas.draw_idle()
    
    circuit = RCCircuit(R=Rs[0], C=Cs[0])
    voltages = []
    for val in sim_results:
        circuit.step(val, dt)
        voltages.append(circuit.v)
        
    fig, ax = plt.subplots()
    fig.subplots_adjust(bottom=0.25)
    line,  = ax.plot(np.arange(0, len(voltages))*dt, voltages)
    #plt.xlim(0, 0.1e-3)
    
    axR = fig.add_axes([0.22, 0.10, 0.58, 0.03])
    R_slider = Slider(ax=axR, label='Resistance [Ohm]', valmin=Rs[0], valmax=Rs[-1], valinit=Rs[0],)
    R_slider.on_changed(update)
    
    axC = fig.add_axes([0.22, 0.05, 0.58, 0.03])
    C_slider = Slider(ax=axC, label='Capacitance [F]', valmin=Cs[0], valmax=Cs[-1], valinit=Cs[0],)
    C_slider.on_changed(update)

    plt.show()


def test_create_cosine_table(config):
    DAC_MAX_VALUE = config['DAC_MAX_VALUE'] / 2
    table_len = config['RFID_SIG_COSINE_TABLE_LEN']
    table = []
    for i in range(table_len):
        table.append(int(DAC_MAX_VALUE + DAC_MAX_VALUE * np.sin(3*np.pi/2+2*np.pi*i/table_len)))
    print(table)
    return table
###############################################################################################
############################################ Tests ############################################
###############################################################################################

config = read_consts_from_vhdl(r".\RFID.srcs\sources_1\new\typedefs.vhd")

if __name__ == "__main__":
    #print(config)
    #test_create_cosine_table(config)
    test_plot_RC_circuit_sim_results(config)
    

