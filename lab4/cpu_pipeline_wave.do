onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_pipeline_testbench/dut/clk
add wave -noupdate /cpu_pipeline_testbench/dut/reset
add wave -noupdate -childformat {{{/cpu_pipeline_testbench/dut/regdata/RegisData[31]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[30]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[29]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[28]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[27]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[26]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[25]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[24]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[23]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[22]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[21]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[20]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[19]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[18]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[17]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[16]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[15]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[14]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[13]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[12]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[11]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[10]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[9]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[8]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[7]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[6]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[5]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[4]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[3]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[2]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[1]} -radix decimal} {{/cpu_pipeline_testbench/dut/regdata/RegisData[0]} -radix decimal}} -expand -subitemconfig {{/cpu_pipeline_testbench/dut/regdata/RegisData[31]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[30]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[29]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[28]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[27]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[26]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[25]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[24]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[23]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[22]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[21]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[20]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[19]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[18]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[17]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[16]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[15]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[14]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[13]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[12]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[11]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[10]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[9]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[8]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[7]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[6]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[5]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[4]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[3]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[2]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[1]} {-radix decimal} {/cpu_pipeline_testbench/dut/regdata/RegisData[0]} {-radix decimal}} /cpu_pipeline_testbench/dut/regdata/RegisData
add wave -noupdate /cpu_pipeline_testbench/dut/NewNegative
add wave -noupdate /cpu_pipeline_testbench/dut/NewZero
add wave -noupdate /cpu_pipeline_testbench/dut/NewOverflow
add wave -noupdate /cpu_pipeline_testbench/dut/NewCarryout
add wave -noupdate /cpu_pipeline_testbench/dut/negative
add wave -noupdate /cpu_pipeline_testbench/dut/zero
add wave -noupdate /cpu_pipeline_testbench/dut/overflow
add wave -noupdate /cpu_pipeline_testbench/dut/carryout
add wave -noupdate /cpu_pipeline_testbench/dut/stage4/data/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {96086589 ps} 0}
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
WaveRestoreZoom {0 ps} {100891560 ps}
