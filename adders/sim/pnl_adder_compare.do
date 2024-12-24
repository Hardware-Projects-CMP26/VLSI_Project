transcript on

vlib work



vlog -work work {./adders/rtl/lib/primitives.v}
vlog -work work {./adders/rtl/lib/sky130_fd_sc_hd.v}

vlog -work work {./adders/rtl/pnl/ripple_carry_adder.pnl.v}
vlog -work work {./adders/rtl/pnl/carry_look_ahead_adder.pnl.v}
vlog -work work {./adders/rtl/pnl/carry_bypass_adder.pnl.v}
vlog -work work {./adders/rtl/pnl/carry_select_adder.pnl.v}

vlog -work work {./adders/tb/adders_comp_tb.v}

vsim -t 1ps work.adder_comparison_tb

run 1000ns
