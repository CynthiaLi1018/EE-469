// EE 469 LAB4
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This module represents the execution stage of a 5-stage-pipelined CPU. It receives control signal for ALU operation,
// flag updates, data to perform math operations.
// It produces and updates all the flags, and the result for ALU, shifter and multiplier. Buffer are used to hold the data and signals
// needed for later stages, and the forwarding unit.

`timescale 1ns/10ps
module Exec_Stage(reset, clk, DataA_Reg, DataB_Reg, ALU_in_Reg, SHAMT_Reg, SFTDir_Reg, SetFlag_Reg, ALUOp_Reg, // Pipelined data and signals from RegDec stage, used in current Exec stage
						MemWrite_Reg, MemRead_Reg, RegWrite_Reg, RegWrSrc_Reg, Rd_Reg,											// Pipelined data and singals from RegDec stage, used in later stages
						zero, negative, overflow, carryout, NewZero, NewNegative, NewOverflow, NewCarryout,				// output the old flags from the buffer and the new flags from current cycle execution
						ALU_out, shifter2_out, MUL_out,																					// output data from current cycle execution needed for forwarding unit
						ALU_out_Ex, shifter2_out_Ex, MUL_out_Ex,																		// pipelined data result from math operations, transfer to later Mem stage
						MemWrite_Ex, MemRead_Ex, RegWrite_Ex, RegWrSrc_Ex, Rd_Ex, DataB_Ex);									// pipelined control signal and data out from Exec stage
						
	input logic reset;
	input logic clk;
	
	//control signal
	input logic SFTDir_Reg, SetFlag_Reg; 
	input logic [2:0] 	ALUOp_Reg;
	
	//input data
	input logic [5:0] 	SHAMT_Reg;
	input logic [63:0]	DataA_Reg;
	input logic [63:0]	DataB_Reg;
	input logic [63:0] 	ALU_in_Reg;
	
	//control signal to buffer
	input logic MemWrite_Reg, MemRead_Reg, RegWrite_Reg;
	input logic [1:0] RegWrSrc_Reg;
	input logic [4:0] Rd_Reg;
	
	output logic [63:0] 	ALU_out, shifter2_out, MUL_out;

	output logic [63:0] 	ALU_out_Ex, shifter2_out_Ex, MUL_out_Ex;
	output logic zero, negative, overflow, carryout;
	output logic NewNegative, NewZero, NewOverflow, NewCarryout;
	
	
	//control signal from buffer
	output logic MemWrite_Ex, MemRead_Ex, RegWrite_Ex;
	output logic [1:0] RegWrSrc_Ex;
	output logic [4:0] Rd_Ex;
	output logic [63:0] DataB_Ex;
	
	
	// ALU
	alu alu1 (.A(DataA_Reg), .B(ALU_in_Reg), .cntrl(ALUOp_Reg), .result(ALU_out), .negative(NewNegative), .zero(NewZero), .overflow(NewOverflow), .carry_out(NewCarryout));
	
	// flags
	SetFlag SetNegative 	(.q(negative), .d(NewNegative), .clk, .enable(SetFlag_Reg));
	SetFlag SetZero		(.q(zero), .d(NewZero), .clk, .enable(SetFlag_Reg));
	SetFlag SetOverflow	(.q(overflow), .d(NewOverflow), .clk, .enable(SetFlag_Reg));
	SetFlag SetCarryout	(.q(carryout), .d(NewCarryout), .clk, .enable(SetFlag_Reg));

	// shifter
	shifter shifter2 (.value(DataA_Reg), .direction(SFTDir_Reg), .distance(SHAMT_Reg), .result(shifter2_out));
	
	// Mult
	mult mulOp (.A(DataA_Reg), .B(DataB_Reg), .doSigned(1'b1), .mult_low(MUL_out), .mult_high());
	
	// buffers
	D_FF buffer1 (.q(MemWrite_Ex),   .d(MemWrite_Reg),   .reset(reset), .clk(clk));
	D_FF buffer2 (.q(MemRead_Ex),    .d(MemRead_Reg),    .reset(reset), .clk(clk));
	D_FF buffer3 (.q(RegWrite_Ex),   .d(RegWrite_Reg),   .reset(reset), .clk(clk));
	
	D_FF buffer4 (.q(RegWrSrc_Ex[0]), .d(RegWrSrc_Reg[0]), .reset(reset), .clk(clk));
	D_FF buffer5 (.q(RegWrSrc_Ex[1]), .d(RegWrSrc_Reg[1]), .reset(reset), .clk(clk));
	
	register_64 buffer6 (.DataIn(DataB_Reg), .DataOut(DataB_Ex), .WriteEn(1'b1), .clk(clk), .reset(reset));
	 
	D_FF buffer7  (.q(Rd_Ex[0]), .d(Rd_Reg[0]), .reset(reset), .clk(clk));
	D_FF buffer8  (.q(Rd_Ex[1]), .d(Rd_Reg[1]), .reset(reset), .clk(clk));
	D_FF buffer9  (.q(Rd_Ex[2]), .d(Rd_Reg[2]), .reset(reset), .clk(clk));
	D_FF buffer10 (.q(Rd_Ex[3]), .d(Rd_Reg[3]), .reset(reset), .clk(clk));
	D_FF buffer11 (.q(Rd_Ex[4]), .d(Rd_Reg[4]), .reset(reset), .clk(clk));
	
	register_64 buffer12 (.DataIn(ALU_out),      .DataOut(ALU_out_Ex),      .WriteEn(1'b1), .clk(clk), .reset(reset));
	register_64 buffer13 (.DataIn(shifter2_out), .DataOut(shifter2_out_Ex), .WriteEn(1'b1), .clk(clk), .reset(reset));
	register_64 buffer14 (.DataIn(MUL_out),      .DataOut(MUL_out_Ex),      .WriteEn(1'b1), .clk(clk), .reset(reset));
	
endmodule
