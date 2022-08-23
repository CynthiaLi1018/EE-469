// EE 469 LAB3
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is module tests whether the 32-bit instruction contains the op code of each instructions, after determining the instruction, it ouputs
// the corresponding datapath control signals, the regFile inputs and the addresses.

`timescale 1ns/10ps
module control (instruction, 
					zero, negative, overflow, carryout, NewZero, NewNegative, NewOverflow, NewCarryout, DataB_zero,
					Rd_Reg, Rd_Ex, RegWrite_Reg, RegWrite_Ex, RegWrSrc_Reg, SetFlag_Reg,
					RegReadA, RegReadB,
					Reg2Loc, RegWrite, MemWrite, BrTaken, UnConBr, SetFlag, MemRead, ALUSrc, ImmAdd, SFTDir, RegWrSrc, ALUOp,
					Cycle2_FW_A, Cycle2_FW_B, Cycle1_FW_A, Cycle1_FW_B);
					
	input logic [31:0] instruction;
	input logic [4:0]  Rd_Reg, Rd_Ex, RegReadA, RegReadB;
	input logic [1:0]  RegWrSrc_Reg;
	input logic RegWrite_Reg, RegWrite_Ex, SetFlag_Reg;
	input logic zero, negative, overflow, carryout, NewZero, NewNegative, NewOverflow, NewCarryout, DataB_zero;
	
	output logic Reg2Loc, RegWrite, MemWrite, BrTaken, UnConBr, SetFlag, MemRead, ALUSrc, ImmAdd, SFTDir;
	output logic [1:0] RegWrSrc;
	output logic [2:0] ALUOp;
	
	output logic Cycle2_FW_A, Cycle2_FW_B;
	output logic [1:0] Cycle1_FW_A, Cycle1_FW_B;
	
	parameter ADDI = 	10'b1001000100;          // 0x244
	parameter ADDS =	11'b10101011000;         // 0x558
	parameter B = 		6'b000101;               // 0x05;
	parameter BLT =	8'b01010100;             // 0x54 to choose B.cond
	parameter CBZ = 	8'b10110100;             // 0xB4
	parameter LDUR = 	11'b11111000010;         // 0x7c2
	parameter LSL = 	11'b11010011011;			 // 0x69b
	parameter LSR = 	11'b11010011010;         // 0x69a
	parameter MUL =   11'b10011011000;		 	 // 0x4D8, shamt = 0x1F
	parameter STUR = 	11'b11111000000;         // 0x7c0
	parameter SUBS = 	11'b11101011000;         // 0x758

	
	// cntrl				instruction
	// 000:				result = B
	// 010:				result = A+B
	// 011:				result = A-B
	// 100:				result = A & B
	// 101:				result = A | B
	// 110:				result = A XOR B
	// 111:				result = (A * B)[63:0]
	
	//logic [14:0] control;
	
	//assign control = {Reg2Loc, ImmAdd, ALUSrc, RegWrSrc, RegWrite, MemWrite, SetFlag, BrTaken, UnConBr, ALU0p, MemRead, SFTDir};
	
	always_comb begin
		if (instruction[31:22] == ADDI) begin
			assign Reg2Loc  = 1'bx;
			assign ImmAdd   = 1'b1;
			assign ALUSrc   = 1'b1;
			assign RegWrSrc  = 2'b01;
			assign RegWrite  = 1'b1;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b0;
			assign BrTaken   = 1'b0;
			assign UnConBr   = 1'bx;
			assign ALUOp     = 3'b010; //add
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'bx;
		end
		else if (instruction[31:21] == ADDS) begin
			assign Reg2Loc  = 1'b1;
			assign ImmAdd   = 1'bx;
			assign ALUSrc   = 1'b0;
			assign RegWrSrc  = 2'b01;
			assign RegWrite  = 1'b1;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b1;
			assign BrTaken   = 1'b0;
			assign UnConBr   = 1'bx;
			assign ALUOp     = 3'b010; //add
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'bx;
		end
		else if (instruction[31:26] == B) begin
			assign Reg2Loc  = 1'bx;
			assign ImmAdd   = 1'bx;
			assign ALUSrc   = 1'bx;
			assign RegWrSrc  = 2'bxx;
			assign RegWrite  = 1'b0;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b0;
			assign BrTaken   = 1'b1;
			assign UnConBr   = 1'b1;
			assign ALUOp     = 3'bxxx; //don't care
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'bx;
		end
		else if (instruction[31:24] == BLT && instruction[4:0] == 5'b01011 && SetFlag_Reg == 1) begin
			assign Reg2Loc  = 1'bx;
			assign ImmAdd   = 1'bx;
			assign ALUSrc   = 1'bx;
			assign RegWrSrc  = 2'bxx;
			assign RegWrite  = 1'b0;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b0;
			assign BrTaken   = (NewOverflow != NewNegative);  // Changed for pipeline
			assign UnConBr   = 1'b0;
			assign ALUOp     = 3'bxxx; //don't care
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'bx;
		end
		else if (instruction[31:24] == BLT && instruction[4:0] == 5'b01011 && SetFlag_Reg == 0) begin
			assign Reg2Loc  = 1'bx;
			assign ImmAdd   = 1'bx;
			assign ALUSrc   = 1'bx;
			assign RegWrSrc  = 2'bxx;
			assign RegWrite  = 1'b0;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b0;
			assign BrTaken   = (overflow != negative);  // Changed for pipeline
			assign UnConBr   = 1'b0;
			assign ALUOp     = 3'bxxx; //don't care
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'bx;
		end
		else if (instruction[31:24] == CBZ) begin
			assign Reg2Loc  = 1'b0;
			assign ImmAdd   = 1'bx;
			assign ALUSrc   = 1'b0;
			assign RegWrSrc  = 2'bxx;
			assign RegWrite  = 1'b0;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b0;
			assign BrTaken   = DataB_zero;  //Changed for pipeline
			assign UnConBr   = 1'b0;
			assign ALUOp     = 3'b000;  // B bypass
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'bx;
		end
		else if (instruction[31:21] == LDUR) begin
			assign Reg2Loc  = 1'bx;
			assign ImmAdd   = 1'b0;
			assign ALUSrc   = 1'b1;
			assign RegWrSrc  = 2'b11;
			assign RegWrite  = 1'b1;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b0;
			assign BrTaken   = 1'b0;
			assign UnConBr   = 1'bx;
			assign ALUOp     = 3'b010; //add
			assign MemRead   = 1'b1;
			assign SFTDir    = 1'bx;
		end
		else if (instruction[31:21] == LSL) begin
			assign Reg2Loc  = 1'bx;
			assign ImmAdd   = 1'bx;
			assign ALUSrc   = 1'bx;
			assign RegWrSrc  = 2'b00;
			assign RegWrite  = 1'b1;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b0;
			assign BrTaken   = 1'b0;
			assign UnConBr   = 1'bx;
			assign ALUOp     = 3'bxxx;  // don't care
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'b0;
		end
		else if (instruction[31:21] == LSR) begin
			assign Reg2Loc  = 1'bx;
			assign ImmAdd   = 1'bx;
			assign ALUSrc   = 1'bx;
			assign RegWrSrc  = 2'b00;
			assign RegWrite  = 1'b1;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b0;
			assign BrTaken   = 1'b0;
			assign UnConBr   = 1'bx;
			assign ALUOp     = 3'bxxx;  // don't care
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'b1;
		end 
		else if (instruction[31:21] == MUL) begin
			assign Reg2Loc  = 1'b1;
			assign ImmAdd   = 1'bx;
			assign ALUSrc   = 1'bx;
			assign RegWrSrc  = 2'b10;
			assign RegWrite  = 1'b1;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b0;
			assign BrTaken   = 1'b0;
			assign UnConBr   = 1'bx;
			assign ALUOp     = 3'bxxx;  // don't care
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'bx;
		end 
		else if (instruction[31:21] == STUR) begin
			assign Reg2Loc  = 1'b0;
			assign ImmAdd   = 1'b0;
			assign ALUSrc   = 1'b1;
			assign RegWrSrc  = 2'bxx;
			assign RegWrite  = 1'b0;
			assign MemWrite  = 1'b1;
			assign SetFlag   = 1'b0;
			assign BrTaken   = 1'b0;
			assign UnConBr   = 1'bx;
			assign ALUOp     = 3'b010; // add
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'bx;
		end
		else if (instruction[31:21] == SUBS) begin
			assign Reg2Loc  = 1'b1;
			assign ImmAdd   = 1'bx;
			assign ALUSrc   = 1'b0;
			assign RegWrSrc  = 2'b01;
			assign RegWrite  = 1'b1;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b1;
			assign BrTaken   = 1'b0;
			assign UnConBr   = 1'bx;
			assign ALUOp     = 3'b011; // subtract
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'bx;
		end
		else begin
			//control = 15'b0;
			assign Reg2Loc  = 1'b0;
			assign ImmAdd   = 1'b0;
			assign ALUSrc   = 1'b0;
			assign RegWrSrc  = 2'b00;
			assign RegWrite  = 1'b0;
			assign MemWrite  = 1'b0;
			assign SetFlag   = 1'b0;
			assign BrTaken   = 1'b0;
			assign UnConBr   = 1'b0;
			assign ALUOp     = 3'b000;
			assign MemRead   = 1'b0;
			assign SFTDir    = 1'b0;
		end
		
		// DataA forwarding from 2 cycle before
		if (RegReadA == Rd_Ex && Rd_Ex != 5'b11111 && RegWrite_Ex == 1'b1) begin
			assign Cycle2_FW_A = 1'b1;
		end
		else begin
			assign Cycle2_FW_A = 1'b0;
		end

//		assign Cycle2_FW_A = (Rn == Rd_Mem && Rd_Mem != 5'b11111 && RegWrite_Mem == 1'b1);
		
		// DataB forwarding from 2 cycle before
		if (RegReadB == Rd_Ex && Rd_Ex != 5'b11111 && RegWrite_Ex == 1'b1) begin
			assign Cycle2_FW_B = 1'b1;
		end
		else begin
			assign Cycle2_FW_B = 1'b0;
		end
		
		// DataA forwarding from 1 cycle before
		if (RegReadA == Rd_Reg && Rd_Reg != 5'b11111 && RegWrite_Reg == 1'b1) begin
			assign Cycle1_FW_A = RegWrSrc_Reg;
		end
		else begin
			assign Cycle1_FW_A = 2'b11;
		end
		
		// DataB forwarding from 1 cycle before
		if (RegReadB == Rd_Reg && Rd_Reg != 5'b11111 && RegWrite_Reg == 1'b1) begin
			assign Cycle1_FW_B = RegWrSrc_Reg;
		end
		else begin
			assign Cycle1_FW_B = 2'b11;
		end
	end
endmodule

module control_testbench();
	logic [31:0] instruction;
	logic zero, negative, overflow, carryout, NewZero, NewNegative, NewOverflow, NewCarryout;
	
	logic Reg2Loc, RegWrite, MemWrite, BrTaken, UnConBr, SetFlag, MemRead, ALUSrc, ImmAdd, SFTDir;
	logic [1:0] RegWrSrc;
	logic [2:0] ALU0p;
	logic [4:0] Rd, Rn, Rm;
	logic [8:0] Imm9;
	logic [11:0] Imm12;
	logic [18:0] Imm19;
	logic [25:0] Imm26;
	logic [5:0] SHAMT;
	
	control dut (Rd, Rn, Rm, Reg2Loc, ALUSrc, ALU0p, RegWrite, MemWrite, BrTaken, UnConBr, SetFlag, RegWrSrc, MemRead, Imm9, Imm12,
					 Imm19, Imm26, SHAMT, instruction, zero, negative, overflow, carryout, NewZero, NewNegative, NewOverflow, NewCarryout, ImmAdd, SFTDir);
	
	integer i;
	initial begin
	   zero <= 0; negative <= 0; overflow <= 0; carryout <= 0; NewZero <= 0; NewNegative <= 0; NewOverflow <= 0; NewCarryout <= 0;
		// addi
		instruction <= 32'b10010001000000000000001111100000; #10; // ADDI X0, X31, #0 
		instruction <= 32'b10010001000000000000010000000001; #10; // ADDI X1, X0, #1
		instruction <= 32'b10010001000000000000100000100011; #10; // ADDI X3, X1, #2 
		// subs
		instruction <= 32'b11101011000000100000000000100011; #10; // SUBS X3, X1, X2  
		// adds
		instruction <= 32'b10101011000001000000000001100101; #10; // ADDS X5, X3, X4
		// B
		instruction <= 32'b00010111111111111111111111111111; #10; // B ERROR 
		// BLT
		//11101011000_00000_000000_11111_11111   // SUBS X31, X31, X0
		instruction <= 32'b01010100000000000000000010001011; #10; //B.LT SUCCESS
		// CBZ
		instruction <= 32'b10110100111111111111111011011111; #10; // CBZ X31, BACKWARD_CBZ
		// STUR
		instruction <= 32'b11111000000000000000001111100000; #10; // STUR X0, [X31, #0]
		// LDUR
		instruction <= 32'b11111000010000000101000010000111; #10; // LDUR X7, [X4, #5]
		// LSL
		instruction <= 32'b11010011011000000011000000000001; #10; // LSL X1, X0, #12
		// LSR
		instruction <= 32'b11010011010000000001000000100010; #10; // LSR X2, X1, #4
		// MUL
		instruction <= 32'b10011011000000000111110000000100; #10; // MUL X4, X0, X0
	end
endmodule

		