module SPI_slave(clk, rst_n, MOSI, tx_data, tx_valid, SS_n, MISO, rx_data, rx_valid);

    input clk, rst_n, MOSI, tx_data, tx_valid, SS_n;
    output MISO, rx_data, rx_valid;

    parameter IDLE = 0;
    parameter CHK_CMD = 1;
    parameter WRITE = 2;
    parameter READ_ADD = 3;
    parameter READ_DATA = 4;


    reg read_flag;
    reg next_state, current_state;


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

                else if(SS_n==0 && MOSI==1 && read_flag==0)
                    next_state = READ_ADD;

                else 
                    next_state = READ_DATA;
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
    always @(posedge clk) begin
        
    end

endmodule