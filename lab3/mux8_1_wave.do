onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned -childformat {{{/mux8_1_testbench/in[7]} -radix unsigned} {{/mux8_1_testbench/in[6]} -radix unsigned} {{/mux8_1_testbench/in[5]} -radix unsigned} {{/mux8_1_testbench/in[4]} -radix unsigned} {{/mux8_1_testbench/in[3]} -radix unsigned} {{/mux8_1_testbench/in[2]} -radix unsigned} {{/mux8_1_testbench/in[1]} -radix unsigned} {{/mux8_1_testbench/in[0]} -radix unsigned}} -expand -subitemconfig {{/mux8_1_testbench/in[7]} {-radix unsigned} {/mux8_1_testbench/in[6]} {-radix unsigned} {/mux8_1_testbench/in[5]} {-radix unsigned} {/mux8_1_testbench/in[4]} {-radix unsigned} {/mux8_1_testbench/in[3]} {-radix unsigned} {/mux8_1_testbench/in[2]} {-radix unsigned} {/mux8_1_testbench/in[1]} {-radix unsigned} {/mux8_1_testbench/in[0]} {-radix unsigned}} /mux8_1_testbench/in
add wave -noupdate /mux8_1_testbench/sel
add wave -noupdate /mux8_1_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6440000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {21504 ns}
