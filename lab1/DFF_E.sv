// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module is built on D_FF. It takes 1-bit input d, reset, clk, and WriEn,
// it will reset DFF output 'q' to 0 when reset is true, 
// and update the value output from DFF when 'WriEn' is true,
// otherwise it will pass the previous output 'q' as new input 'd' of DFF

`timescale 1ns/10ps

module DFF_E (q, d, reset, clk, WriEn);
  output reg q;
  input logic d, reset, clk, WriEn;
  
  logic Din;
  
  // Use 2-to-1 mux to decide whether update the dff or not depending on 'WriEn' flag
  mux2_1 mux0 (.out(Din), .i0(q), .i1(d), .sel(WriEn));
  
  // DFF as single bit in the 64-bit register
  D_FF dff1 (.q(q), .d(Din), .reset(reset), .clk(clk));
endmodule 

module DFF_E_testbench();
   parameter ClockDelay = 50;
	
	reg q;
	logic d, reset, clk, WriEn;
	
	DFF_E dut (.q, .d, .reset, .clk, .WriEn);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	integer i;
	
	initial begin
		for (i = 0; i < 8; i++) begin
			{reset, WriEn, d} <= i; #ClockDelay;
		end
		$stop;
	end
endmodule
