transcript on

vlib work

vlog -work work {./adders/rtl/lib/primitives.v}
vlog -work work {./adders/rtl/lib/sky130_fd_sc_hd.v}


vlog -work work {./multipliers/rtl/snl/sequential_multiplier.nl.v}
vlog -work work {./multipliers/rtl/snl/normal_multiplier.nl.v}
vlog -work work {./multipliers/rtl/snl/dadda_multiplier_32.nl.v}
vlog -work work {./multipliers/rtl/snl/booth_multiplier.nl.v}

vlog -work work {./multipliers/tb/multiplier_comparison_tb.v}

vsim -t 1ps work.multiplier_comparison_tb

run 10000ns
