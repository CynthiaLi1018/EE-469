onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dec4_16_testbench/En
add wave -noupdate -radix unsigned -childformat {{{/dec4_16_testbench/sel[3]} -radix unsigned} {{/dec4_16_testbench/sel[2]} -radix unsigned} {{/dec4_16_testbench/sel[1]} -radix unsigned} {{/dec4_16_testbench/sel[0]} -radix unsigned}} -expand -subitemconfig {{/dec4_16_testbench/sel[3]} {-radix unsigned} {/dec4_16_testbench/sel[2]} {-radix unsigned} {/dec4_16_testbench/sel[1]} {-radix unsigned} {/dec4_16_testbench/sel[0]} {-radix unsigned}} /dec4_16_testbench/sel
add wave -noupdate -expand /dec4_16_testbench/DataOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {230 ps} 0}
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
WaveRestoreZoom {0 ps} {336 ps}
