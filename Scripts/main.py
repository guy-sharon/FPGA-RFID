import serial
import numpy as np
import matplotlib.pyplot as plt


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
                eval_str = mapping[key]
                for subkey in mapping:
                    if subkey in mapping[key]:
                        eval_str = eval_str.replace(subkey, "mapping['{}']".format(subkey))
                mapping[key] = int(eval(eval_str))
            except:
                print('could not parse constant "{}"'.format(key))
                
    return mapping
        

        
def read_sim_results():
    with open(r"../\RFID\RFID.sim\sim_1\behav\xsim\output_results.txt") as f:
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
    circuit = RCCircuit(R=1000, C=2.7e-9)
    clk_freq = 12.0e6
    dt = 1 / clk_freq
    voltages = []
    for val in read_sim_results():
        circuit.step(val, dt)
        voltages.append(circuit.v)
    plt.plot(np.arange(0, len(voltages))*dt, voltages)
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
print(config)

if __name__ == "__main__":
    test_create_cosine_table(config)
    #test_plot_RC_circuit_sim_results(config)
    

