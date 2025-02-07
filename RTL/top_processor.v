module top_processor (clk, reset, imgmn, imgm1n, imgmn1, imgm1n1, img_rdy, sw_val, sh_val, tw_val, th_val, loc_x, loc_y, pixel_rdy, pixel_rdy_final, pixel_val, pixel_rdy11, pixel_val11, out_img);

input clk;
input reset;
input [15:0] imgmn;
input [15:0] imgm1n; 
input [15:0] imgmn1;
input [15:0] imgm1n1;
input [15:0]sw_val; 
input [15:0] sh_val; 
input [15:0] tw_val; 
input [15:0] th_val; 
input [15:0] loc_x; 
input [15:0] loc_y;
input img_rdy;
output pixel_rdy;
output pixel_rdy11;
output pixel_rdy_final;
output [15:0] pixel_val;
output [15:0] pixel_val11; 
output [15:0] out_img;
wire [15:0] out_img;
wire out_rdy;

wire [15:0] top;
wire [15:0] bottom;
wire [15:0] left;
wire [15:0] right;

wire [15:0] Amn;
wire [15:0] Am1n;
wire [15:0] Amn1;
wire [15:0] Am1n1;

wire [15:0] Amnf;
wire [15:0] Am1nf;
wire [15:0] Amn1f;
wire [15:0] Am1n1f;

wire pixel_rdy;
wire [15:0] pixel_val;
wire pixel_rdy11;
wire [15:0] pixel_val11;
reg [15:0] n_val;
reg data_rdy;
reg pixel_rdy_final;

always @(posegde clk)
begin
if (~reset)
begin
pixel_rdy_final<=1'b0;
n_val<=2;
data_rdy<=0;
end
else
pixel_rdy_final<=pixel_rdy;
data_rdy<=1;
end

REG_BANK inst_reg (.clk(clk), .reset(reset), .imgmn(imgmn), .imgm1n(imgm1n), .imgmn1(imgmn1), .imgm1n1(imgm1n1), .img_rdy(img_rdy), .out_img(out_img), .out_rdy(out_rdy));


AP_design inst_ap (.clk(clk), .reset(reset), .start(img_rdy), .sw(sw_val), .sh(sh_val),.tw(tw_val),.th(th_val), .locx(loc_x),.locy(loc_y), .n_val(n_val), .pixel_rdy(pixel_rdy), .pixel_val(pixel_val), .pixel_rdy11(pixel_rdy11), .pixel_val11(pixel_val11), .left_val(left), .right_val(right), .top_val(top), .bttm_val(bottom));

area_generator inst_area (.clk(clk), .reset(reset), .top(top), .bottom(bottom),  .left(left), .right(right), .data_rdy(data_rdy), .Amn (Amn), .Am1n (Am1n),.Am1n1 (Am1n1),.Amn1 (Amn1), .out_rdy(out_rdy));

EDGE_CATCH_AREA_TUNE inst_edge (.clk(clk), .reset(reset),  .imgmn(imgmn), .imgm1n(imgm1n), .imgmn1(imgmn1), .imgm1n1(imgm1n1), .Amn (Amn), .Am1n (Am1n),.Am1n1 (Am1n1),.Amn1 (Amn1), .img_rdy(img_rdy), .out_img(out_img),  .Amnf (Amnf), .Am1nf (Am1nf),.Amn1f (Amn1f), .Am1n1f (Am1n1f), .out_rdy(out_rdy));

endmodule
