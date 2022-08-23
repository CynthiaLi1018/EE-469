// Test bench for ALU
`timescale 1ns/10ps

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.  (A63)
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
		
		// test pass B function
		$display("%t testing PASS_B operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		// Test addition function
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		// test zero
		A = 64'h0; B = 64'h0;
		#(delay);
		assert(result == 64'h0 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 1);
		// test normal operations
		A = 64'h0000000001000001; B = 64'h0000000003C00001;
		#(delay);
		assert(result == 64'h0000000004C00002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		// test negative
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'hFFFFFFFFFFFF0000;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFEFFFF && carry_out == 1 && overflow == 0 && negative == 1 && zero == 0);
		// test overflow & not negative & zero
		A = 64'h8000000000000000; B = 64'h8000000000000000;
		#(delay);
		assert(result == 64'h0 && carry_out == 1 && overflow == 1 && negative == 0 && zero == 1);
		// test overflow & negative
		A = 64'h7FFFFFFFFFFFFFFF; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h8000000000000000 && carry_out == 0 && overflow == 1 && negative == 1 && zero == 0);
		
		// test subtraction function
		$display("%t testing subtraction", $time);
		cntrl = ALU_SUBTRACT; 
		// test zero (with zero input)
		A = 64'h0000000000000000; B = 64'h0000000000000000;
		#(delay);
		assert(result == 64'h0 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 1);
		// test zero (with non-zero input of different edge cases)
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'hFFFFFFFFFFFFFFFF;
		#(delay);
		assert(result == 64'h0 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 1);
		// test large number subtract
		A = 64'h0000000a0c000001; B = 64'h0000000200800001;
		#(delay);
		assert(result == 64'h000000080b800000 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 0);
		
		A = 64'h8F00000000000000; B = 64'h8000000000000000;
		#(delay);
		assert(result == 64'h0F00000000000000 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 0);
		// test subtract with two large negative number
		A = 64'h8000000000000000; B = 64'h8F00000000000000;
		#(delay);
		assert(result == 64'hF100000000000000 && carry_out == 0 && overflow == 0 && negative == 1 && zero == 0);
		// test overflow
		A = 64'h8000000000000002; B = 64'h7FFFFFFFFFFFFFFF;
		#(delay);
		assert(result == 64'h0000000000000003 && carry_out == 1 && overflow == 1 && negative == 0 && zero == 0);
		
		// test and gate function
		$display("%t testing bitwise AND ", $time);
		cntrl = ALU_AND;
		for (i=0; i< 100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == (A & B) && negative == result[63] && zero == (result == '0));
		end
		
		// test or gate function
		$display("%t testing bitwise OR ", $time);
		cntrl = ALU_OR;
		for (i=0; i< 100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == (A | B) && negative == result[63] && zero == (result == '0));
		end
		
		
		// test xor gate function
		$display("%t testing bitwise XOR ", $time);
		cntrl = ALU_XOR;
		for (i=0; i< 100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == (A ^ B) && negative == result[63] && zero == (result == '0));
		end
	end
endmodule

