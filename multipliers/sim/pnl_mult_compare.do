transcript on

vlib work

vlog -work work {./adders/rtl/lib/primitives.v}
vlog -work work {./adders/rtl/lib/sky130_fd_sc_hd.v}


vlog -work work {./multipliers/rtl/pnl/sequential_multiplier.pnl.v}
vlog -work work {./multipliers/rtl/pnl/normal_multiplier.pnl.v}
vlog -work work {./multipliers/rtl/pnl/dadda_multiplier_32.pnl.v}
vlog -work work {./multipliers/rtl/pnl/booth_multiplier.pnl.v}

vlog -work work {./multipliers/tb/multiplier_comparison_tb.v}

vsim -t 1ps work.multiplier_comparison_tb

run 10000ns
