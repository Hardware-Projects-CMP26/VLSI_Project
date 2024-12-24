# Define the clock
create_clock -name clk -period 20 [get_ports clk]

# Set input delay
set_input_delay 1 [all_inputs]

# Set output delay
set_output_delay 0.5 [all_outputs]

# Set load
set_load 10 [all_outputs]

# Define clock skew constraint
set_clock_uncertainty 0.2 [get_clocks clk]
