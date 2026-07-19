module uart_rx(
    input clk, rst, tick, rx, 
    output reg [8:0] dout, 
    output reg done
);
    localparam IDLE=0, START=1, DATA=2, STOP=3;
    reg [1:0] state; 
    reg [3:0] s, n; 
    reg [8:0] b;
    
    always @(posedge clk) begin
        if (rst) begin 
            state <= IDLE; done <= 0; s <= 0; n <= 0; 
        end
        else begin
            done <= 0;
            case (state)
                IDLE: if (~rx) begin state <= START; s <= 0; end
                START: if(tick) begin
                    if(s == 7) begin 
                        if(~rx) begin s <= 0; n <= 0; state <= DATA; end 
                        else state <= IDLE; 
                    end 
                    else s <= s + 1;
                end
                DATA: if(tick) begin
                    if(s == 15) begin
                        s <= 0; 
                        b <= {rx, b[8:1]}; 
                        if(n == 8) state <= STOP; 
                        else n <= n + 1;
                    end 
                    else s <= s + 1;
                end
                STOP: if(tick) begin
                    if(s == 15) begin state <= IDLE; done <= 1; dout <= b; end
                    else s <= s + 1;
                end
            endcase
        end
    end
endmodule
