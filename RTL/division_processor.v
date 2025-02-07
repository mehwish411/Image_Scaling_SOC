module division_processor (
    input clk,
    input reset,
    input [15:0] data1,
    input [15:0] data2,
    input rdy,
    output reg [15:0] out,
    output reg out_rdy
);

reg [15:0] dividend;
reg [15:0] divisor;
reg [15:0] quotient;
reg [15:0] remainder;
reg [4:0] count;
reg [2:0] state;

parameter IDLE = 3'b000;
parameter INIT = 3'b001;
parameter DIVIDE = 3'b010;
parameter DONE = 3'b011;

always @(posedge clk) begin
    if (~reset) begin
        out <= 16'd0;
        out_rdy <= 1'b0;
        state <= IDLE;
        count <= 5'd0;
    end
    else begin
        case (state)
            IDLE: begin
                if (rdy) begin
                    dividend <= data1;
                    divisor <= data2;
                    quotient <= 16'd0;
                    remainder <= 16'd0;
                    count <= 5'd16;
                    state <= INIT;
                    out_rdy <= 1'b0;
                end
            end
            
            INIT: begin
                state <= DIVIDE;
            end
            
            DIVIDE: begin
                if (count > 0) begin
                    remainder <= remainder << 1;
                    remainder[0] <= dividend[15];
                    dividend <= dividend << 1;
                    
                    if (remainder >= divisor) begin
                        remainder <= remainder - divisor;
                        quotient <= (quotient << 1) | 1'b1;
                    end
                    else begin
                        quotient <= quotient << 1;
                    end
                    
                    count <= count - 1;
                end
                else begin
                    out <= quotient;
                    out_rdy <= 1'b1;
                    state <= DONE;
                end
            end
            
            DONE: begin
                out_rdy <= 1'b0;
                state <= IDLE;
            end
            
            default: state <= IDLE;
        endcase
    end
end

endmodule
