module RAM#(
    parameter MEM_DEPTH =256,
    parameter ADDR_SIZE=8
)(
input clk,rst_n,rx_valid,
input[9:0] din,
output reg [7:0] dout,
output reg tx_valid
);

reg [ADDR_SIZE-1:0] mem[MEM_DEPTH-1:0];
reg [ADDR_SIZE-1:0] wr_address,r_address ; 
always @ (posedge clk) begin
    if(~rst_n) begin
        dout <=0;
        tx_valid <=0;
    end
    else begin
        if (rx_valid) begin
             if(din[ADDR_SIZE+1:ADDR_SIZE] == 2'b00)  wr_address <= din[ADDR_SIZE-1:0];
             else if( din[ADDR_SIZE+1:ADDR_SIZE] ==2'b01)  mem[wr_address] <= din[ADDR_SIZE-1:0];
             else if( din[ADDR_SIZE+1:ADDR_SIZE] ==2'b10)  r_address <= din[ADDR_SIZE-1:0];
             else begin
                 dout <= mem[r_address];
                 tx_valid <=1'b1;
                end
        end

    end
end
endmodule
