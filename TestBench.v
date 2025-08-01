module instantiation_tb;
    reg clk, rst_n, MOSI;
    reg SS_n;
    wire MISO;
    reg [7:0] random, address;

    // DUT instantiation
    SPI_slave_with_RAM DUT (
        .clk(clk),
        .rst_n(rst_n),
        .MOSI(MOSI),
        .SS_n(SS_n),
        .MISO(MISO)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // SPI send task (MSB first)
    task send_10bit;
        input [9:0] data;
        integer j;
        begin
            for (j = 9; j >= 0; j = j - 1) begin
                MOSI = data[j];
                @(posedge clk);  
            end
        end
    endtask

    initial begin
        // Reset
        rst_n = 0; SS_n = 1; MOSI = 0;
        repeat(2) @(posedge clk);
        rst_n = 1;
        repeat(2) @(posedge clk);

        // ------------------ Write Loop ------------------
        for (address = 0; address < 254; address = address + 1) begin
            random = $random;
            
            // WRITE (address)
            SS_n = 0; MOSI = 0;
            @(posedge clk);  
            send_10bit({2'b00, address});  
            SS_n = 1; @(posedge clk);

            // WRITE (data)
            SS_n = 0; MOSI = 0;
            @(posedge clk);  
            send_10bit({2'b01, random});  
            SS_n = 1; @(posedge clk);

            $display("Wrote %h to address %h", random, address);
        end

        // ------------------ Read Loop ------------------
        for (address = 0; address < 254; address = address + 1) begin
            // READ ADD
            SS_n = 0; MOSI = 1;
            repeat(2) @(posedge clk);  
            send_10bit({2'b10, address});  
            SS_n = 1; @(posedge clk);

            //READ DATA
            SS_n = 0; MOSI = 1;
            repeat(2) @(posedge clk);  
            send_10bit({2'b11, 8'd0}); 
            repeat(12) @(posedge clk);  
            SS_n = 1; @(posedge clk);

        end

        $stop;
    end


    initial begin
        $monitor("ss_n = %b, Mosi = %b, Miso = %b current state = %d", 
                 SS_n, MOSI, MISO, 
                 DUT.inst1.current_state);
    end

endmodule
