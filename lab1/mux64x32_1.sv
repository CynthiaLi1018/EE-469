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
