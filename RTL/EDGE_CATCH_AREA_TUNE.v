module EDGE_CATCH_AREA_TUNE (clk, reset, imgmn, imgm1n, imgmn1, imgm1n1,  Amn, Am1n,Amn1, Am1n1,  img_rdy, out_img, Amnf, Am1nf,Amn1f, Am1n1f, out_rdy);

input clk;
input reset;
input [15:0] imgmn;
input [15:0] imgm1n;
input [15:0] imgmn1;
input [15:0] imgm1n1;
input img_rdy;

input [15:0] Amn;
input [15:0] Am1n;
input [15:0] Amn1;
input [15:0] Am1n1;
output out_rdy;
output [15:0] out_img;
output [15:0] Amnf;
output [15:0] Am1nf;
output [15:0] Amn1f;
output [15:0] Am1n1f;

wire [15:0] Amnf;
wire [15:0] Am1nf;
wire [15:0] Amn1f;
wire [15:0] Am1n1f;

reg [15:0] out_img;
reg out_rdy;

wire [15:0] level_value;

//assign level_value= (img_rdy & imgm1n > imgmn1 & //imgm1n1 > imgmn)...(img_rdy & imgm1n < imgmn1 & imgm1n1 < imgmn) ? ...

assign level_value = (img_rdy & imgm1n > imgmn1 & imgm1n1 > imgmn) ? 16'd255 :(img_rdy & imgm1n < imgmn1 & imgm1n1 < imgmn) ? -16'd255 : 16'd0;

assign Amnf= (level_value>=0)?(Amn-(level_value*Amn)>>8): (level_value<=0)?(Am1n-(level_value*Am1n)>>8): 16'd0;


assign Am1nf= (level_value>=0)?(Am1n+(level_value*Am1n)>>8): (level_value<=0)?(Amn-(level_value*Amn)>>8): 16'd0;


assign Amn1f= (level_value>=0)?(Amn1): (level_value<=0)?(Amn1): 16'd0;


assign Am1n1f= (level_value>=0)?(Am1n1): (level_value<=0)?(Am1n1): 16'd0;

always @(posedge clk)
begin
if(~reset)
begin
out_img<=16'd0;
out_rdy<=1'b0;
end
else if(img_rdy)
begin
out_img<=imgmn;
out_rdy<=1'b1;
end

else 
begin
out_img<=out_img;
out_rdy<=1'b0;
end 
end
endmodule
