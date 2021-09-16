`include "../riscv/general/xcheck.sv"
module tb();

parameter DW = 32;
reg clk;
reg [DW-1:0] i_dat;

initial begin
#0	clk =0;
	i_dat='b1;
#100	;
#10	i_dat='b11;

#100	;
$finish;
end

always #5 clk <= ~clk;

x_checker u1 (
	.clk(clk),
	.i_dat(i_dat)
);
endmodule
