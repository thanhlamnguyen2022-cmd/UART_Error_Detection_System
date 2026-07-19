`timescale 1ns / 1ps

module tb_uart_system();
    reg clk, rst, tx_start, inject_error;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire error_flag, tx_done, rx_done;

    uart_system_top dut (
        .clk(clk), .rst(rst), .tx_start(tx_start), .inject_error(inject_error),
        .data_in(data_in), .data_out(data_out),
        .error_flag(error_flag), .tx_done(tx_done), .rx_done(rx_done)
    );

    initial begin clk = 0; forever #10 clk = ~clk; end 

    initial begin
        rst = 1; tx_start = 0; inject_error = 0; data_in = 8'h00;
        #100 rst = 0;
        
        #1000 data_in = 8'hA5; tx_start = 1; 
        #20 tx_start = 0;
        @(posedge rx_done); 
        
        #50000 data_in = 8'h3C; tx_start = 1; 
        #20 tx_start = 0;
        
        #150000 inject_error = 1; 
        #20000  inject_error = 0;
        
        @(posedge rx_done);
        
        #50000 $stop; 
    end
endmodule
