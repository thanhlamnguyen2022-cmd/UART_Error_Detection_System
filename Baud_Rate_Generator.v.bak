module baud_gen(
    input clk, rst, 
    output reg tick
);
    reg [8:0] counter;
    always @(posedge clk) begin
        if(rst) begin 
            counter <= 0; 
            tick <= 0; 
        end
        else if(counter == 325) begin 
            counter <= 0; 
            tick <= 1; 
        end 
        else begin 
            counter <= counter + 1; 
            tick <= 0; 
        end
    end
endmodule
