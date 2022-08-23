onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -childformat {{{/cpu_single_testbench/dut/regdata/RegisData[18]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[17]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[16]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[15]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[14]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[11]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[10]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[9]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[8]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[7]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[6]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[5]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[4]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[3]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[2]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[1]} -radix decimal} {{/cpu_single_testbench/dut/regdata/RegisData[0]} -radix decimal}} -expand -subitemconfig {{/cpu_single_testbench/dut/regdata/RegisData[18]} {-radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[17]} {-radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[16]} {-radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[15]} {-radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[14]} {-radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[11]} {-radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[10]} {-radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[9]} {-radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[8]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[7]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[6]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[5]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[4]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[3]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[2]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[1]} {-height 15 -radix decimal} {/cpu_single_testbench/dut/regdata/RegisData[0]} {-height 15 -radix decimal}} /cpu_single_testbench/dut/regdata/RegisData
add wave -noupdate /cpu_single_testbench/clk
add wave -noupdate /cpu_single_testbench/reset
add wave -noupdate -radix decimal /cpu_single_testbench/dut/PC
add wave -noupdate -radix decimal /cpu_single_testbench/dut/final_PC
add wave -noupdate /cpu_single_testbench/dut/SetFlag
add wave -noupdate /cpu_single_testbench/dut/negative
add wave -noupdate /cpu_single_testbench/dut/zero
add wave -noupdate /cpu_single_testbench/dut/overflow
add wave -noupdate /cpu_single_testbench/dut/carryout
add wave -noupdate -expand /cpu_single_testbench/dut/data/mem
add wave -noupdate /cpu_single_testbench/dut/instruction
add wave -noupdate /cpu_single_testbench/dut/fetch/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {31047537620 ps} 0}
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
WaveRestoreZoom {0 ps} {86625 us}
