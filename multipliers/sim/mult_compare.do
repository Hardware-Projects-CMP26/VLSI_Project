transcript on

vlib work

vlog -work work {./multipliers/rtl/sequential_multiplier.v}
vlog -work work {./multipliers/rtl/normal_multiplier.v}
vlog -work work {./multipliers/rtl/dadda_multiplier_32.v}
vlog -work work {./multipliers/rtl/booth_multiplier.v}
vlog -work work {./multipliers/tb/multiplier_comparison_tb.v}

vsim -t 1ps work.multiplier_comparison_tb

run 1000ns
