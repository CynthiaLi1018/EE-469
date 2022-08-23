onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /alustim/A
add wave -noupdate -radix hexadecimal /alustim/B
add wave -noupdate -radix unsigned /alustim/cntrl
add wave -noupdate -radix hexadecimal /alustim/result
add wave -noupdate /alustim/negative
add wave -noupdate /alustim/zero
add wave -noupdate /alustim/overflow
add wave -noupdate /alustim/carry_out
add wave -noupdate /alustim/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {41099997580 ps} 0}
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
WaveRestoreZoom {41099996681 ps} {41100000175 ps}
