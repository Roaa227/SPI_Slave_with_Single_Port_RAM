# Create the work library
vlib work
vmap work work

# Compile design files
vlog RAM.v
vlog SPI_slave.v
vlog SPI_slave_with_RAM.v
vlog TestBench.v

# Simulate the testbench top module
vsim -voptargs=+acc work.instantiation_tb

# Add signals to waveform
add wave -position insertpoint sim:/instantiation_tb/clk
add wave -position insertpoint sim:/instantiation_tb/rst_n
add wave -position insertpoint sim:/instantiation_tb/SS_n
add wave -position insertpoint sim:/instantiation_tb/MOSI
add wave -position insertpoint sim:/instantiation_tb/MISO
add wave -position insertpoint sim:/instantiation_tb/random
add wave -position insertpoint sim:/instantiation_tb/address
add wave -position insertpoint sim:/instantiation_tb/received_data

# Internal DUT signals
add wave -position insertpoint sim:/instantiation_tb/DUT/SPI/rx_valid
add wave -position insertpoint sim:/instantiation_tb/DUT/SPI/rx_data
add wave -position insertpoint sim:/instantiation_tb/DUT/SPI/tx_valid
add wave -position insertpoint sim:/instantiation_tb/DUT/SPI/tx_data

add wave -position insertpoint sim:/instantiation_tb/DUT/RAM/din
add wave -position insertpoint sim:/instantiation_tb/DUT/RAM/dout
add wave -position insertpoint sim:/instantiation_tb/DUT/RAM/rx_valid
add wave -position insertpoint sim:/instantiation_tb/DUT/RAM/tx_valid

# Run simulation
run -all
