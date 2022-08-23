// EE 469 LAB3
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the top module that works as a single cycle CPU. It uses the control module to decode the instructions from instruction memory and produces
// the required control signals and inputs for the datapath. It wires these signals and inputs to the register files, ALUs, muxes, etc. and performs the
// corresponding operations to update register data, the mememory, and the instruction memory address.

`timescale 1ns/10ps
module cpu_single(reset, clk);
	input logic reset;
	input logic clk;
	logic Reg2Loc, RegWrite, MemWrite, BrTaken, UnConBr, SetFlag, MemRead, zero, negative, overflow, carryout, ALUSrc, ImmAdd, SFTDir;
	logic adder1_carryout, adder2_carryout;
	logic NewNegative, NewZero, NewOverflow, NewCarryout;
	logic [1:0]    RegWrSrc;
	logic [2:0] 	ALUOp;
	logic [4:0] 	Rd, Rn, Rm;
	logic [4:0] 	Rd_Rm;
	logic [5:0] 	SHAMT;
	
	logic [8:0] 	Imm9;
	logic [11:0] 	Imm12;
	logic [18:0] 	Imm19;
	logic [25:0] 	Imm26;
	logic [63:0]	SE9;
	logic [63:0]	ZE12;
	logic [63:0]	SE19;
	logic [63:0]	SE26;
	
	logic [31:0]	instruction;
	
	logic [63:0]	RegWriteData;
	logic [63:0]	BrTakenMUX_out;
	logic [63:0]	UnCondBrMUX_out;	
	logic [63:0]	shifter1_out;	
	logic [63:0]	shifter2_out;
	logic [63:0]	adder1_out;
	logic [63:0]	adder2_out;
	logic [63:0]	DataA;
	logic [63:0]	DataB;
	logic [63:0] 	ALU_in;
	logic [63:0] 	ALU_out;	
	logic [63:0] 	datamem_out;
	logic [63:0]	PC;
	logic [63:0]	final_PC;
	logic [63:0] 	const_src;
	logic [63:0]   MUL_out;
	
	
	// initialize PC / reset PC + update PC
	mux64x2_1 SetUpPC (final_PC, BrTakenMUX_out, 64'b0, reset);
	DFF64 UpdatePC (PC, final_PC, clk, 1'b1);
	
	// sign extensions
	signExtend19 SE_19 (SE19, Imm19);
	signExtend26 SE_26 (SE26, Imm26);
	zeroExtend12 ZE_12 (ZE12, Imm12);
	signExtend9  SE_9  (SE9, Imm9);
	
	// unconditional branch  /checked
	mux64x2_1 UnConBrMUX (UnCondBrMUX_out, SE19, SE26, UnConBr);
	shifter shifter1 (UnCondBrMUX_out, 1'b0, 6'b000010, shifter1_out);
	fulladd_64 adder1 (.A(PC), .B(shifter1_out), .R(adder1_out), .SubFlag(1'b0), .Cout(adder1_carryout), .Overflow());
	
	// PC = PC + 4
	fulladd_64 adder2 (.A(PC), .B(64'h0000000000000004), .R(adder2_out), .SubFlag(1'b0), .Cout(adder2_carryout), .Overflow());
	
	// branch taken mux  /checked
	mux64x2_1 BrTakenMUX (BrTakenMUX_out, adder2_out, adder1_out, BrTaken);
	
	// instruction fetch
	instructmem fetch (.address(PC), .instruction, .clk);  // Use current PC to get the instruction
	control instructionDecode (Rd, Rn, Rm, Reg2Loc, ALUSrc, ALUOp, RegWrite, MemWrite, BrTaken, UnConBr, SetFlag, RegWrSrc, MemRead, Imm9, Imm12,
					 Imm19, Imm26, SHAMT, instruction, zero, negative, overflow, carryout, NewZero, NewNegative, NewOverflow, NewCarryout, ImmAdd, SFTDir);
	
	// register file  /checked
	mux5x2_1 RdRm (Rd_Rm, Rd, Rm, Reg2Loc); // chose from Rd or Rm as input read register
	regfile regdata (.ReadData1(DataA), .ReadData2(DataB), .WriteData(RegWriteData), .ReadRegister1(Rn), .ReadRegister2(Rd_Rm), .WriteRegister(Rd), .RegWrite(RegWrite), .clk(clk));
	
	// ALU
	//mux64x4_1 ALUSrcMUX (.out(ALU_in), .A(DataB), .B(SE9), .C(ZE12), .D(64'bX), .sel(ALUSrc));
	mux64x2_1 ImmAddMUX (.DataOut(const_src), .DataIn_A(SE9), .DataIn_B(ZE12), .sel(ImmAdd));
	mux64x2_1 ALUSrcMUX (.DataOut(ALU_in), .DataIn_A(DataB), .DataIn_B(const_src), .sel(ALUSrc));
	alu alu1 (.A(DataA), .B(ALU_in), .cntrl(ALUOp), .result(ALU_out), .negative(NewNegative), .zero(NewZero), .overflow(NewOverflow), .carry_out(NewCarryout));
	
	// flags
	SetFlag SetNegative 	(.q(negative), .d(NewNegative), .clk, .enable(SetFlag));
	SetFlag SetZero		(.q(zero), .d(NewZero), .clk, .enable(SetFlag));
	SetFlag SetOverflow	(.q(overflow), .d(NewOverflow), .clk, .enable(SetFlag));
	SetFlag SetCarryout	(.q(carryout), .d(NewCarryout), .clk, .enable(SetFlag));
	
	// shifter
	shifter shifter2 (.value(DataA), .direction(SFTDir), .distance(SHAMT), .result(shifter2_out));
	
	// Mult
	mult mulOp (.A(DataA), .B(DataB), .doSigned(1'b1), .mult_low(MUL_out), .mult_high());
	
	// data memory
	datamem data (.address(ALU_out), .write_enable(MemWrite), .read_enable(MemRead), .write_data(DataB), .clk, .xfer_size(4'b1000), .read_data(datamem_out));
	
	// determine data to regfile : datamem_out/mult/alu/shifter <=> 00/01/10/11
	mux64x4_1 RegWrSrcMUX (.out(RegWriteData), .A(datamem_out), .B(MUL_out), .C(ALU_out), .D(shifter2_out), .sel(RegWrSrc));
	
endmodule

module cpu_single_testbench();

	parameter delay = 10000;

	logic reset;
	logic clk;

	cpu_single dut (.reset, .clk);

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

	