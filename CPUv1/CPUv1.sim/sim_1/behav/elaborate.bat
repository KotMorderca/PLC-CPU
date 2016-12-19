@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 505e6d7939bc494d983c5a49e2fa0360 -m64 --debug typical --relax --mt 2 --include "../../../CPUv1.srcs/sources_1/ipshared/xilinx.com/axi_infrastructure_v1_1/cf21a66f/hdl/verilog" -L xil_defaultlib -L microblaze_v9_5 -L lmb_v10_v3_0 -L lmb_bram_if_cntlr_v4_0 -L blk_mem_gen_v8_2 -L axi_lite_ipif_v3_0 -L axi_intc_v4_1 -L mdm_v3_2 -L lib_cdc_v1_0 -L proc_sys_reset_v5_0 -L lib_pkg_v1_0 -L lib_srl_fifo_v1_0 -L axi_uartlite_v2_0 -L dist_mem_gen_v8_0 -L fifo_generator_v12_0 -L lib_fifo_v1_0 -L interrupt_control_v3_1 -L axi_quad_spi_v3_2 -L axi_gpio_v2_0 -L generic_baseblocks_v2_1 -L axi_infrastructure_v1_1 -L axi_register_slice_v2_1 -L axi_data_fifo_v2_1 -L axi_crossbar_v2_1 -L axi_protocol_converter_v2_1 -L axi_clock_converter_v2_1 -L axi_dwidth_converter_v2_1 -L unisims_ver -L unimacro_ver -L secureip --snapshot top_lvl_behav xil_defaultlib.top_lvl xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
