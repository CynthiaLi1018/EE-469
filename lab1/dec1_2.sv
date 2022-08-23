// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is a module that sets a single 1x2 decoder.
// It takes in 1-bit input sel and En, and generates 
// 2-bit output DataOut with only the selected bit as 'En'
// , other bits are all zeros.

`timescale 1ns/10ps

module dec1_2 (DataOut, sel, En);
	output logic [1:0] DataOut;
	input  logic sel, En;

	logic nsel;
	
	not #0.05 Not_1 (nsel, sel);
	and #0.05 And_1 (DataOut[0], En, nsel);
	and #0.05 And_2 (DataOut[1], En, sel);
endmodule

module dec1_2_testbench();
  logic [1:0] DataOut;
  logic sel;
  logic En;

  dec1_2 dut (.DataOut, .sel, .En);

  initial begin
	  sel = 0; En = 1; #10;
	  sel = 1; En = 1; #10;
	  sel = 0; En = 0; #10;
	  sel = 1; En = 0; #10;
  end
endmodule 