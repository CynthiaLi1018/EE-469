// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module is built on 4 DFF_E. 
// It takes 4-bit input DataIn, 1-bit value reset, clk, and WriEn,
// and returns 4-bit output Dataout based on reset and WriteEn, 
// when reset = 0 and WriteEn = 1, the DataOut will be updated to DataIn.

`timescale 1ns/10ps

module register_4 (DataIn, DataOut, WriteEn, clk, reset);
  output logic [3:0] DataOut;  // 4-bit output data
  input  logic [3:0] DataIn;   // 4-bit input data
  input  logic WriteEn; 		 // Write Enable flag
  input  logic clk, reset;      // reset and clock

  
  // 4 DFF_E, each represents 1 bit in the register
  DFF_E dff0 (.q(DataOut[0]), .d(DataIn[0]), .reset(reset), .clk(clk), .WriEn(WriteEn));
  DFF_E dff1 (.q(DataOut[1]), .d(DataIn[1]), .reset(reset), .clk(clk), .WriEn(WriteEn));
  DFF_E dff2 (.q(DataOut[2]), .d(DataIn[2]), .reset(reset), .clk(clk), .WriEn(WriteEn));
  DFF_E dff3 (.q(DataOut[3]), .d(DataIn[3]), .reset(reset), .clk(clk), .WriEn(WriteEn));
  
endmodule

module register_4_testbench();
   parameter ClockDelay = 50;
	
	logic [3:0] DataOut;
	logic [3:0] DataIn;
	logic reset, clk, WriteEn;
	
	register_4 dut (.DataIn, .DataOut, .WriteEn, .clk, .reset);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	initial begin
	   DataIn <= 4'b0000; WriteEn <= 0; reset <= 1; #ClockDelay;
		DataIn <= 4'b0000; WriteEn <= 0; reset <= 0; #ClockDelay;
		DataIn <= 4'b0010; WriteEn <= 0; #ClockDelay;
		DataIn <= 4'b0010; WriteEn <= 1; #ClockDelay;
		DataIn <= 4'b0101; WriteEn <= 0; #ClockDelay;
		DataIn <= 4'b1010; WriteEn <= 1; #ClockDelay;
		
		$stop;
	end
endmodule
