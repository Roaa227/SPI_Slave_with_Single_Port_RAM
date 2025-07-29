module SPI_slave_with_RAM(clk, rst_n, MOSI, MISO, SS_n);
    input clk, rst_n, MOSI, SS_n;
    output MISO;

    wire [9:0] rx_data;
    wire rx_valid;
    wire [7:0] tx_data;
    wire tx_valid;

    SPI_slave inst1(
        .clk(clk),
        .rst_n(rst_n), 
        .MOSI(MOSI), 
        .tx_data(tx_data), 
        .tx_valid(tx_valid), 
        .SS_n(SS_n), 
        .MISO(MISO), 
        .rx_data(rx_data), 
        .rx_valid(rx_valid));


    RAM #(
    .MEM_DEPTH(256),
    .ADDR_SIZE(8)
    ) 
    inst2(
    .clk(clk),
    .rst_n(rst_n),
    .rx_valid(rx_valid),
    .din(rx_data),
    .dout(tx_data),
    .tx_valid(tx_valid)
    );


endmodule