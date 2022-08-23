// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is a module that sets a 4x16 decoder made of 5 2x4 decoder.
// It takes in a 4-bit input sel and a 1-bit value En, and generates 
// the 16-bit output DataOut with only the selected bit as 'En'
// , other bits are all zeros.

`timescale 1ns/10ps

module dec4_16 (DataOut, sel, En);
	output logic [15:0] DataOut;
	input  logic [3:0] sel;
   input  logic En;
	
	logic [3:0] v;
	
	dec2_4 dec1 (.DataOut(v), .sel(sel[3:2]), .En(En));
	dec2_4 dec2 (.DataOut(DataOut[3:0]),   .sel(sel[1:0]), .En(v[0]));
	dec2_4 dec3 (.DataOut(DataOut[7:4]),   .sel(sel[1:0]), .En(v[1]));
	dec2_4 dec4 (.DataOut(DataOut[11:8]),  .sel(sel[1:0]), .En(v[2]));
	dec2_4 dec5 (.DataOut(DataOut[15:12]), .sel(sel[1:0]), .En(v[3]));
endmodule

module dec4_16_testbench();
  logic [15:0] DataOut;
  logic [3:0] sel;
  logic En;

  dec4_16 dut (.DataOut, .sel, .En);

  integer i;
  initial begin
    for(i=0; i<32; i++) begin
      {En, sel} = i; #10;
    end
  end
endmodule 
