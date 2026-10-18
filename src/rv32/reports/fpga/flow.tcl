# GMP 风格独立综合与实现。时序失败返回非零，checkpoint 保留供分析。
if {$argc < 2} { error "usage: <part> <ooc|impl|board>" }
set part [lindex $argv 0]
set mode [lindex $argv 1]
set_param general.maxThreads 1
set python python3
if {[info exists ::env(RV32_PYTHON)]} { set python $::env(RV32_PYTHON) }
set placement_reference [expr {[info exists ::env(RV32_PLACEMENT_REFERENCE)] && $::env(RV32_PLACEMENT_REFERENCE) eq "1"}]
source syn/check_resources.tcl
set top Rv32Soc
if {[info exists ::env(SYN_TOP)]} { set top $::env(SYN_TOP) }
set predict 2
if {[info exists ::env(PREDICT)]} { set predict $::env(PREDICT) }
set perf 0
if {[info exists ::env(PERF)]} { set perf $::env(PERF) }
set revision ""
if {[info exists ::env(REV)]} { set revision $::env(REV) }
set bp_entries 8
if {[info exists ::env(BP_ENTRIES)]} { set bp_entries $::env(BP_ENTRIES) }
set over_frac 1.0
if {[info exists ::env(OVER_FRAC)]} { set over_frac $::env(OVER_FRAC) }
set tag $top-p$predict
if {[info exists ::env(RUN_TAG)]} { set tag $::env(RUN_TAG) }
set out build/$mode/$tag
file mkdir $out
set clock_name cpu
set input_delay 0.5
set output_delay 0.0
if {$mode eq "board"} {
    set top top
    set clock_name clk_raw
    set input_delay null
    set output_delay null
    if {$over_frac != 1.0} { error "board implementation uses the actual generated clock; OVER_FRAC must be 1.0" }
}
set config [open $out/config.json w]
puts $config [format {{"part":"%s","top":"%s","mode":"%s","cpu_clock":"%s","predict":%d,"bp_entries":%d,"perf":%d,"pipeline_stages":4,"isa":"rv32i_zmmul","rev":"%s","trace":0,"resource_policy":"ff_except_ilm_dlm_no_dsp","implementation_period_ns":%.3f,"report_period_ns":5.0,"input_min_max_ns":%s,"output_delay_ns":%s,"post_route_optimization_floor_ns":-0.4}} $part $top $mode $clock_name $predict $bp_entries $perf $revision [expr {5.0 * $over_frac}] $input_delay $output_delay]
close $config
exec $python -I -c {import hashlib,json,sys; from pathlib import Path; p=Path(sys.argv[1]); f=Path(sys.argv[2]); d=json.loads(p.read_text()); d["physical_flow_sha256"]=hashlib.sha256(f.read_bytes()).hexdigest(); p.write_text(json.dumps(d,indent=2)+"\n")} $out/config.json $out/flow.tcl
read_verilog -sv [glob $out/src/*.v]
if {$mode eq "board"} {
    read_verilog $out/src/board/top.v
    read_xdc $out/src/board/rv32.xdc
    synth_design -top top -part $part -directive PerformanceOptimized -retiming -generic [list PREDICT=$predict PERF=$perf] -gated_clock_conversion auto -max_dsp 0 -shreg_min_size 100000
} else {
    synth_design -top $top -part $part -mode out_of_context -generic [list PREDICT=$predict TRACE=0 PERF=$perf] -gated_clock_conversion auto -max_dsp 0 -shreg_min_size 100000
    create_clock -name cpu -period [expr {5.0 * $over_frac}] [get_ports clk]
    # OOC 主机/存储接口按同域寄存器驱动建模；min/max 均为 0.5ns。
    set_input_delay 0.5 -clock cpu [get_ports -filter {DIRECTION == IN && NAME != clk}]
    set_output_delay 0.0 -clock cpu [get_ports -filter {DIRECTION == OUT}]
}
report_utilization -hierarchical -file $out/util_synth.rpt
report_timing_summary -delay_type min_max -file $out/timing_synth.rpt
write_checkpoint -force $out/synth.dcp
rv32_check_resources $out/resources_synth.json
if {$mode eq "ooc"} { exit }
if {$mode eq "board" && [file exists $out/src/board/floorplan.xdc]} {
    read_xdc $out/src/board/floorplan.xdc
}
opt_design -directive Explore
if {$mode eq "board" && !$placement_reference} {
    set inc_ref [exec $python -I syn/reference.py $out $part]
    exec $python -I -c {import hashlib,json,sys;from pathlib import Path;p=Path(sys.argv[1]);d=json.loads(p.read_text());d["incremental_reference_sha256"]=hashlib.sha256(Path(sys.argv[2]).read_bytes()).hexdigest();p.write_text(json.dumps(d,indent=2)+"\n")} $out/config.json $inc_ref
    read_checkpoint -incremental $inc_ref
}
place_design -directive ExtraNetDelay_high
report_timing -setup -max_paths 20 -nworst 1 -file $out/setup_placed.rpt
phys_opt_design -directive AggressiveExplore
report_timing -setup -max_paths 20 -nworst 1 -file $out/setup_optimized.rpt
route_design -directive NoTimingRelaxation
set route_paths [get_timing_paths -setup -max_paths 1]
if {[llength $route_paths] != 1} { error "no routed setup paths analyzed" }
set route_slack [get_property SLACK [lindex $route_paths 0]]
if {$route_slack >= -0.4} {
    phys_opt_design -directive AggressiveExplore
} else {
    puts "RV32: routed slack=$route_slack ns; save failing reports without post-route physical optimization"
}
if {$mode ne "board"} {
    # 与 GMP 相同：较紧约束引导实现，最终按实际 200MHz 周期验收。
    create_clock -name cpu -period 5.000 [get_ports clk]
}
report_timing_summary -delay_type min_max -check_timing_verbose -report_unconstrained -file $out/timing.rpt
report_timing -setup -max_paths 20 -nworst 1 -file $out/setup.rpt
report_timing -hold -max_paths 10 -nworst 1 -file $out/hold.rpt
report_utilization -hierarchical -file $out/util.rpt
report_clocks -file $out/clocks.rpt
report_drc -file $out/drc.rpt
write_checkpoint -force $out/routed.dcp
rv32_check_resources $out/resources_route.json
if {[file exists tight_setup_hold_pins.txt]} {
    file rename -force tight_setup_hold_pins.txt $out/tight_setup_hold_pins.txt
}
if {$placement_reference} {
    puts "RV32: reference placement saved; final PLL implementation performs the 200 MHz acceptance checks"
    exit
}
foreach type {setup hold} {
    set paths [get_timing_paths -$type -max_paths 1]
    if {[llength $paths] == 0} { error "no $type paths analyzed" }
    set slack [get_property SLACK [lindex $paths 0]]
    puts "RV32: $type slack=$slack ns"
    if {$slack < 0} { error "200 MHz $type timing failed ($slack ns); bitstream rejected" }
}
if {$mode eq "board"} {
    write_bitstream -force $out/rv32.bit
}
