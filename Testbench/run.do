
vlib work
vlog RAM.v SPI_slave.v instantiation.v  instantiation_tb.v
vsim -voptargs=+acc work.instantiation_tb
add wave -position insertpoint sim:/instantiation_tb/clk
add wave -position insertpoint sim:/instantiation_tb/rst_n
add wave -position insertpoint sim:/instantiation_tb/SS_n
add wave -position insertpoint sim:/instantiation_tb/MOSI
add wave -position insertpoint sim:/instantiation_tb/MISO
add wave -position insertpoint sim:/instantiation_tb/DUT/SPI/rx_valid
add wave -position insertpoint sim:/instantiation_tb/DUT/RAM/rx_valid
add wave -position insertpoint sim:/instantiation_tb/random
add wave -position insertpoint sim:/instantiation_tb/DUT/SPI/rx_data
add wave -position insertpoint sim:/instantiation_tb/DUT/RAM/din
add wave -position insertpoint sim:/instantiation_tb/DUT/RAM/dout
add wave -position insertpoint sim:/instantiation_tb/DUT/SPI/tx_data
add wave -position insertpoint sim:/instantiation_tb/DUT/RAM/tx_valid
add wave -position insertpoint sim:/instantiation_tb/DUT/SPI/tx_valid

run -all
