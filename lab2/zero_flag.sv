// EE 469 LAB2
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This module takes in a 64-bit input R and determines whether
// this value is 0 using a series of or gates and a not gate. 
// If the R is zero, it will change the 1'b output zero to 1,
// otherwise zero is 0.

`timescale 1ns/10ps

module zero_flag (zero, R);
	output logic zero;
	input  logic [63:0] R;
	logic  [63:0] temp;
	
	assign temp[0] = R[0];
	
	genvar i;
	// or all bits together to check if any bit is 1
	generate
		for (i=1; i<64; i++) begin : eachOr
			or #0.05 or_bit (temp[i], temp[i-1], R[i]);
		end
	endgenerate
	
	not #0.05 Not_1 (zero, temp[63]); // invert the result to get zero flag
endmodule

module zero_flag_testbench;
	logic zero;
	logic [63:0] R;
	
	zero_flag dut (.*);
	
	initial begin
		R = 64'b0; #10;
		R[0] = 1;  #10;
		R = 64'b0; #10;
		R = 497403948; #10;
		R = 64'b0; #10;
	end
endmodule

