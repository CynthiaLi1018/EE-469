// EE 469 LAB2
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This module performs addition and subtraction over a single bit.
// It takes in single bit input A and B and Cin, as the values for
// calculation, and SubFlag that determines whether addition or
// subtraction should be performed. It uses various logic gates to
// produce the value of the remaining in this bit position as R, and
// the value Cout that would be passed to the next bit position.

`timescale 1ns/10ps

module bit_add(A, B, R, SubFlag, Cout, Cin);
	output logic R, Cout;
	input  logic A, B, SubFlag, Cin;
	logic notB, Bin, R_temp, AB, ACin, BCin;
	
	not #0.05 Not_1 (notB, B);
	//Choose the corresponding Bin according to 'SubFlag'
	mux2_1 mux1 (.out(Bin), .i0(B), .i1(notB), .sel(SubFlag)); 
	xor #0.05 Xor_1 (R_temp, A, Bin);
	// Get the output 'R' of the bit adder
	xor #0.05 Xor_2 (R, Cin, R_temp);	
	and #0.05 And_1 (AB, A, Bin);
	and #0.05 And_2 (ACin, A, Cin);
	and #0.05 And_3 (BCin, Bin, Cin);
	//Get the output 'Cout' of the bit adder
	or  #0.05 Or_1  (Cout, AB, ACin, BCin); 

endmodule

module bit_add_testbench;
	logic R, Cout;
	logic A, B, SubFlag, Cin;
	logic notB, Bin;
	
	bit_add dut (.*);
	
	integer i;
	
	// when SubFlag = 0, test all cases for addition
	// when SubFlag = 1, test all cases for subtraction
	initial begin
		for (i = 0; i < 16; i++) begin
			{SubFlag, A, B, Cin} = i; #10;
		end
	end
endmodule
			