module MULT (
    input clk,
    input reset,
    input [15:0] mul_p,
    input [15:0] mul_l,
    input mul_rdy,
    output reg [15:0] prod_out,
    output reg prod_out_rdy
);

reg [31:0] product;
reg [2:0] state;

parameter IDLE = 3'b000;
parameter COMPUTE = 3'b001;
parameter DONE = 3'b010;

always @(posedge clk) begin
    if (~reset) begin
        prod_out <= 16'd0;
        prod_out_rdy <= 1'b0;
        product <= 32'd0;
        state <= IDLE;
    end
    else begin
        case (state)
            IDLE: begin
                if (mul_rdy) begin
                    product <= mul_p * mul_l;
                    state <= COMPUTE;
                    prod_out_rdy <= 1'b0;
                end
            end
            
            COMPUTE: begin
                // Take only the 16 most significant bits of the product
                prod_out <= product[15:0];
                prod_out_rdy <= 1'b1;
                state <= DONE;
            end
            
            DONE: begin
                prod_out_rdy <= 1'b0;
                state <= IDLE;
            end
            
            default: state <= IDLE;
        endcase
    end
end

endmodule
