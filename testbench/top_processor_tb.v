`include "configure.h"

module top_processor_tb;

reg clk;
reg reset;
reg [15:0] imgmn;
reg [15:0] imgm1n;
reg [15:0] imgmn1;
reg [15:0] imgm1n1; 
reg [15:0] sw_val;
reg [15:0] sh_val;
reg [15:0] tw_val;
reg [15:0] th_val;
reg [15:0] loc_x;
reg [15:0] loc_y;
reg img_rdy;
reg [15:0] mem [1: `INPUT_IMAGE_SIZE] [1:`INPUT_IMAGE_SIZE];
integer k,k1;
wire [15:0] pixel_val;
wire pixel_rdy11;
wire [15:0] pixel_val11;
wire [15:0] out_img;
integer fid;
wire pixel_rdy_final;


top_processor inst_test (clk,reset,imgmn,imgm1n,imgmn1,imgm1n1, img_rdy, sw_val, sh_val, tw_val, th_val, loc_x, loc_y, pixel_rdy, pixel_rdy_final, pixel_val, pixel_rdy11, pixel_val11, out_img);

initial
begin
clk=0;
reset=0;
img_rdy=0;
end

initial
begin
$readmemh("image_textfile.txt",mem);
fid=$fopen("outimage.txt");
end

always
#10 clk=~clk;

initial 
begin
#200;

reste=1; img_rdy=1;
sw_val=`INPUT_IMAGE_SIZE;
sh_val=`INPUT_IMAGE_SIZE;
tw_val=`OUTPUT_IMAGE_SIZE;
th_val=`OUTPUT_IMAGE_SIZE;

imgmn=16'd0;
imgm1n=16'd0;
imgmn1=16'd0;
imgm1n1=16'd0;

for(k1=0; k1<=th_val; k1=k1+1)
begin
begin

imgmn=imgmn;
imgm1n=imgm1n;
imgmn1=imgmn1;
imgm1n1=imgm1n1;

for (k=0; k<=tw_val; k=k+1)
begin

@(posedge pixel_rdy)
begin
loc_x=k;
loc_y=k;
imgmn=mem[pixel_val11] [pixel_val];
imgmn1=mem[pixel_val11+1] [pixel_val+1];
imgm1n=mem[pixel_val11+2] [pixel_val+2];
imgm1n1=mem[pixel_val11+3] [pixel_val+3];

end
end
end
end
end
always @ (posedge pixel_rdy_final)
begin
if (k>0 & k1>0)
begin
$display("%d",out_img);
$fdisplay(fid,"%d",ouyt_img);
end
if (k==`OUTPUT_IMAGE_SIZE & k1==`OUTPUT_IMAGE_SIZE)
begin
img_rdy=0;
$finish;
$fclose(fid);
end
end	
endmodule

