// EE 469 LAB3
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module that creates 64 parallel 2-to-1 mux. Each mux is
// responsible for selection of each bit of 2 inputs. The result
// is depending the input 'sel'
`timescale 1ns/10ps

module mux64x2_1 (DataOut, DataIn_A, DataIn_B, sel);
	output logic [63:0] DataOut;
	input  logic [63:0] DataIn_A, DataIn_B;
	input  logic sel;
	
	// Use generate statement to create 64 parallel 2-to-1 mux. Each mux is
	// responsible for selection of each bit of 2 ALU results. The result
	// is depending the input 'sel'
	genvar i;
	
	generate
		for (i=0; i<64; i++) begin : eachMux
			mux2_1 eachBit (.out(DataOut[i]), .i0(DataIn_A[i]), .i1(DataIn_B[i]), .sel(sel));
		end
	endgenerate
endmodule

module mux64x2_1_testbench;
	logic [63:0] DataOut;
	logic [63:0] DataIn_A, DataIn_B;
	logic sel;
	
	mux64x2_1 dut (.DataOut(DataOut), .DataIn_A(DataIn_A), .DataIn_B(DataIn_B), .sel(sel));
	
	initial begin
		DataIn_A = 64'h0000000000100000;
		DataIn_B = 64'h0000000000000000; sel = 0; #10;
		
		DataIn_A = 64'h00000007b0000000;
		DataIn_B = 64'h0000000e06000000; sel = 0; #10;
		
		DataIn_A = 64'h000000000000001a;
		DataIn_B = 64'h00000000000002a0; sel = 0; #10;
		
		DataIn_A = 64'h00000007b0000000;
		DataIn_B = 64'h0000000e06000000; sel = 1; #10;
		
		DataIn_A = 64'h000000000000001a;
		DataIn_B = 64'h00000000000002a0; sel = 1; #10;
	end
endmodule
