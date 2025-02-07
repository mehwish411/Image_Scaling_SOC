module AP_design (clk, reset, start, sw, sh, tw, th, locx, locy, n_val, pixel_rdy, pixel_val, pixel_rdy11, pixel_val11, left_val, right_val, top_val, bttm_val);

input clk;
input reset;
input start;
input [15:0] sw;
input [15:0] sh;
input [15:0] tw;
input [15:0] th;
input [15:0] locx;
input [15:0] locy;
input [15:0] n_val;

output pixel_rdy;
output [15:0] pixel_val;
output pixel_rdy11;
output [15:0] pixel _val11;
output [15:0] left_val;
output [15:0] bttm_val;
output [15:0] top_val;
output [15:0] right_val;

wire [15:0] left_val;
wire [15:0] bttm_val;
wire [15:0] top_val;
wire [15:0] right_val;

wire pixel_rdy11;
wire [15:0] pixel_val11;
wire pixel_rdy;
wire [15:0] pixel_val;
reg [15:0] data1;
reg [15:0] data2;
reg rdy;
wire [15:0] out_data;
wire [15:0] sw_temp;
wire out_rdy;
reg [15:0] cnt_val1;
reg [15:0] cnt_val2;
reg rdy1, rdy2, rdy4;
wire [15:0] out_data4;
wire out_rdy4;
reg [15:0] cnt_val3;
reg [15:0] cnt_val4;
wire [15:0] out_data1;
wire out_rdy1;

assign left_val= (sw-1)*(tw-1);
assign right_val= (sw*th);
assign top_val=sw;
assign bttm_val=th;

assign pixel_val=(cnt_val2<=tw & cnt_val2>=16'd0)?out_data1:16'd0;
assign pixel_rdy=(cnt_val2<=tw & cnt_val2>16'd0)?out_rdy1:1'b0;

assign pixel_val11=(cnt_val4<=tw & cnt_val4>=16'd0)?out_data4:16'd0;
assign pixel_rdy11=(cnt_val4<=tw & cnt_val4>16'd0)?out_rdy4:1'b0;

assign pixel_rdy2=(cnt_val2==tw & pixel_rdy);
assign sw_temp=(start)?sw*100:16'd0;

always @(posedge clk)
begin
if(~reset)
begin
data1<=16'd0;
rdy<=1'b0;
end

else if (start)
begin
data1<=sw_temp;
data2<=tw;
rdy <=1'b1;
end
else
begin
data1<=data1;
data2<=data2;
rdy<=rdy;
end
end
always @ (posedge clk)
begin
cnt_val1<=16'd0;
cnt_val2<=16'd0;
rdy1<=1'b0;
rdy2<=1'b1;
end
else if(out_rdy)
begin
cnt_val1<=cnt_val1+(out_data);
cnt_val2<=cnt_val2+16'd1;
rdy1<=1'b1;
rdy2<=1'b0;
end 
else if (~out_rdy & out_rdy1 &cnt_val2<=tw)
begin
cnt_val1<=cnt_val1+(out_data);
cnt_val2<=cnt_val2+16'd1;
rdy1<=1'b1;
rdy2<=1'b0;
end

else if (out_rdy4)
begin
cnt_val1<=16'd0;
cnt_val2<=16'd0;
rdy1<=1'b1;
end
else 
begin
cnt_val1<=cnt_val1;
cnt_val2<=cnt_val2;
end
end
always @(posedge clk)
begin
if (~reset)
begin 
cnt_val3<=16'd0;
cnt_val4<=16'd0;
rdy4<=1'b0;
end
else if (pixel_rdy2)
begin
cnt_val3<=cnt_val3+(out_data);
cnt_val4<=cnt_val4+16'd1;
rdy4<=1'b1;
end
else if (pixel_rdy2 & cnt_val3<=tw & out_rdy4)
begin 
cnt_val3<=cnt_val3+(out_data);
cnt_val4<=cnt_val4+16'd1;
rdy4<=1'b1;
end

else if (out_rdy4)
begin
rdy4<=1'b0;
cnt_val3<=cnt_val3;
cnt_val4<=cnt_val4;
end
end

division_processor division_inst (.clk(clk), .reset(reset), .data1(data1), .data2(data2), .rdy(rdy & rdy2), .out(out_data), .out_rdy(out_rdy));

division_processor division_inst2 (.clk(clk), .reset(reset), .data1(cnt_val1), .data2(16'd100), .rdy(rdy1), .out(out_data1), .out_rdy(out_rdy1));

division_processor division_inst3 (.clk(clk), .reset(reset), .data1(cnt_val3), .data2(16'd100), .rdy(rdy4), .out(out_data4), .out_rdy(out_rdy4));

endmodule




