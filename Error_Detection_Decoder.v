module error_decoder(
    input [8:0] data_in, 
    output [7:0] data_out, 
    output err
);
    assign data_out = data_in[7:0]; 
    assign err = (^data_in[7:0] != data_in[8]); 
endmodule
