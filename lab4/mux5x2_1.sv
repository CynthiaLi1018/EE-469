// EE 469 LAB3
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is a module that sets a 5x2_1 mux that is made of 5 2x1 mux.
// It takes in 5-bit inputs A and B, insert each 5-bit value into a 5-bit register out
// based on the 1-bit input sel.

`timescale 1ns/10ps

module mux5x2_1 (out, A, B, sel);
	output logic [4:0] out;
	input logic [4:0] A, B;
	input logic sel;
	
	genvar i;
	generate
		for (i = 0; i < 5; i++) begin: eachBit
			mux2_1 muxes (out[i], A[i], B[i], sel);
		end
	endgenerate
endmodule

module mux5x2_1_testbench;
	logic [4:0] A, B, out;
	logic sel;
	
	mux5x2_1 dut (.*);
	
	initial begin 
		A = 5'b11110; B = 5'b00100;
		sel = 1'b1; #10;
		sel = 1'b0; #10;
		A = 5'b01111; B = 5'b11100;
		sel = 1'b1; #10;
		sel = 1'b0; #10;
	end
endmodule