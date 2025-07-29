module SPI_slave(clk, rst_n, MOSI, tx_data, tx_valid, SS_n, MISO, rx_data, rx_valid);

    input clk, rst_n, MOSI, tx_valid, SS_n;
    input [7:0] tx_data;

    output MISO, rx_valid;
    output [9:0] rx_data;


    parameter IDLE = 0;
    parameter CHK_CMD = 1;
    parameter WRITE = 2;
    parameter READ_ADD = 3;
    parameter READ_DATA = 4;


    reg read_flag = 0;
    reg [2:0] next_state, current_state;


    //current state
    always @(posedge clk) begin
        if(~rst_n) 
            current_state <= IDLE;
        else
            current_state <= next_state;

    end

    //next state
    always @(*) begin
        case (current_state)
            IDLE: begin
                if(SS_n)
                    next_state = IDLE;
                else   
                    next_state = CHK_CMD;
            end

            CHK_CMD: begin
                if(SS_n==0 && MOSI==0)
                    next_state = WRITE;

                else if(SS_n==0 && MOSI==1 && read_flag==0) begin
                    next_state = READ_ADD;
                    // read_flag = 1;
                end


                else begin
                    next_state = READ_DATA;
                    // read_flag = 0;
                end
            end

            WRITE: begin
                if(SS_n)
                    next_state = IDLE;
                else
                    next_state = WRITE;
            end

            READ_ADD: begin
                if(SS_n)
                    next_state = IDLE;
                else
                    next_state = READ_ADD;
            end

            READ_DATA: begin
                if(SS_n)
                    next_state = IDLE;
                else
                    next_state = READ_DATA;
            end

            default : next_state = IDLE;
        endcase
        
    end

    //output
    reg [3:0] counter;
    reg [9:0] shft_reg;
    always @(posedge clk) begin
        if(~rst_n) begin
            counter <= 0;
            rx_data <= 0;
            rx_valid <= 0;
            shft_reg <= 0;
            MISO <= 0;
        end
        else begin
            case (current_state)
                WRITE: begin
                    shft_reg <= {shft_reg[8:0], MOSI};
                    counter <= counter + 1;

                    if(counter == 9) begin
                        rx_valid <= 1;
                        rx_data <= shft_reg;
                        counter <= 0;
                    end
                end
            endcase
        end
            
        
    end

endmodule