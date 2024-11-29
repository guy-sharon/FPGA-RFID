Analog Discovery Studio - Cmod S7 Demo

Wiki page for demo: https://reference.digilentinc.com/reference/instrumentation/analog-discovery-studio/cmod-s7-demo

Inventory:
	Hardware:
		Analog Discovery Studio
		Breadboard Canvas
		MTE Cables
		Power Supply
		MiniUSB Cable
		Cmod S7
		MicroUSB Cable
		Pmod R2R
	Software:
		WaveForms
		Vivado 2019.1
		
Setup instructions:
	Hardware:
		Connect the Pmod R2R to the Cmod S7's Pmod Port
		Connect the Cmod S7 to the Breadboard Canvas
		Connect the Cmod S7's MicroUSB port to the Analog Discovery Studio's USB port via the MicroUSB cable
		Connect the MTE cables using the following pin mapping:
			Connect WaveGen W1 to Cmod S7 pin 32
			Connect WaveGen W2 to Cmod S7 pin 33
			Connect Scope 1+ to Pmod R2R VOUT
			Connect WaveGen 1&2 ground, Scope 1-, Pmod R2R ground, and Cmod S7 ground to each other
			Connect DIO 0-3 to Cmod S7 pins 1-4
			Connect DIO 4-7 to Cmod S7 pins 45-48
		Ensure both Scope connection select switches are in MTE position
		Plug in the Analog Discovery Studio's power supply
		Plug in the Analog Discovery Studio to the host computer
		Turn on the Analog Discovery Studio
	Software
		Download and extract the demo files (FIXME.zip)
		To program the Cmod S7 (only needs to happen once, the bit file is programmed into non-volatile flash memory):
			Open Vivado 2019.1
			Enter the following commands in the TCL Console:
				cd <demo's extracted folder>
				source program_flash.tcl
			Power down the Cmod S7, then power it back up
		WaveForms:
			Launch WaveForms
			Open the WaveForms Workspace
			Open the Script instrument (shares a pane with StaticIO), then click Run to begin running all instruments
			Return to the StaticIO instrument
			Ensure that StaticIO CPOL and CPHA switches match the SPI1 configuration
			Click the StaticIO RESET button (to reset the SPI controller contained in the Cmod S7)
			Ensure that the StaticIO ENABLE switch is set to "1"
		The Vivado Project used to generate the included bitstream and flash binary is located at https://github.com/Digilent/Analog-Discovery-Studio-Cmod-S7-SPI
		