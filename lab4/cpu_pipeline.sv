// EE 469 LAB4
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the top module that works as a 5-stage pipelining CPU. It uses the control module to decode the instructions from
// instruction memory and produces the required control signals and inputs for the datapath. It wires these signals and inputs
// to the register files, ALUs, muxes, etc. and performs the corresponding operations to update register data, the mememory,
// and the instruction memory address.

`timescale 1ns/10ps
module cpu_pipeline(reset, clk);
	input logic reset;
	input logic clk;
	logic ALUSrc_Reg, RegWrite_Reg, MemWrite_Reg, SetFlag_Reg, MemRead_Reg, SFTDir_Reg;
	logic RegWrite_Ex, MemWrite_Ex, MemRead_Ex;
	logic RegWrite_Mem;
	logic adder1_carryout, adder2_carryout;
	logic NewNegative, NewZero, NewOverflow, NewCarryout;
	logic [1:0]    RegWrSrc, RegWrSrc_Reg, RegWrSrc_Ex, RegWrSrc_Mem;
	logic [2:0] 	ALUOp, ALUOp_Reg;
	logic [4:0] 	Rd, Rn, Rm;
	logic [4:0] 	Rd_Rm;
	logic [5:0] 	SHAMT, SHAMT_Reg;

	logic [63:0]	SE9;
	logic [63:0]	ZE12;
	logic [63:0]	SE19;
	logic [63:0]	SE26;
	
	logic [31:0]	instruction_IF;
	
	logic [63:0]	RegWriteData, RegWriteData_Mem;
	logic [63:0]	PC_plus_4, PC_IF;
	logic [63:0]	DataA_Reg, DataB_Reg, ALU_in_Reg;
	logic [63:0]	DataB_Ex;
	logic [63:0] 	datamem_out;
	logic [63:0]	PC;
	logic [63:0] 	const_src;
	logic [63:0]   ALU_out, shifter2_out, MUL_out;
	logic [63:0]   ALU_out_Ex, shifter2_out_Ex, MUL_out_Ex;
	
	logic [4:0] Rd_Reg, Rd_Ex, Rd_Mem;
	logic 		Cycle2_FW_A, Cycle2_FW_B;
	logic [1:0] Cycle1_FW_A, Cycle1_FW_B;
	

	InsFet_Stage stage1 (reset, clk, PC, 						  // current PC needed for instruction fetch
								instruction_IF, PC_plus_4, PC_IF); // pipelined instruction and PC out from IF stage

	RegDec_Stage stage_2_5 (reset, clk, PC_plus_4, instruction_IF, PC_IF, // pipelined data from IF stage, and PC_plus_4
								   RegWriteData, ALU_out, shifter2_out, MUL_out, // forwarding data from Ex and Mem stage
				 				   RegWrite_Ex, Rd_Ex, RegWrSrc_Ex,					 // signals for forwarding control
									RegWriteData_Mem, RegWrite_Mem, Rd_Mem, 		 // Data and signals for Write stage
								   zero, negative, overflow, carryout, NewZero, NewNegative, NewOverflow, NewCarryout, // flags for determining control signals
								   PC, DataA_Reg, DataB_Reg, ALU_in_Reg,			 // updated PC, and the pipelined data
								   RegWrite_Reg, MemWrite_Reg, SetFlag_Reg, MemRead_Reg, SFTDir_Reg, RegWrSrc_Reg, ALUOp_Reg, SHAMT_Reg, Rd_Reg);	// pipelined control signals out from RegDec stage				

   Exec_Stage stage3 (reset, clk, DataA_Reg, DataB_Reg, ALU_in_Reg, SHAMT_Reg, SFTDir_Reg, SetFlag_Reg, ALUOp_Reg, // Pipelined data and signals from RegDec stage, used in current Exec stage
							 MemWrite_Reg, MemRead_Reg, RegWrite_Reg, RegWrSrc_Reg, Rd_Reg,										 // Pipelined data and singals from RegDec stage, used in later stages
							 zero, negative, overflow, carryout, NewZero, NewNegative, NewOverflow, NewCarryout,			 // output the old flags from the buffer and the new flags from current cycle execution
							 ALU_out, shifter2_out, MUL_out,																					 // output data from current cycle execution needed for forwarding unit
							 ALU_out_Ex, shifter2_out_Ex, MUL_out_Ex,																		 // pipelined data result from math operations, transfer to later Mem stage
							 MemWrite_Ex, MemRead_Ex, RegWrite_Ex, RegWrSrc_Ex, Rd_Ex, DataB_Ex);							    // pipelined control signal and data out from Exec stage

   Mem_Stage stage4 (reset, clk, MemWrite_Ex, MemRead_Ex, ALU_out_Ex, shifter2_out_Ex, MUL_out_Ex, DataB_Ex, RegWrSrc_Ex, // Pipelined data and signals from Exec stage, used in current Mem stage
						   RegWrite_Ex, Rd_Ex, 	  // Pipelined data and singals from Exec stage, used in later stages
						   RegWriteData,			  // output data from current cycle execution needed for forwarding unit																										  
							RegWriteData_Mem, 	  // output data to be writen into regfile in Write stage
						   RegWrite_Mem, Rd_Mem); // pipelined control signal output from Men stage buffers
endmodule

module cpu_pipeline_testbench();

	parameter delay = 8000;

	logic reset;
	logic clk;

	cpu_pipeline dut (.reset, .clk);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(delay/2) clk <= ~clk;
	end
	
	integer i;
	initial begin
	   $display("%t testing branchmark ", $time);
		reset <= 0; @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		for (i = 0; i<800; i++) begin
			@(posedge clk);
		end
		$stop;
	end
	
endmodule

	