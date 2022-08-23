// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module that sets a single 4:1 mux made of 3 2:1 muxes.
// It takes in a 4-bit inputs and a 2-bit value sel. sel selects 
// the line (bit) of in that will be send to a 1-bit output.

`timescale 1ns/10ps

module mux4_1(out, in, sel);
  output logic out;
  input  logic [3:0] in;
  input  logic [1:0] sel;

  logic v0, v1;

  mux2_1 m0(.out(v0), .i0(in[0]), .i1(in[1]), .sel(sel[0]));
  mux2_1 m1(.out(v1), .i0(in[2]), .i1(in[3]), .sel(sel[0]));
  mux2_1 m (.out(out), .i0(v0), .i1(v1), .sel(sel[1]));
endmodule

module mux4_1_testbench();
  logic [3:0] in;
  logic [1:0] sel;
  logic out;

  mux4_1 dut (.out, .in, .sel);

  integer i;
  initial begin
    for(i=0; i<64; i++) begin
      {sel, in} = i; #10;
    end
  end
endmodule 