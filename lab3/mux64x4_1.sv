// EE 469 LAB3
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module that creates 64 parallel 4-to-1 mux. Each mux is
// responsible for selection of each bit of 4 inputs. The result
// is depending the input 'sel'

`timescale 1ns/10ps
module mux64x4_1(out, A, B, C, D, sel);
	output logic [63:0] out;
	input logic [63:0] A, B, C, D;
	input logic [1:0] sel;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin: eachBit
			mux4_1 muxes (.out(out[i]), .in({A[i], B[i], C[i], D[i]}), .sel);
		end
	endgenerate
endmodule

module mux64x4_1_testbench;
	logic [63:0] out;
	logic [63:0] A, B, C, D;
	logic [1:0] sel;
	
	mux64x4_1 dut (.out(out), .A(A), .B(B), .C(C), .D(D), .sel(sel));
	
	initial begin
		A = 64'hFFFFFFFF00000000; B = 64'hFFFFFFFFFFFFFFFFF;
		C = 64'h0; D = 64'h000000000000FFFF;
		sel = 2'b00; #10;
		sel = 2'b01; #10;
		sel = 2'b10; #10;
		sel = 2'b11; #10;
		D = 64'hFFFF0000FFFF0000;
		sel = 2'b00; #10;
		sel = 2'b01; #10;
		sel = 2'b10; #10;
		sel = 2'b11; #10;
	end
endmodule