// EE 469 LAB2
// Hongjiang Cai	1863768
// Cynthia Li		1839952

// This is the module that sets a single 8:1 mux made of 2 4:1 muxes
// and a 2:1 mux. It takes in a 8-bit input and a 3-bit value sel.
// sel selects the line (bit) of in that will be send to a 1-bit output.

`timescale 1ns/10ps

module mux8_1(out, in, sel);
  output logic out;
  input  logic [7:0] in;
  input  logic [2:0] sel;

  logic [1:0] v;

  mux4_1 m0 (.out(v[0]), .in(in[3:0]),   .sel(sel[1:0]));
  mux4_1 m1 (.out(v[1]), .in(in[7:4]),   .sel(sel[1:0]));
  mux2_1 m  (.out(out),  .i0(v[0]), .i1(v[1]), .sel(sel[2]));
  
endmodule

module mux8_1_testbench();
  logic [7:0] in;
  logic [2:0] sel;
  logic out;

  mux8_1 dut (.out, .in, .sel);

  integer i;
  initial begin
    for(i=0; i<2048; i++) begin
      {sel, in} = i; #10;
    end
  end
endmodule 
  