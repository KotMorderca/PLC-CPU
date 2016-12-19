@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xsim top_lvl_behav -key {Behavioral:sim_1:Functional:top_lvl} -tclbatch top_lvl.tcl -view D:/Dropbox/mgr/Workspaces/Vivado/CPUv1/top_lvl_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
