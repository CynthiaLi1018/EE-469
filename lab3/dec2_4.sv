// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is a module that sets a 2x4 decoder made of 3 1x2 decoder.
// It takes in a 2-bit input sel and a 1-bit value En, and generates 
// the 4-bit output DataOut with only the selected bit as 'En'
// , other bits are all zeros.

`timescale 1ns/10ps

module dec2_4 (DataOut, sel, En);
	output logic [3:0] DataOut;
	input  logic [1:0] sel;
   input  logic En;
	
	logic [1:0] v;
	
	dec1_2 dec1 (.DataOut(v), .sel(sel[1]), .En(En));
	dec1_2 dec2 (.DataOut(DataOut[1:0]), .sel(sel[0]), .En(v[0]));
	dec1_2 dec3 (.DataOut(DataOut[3:2]), .sel(sel[0]), .En(v[1]));
endmodule

module dec2_4_testbench();
  logic [3:0] DataOut;
  logic [1:0] sel;
  logic En;

  dec2_4 dut (.DataOut, .sel, .En);

  integer i;
  initial begin
    for(i=0; i<8; i++) begin
      {En, sel} = i; #10;
    end
  end
endmodule 