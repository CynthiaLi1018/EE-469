onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /register_64_testbench/clk
add wave -noupdate /register_64_testbench/reset
add wave -noupdate -radix hexadecimal /register_64_testbench/DataIn
add wave -noupdate /register_64_testbench/WriteEn
add wave -noupdate -radix hexadecimal /register_64_testbench/DataOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {293 ps} 0}
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
WaveRestoreZoom {0 ps} {315 ps}
