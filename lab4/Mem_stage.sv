// EE 469 LAB4
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This module represents the memory access stage of a 5-stage-pipelined CPU. It receives buffered control signal for data memory's 
// reading and writing, and outputs the control signals for forwarding required for this stage. It performs the reading and writing
// in the data memory and selecting the data to be writen in Write stage. Buffers is used for pipeling the output data and signal needed for 
// forwarding unit and Write stage

`timescale 1ns/10ps
module Mem_Stage(reset, clk, MemWrite_Ex, MemRead_Ex, ALU_out_Ex, shifter2_out_Ex, MUL_out_Ex, DataB_Ex, RegWrSrc_Ex, // Pipelined data and signals from Exec stage, used in current Mem stage
					  RegWrite_Ex, Rd_Ex, 	  																									    // Pipelined data and singals from Exec stage, used in later stages
					  RegWriteData,																													 // output data from current cycle execution needed for forwarding unit
					  RegWriteData_Mem,																												 // output data to be writen into regfile in Write stage
					  RegWrite_Mem, Rd_Mem); 																										 // pipelined control signal output from Men stage buffers
					  
   input logic reset, clk;
	input logic MemWrite_Ex, MemRead_Ex;
	input logic [1:0] RegWrSrc_Ex;
	input logic [63:0] ALU_out_Ex, shifter2_out_Ex, MUL_out_Ex, DataB_Ex;
	
	// control signal to buffer
	input logic RegWrite_Ex;
	input logic [4:0] Rd_Ex;
	
	logic [63:0] datamem_out;
	
	output logic [63:0] RegWriteData_Mem, RegWriteData;
	
	//control signal from buffer
	output logic RegWrite_Mem;
	output logic [4:0] Rd_Mem;

	// data memory
	datamem data (.address(ALU_out_Ex), .write_enable(MemWrite_Ex), .read_enable(MemRead_Ex), .write_data(DataB_Ex), .clk, .xfer_size(4'b1000), .read_data(datamem_out));
	
	// determine data to regfile : shifter/mult/alu/datamem_out <=> 00/01/10/11
	mux64x4_1 RegWrSrcMUX (.out(RegWriteData), .A(datamem_out), .B(MUL_out_Ex), .C(ALU_out_Ex), .D(shifter2_out_Ex), .sel(RegWrSrc_Ex));
	
	// buffers
	D_FF buffer1 (.q(RegWrite_Mem),   .d(RegWrite_Ex),   .reset(reset), .clk(clk));
	
	register_64 buffer2 (.DataIn(RegWriteData), .DataOut(RegWriteData_Mem), .WriteEn(1'b1), .clk(clk), .reset(reset));
	
	D_FF buffer6  (.q(Rd_Mem[0]), .d(Rd_Ex[0]), .reset(reset), .clk(clk));
	D_FF buffer7  (.q(Rd_Mem[1]), .d(Rd_Ex[1]), .reset(reset), .clk(clk));
	D_FF buffer8  (.q(Rd_Mem[2]), .d(Rd_Ex[2]), .reset(reset), .clk(clk));
	D_FF buffer9  (.q(Rd_Mem[3]), .d(Rd_Ex[3]), .reset(reset), .clk(clk));
	D_FF buffer10 (.q(Rd_Mem[4]), .d(Rd_Ex[4]), .reset(reset), .clk(clk));

endmodule
