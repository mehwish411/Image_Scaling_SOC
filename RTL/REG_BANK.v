module REG_BANK (clk, reset, imgmn, imgm1n, imgmn1, imgm1n1, img_rdy, out_img, out_rdy);

input clk;
input reset;
input [15:0] imgmn;
input [15:0] imgm1n;
input [15:0] imgmn1;
input [15:0] imgm1n1;
input img_rdy;
output [15:0] out_img;
output out_rdy;
wire [15:0] out_img;
reg out_rdy;
reg [15:0] out_img1;

assign out_img= imgmn;
always @(posedge clk)
begin
out_img1<=16'd0;
out_rdy<=1'b0;
end

else if (img_rdy)
begin 
out_img1<=imgmn;
out_rdy<= 1'b1;
end
else
begin
out_img1<=out_img1;
out_rdy<=1'b0;
end
end 
endmodule


