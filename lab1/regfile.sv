// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// The register file that connects all components. The input 'RegWrite' will first be sent to
// the decoder and the output will indicates which register is being writen at current clock cycle
// depending on the 5-bit input 'WriteRegister'. Then, only the selected register will be updated,
// except X31 which is always hardwired to 0. Then, two large 64x32:1 muxes will read the output from
// all 32 registers and select the 64-bit output 'ReadData1' and 'ReadData2' according to the 5-bit
// inputs 'ReadRegister1' and 'ReadRegister2'.
`timescale 1ns/10ps

module regfile (ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, RegWrite, clk);
	output logic [63:0] ReadData1, ReadData2;
	input  logic [63:0] WriteData;
	input  logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input  logic RegWrite, clk;
			
   logic [31:0] WriteEnable;
	logic [31:0][63:0] RegisData;   // X[i] = i th register's output data
					 
   // 5-to-32 decoder, output will 'and' with 'RegWrite' to determine the "WriteEnable" of registers
	dec5_32 dec32 (.DataOut(WriteEnable), .sel(WriteRegister), .En(RegWrite));
   // 31 parallel 64-bit registers (X0 to X30)
	genvar i;
	
	generate
		for (i=0; i<31; i++) begin : X
			// @Params: WriteEn - output of decoder 'and' with 'RegWrtie'
			register_64 regis (.DataIn(WriteData), .DataOut(RegisData[i]), .WriteEn(WriteEnable[i]), .clk(clk), .reset(0)); 
		end
	endgenerate
	// X31, the special register that is always hardwired to 0.
	register_64 X31 (.DataIn(0), .DataOut(RegisData[31]), .WriteEn(1), .clk(clk), .reset(0));
	
	// two large 64x32:1 mux, the input will be the DataOut from registers,
	// the mux will choose the data from one register depending on the input 'ReadRegister'
	mux64x32_1 mux1 (.DataOut(ReadData1), .DataIn(RegisData), .ReadRegister(ReadRegister1)); // dataIn, 2-D array from DataOut of 32 64-bit Registers
	mux64x32_1 mux2 (.DataOut(ReadData2), .DataIn(RegisData), .ReadRegister(ReadRegister2));
					 
endmodule
