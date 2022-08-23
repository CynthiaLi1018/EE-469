// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module is built on 4 register_16. 
// It takes 64-bit input DataIn, 1-bit value reset, clk, and WriEn,
// and returns 64-bit output Dataout based on reset and WriteEn, 
// when reset = 0 and WriteEn = 1, the DataOut will be updated to DataIn.


`timescale 1ns/10ps

module register_64 (DataIn, DataOut, WriteEn, clk, reset);
  output logic [63:0] DataOut;  // 64-bit output data
  input  logic [63:0] DataIn;   // 64-bit input data
  input  logic WriteEn; 		  // Write Enable flag
  input  logic clk, reset;      // reset and clock
  
  // 4 16-bit registers, each represents 16 bits data in the register
  register_16 reg16_0 (.DataIn(DataIn[15:0]),    .DataOut(DataOut[15:0]),    .WriteEn(WriteEn),  .clk(clk), .reset(reset));
  register_16 reg16_1 (.DataIn(DataIn[31:16]),   .DataOut(DataOut[31:16]),   .WriteEn(WriteEn),  .clk(clk), .reset(reset));
  register_16 reg16_2 (.DataIn(DataIn[47:32]),   .DataOut(DataOut[47:32]),   .WriteEn(WriteEn),  .clk(clk), .reset(reset));
  register_16 reg16_3 (.DataIn(DataIn[63:48]),   .DataOut(DataOut[63:48]),   .WriteEn(WriteEn),  .clk(clk), .reset(reset));
  
endmodule

module register_64_testbench();
   parameter ClockDelay = 50;
	
	logic [63:0] DataOut;
	logic [63:0] DataIn;
	logic reset, clk, WriteEn;
	
	register_64	dut (.DataIn, .DataOut, .WriteEn, .clk, .reset);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	initial begin
	   DataIn <= 64'h0000000000000000; WriteEn <= 0; reset <= 1; #ClockDelay;
		DataIn <= 64'h0000000000000000; WriteEn <= 0; reset <= 0; #ClockDelay;
		DataIn <= 64'h00A0000000FFF000; WriteEn <= 0; #ClockDelay;
		DataIn <= 64'h000D00001000C0A0; WriteEn <= 1; #ClockDelay;
		DataIn <= 64'h0000D00C00F0F000; WriteEn <= 0; #ClockDelay;
		DataIn <= 64'h00000D00A0007700; WriteEn <= 1; #ClockDelay;
		#ClockDelay;
		$stop;
	end
endmodule