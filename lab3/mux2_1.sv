// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module that sets a single 2x1 mux.
// mux2_1 takes in three 1-bit inputs i0, i1, sel,
// sel pick which bit from i0 or i1 will be sent to out.

`timescale 1ns/10ps

module mux2_1(out, i0, i1, sel);
  output logic out;
  input logic i0, i1, sel;
  
  logic v0, v1, nsel;
  
  //out = (i1 & sel) | (i0 & ~sel);
  not #0.05 Not_1 (nsel, sel);
  and #0.05 And_1 (v0, i0, nsel);
  and #0.05 And_2 (v1, i1, sel);
  or  #0.05 Or_1  (out, v1, v0); 
  
endmodule

module mux2_1_testbench();
	logic i0, i1, sel;
	logic out;

	mux2_1 dut (.out, .i0, .i1, .sel);

	integer i;
	initial begin
		for (i = 0; i < 8; i++) begin
			{sel, i1, i0} = i; #10;
		end
	end
endmodule 
