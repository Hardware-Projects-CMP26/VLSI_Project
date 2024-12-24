
# NOTE: defines a virtual clock
create_clock -name clk -period 40

set_input_delay 0.1 [all_inputs] -clock clk

set_output_delay 0.5 [all_outputs] -clock clk

set_load 0.01 [all_outputs]

# Define clock skew constraint
set_clock_uncertainty 0.2 [get_clocks clk]
