transcript on

vlib work


vlog -work work {./adders/rtl/full_adder.v}
vlog -work work {./adders/rtl/ripple_carry_adder4.v}
vlog -work work {./adders/rtl/skip_logic.v}

vlog -work work {./adders/rtl/ripple_carry_adder.v}
vlog -work work {./adders/rtl/carry_look_ahead_adder.v}
vlog -work work {./adders/rtl/carry_bypass_adder.v}
vlog -work work {./adders/rtl/carry_select_adder.v}

vlog -work work {./adders/tb/adders_comp_tb.v}

vsim -t 1ps work.adder_comparison_tb

run 1000ns
