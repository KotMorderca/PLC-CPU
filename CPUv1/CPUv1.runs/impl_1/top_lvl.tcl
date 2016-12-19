proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7a100tcsg324-1
  set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir D:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.cache/wt [current_project]
  set_property parent.project_path D:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.xpr [current_project]
  set_property ip_repo_paths d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.cache/ip [current_project]
  set_property ip_output_repo d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.cache/ip [current_project]
  add_files -quiet D:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.runs/synth_1/top_lvl.dcp
  add_files D:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/programator.bmm
  set_property SCOPED_TO_REF programator [get_files -all D:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/programator.bmm]
  set_property SCOPED_TO_CELLS {} [get_files -all D:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/programator.bmm]
  add_files D:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.sdk/programator/Debug/programator.elf
  set_property SCOPED_TO_REF programator [get_files -all D:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.sdk/programator/Debug/programator.elf]
  set_property SCOPED_TO_CELLS microblaze_0 [get_files -all D:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.sdk/programator/Debug/programator.elf]
  read_xdc -ref programator_microblaze_0_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_microblaze_0_0/programator_microblaze_0_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_microblaze_0_0/programator_microblaze_0_0.xdc]
  read_xdc -ref programator_dlmb_v10_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_dlmb_v10_0/programator_dlmb_v10_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_dlmb_v10_0/programator_dlmb_v10_0.xdc]
  read_xdc -ref programator_ilmb_v10_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_ilmb_v10_0/programator_ilmb_v10_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_ilmb_v10_0/programator_ilmb_v10_0.xdc]
  read_xdc -ref programator_microblaze_0_axi_intc_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_microblaze_0_axi_intc_0/programator_microblaze_0_axi_intc_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_microblaze_0_axi_intc_0/programator_microblaze_0_axi_intc_0.xdc]
  read_xdc -ref programator_mdm_1_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_mdm_1_0/programator_mdm_1_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_mdm_1_0/programator_mdm_1_0.xdc]
  read_xdc -prop_thru_buffers -ref programator_clk_wiz_1_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_clk_wiz_1_0/programator_clk_wiz_1_0_board.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_clk_wiz_1_0/programator_clk_wiz_1_0_board.xdc]
  read_xdc -ref programator_clk_wiz_1_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_clk_wiz_1_0/programator_clk_wiz_1_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_clk_wiz_1_0/programator_clk_wiz_1_0.xdc]
  read_xdc -prop_thru_buffers -ref programator_rst_clk_wiz_1_100M_0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_rst_clk_wiz_1_100M_0/programator_rst_clk_wiz_1_100M_0_board.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_rst_clk_wiz_1_100M_0/programator_rst_clk_wiz_1_100M_0_board.xdc]
  read_xdc -ref programator_rst_clk_wiz_1_100M_0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_rst_clk_wiz_1_100M_0/programator_rst_clk_wiz_1_100M_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_rst_clk_wiz_1_100M_0/programator_rst_clk_wiz_1_100M_0.xdc]
  read_xdc -prop_thru_buffers -ref programator_axi_uartlite_0_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_uartlite_0_0/programator_axi_uartlite_0_0_board.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_uartlite_0_0/programator_axi_uartlite_0_0_board.xdc]
  read_xdc -ref programator_axi_uartlite_0_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_uartlite_0_0/programator_axi_uartlite_0_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_uartlite_0_0/programator_axi_uartlite_0_0.xdc]
  read_xdc -prop_thru_buffers -ref programator_axi_quad_spi_0_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_quad_spi_0_0/programator_axi_quad_spi_0_0_board.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_quad_spi_0_0/programator_axi_quad_spi_0_0_board.xdc]
  read_xdc -ref programator_axi_quad_spi_0_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_quad_spi_0_0/programator_axi_quad_spi_0_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_quad_spi_0_0/programator_axi_quad_spi_0_0.xdc]
  read_xdc -prop_thru_buffers -ref programator_axi_gpio_0_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_gpio_0_0/programator_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_gpio_0_0/programator_axi_gpio_0_0_board.xdc]
  read_xdc -ref programator_axi_gpio_0_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_gpio_0_0/programator_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_gpio_0_0/programator_axi_gpio_0_0.xdc]
  read_xdc -ref programator_mig_7series_0_0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_mig_7series_0_0/programator_mig_7series_0_0/user_design/constraints/programator_mig_7series_0_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_mig_7series_0_0/programator_mig_7series_0_0/user_design/constraints/programator_mig_7series_0_0.xdc]
  read_xdc -prop_thru_buffers -ref programator_mig_7series_0_0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_mig_7series_0_0/programator_mig_7series_0_0_board.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_mig_7series_0_0/programator_mig_7series_0_0_board.xdc]
  read_xdc -prop_thru_buffers -ref programator_rst_mig_7series_0_81M_0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_rst_mig_7series_0_81M_0/programator_rst_mig_7series_0_81M_0_board.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_rst_mig_7series_0_81M_0/programator_rst_mig_7series_0_81M_0_board.xdc]
  read_xdc -ref programator_rst_mig_7series_0_81M_0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_rst_mig_7series_0_81M_0/programator_rst_mig_7series_0_81M_0.xdc
  set_property processing_order EARLY [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_rst_mig_7series_0_81M_0/programator_rst_mig_7series_0_81M_0.xdc]
  read_xdc D:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/constrs_1/imports/Downloads/Nexys4DDR_Master.xdc
  read_xdc -ref programator_microblaze_0_axi_intc_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_microblaze_0_axi_intc_0/programator_microblaze_0_axi_intc_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_microblaze_0_axi_intc_0/programator_microblaze_0_axi_intc_0_clocks.xdc]
  read_xdc -ref programator_axi_quad_spi_0_0 -cells U0 d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_quad_spi_0_0/programator_axi_quad_spi_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_axi_quad_spi_0_0/programator_axi_quad_spi_0_0_clocks.xdc]
  read_xdc -ref programator_auto_ds_0 -cells inst d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_ds_0/programator_auto_ds_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_ds_0/programator_auto_ds_0_clocks.xdc]
  read_xdc -ref programator_auto_ds_1 -cells inst d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_ds_1/programator_auto_ds_1_clocks.xdc
  set_property processing_order LATE [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_ds_1/programator_auto_ds_1_clocks.xdc]
  read_xdc -ref programator_auto_ds_2 -cells inst d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_ds_2/programator_auto_ds_2_clocks.xdc
  set_property processing_order LATE [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_ds_2/programator_auto_ds_2_clocks.xdc]
  read_xdc -ref programator_auto_ds_3 -cells inst d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_ds_3/programator_auto_ds_3_clocks.xdc
  set_property processing_order LATE [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_ds_3/programator_auto_ds_3_clocks.xdc]
  read_xdc -ref programator_auto_cc_0 -cells inst d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_cc_0/programator_auto_cc_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_cc_0/programator_auto_cc_0_clocks.xdc]
  read_xdc -ref programator_auto_us_0 -cells inst d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_us_0/programator_auto_us_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_us_0/programator_auto_us_0_clocks.xdc]
  read_xdc -ref programator_auto_us_1 -cells inst d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_us_1/programator_auto_us_1_clocks.xdc
  set_property processing_order LATE [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_us_1/programator_auto_us_1_clocks.xdc]
  read_xdc -ref programator_auto_us_2 -cells inst d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_us_2/programator_auto_us_2_clocks.xdc
  set_property processing_order LATE [get_files d:/Dropbox/dr/mgr/Workspaces/Vivado/CPUv1/CPUv1.srcs/sources_1/bd/programator/ip/programator_auto_us_2/programator_auto_us_2_clocks.xdc]
  link_design -top top_lvl -part xc7a100tcsg324-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force top_lvl_opt.dcp
  report_drc -file top_lvl_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file top_lvl.hwdef}
  place_design 
  write_checkpoint -force top_lvl_placed.dcp
  report_io -file top_lvl_io_placed.rpt
  report_utilization -file top_lvl_utilization_placed.rpt -pb top_lvl_utilization_placed.pb
  report_control_sets -verbose -file top_lvl_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force top_lvl_routed.dcp
  report_drc -file top_lvl_drc_routed.rpt -pb top_lvl_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file top_lvl_timing_summary_routed.rpt -rpx top_lvl_timing_summary_routed.rpx
  report_power -file top_lvl_power_routed.rpt -pb top_lvl_power_summary_routed.pb
  report_route_status -file top_lvl_route_status.rpt -pb top_lvl_route_status.pb
  report_clock_utilization -file top_lvl_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force top_lvl.mmi }
  catch { write_bmm -force top_lvl_bd.bmm }
  write_bitstream -force top_lvl.bit 
  catch { write_sysdef -hwdef top_lvl.hwdef -bitfile top_lvl.bit -meminfo top_lvl.mmi -file top_lvl.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

