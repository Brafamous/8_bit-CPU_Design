############################################################
# CPU Waveform Capture Script
# Project: 8-bit Single-Cycle CPU
############################################################

transcript on

puts ""
puts "=========================================="
puts " Starting CPU Waveform Capture"
puts "=========================================="
puts ""

############################################################
# Start Simulation
############################################################

vsim work.cpu_top_tb

############################################################
# Open Wave Window
############################################################

view wave

############################################################
# Add Signals
############################################################

puts ""
puts "Adding waveform signals..."
puts ""

# Clock / Reset
add wave -divider "CLOCK_RESET"
add wave sim:/cpu_top_tb/clk
add wave sim:/cpu_top_tb/rst
add wave sim:/cpu_top_tb/enable

# Fetch
add wave -divider "FETCH"
add wave -radix unsigned sim:/cpu_top_tb/pc_value
add wave -radix hexadecimal sim:/cpu_top_tb/instruction

# Decode
add wave -divider "DECODE"
add wave -radix binary sim:/cpu_top_tb/opcode
add wave -radix unsigned sim:/cpu_top_tb/rd
add wave -radix unsigned sim:/cpu_top_tb/rs1
add wave -radix unsigned sim:/cpu_top_tb/rs2

# Control Signals
add wave -divider "CONTROL"
add wave sim:/cpu_top_tb/reg_write
add wave sim:/cpu_top_tb/mem_read
add wave sim:/cpu_top_tb/mem_write
add wave -radix binary sim:/cpu_top_tb/alu_op

# Register File
add wave -divider "REGISTER_FILE"
add wave -radix unsigned sim:/cpu_top_tb/reg_data_a
add wave -radix unsigned sim:/cpu_top_tb/reg_data_b

# ALU
add wave -divider "ALU"
add wave -radix unsigned sim:/cpu_top_tb/alu_result
add wave sim:/cpu_top_tb/zero_flag
add wave sim:/cpu_top_tb/carry_flag
add wave sim:/cpu_top_tb/negative_flag

# Memory
add wave -divider "MEMORY"
add wave -radix unsigned sim:/cpu_top_tb/mem_rd_data
add wave -radix unsigned sim:/cpu_top_tb/writeback_data

############################################################
# Run Simulation
############################################################

puts ""
puts "Running simulation..."
puts ""

run -all

############################################################
# Format Wave Window
############################################################

wave zoom full

configure wave -namecolwidth 250
configure wave -valuecolwidth 100
configure wave -signalnamewidth 1
configure wave -timelineunits ns

############################################################
# Zoom into Interesting Region
############################################################

wave zoom range 10ns 70ns

############################################################
# Helpful Message
############################################################

puts ""
puts "=========================================="
puts " Waveform Ready"
puts ""
puts "Recommended README Screenshot:"
puts ""
puts "  10ns -> 70ns"
puts ""
puts "Show:"
puts "  PC"
puts "  Instruction"
puts "  Opcode"
puts "  Register Data A/B"
puts "  ALU Result"
puts "  MEM_RD_DATA"
puts "  WRITEBACK_DATA"
puts ""
puts "This captures:"
puts "  STORE -> LOAD -> ADD"
puts ""
puts "Expected:"
puts "  Memory[7] = 5"
puts "  R3 = 5"
puts "  R4 = 10"
puts "=========================================="
puts ""