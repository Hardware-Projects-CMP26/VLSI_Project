# Define the clock
create_clock -name clk -period 30

# Set input delay
set_input_delay 1 [all_inputs] -clock clk

# Set output delay
set_output_delay 0.5 [all_outputs] -clock clk

# Set load
set_load 0.01 [all_outputs]

# Define clock skew constraint
# set_clock_uncertainty 0.2 [get_clocks clk]
