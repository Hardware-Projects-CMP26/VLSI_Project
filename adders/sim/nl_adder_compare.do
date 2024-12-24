transcript on

vlib work



vlog -work work {./adders/rtl/lib/primitives.v}
vlog -work work {./adders/rtl/lib/sky130_fd_sc_hd.v}



vlog -work work {./adders/rtl/snl/ripple_carry_adder.nl.v}
vlog -work work {./adders/rtl/snl/carry_look_ahead_adder.nl.v}
vlog -work work {./adders/rtl/snl/carry_bypass_adder.nl.v}
vlog -work work {./adders/rtl/snl/carry_select_adder.nl.v}

vlog -work work {./adders/tb/adders_comp_tb.v}

vsim -t 1ps work.adder_comparison_tb

run 1000ns
