module RAM#(
    parameter MEM_DEPTH =256,
    parameter ADDR_SIZE=8
)(
input clk,rst_n,rx_valid,
input[ADDR_SIZE+1:0] din,
output reg [ADDR_SIZE-1:0] dout,
output reg tx_valid
);

reg [ADDR_SIZE-1:0] mem[MEM_DEPTH-1:0];
reg [ADDR_SIZE-1:0] wr_address,r_address ; 
reg tx_valid_int; 
reg [ADDR_SIZE-1:0] dout_int;
always @(posedge clk) begin
    if (~rst_n) begin
        tx_valid <= 0;
        tx_valid_int <= 0;
        dout <= 0;
        dout_int <= 0;
    end else begin
        tx_valid <= tx_valid_int;
        dout <= dout_int;

        if (rx_valid) begin
            tx_valid_int <= 0;

            case (din[ADDR_SIZE+1:ADDR_SIZE])
                2'b00: wr_address <= din[ADDR_SIZE-1:0];
                2'b01: mem[wr_address] <= din[ADDR_SIZE-1:0];
                2'b10: r_address <= din[ADDR_SIZE-1:0];
                2'b11: begin
                    dout_int <= mem[r_address];
                    tx_valid_int <= 1'b1;
                end
            endcase
        end
    end
end
endmodule