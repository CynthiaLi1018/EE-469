onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /register64_testbench/clk
add wave -noupdate /register64_testbench/enable
add wave -noupdate /register64_testbench/in
add wave -noupdate /register64_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1148622 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 105
configure wave -valuecolwidth 99
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
WaveRestoreZoom {2802875 ps} {4010375 ps}
