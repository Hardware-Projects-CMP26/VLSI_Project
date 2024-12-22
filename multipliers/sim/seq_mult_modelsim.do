transcript on

vlib work

vlog -work work {./multipliers/rtl/sequential_multiplier.v}
vlog -work work {./multipliers/tb/sequential_multiplier_tb.v}

vsim -t 1ps work.sequential_multiplier_tb

add wave -position insertpoint -divider "Inputs"
add wave -position insertpoint \
    sim:/sequential_multiplier_tb/clk \
    sim:/sequential_multiplier_tb/rst \
    sim:/sequential_multiplier_tb/start \
    sim:/sequential_multiplier_tb/multiplicand \
    sim:/sequential_multiplier_tb/multiplier

add wave -position insertpoint -divider "Outputs"
add wave -position insertpoint \
    sim:/sequential_multiplier_tb/product \
    sim:/sequential_multiplier_tb/done

add wave -position insertpoint -divider "Internal Signals"
add wave -position insertpoint \
    sim:/sequential_multiplier_tb/dut/state \
    sim:/sequential_multiplier_tb/dut/acc \
    sim:/sequential_multiplier_tb/dut/m \
    sim:/sequential_multiplier_tb/dut/q \
    sim:/sequential_multiplier_tb/dut/count \
    sim:/sequential_multiplier_tb/dut/sign

configure wave -namecolwidth 220
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2

run 1000ns
wave zoom full
