module uart_system_top(
    input clk, rst, tx_start, inject_error,
    input [7:0] data_in,
    output [7:0] data_out,
    output error_flag, tx_done, rx_done
);
    wire tick;
    wire [8:0] encoded_data, received_data;
    wire tx_wire, rx_wire;

    baud_gen bg (.clk(clk), .rst(rst), .tick(tick));
    
    error_encoder enc (.data_in(data_in), .data_out(encoded_data));
    
    uart_tx tx_mod (.clk(clk), .rst(rst), .tick(tick), .start(tx_start), 
                    .din(encoded_data), .tx(tx_wire), .done(tx_done));
    
    assign rx_wire = inject_error ? ~tx_wire : tx_wire; 

    uart_rx rx_mod (.clk(clk), .rst(rst), .tick(tick), .rx(rx_wire), 
                    .dout(received_data), .done(rx_done));
                    
    error_decoder dec (.data_in(received_data), .data_out(data_out), .err(error_flag));
endmodule