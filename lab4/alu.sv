// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the top module of the ALU. It has two 64-bit input ports, A and B,
// a 3-bit ALU control port, cntrl, a 64-bit output port restult, a 1 bit output
// carry out, and some 1-bit detection ports including negative, zero, and overflow.
// cntrl gives intruction to the ALU to perform different tasks such as addition, 
// subtraction, pass_B, etc. 2 64-bit full adder, logical gates, and muxes are used
// to perform specified tasks and update the outputs.

`timescale 1ns/10ps

module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	output logic [63:0] result;
	output logic negative, zero, overflow, carry_out;
	input  logic [63:0] A, B;
	input  logic [2:0]  cntrl;
	
	logic [7:0][63:0] alu_temp;
	//logic [1:0] temp_overflow, temp_carry;
	logic temp_overflow, temp_carry;
	
	//alu_temp[0]
	assign alu_temp[0] = B;
	assign alu_temp[1] = 0;
	//alu_temp[2]
	//fulladd_64 addOP (.A(A), .B(B), .R(alu_temp[2]), .SubFlag(0), .Cout(temp_carry[0]), .Overflow(temp_overflow[0]));
	fulladd_64 addOP (.A(A), .B(B), .R(alu_temp[2]), .SubFlag(cntrl[0]), .Cout(carry_out), .Overflow(overflow));
	//alu_temp[3]
	//fulladd_64 subOp (.A(A), .B(B), .R(alu_temp[3]), .SubFlag(1), .Cout(temp_carry[1]), .Overflow(temp_overflow[1]));
	assign alu_temp[3] = alu_temp[2];
	//assign alu_temp[3] = alu_temp[2];
	//alu_temp[4]
	and_64 andOp (.A(A), .B(B), .R(alu_temp[4]));
	//alu_temp[5]
	or_64  orOp  (.A(A), .B(B), .R(alu_temp[5]));
	//alu_temp[6]
	xor_64 xorOp (.A(A), .B(B), .R(alu_temp[6]));
	//alu_temp[7]
	assign alu_temp[7] = 0;
	//mult mulOp (.A(A), .B(B), .doSigned(1'b1), .mult_low(alu_temp[7]), .mult_high());

	// Set overflow flag
	//mux2_1 mux1 (.out(overflow), .i0(temp_overflow[0]), .i1(temp_overflow[1]), .sel(cntrl[0]));
	// Set carry_out
	//mux2_1 mux2 (.out(carry_out), .i0(temp_carry[0]), .i1(temp_carry[1]), .sel(cntrl[0]));
	
	// Use 8:1 mux to choose the correct 'result' according to 'cntrl'
	mux64x8_1 mux64 (.DataOut(result), .DataIn(alu_temp), .cntrl(cntrl));
	
	// Set negative flag
	assign negative = result[63];
	
	// Set zero flag
	zero_flag zero_1 (.zero(zero), .R(result));
endmodule