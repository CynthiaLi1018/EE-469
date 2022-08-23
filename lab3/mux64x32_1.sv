// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is a module that sets a 64x32_1 mux that is made of 64 32x1 mux.
// It takes in a 32x64 input DataIn, insert each 64-bit value into a 64 bit register
// and select which 64-bit value to set for DataOut by the 5-bit input ReadRegister.

`timescale 1ns/10ps

module mux64x32_1 (DataOut, DataIn, ReadRegister);
	output logic [63:0] DataOut;
	input  logic [31:0][63:0] DataIn;
	input  logic [4:0]  ReadRegister;
	
	// Use generate statement to create 64 parallel 32-to-1 mux. Each mux is
	// responsible for selection of each bit of 32 64-bit registers. The result
	// is depending the input 'ReadRegister'
	genvar i;
	
	generate
		for (i=0; i<64; i++) begin : eachMux
			mux32_1 mux (.out(DataOut[i]), .in({DataIn[31][i],DataIn[30][i],DataIn[29][i],DataIn[28][i],
														   DataIn[27][i],DataIn[26][i],DataIn[25][i],DataIn[24][i],
															DataIn[23][i],DataIn[22][i],DataIn[21][i],DataIn[20][i],
															DataIn[19][i],DataIn[18][i],DataIn[17][i],DataIn[16][i],
															DataIn[15][i],DataIn[14][i],DataIn[13][i],DataIn[12][i],
															DataIn[11][i],DataIn[10][i],DataIn[9][i],DataIn[8][i],
															DataIn[7][i],DataIn[6][i],DataIn[5][i],DataIn[4][i],
															DataIn[3][i],DataIn[2][i],DataIn[1][i],DataIn[0][i]}), .sel(ReadRegister));
		end
	endgenerate
endmodule

module mux64x32_1_testbench;
	logic [63:0] DataOut;
	logic [31:0][63:0] DataIn;
	logic [4:0]  ReadRegister;
	
	mux64x32_1 dut (.*);
	
	integer i;
	initial begin
		DataIn[0] = 64'h0000000000000000;
		DataIn[1] = 64'h0000000000000001;
		DataIn[2] = 64'h0000000000000002;
		DataIn[3] = 64'h0000000000000003;
		DataIn[4] = 64'h0000000000000004;
		DataIn[5] = 64'h0000000000000005;
		DataIn[6] = 64'h0000000000000006;
		DataIn[7] = 64'h0000000000000007;
		DataIn[8] = 64'h0000000000000008;
		DataIn[9] = 64'h0000000000000009;
		DataIn[10] = 64'h000000000000000a;
		DataIn[11] = 64'h000000000000000b;
		DataIn[12] = 64'h000000000000000c;
		DataIn[13] = 64'h000000000000000d;
		DataIn[14] = 64'h000000000000000e;
		DataIn[15] = 64'h000000000000000f;
		DataIn[16] = 64'h0000000000000010;
		DataIn[17] = 64'h0000000000000011;
		DataIn[18] = 64'h0000000000000012;
		DataIn[19] = 64'h0000000000000013;
		DataIn[20] = 64'h0000000000000014;
		DataIn[21] = 64'h0000000000000015;
		DataIn[22] = 64'h0000000000000016;
		DataIn[23] = 64'h0000000000000017;
		DataIn[24] = 64'h0000000000000018;
		DataIn[25] = 64'h0000000000000019;
		DataIn[26] = 64'h000000000000001a;
		DataIn[27] = 64'h000000000000001b;
		DataIn[28] = 64'h000000000000001c;
		DataIn[29] = 64'h000000000000001d;
		DataIn[30] = 64'h000000000000001e;
		DataIn[31] = 64'h000000000000001f;
		for (i = 0; i < 2**5; i++) begin
			ReadRegister = i; #10;
			assert(DataOut == DataIn[i]);
		end
	end

endmodule
					
				
					

