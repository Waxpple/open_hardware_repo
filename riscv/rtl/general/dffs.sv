// ====================
// Ref: E200 opencore
// Author: Waxpple
// Date: 2021-09-16
// Description:
//	PASS SPYGLASS RTL LINT
// ====================

// ====================
// dffs_lrs : 
//	Description:
//		Default reset value is 1 with load enable
// ====================
module dff_lrs # (
	parameter DW = 32
) (

	input 		lden,
	input [DW-1:0] 	din,
	output [DW-1:0] qout,
	// clock
	input		clk,
	input		rst_n
);
reg [DW-1:0] qout_r;

always@(posedge clk or negedge rst_n)
begin : dff_lrs_proc
	if (rst_n == 1'b0) begin
		qout_r <= {DW{1'b1}};
	end
	else if (lden == 1'b1) begin
		qout_r <= #1 din;
	end
end
assign qout = qout_r;

`ifndef FPGA_SOURCE
`ifndef DISABLE_SV_ASSERTION

xchecker # (
	.DW(1)
) xchecker_lrs (
	.i_dat	(lden),
	.clk	(clk)
);
`endif
`endif
endmodule

// ====================
// dff_lr : 
//	Description:
//		Default reset value is 0 with load enable
// ====================
module dff_lr # (
	parameter DW = 32
) (

	input 		lden,
	input [DW-1:0] 	din,
	output [DW-1:0] qout,
	// clock
	input		clk,
	input		rst_n
);
reg [DW-1:0] qout_r;

always@(posedge clk or negedge rst_n)
begin : dff_lr_proc
	if (rst_n == 1'b0) begin
		qout_r <= {DW{1'b0}};
	end
	else if (lden == 1'b1) begin
		qout_r <= #1 din;
	end
end
assign qout = qout_r;

`ifndef FPGA_SOURCE
`ifndef DISABLE_SV_ASSERTION

xchecker # (
	.DW(1)
) xchecker_lr (
	.i_dat	(lden),
	.clk	(clk)
);
`endif
`endif
endmodule

// ====================
// dff_l : 
//	Description:
//		no reset with load enable
// ====================
module dff_l # (
	parameter DW = 32
) (

	input 		lden,
	input [DW-1:0] 	din,
	output [DW-1:0] qout,
	// clock
	input		clk
);
reg [DW-1:0] qout_r;

always@(posedge clk)
begin : dff_l_proc
	if (lden == 1'b1) begin
		qout_r <= #1 din;
	end
end
assign qout = qout_r;

`ifndef FPGA_SOURCE
`ifndef DISABLE_SV_ASSERTION

xchecker # (
	.DW(1)
) xchecker_lr (
	.i_dat	(lden),
	.clk	(clk)
);
`endif
`endif
endmodule
// ====================
// dff_rs : 
//	Description:
//		Default reset value is 1
// ====================
module dff_rs # (
	parameter DW = 32
) (

	input [DW-1:0] 	din,
	output [DW-1:0] qout,
	// clock
	input		clk,
	input		rst_n
);
reg [DW-1:0] qout_r;

always@(posedge clk or negedge rst_n)
begin : dff_lrs_proc
	if (rst_n == 1'b0) begin
		qout_r <= {DW{1'b1}};
	end
	else begin
		qout_r <= #1 din;
	end
end
assign qout = qout_r;

`ifndef FPGA_SOURCE
`ifndef DISABLE_SV_ASSERTION

`endif
`endif
endmodule

// ====================
// dff_r : 
//	Description:
//		Default reset value is 0
// ====================
module dff_r # (
	parameter DW = 32
) (

	input [DW-1:0] 	din,
	output [DW-1:0] qout,
	// clock
	input		clk,
	input		rst_n
);
reg [DW-1:0] qout_r;

always@(posedge clk or negedge rst_n)
begin : dff_lr_proc
	if (rst_n == 1'b0) begin
		qout_r <= {DW{1'b0}};
	end
	else  begin
		qout_r <= #1 din;
	end
end
assign qout = qout_r;

`ifndef FPGA_SOURCE
`ifndef DISABLE_SV_ASSERTION

`endif
`endif
endmodule

// ====================
// ltch : 
//	Description:
//		verilog for general latchs
// ====================
module ltch # (
	parameter DW = 32
) (
	input lden,
	input [DW-1:0] din,
	output [DW-1:0] qout
);

reg [DW-1:0] qout_r;
always @ (*)begin:LTCH_PROC
	if(lden==1'b1)
		qout_r <= din;
end

assign qout = qout_r;

`ifndef FPGA_SOURCE
`ifndef DISABLE_SV_ASSERTION

always_comb begin : CHECK_THE_X_VALUE
	assert (lden !== 1'bx) 
	else   $fatal ("\n Error: Oops! X value propagate!\n");
end

`endif
`endif
endmodule