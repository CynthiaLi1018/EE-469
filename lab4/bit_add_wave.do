onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bit_add_testbench/i
add wave -noupdate /bit_add_testbench/SubFlag
add wave -noupdate /bit_add_testbench/A
add wave -noupdate /bit_add_testbench/B
add wave -noupdate /bit_add_testbench/Cin
add wave -noupdate /bit_add_testbench/R
add wave -noupdate /bit_add_testbench/Cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4667 ps} 0}
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
WaveRestoreZoom {0 ps} {168 ns}
