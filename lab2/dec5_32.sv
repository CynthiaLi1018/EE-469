// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is a module that sets a 5x32 decoder made of 2 4x16 decoder and 1 1x2 decoder.
// It takes in a 5-bit input sel and a 1-bit value En, and generates the 32-bit output
// DataOut with only the selected bit as 'En'
// , other bits are all zeros.

`timescale 1ns/10ps

module dec5_32 (DataOut, sel, En);
	output logic [31:0] DataOut;
	input  logic [4:0] sel;
   input  logic En;
	
	logic [1:0] v;
	
	dec1_2 dec1 (.DataOut(v), .sel(sel[4]), .En(En));
	dec4_16 dec2 (.DataOut(DataOut[15:0]),  .sel(sel[3:0]), .En(v[0]));
	dec4_16 dec3 (.DataOut(DataOut[31:16]), .sel(sel[3:0]), .En(v[1]));
endmodule

module dec5_32_testbench();
  logic [31:0] DataOut;
  logic [4:0] sel;
  logic En;

  dec5_32 dut (.DataOut, .sel, .En);

  integer i;
  initial begin
    for(i=0; i<64; i++) begin
      {En, sel} = i; #10;
    end
  end
endmodule 
