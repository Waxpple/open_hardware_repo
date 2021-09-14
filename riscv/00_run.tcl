read_file -type verilog ../riscv/general/xcheck.sv
set_option enableSV yes
current_goal Design_Read -alltop
link_design -force
current_goal lint/lint_rtl -alltop
run_goal

