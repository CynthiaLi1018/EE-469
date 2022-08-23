# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./mux2_1.sv"
vlog "./mux4_1.sv"
vlog "./mux16_1.sv"
vlog "./mux32_1.sv"
vlog "./mux64x32_1.sv"
vlog "./register_4.sv"
vlog "./register_16.sv"
vlog "./register_64.sv"
vlog "./dec1_2.sv"
vlog "./dec2_4.sv"
vlog "./dec4_16.sv"
vlog "./dec5_32.sv"
vlog "./D_FF.sv"
vlog "./DFF_E.sv"
vlog "./regfile.sv"
vlog "./regstim.sv"
vlog "./alu.sv"
vlog "./alustim.sv"
vlog "./fulladd_64.sv"
vlog "./bit_add.sv"
vlog "./and_64.sv"
vlog "./or_64.sv"
vlog "./xor_64.sv"
vlog "./mux64x8_1.sv"
vlog "./mux8_1.sv"
vlog "./zero_flag.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
#vsim -voptargs="+acc" -t 1ps -lib work mux2_1_testbench
#vsim -voptargs="+acc" -t 1ps -lib work mux4_1_testbench
#vsim -voptargs="+acc" -t 1ps -lib work mux16_1_testbench
#vsim -voptargs="+acc" -t 1ps -lib work mux32_1_testbench
#vsim -voptargs="+acc" -t 1ps -lib work D_FF_testbench
#vsim -voptargs="+acc" -t 1ps -lib work DFF_E_testbench
#vsim -voptargs="+acc" -t 1ps -lib work dec1_2_testbench
#vsim -voptargs="+acc" -t 1ps -lib work dec2_4_testbench
#vsim -voptargs="+acc" -t 1ps -lib work dec4_16_testbench
#vsim -voptargs="+acc" -t 1ps -lib work dec5_32_testbench
#vsim -voptargs="+acc" -t 1ps -lib work register_4_testbench
#vsim -voptargs="+acc" -t 1ps -lib work register_16_testbench
#vsim -voptargs="+acc" -t 1ps -lib work register_64_testbench
#vsim -voptargs="+acc" -t 1ps -lib work regfile_testbench
#vsim -voptargs="+acc" -t 1ps -lib work regstim
#vsim -voptargs="+acc" -t 1ps -lib work mux64x32_1_testbench

vsim -voptargs="+acc" -t 1ps -lib work alustim
#vsim -voptargs="+acc" -t 1ps -lib work mux8_1_testbench
#vsim -voptargs="+acc" -t 1ps -lib work mux64x8_1_testbench
#vsim -voptargs="+acc" -t 1ps -lib work and_64_testbench
#vsim -voptargs="+acc" -t 1ps -lib work or_64_testbench
#vsim -voptargs="+acc" -t 1ps -lib work xor_64_testbench
#vsim -voptargs="+acc" -t 1ps -lib work bit_add_testbench
#vsim -voptargs="+acc" -t 1ps -lib work fulladd_64_testbench
#vsim -voptargs="+acc" -t 1ps -lib work zero_flag_testbench

				


# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
#do mux2_1_wave.do
#do mux4_1_wave.do
#do mux16_1_wave.do
#do mux32_1_wave.do
#do D_FF_wave.do
#do DFF_E_wave.do
#do dec1_2_wave.do
#do dec2_4_wave.do
#do dec4_16_wave.do
#do dec5_32_wave.do
#do register_4_wave.do
#do register_16_wave.do
#do register_64_wave.do
#do regfile_wave.do
#do regstim_wave.do
#do mux64x32_1_wave.do

do alustim_wave.do
#do mux8_1_wave.do
#do mux64x8_1_wave.do
#do and_64_wave.do
#do or_64_wave.do
#do xor_64_wave.do
#do bit_add_wave.do
#do fulladd_64_wave.do
#do zero_flag_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
