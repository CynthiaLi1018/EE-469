// EE 469 LAB1
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module that sets a single 16:1 mux made of 4 4:1 muxes.
// It takes in a 16-bit inputs and a 4-bit value sel. sel selects 
// the line (bit) of in that will be send to a 1-bit output.

`timescale 1ns/10ps

module mux16_1(out, in, sel);
  output logic out;
  input  logic [15:0] in;
  input  logic [3:0] sel;

  logic [3:0] v;

  mux4_1 m0 (.out(v[0]), .in(in[3:0]),   .sel(sel[1:0]));
  mux4_1 m1 (.out(v[1]), .in(in[7:4]),   .sel(sel[1:0]));
  mux4_1 m2 (.out(v[2]), .in(in[11:8]),  .sel(sel[1:0]));
  mux4_1 m3 (.out(v[3]), .in(in[15:12]), .sel(sel[1:0]));
  mux4_1 m  (.out(out),  .in(v[3:0]),    .sel(sel[3:2]));
  
endmodule

module mux16_1_testbench();
  logic [15:0] in;
  logic [3:0] sel;
  logic out;

  mux16_1 dut (.out, .in, .sel);

  integer i;
  initial begin
    for(i=0; i<1048576; i++) begin
      {sel, in} = i; #10;
    end
  end
endmodule 