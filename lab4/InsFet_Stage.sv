// EE 469 LAB4
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This module represents the instruction fetch of a 5-stage pipelined CPU. It performs PC+4, obtains the instruction
// from instruction memory, and passes instruction and PC through register buffer. It outputs the updated PC,
// the instruction to decode (instruction_IF) and the instruction fetch control signal (buffered PC: PC_IF).

`timescale 1ns/10ps
module InsFet_Stage(reset, clk, PC,							  // current PC needed for instruction fetch
						  instruction_IF, PC_plus_4, PC_IF);  // pipelined instruction and PC out from IF stage
	input logic reset, clk;
	input logic [63:0] PC;
	
	logic [31:0] instruction;
	output logic [63:0] PC_plus_4;

	output logic [31:0] instruction_IF;
	output logic [63:0] PC_IF;

	// PC = PC + 4
	fulladd_64 adder2 (.A(PC), .B(64'h0000000000000004), .R(PC_plus_4), .SubFlag(1'b0), .Cout(), .Overflow());

	// instruction fetch
	instructmem fetch (.address(PC), .instruction, .clk);  // Use current PC to get the instruction

	
   // buffers  Instruction, PC
	register_32 buffer1 (.DataIn(instruction), .DataOut(instruction_IF), .WriteEn(1'b1), .clk(clk), .reset(reset));
	register_64 buffer2 (.DataIn(PC),        .DataOut(PC_IF),        .WriteEn(1'b1), .clk(clk), .reset(reset));
	//register_64 buffer3 (.DataIn(PC_plus_4), .DataOut(PC_plus_4_IF), .WriteEn(1'b1), .clk(clk), .reset(reset));
	
	
endmodule
