transcript on

vlib work



vlog -work work {./FPALU/rtl/lib/sky130_fd_sc_hd.v}
vlog -work work {./FPALU/rtl/lib/sky130_fd_sc_hd.v}


vlog -work work {./FPALU/rtl/snl/ALU.nl.v}

vlog -work work {./FPALU/tb_ALU.v}

vsim -t 1ps work.ALU_tb

run 1000ns
