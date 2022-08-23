onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /xor_64_testbench/A
add wave -noupdate -radix hexadecimal /xor_64_testbench/B
add wave -noupdate /xor_64_testbench/i
add wave -noupdate /xor_64_testbench/j
add wave -noupdate -radix hexadecimal /xor_64_testbench/R
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2559241 ps} 0}
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
WaveRestoreZoom {2559050 ps} {2560050 ps}
