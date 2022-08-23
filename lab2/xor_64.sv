// EE 469 LAB2
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This module produces the function that takes in two 64-bit value, A and B,
// produce the pass each bit through a xor gate and produces the 64-bit
// result as R.

`timescale 1ns/10ps

module xor_64 (A, B, R);
	output logic  [63:0] R;
	input  logic  [63:0] A, B;
	
	genvar i;
	
	generate
		for (i=0; i<64; i++) begin : eachXor
			xor #0.05 xor_bit (R[i], A[i], B[i]);
		end
	endgenerate
endmodule

module xor_64_testbench;
	logic  [63:0] R;
	logic  [63:0] A, B;
	
	xor_64 dut (.A, .B, .R);
	
	integer i, j;
	initial begin
		for (i = 0; i < 2**4; i++) begin
			for (j = 0; j < 2**4; j++) begin
				A = i;
				B = j; #10;
				assert(R == (A ^ B));
			end
		end
	end
endmodule
				