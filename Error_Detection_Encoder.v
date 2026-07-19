module error_encoder(
    input [7:0] data_in, 
    output [8:0] data_out
);
    assign data_out = {^data_in, data_in}; 
endmodule
