// EE 469 LAB2
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This module output the result of two 64'b input (A and B)'s addition or su-
// btraction, 1-bit input SubFlag determines whether the module performs addi-
// tion or sub traction (0 for addition and 1 for subtraction). It passes each
// bit of A and B from the lowest bit through the bit-add module to get the 64'b
// output R, and 1-bit output Cout and Overflow that shows whether overflow error
// has occured.

`timescale 1ns/10ps

module fulladd_64 (A, B, R, SubFlag, Cout, Overflow);
   output logic  [63:0] R;
	output logic  Cout, Overflow;
	input  logic   [63:0] A, B;
	input  logic  SubFlag;
	logic [63:0] Cin;
	
	//assign Cin[0] = SubFlag;
   //bit_add BitAdd_0 (A, B, R, SubFlag, Cout, Cin)
	//set the first bit adder with 'SubFlag' as 'Cin'
	bit_add BitAdd_0 (.A(A[0]), .B(B[0]), .R(R[0]), .SubFlag(SubFlag), 
							.Cout(Cin[1]), .Cin(SubFlag)); 
	
	genvar i;
	//set bit adder 1 to 62 with Cout from previous adder as Cin
	generate
		for (i=1; i<63; i++) begin : eachAdder
			bit_add BitAdd_i (.A(A[i]), .B(B[i]), .R(R[i]), .SubFlag(SubFlag),
									.Cout(Cin[i+1]), .Cin(Cin[i]));
		end
	endgenerate
	//finish adding and set the carry out
	bit_add BitAdd_63 (.A(A[63]), .B(B[63]), .R(R[63]), .SubFlag(SubFlag), 
							.Cout(Cout), .Cin(Cin[63])); 
	// calculate overflow
	xor #0.05 Xor_1 (Overflow, Cout, Cin[63]); 
	
endmodule


// Only tested overflow cases 
//	Addition and Subtraction's performance was tested in bit-add module
module fulladd_64_testbench;
	logic  [63:0] R;
	logic  Cout, Overflow;
	logic  [63:0] A, B;
	logic  SubFlag;

	fulladd_64 dut (.*);
	

	initial begin
	   SubFlag = 0;
		// TEST: no overflow, Cout = 0
		A = 64'h0000000000000001; B = 64'hFFFFFFFFFFFFFF00; #10;
		// TEST: no overflow, Cout = 1
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0000000000000001; #10;
		// TEST: overflow, Cout = 1
		A = 64'h7FFFFFFFFFFFFFFF; B = 64'h700000000000000F; #10;
		SubFlag = 1;
		// TEST: no overflow, Cout = 1
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'hFFFFFFFFFFFFFFFE; #10;
		// TEST: overflow, Cout = 1; 
		A = 64'h8FFFFFFFFFFFFFFF; B = 64'h7FFFFFFFFFFFF001; #10;
	end
endmodule