// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module that sets a single 32:1 mux made of 2 16:1 muxes and 1 2:1 mux.
// It takes in a 32-bit inputs and a 5-bit value sel. sel selects 
// the line (bit) of in that will be send to a 1-bit output.

`timescale 1ns/10ps

module mux32_1(out, in, sel);
	output logic out;
	input  logic [31:0] in;
	input  logic [4:0] sel;

	logic v0, v1;

	mux16_1 m0 (.out(v0),   .in(in[15:0]),      .sel(sel[3:0]));
	mux16_1 m1 (.out(v1),   .in(in[31:16]),     .sel(sel[3:0]));
	mux2_1  m  (.out(out), .i0(v0), .i1(v1),    .sel(sel[4]));
  
endmodule

module mux32_1_testbench();
	logic [31:0] in;
	logic [4:0] sel;
	logic out;

	mux32_1 dut (.out, .in, .sel);
  
	integer i;
	initial begin
		in = 32'b10101010101010101010101010101010;
		for (i = 0; i < 32; i++) begin
			sel = i; #10;
		end
		in = 32'b11110000111100001111000011110000; 
		for (i = 0; i < 32; i++) begin
			sel = i; #10;
		end
		in = 32'b00000000111111110000000011111111;
		for (i = 0; i < 32; i++) begin
			sel = i; #10;
		end
		in = 32'b00001111111100001111111100000000;
		for (i = 0; i < 32; i++) begin
			sel = i; #10;
		end
  end
endmodule 
