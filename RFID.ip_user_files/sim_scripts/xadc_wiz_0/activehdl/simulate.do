transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+xadc_wiz_0  -L xil_defaultlib -L secureip -O5 xil_defaultlib.xadc_wiz_0

do {xadc_wiz_0.udo}

run 1000ns

endsim

quit -force
