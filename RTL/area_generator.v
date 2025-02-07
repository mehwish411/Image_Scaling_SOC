module area_generator(clk, reset, top, bottom, left, right, data_rdy, Amn, Am1n, Am1n1, Amn1, out_rdy);
input clk;
input reset;
input [15:0] top;
input [15:0] bottom;
input [15:0] left;
input [15:0] right;

input data_rdy;
output [15:0] Amn;
output [15:0] Am1n;
output [15:0] Am1n1;
output [15:0] Amn1;
output out_rdy;
reg [15:0] t1;
reg [15:0] b1;
reg [15:0] l1;
reg [15:0] r1;
reg rdy;

wire [15:0] Amn;
wire [15:0] Am1n;
wire [15:0] Am1n1;
wire [15:0] Amn1;
wire out_rdy;

wire [15:0] lt;
wire [15:0] tr;
wire [15:0] rb;
wire [15:0] bl;
wire lt_rdy;
wire tr_rdy;
wire rb_rdy;
wire bl_rdy;

assign out_rdy=(lt_rdy && tr_rdy && rb_rdy && bl_rdy);

assign Amn=(out_rdy)?lt:16'd0;
assign Am1n=(out_rdy)?tr:16'd0;
assign Am1n1=(out_rdy)?rb:16'd0;
assign Amn1=(out_rdy)?bl:16'd0;

always @(posedge clk) 
begin
if(~reset)
begin
t1<=16'd0;
b1<=16'd0;
l1<=16'd0;
r1<=16'd0;
rdy<=1'd0;
end
else if(data_rdy)
begin
t1<=top;
b1<=bottom;
l1<=left;
r1<=right;
rdy<=1'b1;
end 

else
begin
t1<=t1;
b1<=b1;
l1<=l1;
r1<=r1;
rdy<=rdy;
end
end

MULT mult_inst1 (.clk(clk), .reset(reset), .mul_p(l1), .mul_l(t1), .mul_rdy(rdy), .prod_out(lt), .prod_out_rdy(lt_rdy));

MULT mult_inst2 (.clk(clk), .reset(reset), .mul_p(t1), .mul_l(r1), .mul_rdy(rdy), .prod_out(tr), .prod_out_rdy(tr_rdy));

MULT mult_inst3 (.clk(clk), .reset(reset), .mul_p(r1), .mul_l(b1), .mul_rdy(rdy), .prod_out(rb), .prod_out_rdy(rb_rdy));

MULT mult_inst4 (.clk(clk), .reset(reset), .mul_p(b1), .mul_l(l1), .mul_rdy(rdy), .prod_out(bl), .prod_out_rdy(bl_rdy));
endmodule



