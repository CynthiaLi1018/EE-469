// EE 469 LAB3
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module that use 64 2:1 muxes and DFFs to store the PC value

`timescale 1ns/10ps

module DFF64 (q, d, clk, en);  //Maybe replace by a 64bit register
	output logic [63:0] q;
	input logic [63:0] d;
	input logic clk, en;
	
	logic [63:0] data;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin: eachDFF
			mux2_1 checkEnable (data[i], q[i], d[i], en);
			D_FF dffs (q[i], data[i], 1'b0, clk);
		end
	endgenerate
endmodule

module DFF64_testbench();
	parameter ClockDelay = 50;
	logic [63:0] q;
	logic [63:0] d;
	logic clk, en;
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	DFF64 dut (.*);
	initial begin
		// case: en = 0, expect no data transferring
		en <= 0;
		d[63:0] = 0;							repeat(2) @(posedge clk);
		d[0] = 1;								repeat(2) @(posedge clk);
		d[1] = 1;								repeat(2) @(posedge clk);
		d[6] = 1;								repeat(2) @(posedge clk);
		d[9] = 1;								repeat(2) @(posedge clk);
		d[26]	= 1;								repeat(2) @(posedge clk);
		d[48] = 1;								repeat(2) @(posedge clk);
		d[63] = 1;								repeat(2) @(posedge clk);
		
		// case: en = 1, expect data transferring: q=d
		en  <= 1;
		d[63:0] = 0;							repeat(2) @(posedge clk);
		d[0] = 1;								repeat(2) @(posedge clk);
		d[1] = 1;								repeat(2) @(posedge clk);
		d[6] = 1;								repeat(2) @(posedge clk);
		d[9] = 1;								repeat(2) @(posedge clk);
		d[26]	= 1;								repeat(2) @(posedge clk);
		d[48] = 1;								repeat(2) @(posedge clk);
		d[63] = 1;								repeat(2) @(posedge clk);
		
		$stop;
	end
	
endmodule
