// EE 469 LAB2
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module that creates 64 parallel 8-to-1 mux. Each mux is
// responsible for selection of each bit of 8 ALU results. The result
// is depending the input 'cntrl'

`timescale 1ns/10ps

module mux64x8_1 (DataOut, DataIn, cntrl);
	output logic [63:0] DataOut;
	input  logic [7:0][63:0] DataIn;
	input  logic [2:0]  cntrl;
	
	// Use generate statement to create 64 parallel 8-to-1 mux. Each mux is
	// responsible for selection of each bit of 8 ALU results. The result
	// is depending the input 'cntrl'
	genvar i;
	
	generate
		for (i=0; i<64; i++) begin : eachMux
			mux8_1 mux_i (.out(DataOut[i]), .in({DataIn[7][i],DataIn[6][i],DataIn[5][i],DataIn[4][i],
															DataIn[3][i],DataIn[2][i],DataIn[1][i],DataIn[0][i]}), .sel(cntrl));
		end
	endgenerate
endmodule

module mux64x8_1_testbench;
	logic [63:0] DataOut;
	logic [7:0][63:0] DataIn;
	logic [2:0]  cntrl;
	
	mux64x8_1 dut (.DataOut, .DataIn, .cntrl);
	
	integer i;
	initial begin
		DataIn[0] = 64'h0000000000000000;
		DataIn[1] = 64'h000000000000001a;
		DataIn[2] = 64'h00000000000002a0;
		DataIn[3] = 64'h0000000000003f00;
		DataIn[4] = 64'h000000000004c000;
		DataIn[5] = 64'h000000000d500000;
		DataIn[6] = 64'h0000000e06000000;
		DataIn[7] = 64'h00000007b0000000;
		for (i = 0; i < 2**3; i++) begin
			cntrl = i; #10;
		end
	end
endmodule