onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_testbench/operation
add wave -noupdate /control_testbench/negative
add wave -noupdate /control_testbench/overflow
add wave -noupdate /control_testbench/NewZero
add wave -noupdate -radix unsigned /control_testbench/Rd
add wave -noupdate -radix unsigned /control_testbench/Rn
add wave -noupdate -radix unsigned /control_testbench/Rm
add wave -noupdate -radix decimal /control_testbench/Imm9
add wave -noupdate -radix unsigned /control_testbench/Imm12
add wave -noupdate -radix decimal /control_testbench/Imm19
add wave -noupdate -radix unsigned /control_testbench/Imm26
add wave -noupdate -radix unsigned /control_testbench/SHAMT
add wave -noupdate /control_testbench/Reg2Loc
add wave -noupdate /control_testbench/ImmAdd
add wave -noupdate /control_testbench/ALUSrc
add wave -noupdate /control_testbench/ALUToReg
add wave -noupdate /control_testbench/MemToReg
add wave -noupdate /control_testbench/RegWrite
add wave -noupdate /control_testbench/MemWrite
add wave -noupdate /control_testbench/SetFlag
add wave -noupdate /control_testbench/BrTaken
add wave -noupdate /control_testbench/UnConBr
add wave -noupdate /control_testbench/ALU0p
add wave -noupdate /control_testbench/MemRead
add wave -noupdate /control_testbench/SFTDir
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 199
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
WaveRestoreZoom {0 ps} {136500 ps}
