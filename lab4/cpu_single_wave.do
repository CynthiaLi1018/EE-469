onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_single_testbench/clk
add wave -noupdate /cpu_single_testbench/reset
add wave -noupdate -childformat {{{/cpu_single_testbench/dut/regdata/RegisData[8]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[7]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[6]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[5]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[4]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[3]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[2]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[1]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[0]} -radix decimal}} -subitemconfig {{/cpu_single_testbench/dut/regdata/RegisData[8]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[7]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[6]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[5]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[4]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[3]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[2]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[1]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[0]} {-height 15 -radix decimal}} /cpu_single_testbench/dut/regdata/RegisData
add wave -noupdate /cpu_single_testbench/dut/data/mem
add wave -noupdate /cpu_single_testbench/dut/instruction
add wave -noupdate /cpu_single_testbench/dut/zero
add wave -noupdate /cpu_single_testbench/dut/negative
add wave -noupdate /cpu_single_testbench/dut/overflow
add wave -noupdate /cpu_single_testbench/dut/carryout
add wave -noupdate -radix decimal /cpu_single_testbench/dut/SE19
add wave -noupdate -radix decimal /cpu_single_testbench/dut/SE26
add wave -noupdate -radix decimal /cpu_single_testbench/dut/UnCondBrMUX_out
add wave -noupdate -radix decimal /cpu_single_testbench/dut/shifter1_out
add wave -noupdate -radix decimal /cpu_single_testbench/dut/adder1_out
add wave -noupdate -radix decimal /cpu_single_testbench/dut/adder2_out
add wave -noupdate -radix decimal /cpu_single_testbench/dut/BrTakenMUX_out
add wave -noupdate -radix decimal /cpu_single_testbench/dut/PC
add wave -noupdate -radix decimal /cpu_single_testbench/dut/final_PC
add wave -noupdate -radix unsigned /cpu_single_testbench/dut/Rd
add wave -noupdate -radix unsigned /cpu_single_testbench/dut/Rm
add wave -noupdate -radix unsigned /cpu_single_testbench/dut/Rd_Rm
add wave -noupdate -radix unsigned /cpu_single_testbench/dut/Rn
add wave -noupdate -radix decimal /cpu_single_testbench/dut/SE9
add wave -noupdate -radix decimal /cpu_single_testbench/dut/ZE12
add wave -noupdate -radix decimal /cpu_single_testbench/dut/const_src
add wave -noupdate -radix hexadecimal /cpu_single_testbench/dut/DataB
add wave -noupdate -radix hexadecimal /cpu_single_testbench/dut/ALU_in
add wave -noupdate -radix hexadecimal /cpu_single_testbench/dut/DataA
add wave -noupdate -radix hexadecimal /cpu_single_testbench/dut/ALU_out
add wave -noupdate /cpu_single_testbench/dut/NewNegative
add wave -noupdate /cpu_single_testbench/dut/NewZero
add wave -noupdate /cpu_single_testbench/dut/NewOverflow
add wave -noupdate /cpu_single_testbench/dut/NewCarryout
add wave -noupdate -radix hexadecimal /cpu_single_testbench/dut/datamem_out
add wave -noupdate -radix hexadecimal /cpu_single_testbench/dut/SHAMT
add wave -noupdate -radix hexadecimal /cpu_single_testbench/dut/shifter2_out
add wave -noupdate -radix hexadecimal /cpu_single_testbench/dut/Data_To_Reg
add wave -noupdate -radix hexadecimal /cpu_single_testbench/dut/RegWriteData
add wave -noupdate /cpu_single_testbench/dut/fetch/mem
add wave -noupdate /cpu_single_testbench/dut/Reg2Loc
add wave -noupdate /cpu_single_testbench/dut/ImmAdd
add wave -noupdate /cpu_single_testbench/dut/ALUSrc
add wave -noupdate /cpu_single_testbench/dut/ALUToReg
add wave -noupdate /cpu_single_testbench/dut/MemToReg
add wave -noupdate /cpu_single_testbench/dut/RegWrite
add wave -noupdate /cpu_single_testbench/dut/MemWrite
add wave -noupdate /cpu_single_testbench/dut/SetFlag
add wave -noupdate /cpu_single_testbench/dut/BrTaken
add wave -noupdate /cpu_single_testbench/dut/UnConBr
add wave -noupdate /cpu_single_testbench/dut/ALUOp
add wave -noupdate /cpu_single_testbench/dut/MemRead
add wave -noupdate /cpu_single_testbench/dut/SFTDir
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9756668947 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 197
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
WaveRestoreZoom {0 ps} {34125 us}
