// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module is built on 4 register_4. 
// It takes 16-bit input DataIn, 1-bit value reset, clk, and WriEn,
// and returns 16-bit output Dataout based on reset and WriteEn, 
// when reset = 0 and WriteEn = 1, the DataOut will be updated to DataIn.

`timescale 1ns/10ps

module register_16 (DataIn, DataOut, WriteEn, clk, reset);
  output logic [15:0] DataOut;  // 16-bit output data
  input  logic [15:0] DataIn;   // 16-bit input data
  input  logic WriteEn; 		  // Write Enable flag
  input  logic clk, reset;      // reset and clock

  
  // 4 4-bit registers, each represents 4 bits data in the register
  register_4 reg4_0 (.DataIn(DataIn[3:0]),   .DataOut(DataOut[3:0]),    .WriteEn(WriteEn),  .clk(clk), .reset(reset));
  register_4 reg4_1 (.DataIn(DataIn[7:4]),   .DataOut(DataOut[7:4]),    .WriteEn(WriteEn),  .clk(clk), .reset(reset));
  register_4 reg4_2 (.DataIn(DataIn[11:8]),  .DataOut(DataOut[11:8]),   .WriteEn(WriteEn),  .clk(clk), .reset(reset));
  register_4 reg4_3 (.DataIn(DataIn[15:12]), .DataOut(DataOut[15:12]),  .WriteEn(WriteEn),  .clk(clk), .reset(reset));
  
endmodule

module register_16_testbench();
   parameter ClockDelay = 50;
	
	logic [15:0] DataOut;
	logic [15:0] DataIn;
	logic reset, clk, WriteEn;
	
	register_16 dut (.DataIn, .DataOut, .WriteEn, .clk, .reset);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	initial begin
	   DataIn <= 16'b0000000000000000; WriteEn <= 0; reset <= 1; #ClockDelay;
		DataIn <= 16'b0000000000000000; WriteEn <= 0; reset <= 0; #ClockDelay;
		DataIn <= 16'b0000000011001100; WriteEn <= 0; #ClockDelay;
		DataIn <= 16'b0011001000000000; WriteEn <= 1; #ClockDelay;
		DataIn <= 16'b0110010000010000; WriteEn <= 0; #ClockDelay;
		DataIn <= 16'b0100100010001001; WriteEn <= 1; #ClockDelay;
		
		$stop;
	end
endmodule
