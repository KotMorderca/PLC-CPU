// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Fri Jul 03 17:24:34 2015
// Host        : KotMorderca running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               E:/Dropbox/mgr/Workspaces/Vivado/CPUv1/CPUv1.sim/sim_1/synth/func/top_lvl_func_synth.v
// Design      : top_lvl
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module CPU
   (current_state,
    D,
    \LED[0] ,
    \douta_reg[6] ,
    Q,
    CLK1HZ_reg_n_0_BUFG,
    E,
    \douta_reg[4] ,
    \current_state_reg[1]_0 );
  output [1:0]current_state;
  output [6:0]D;
  output [12:0]\LED[0] ;
  input \douta_reg[6] ;
  input [6:0]Q;
  input CLK1HZ_reg_n_0_BUFG;
  input [0:0]E;
  input \douta_reg[4] ;
  input \current_state_reg[1]_0 ;

  wire CLK1HZ_reg_n_0_BUFG;
  wire [6:0]D;
  wire [0:0]E;
  wire [12:0]\LED[0] ;
  wire \PC[0]_i_2_n_0 ;
  wire \PC[0]_i_3_n_0 ;
  wire \PC[1]_i_1_n_0 ;
  wire \PC[2]_i_1_n_0 ;
  wire \PC[3]_i_1_n_0 ;
  wire \PC[4]_i_1_n_0 ;
  wire [6:0]Q;
  wire [0:4]addra;
  wire [1:0]current_state;
  wire \current_state[0]_i_1_n_0 ;
  wire \current_state[1]_i_1_n_0 ;
  wire \current_state_reg[1]_0 ;
  wire [4:0]data_out_bus0;
  wire \douta_reg[4] ;
  wire \douta_reg[6] ;
  wire [22:22]p_1_in;
  wire [3:0]stack_w_ptr;
  wire \stack_w_ptr[0]_i_1_n_0 ;
  wire \stack_w_ptr[1]_i_1_n_0 ;
  wire \stack_w_ptr[2]_i_1_n_0 ;
  wire \stack_w_ptr[3]_i_1_n_0 ;
  wire \stack_w_ptr[3]_i_3_n_0 ;

  (* XILINX_LEGACY_PRIM = "RAM16X1S" *) 
  RAM32X1S #(
    .INIT(32'h00000000)) 
    CR_w_reg_0_15_0_0
       (.A0(stack_w_ptr[0]),
        .A1(stack_w_ptr[1]),
        .A2(stack_w_ptr[2]),
        .A3(stack_w_ptr[3]),
        .A4(1'b0),
        .D(Q[0]),
        .O(data_out_bus0[0]),
        .WCLK(CLK1HZ_reg_n_0_BUFG),
        .WE(\douta_reg[4] ));
  (* XILINX_LEGACY_PRIM = "RAM16X1S" *) 
  RAM32X1S #(
    .INIT(32'h00000000)) 
    CR_w_reg_0_15_1_1
       (.A0(stack_w_ptr[0]),
        .A1(stack_w_ptr[1]),
        .A2(stack_w_ptr[2]),
        .A3(stack_w_ptr[3]),
        .A4(1'b0),
        .D(Q[1]),
        .O(data_out_bus0[1]),
        .WCLK(CLK1HZ_reg_n_0_BUFG),
        .WE(\douta_reg[4] ));
  (* XILINX_LEGACY_PRIM = "RAM16X1S" *) 
  RAM32X1S #(
    .INIT(32'h00000000)) 
    CR_w_reg_0_15_2_2
       (.A0(stack_w_ptr[0]),
        .A1(stack_w_ptr[1]),
        .A2(stack_w_ptr[2]),
        .A3(stack_w_ptr[3]),
        .A4(1'b0),
        .D(Q[2]),
        .O(data_out_bus0[2]),
        .WCLK(CLK1HZ_reg_n_0_BUFG),
        .WE(\douta_reg[4] ));
  (* XILINX_LEGACY_PRIM = "RAM16X1S" *) 
  RAM32X1S #(
    .INIT(32'h00000000)) 
    CR_w_reg_0_15_3_3
       (.A0(stack_w_ptr[0]),
        .A1(stack_w_ptr[1]),
        .A2(stack_w_ptr[2]),
        .A3(stack_w_ptr[3]),
        .A4(1'b0),
        .D(Q[6]),
        .O(data_out_bus0[3]),
        .WCLK(CLK1HZ_reg_n_0_BUFG),
        .WE(\douta_reg[4] ));
  (* XILINX_LEGACY_PRIM = "RAM16X1S" *) 
  RAM32X1S #(
    .INIT(32'h00000000)) 
    CR_w_reg_0_15_4_4
       (.A0(stack_w_ptr[0]),
        .A1(stack_w_ptr[1]),
        .A2(stack_w_ptr[2]),
        .A3(stack_w_ptr[3]),
        .A4(1'b0),
        .D(Q[6]),
        .O(data_out_bus0[4]),
        .WCLK(CLK1HZ_reg_n_0_BUFG),
        .WE(\douta_reg[4] ));
  LUT6 #(
    .INIT(64'h000000006AAA0000)) 
    \PC[0]_i_2 
       (.I0(addra[0]),
        .I1(addra[2]),
        .I2(\PC[0]_i_3_n_0 ),
        .I3(addra[1]),
        .I4(current_state[0]),
        .I5(\douta_reg[6] ),
        .O(\PC[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \PC[0]_i_3 
       (.I0(addra[4]),
        .I1(addra[3]),
        .O(\PC[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0444444440000000)) 
    \PC[1]_i_1 
       (.I0(\douta_reg[6] ),
        .I1(current_state[0]),
        .I2(addra[2]),
        .I3(addra[3]),
        .I4(addra[4]),
        .I5(addra[1]),
        .O(\PC[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFF006A0000006A00)) 
    \PC[2]_i_1 
       (.I0(addra[2]),
        .I1(addra[3]),
        .I2(addra[4]),
        .I3(current_state[0]),
        .I4(\douta_reg[6] ),
        .I5(Q[2]),
        .O(\PC[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h808C8C80)) 
    \PC[3]_i_1 
       (.I0(Q[1]),
        .I1(current_state[0]),
        .I2(\douta_reg[6] ),
        .I3(addra[3]),
        .I4(addra[4]),
        .O(\PC[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hC404)) 
    \PC[4]_i_1 
       (.I0(addra[4]),
        .I1(current_state[0]),
        .I2(\douta_reg[6] ),
        .I3(Q[0]),
        .O(\PC[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \PC_reg[0] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(E),
        .D(\PC[0]_i_2_n_0 ),
        .Q(addra[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PC_reg[1] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(E),
        .D(\PC[1]_i_1_n_0 ),
        .Q(addra[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PC_reg[2] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(E),
        .D(\PC[2]_i_1_n_0 ),
        .Q(addra[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PC_reg[3] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(E),
        .D(\PC[3]_i_1_n_0 ),
        .Q(addra[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PC_reg[4] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(E),
        .D(\PC[4]_i_1_n_0 ),
        .Q(addra[4]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h3FFFFFFF55555555)) 
    \current_state[0]_i_1 
       (.I0(current_state[1]),
        .I1(Q[3]),
        .I2(Q[4]),
        .I3(Q[5]),
        .I4(Q[6]),
        .I5(current_state[0]),
        .O(\current_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF000080000000)) 
    \current_state[1]_i_1 
       (.I0(Q[3]),
        .I1(Q[4]),
        .I2(Q[5]),
        .I3(Q[6]),
        .I4(current_state[0]),
        .I5(current_state[1]),
        .O(\current_state[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \current_state_reg[0] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(1'b1),
        .D(\current_state[0]_i_1_n_0 ),
        .Q(current_state[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \current_state_reg[1] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(1'b1),
        .D(\current_state[1]_i_1_n_0 ),
        .Q(current_state[1]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h1)) 
    \data_out_bus[9]_i_1 
       (.I0(current_state[1]),
        .I1(current_state[0]),
        .O(p_1_in));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[0] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(current_state[0]),
        .D(addra[0]),
        .Q(\LED[0] [12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[11] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(current_state[0]),
        .D(data_out_bus0[4]),
        .Q(\LED[0] [4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[12] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(current_state[0]),
        .D(data_out_bus0[3]),
        .Q(\LED[0] [3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[13] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(current_state[0]),
        .D(data_out_bus0[2]),
        .Q(\LED[0] [2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[14] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(current_state[0]),
        .D(data_out_bus0[1]),
        .Q(\LED[0] [1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[15] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(current_state[0]),
        .D(data_out_bus0[0]),
        .Q(\LED[0] [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[1] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(current_state[0]),
        .D(addra[1]),
        .Q(\LED[0] [11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[2] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(current_state[0]),
        .D(addra[2]),
        .Q(\LED[0] [10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[3] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(current_state[0]),
        .D(addra[3]),
        .Q(\LED[0] [9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[4] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(current_state[0]),
        .D(addra[4]),
        .Q(\LED[0] [8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[7] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(1'b1),
        .D(current_state[1]),
        .Q(\LED[0] [7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[8] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(1'b1),
        .D(current_state[0]),
        .Q(\LED[0] [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[9] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(1'b1),
        .D(p_1_in),
        .Q(\LED[0] [5]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h82020002)) 
    \douta[37]_i_1 
       (.I0(addra[3]),
        .I1(addra[0]),
        .I2(addra[1]),
        .I3(addra[4]),
        .I4(addra[2]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h80020002)) 
    \douta[38]_i_1 
       (.I0(addra[2]),
        .I1(addra[0]),
        .I2(addra[1]),
        .I3(addra[3]),
        .I4(addra[4]),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h82020002)) 
    \douta[39]_i_1 
       (.I0(addra[4]),
        .I1(addra[0]),
        .I2(addra[1]),
        .I3(addra[3]),
        .I4(addra[2]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \douta[3]_i_1 
       (.I0(addra[1]),
        .I1(addra[0]),
        .I2(addra[2]),
        .I3(addra[4]),
        .I4(addra[3]),
        .O(D[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h81000000)) 
    \douta[4]_i_1 
       (.I0(addra[1]),
        .I1(addra[0]),
        .I2(addra[2]),
        .I3(addra[4]),
        .I4(addra[3]),
        .O(D[5]));
  LUT5 #(
    .INIT(32'h80000110)) 
    \douta[6]_i_1 
       (.I0(addra[4]),
        .I1(addra[0]),
        .I2(addra[3]),
        .I3(addra[1]),
        .I4(addra[2]),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h81110504)) 
    \douta[7]_i_1 
       (.I0(addra[0]),
        .I1(addra[3]),
        .I2(addra[4]),
        .I3(addra[1]),
        .I4(addra[2]),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \stack_w_ptr[0]_i_1 
       (.I0(stack_w_ptr[0]),
        .O(\stack_w_ptr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \stack_w_ptr[1]_i_1 
       (.I0(stack_w_ptr[0]),
        .I1(stack_w_ptr[1]),
        .I2(Q[3]),
        .O(\stack_w_ptr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hD2B4)) 
    \stack_w_ptr[2]_i_1 
       (.I0(stack_w_ptr[0]),
        .I1(Q[3]),
        .I2(stack_w_ptr[2]),
        .I3(stack_w_ptr[1]),
        .O(\stack_w_ptr[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \stack_w_ptr[3]_i_1 
       (.I0(current_state[1]),
        .I1(current_state[0]),
        .O(\stack_w_ptr[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h9AAAAAA6)) 
    \stack_w_ptr[3]_i_3 
       (.I0(stack_w_ptr[3]),
        .I1(Q[3]),
        .I2(stack_w_ptr[0]),
        .I3(stack_w_ptr[2]),
        .I4(stack_w_ptr[1]),
        .O(\stack_w_ptr[3]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stack_w_ptr_reg[0] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(\current_state_reg[1]_0 ),
        .D(\stack_w_ptr[0]_i_1_n_0 ),
        .Q(stack_w_ptr[0]),
        .R(\stack_w_ptr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stack_w_ptr_reg[1] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(\current_state_reg[1]_0 ),
        .D(\stack_w_ptr[1]_i_1_n_0 ),
        .Q(stack_w_ptr[1]),
        .R(\stack_w_ptr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stack_w_ptr_reg[2] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(\current_state_reg[1]_0 ),
        .D(\stack_w_ptr[2]_i_1_n_0 ),
        .Q(stack_w_ptr[2]),
        .R(\stack_w_ptr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stack_w_ptr_reg[3] 
       (.C(CLK1HZ_reg_n_0_BUFG),
        .CE(\current_state_reg[1]_0 ),
        .D(\stack_w_ptr[3]_i_3_n_0 ),
        .Q(stack_w_ptr[3]),
        .R(\stack_w_ptr[3]_i_1_n_0 ));
endmodule

module program_memory_mock
   (E,
    Q,
    \data_out_bus_reg[11] ,
    \PC_reg[2] ,
    \stack_w_ptr_reg[0] ,
    current_state,
    D,
    CLK2HZ);
  output [0:0]E;
  output [6:0]Q;
  output \data_out_bus_reg[11] ;
  output \PC_reg[2] ;
  output \stack_w_ptr_reg[0] ;
  input [1:0]current_state;
  input [6:0]D;
  input CLK2HZ;

  wire CLK2HZ;
  wire [6:0]D;
  wire [0:0]E;
  wire \PC_reg[2] ;
  wire [6:0]Q;
  wire [1:0]current_state;
  wire \data_out_bus_reg[11] ;
  wire \stack_w_ptr_reg[0] ;

  LUT5 #(
    .INIT(32'h00000100)) 
    CR_w_reg_0_15_0_0_i_1
       (.I0(Q[5]),
        .I1(Q[6]),
        .I2(Q[4]),
        .I3(current_state[0]),
        .I4(Q[3]),
        .O(\data_out_bus_reg[11] ));
  LUT6 #(
    .INIT(64'h000000007FFFFFFF)) 
    \PC[0]_i_1 
       (.I0(current_state[0]),
        .I1(Q[6]),
        .I2(Q[5]),
        .I3(Q[4]),
        .I4(Q[3]),
        .I5(current_state[1]),
        .O(E));
  LUT4 #(
    .INIT(16'h0008)) 
    \PC[0]_i_4 
       (.I0(Q[4]),
        .I1(Q[3]),
        .I2(Q[6]),
        .I3(Q[5]),
        .O(\PC_reg[2] ));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[37] 
       (.C(CLK2HZ),
        .CE(1'b1),
        .D(D[2]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[38] 
       (.C(CLK2HZ),
        .CE(1'b1),
        .D(D[1]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[39] 
       (.C(CLK2HZ),
        .CE(1'b1),
        .D(D[0]),
        .Q(Q[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[3] 
       (.C(CLK2HZ),
        .CE(1'b1),
        .D(D[6]),
        .Q(Q[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[4] 
       (.C(CLK2HZ),
        .CE(1'b1),
        .D(D[5]),
        .Q(Q[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[6] 
       (.C(CLK2HZ),
        .CE(1'b1),
        .D(D[4]),
        .Q(Q[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[7] 
       (.C(CLK2HZ),
        .CE(1'b1),
        .D(D[3]),
        .Q(Q[3]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00015555)) 
    \stack_w_ptr[3]_i_2 
       (.I0(current_state[1]),
        .I1(Q[4]),
        .I2(Q[6]),
        .I3(Q[5]),
        .I4(current_state[0]),
        .O(\stack_w_ptr_reg[0] ));
endmodule

module ss_driver
   (Q,
    \anodes_reg[1]_0 ,
    CLK);
  output [6:0]Q;
  output [7:0]\anodes_reg[1]_0 ;
  input CLK;

  wire CLK;
  wire [6:0]Q;
  wire [0:0]anodes;
  wire \anodes[0]_i_2_n_0 ;
  wire [7:0]\anodes_reg[1]_0 ;
  wire \bars[0]_i_1_n_0 ;
  wire \bars[1]_i_1_n_0 ;
  wire \bars[2]_i_1_n_0 ;
  wire \bars[3]_i_1_n_0 ;
  wire \bars[5]_i_1_n_0 ;
  wire \bars[6]_i_1_n_0 ;
  wire \clk_counter[0]_i_1__0_n_0 ;
  wire \clk_counter[0]_i_3_n_0 ;
  wire \clk_counter[0]_i_4_n_0 ;
  wire \clk_counter[0]_i_5_n_0 ;
  wire \clk_counter[0]_i_6_n_0 ;
  wire \clk_counter[12]_i_2__0_n_0 ;
  wire \clk_counter[12]_i_3__0_n_0 ;
  wire \clk_counter[4]_i_2__0_n_0 ;
  wire \clk_counter[4]_i_3__0_n_0 ;
  wire \clk_counter[4]_i_4__0_n_0 ;
  wire \clk_counter[4]_i_5__0_n_0 ;
  wire \clk_counter[8]_i_2_n_0 ;
  wire \clk_counter[8]_i_3_n_0 ;
  wire \clk_counter[8]_i_4_n_0 ;
  wire \clk_counter[8]_i_5_n_0 ;
  wire [13:0]clk_counter_reg;
  wire \clk_counter_reg[0]_i_2_n_0 ;
  wire \clk_counter_reg[0]_i_2_n_1 ;
  wire \clk_counter_reg[0]_i_2_n_2 ;
  wire \clk_counter_reg[0]_i_2_n_3 ;
  wire \clk_counter_reg[0]_i_2_n_4 ;
  wire \clk_counter_reg[0]_i_2_n_5 ;
  wire \clk_counter_reg[0]_i_2_n_6 ;
  wire \clk_counter_reg[0]_i_2_n_7 ;
  wire \clk_counter_reg[12]_i_1_n_3 ;
  wire \clk_counter_reg[12]_i_1_n_6 ;
  wire \clk_counter_reg[12]_i_1_n_7 ;
  wire \clk_counter_reg[4]_i_1__0_n_0 ;
  wire \clk_counter_reg[4]_i_1__0_n_1 ;
  wire \clk_counter_reg[4]_i_1__0_n_2 ;
  wire \clk_counter_reg[4]_i_1__0_n_3 ;
  wire \clk_counter_reg[4]_i_1__0_n_4 ;
  wire \clk_counter_reg[4]_i_1__0_n_5 ;
  wire \clk_counter_reg[4]_i_1__0_n_6 ;
  wire \clk_counter_reg[4]_i_1__0_n_7 ;
  wire \clk_counter_reg[8]_i_1_n_0 ;
  wire \clk_counter_reg[8]_i_1_n_1 ;
  wire \clk_counter_reg[8]_i_1_n_2 ;
  wire \clk_counter_reg[8]_i_1_n_3 ;
  wire \clk_counter_reg[8]_i_1_n_4 ;
  wire \clk_counter_reg[8]_i_1_n_5 ;
  wire \clk_counter_reg[8]_i_1_n_6 ;
  wire \clk_counter_reg[8]_i_1_n_7 ;
  wire \current_display[0]_i_1_n_0 ;
  wire \current_display[1]_i_1_n_0 ;
  wire \current_display[2]_i_1_n_0 ;
  wire \current_display[2]_i_2_n_0 ;
  wire \current_display[2]_i_3_n_0 ;
  wire \current_display[2]_i_4_n_0 ;
  wire \current_display_reg_n_0_[0] ;
  wire \current_display_reg_n_0_[1] ;
  wire \current_display_reg_n_0_[2] ;
  wire [3:1]\NLW_clk_counter_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_clk_counter_reg[12]_i_1_O_UNCONNECTED ;

  LUT3 #(
    .INIT(8'hFD)) 
    \anodes[0]_i_1 
       (.I0(\anodes_reg[1]_0 [7]),
        .I1(\anodes[0]_i_2_n_0 ),
        .I2(\anodes_reg[1]_0 [0]),
        .O(anodes));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \anodes[0]_i_2 
       (.I0(\anodes_reg[1]_0 [6]),
        .I1(\anodes_reg[1]_0 [5]),
        .I2(\anodes_reg[1]_0 [4]),
        .I3(\anodes_reg[1]_0 [3]),
        .I4(\anodes_reg[1]_0 [2]),
        .I5(\anodes_reg[1]_0 [1]),
        .O(\anodes[0]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \anodes_reg[0] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(anodes),
        .Q(\anodes_reg[1]_0 [7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \anodes_reg[1] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(\anodes_reg[1]_0 [7]),
        .Q(\anodes_reg[1]_0 [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \anodes_reg[2] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(\anodes_reg[1]_0 [6]),
        .Q(\anodes_reg[1]_0 [5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \anodes_reg[3] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(\anodes_reg[1]_0 [5]),
        .Q(\anodes_reg[1]_0 [4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \anodes_reg[4] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(\anodes_reg[1]_0 [4]),
        .Q(\anodes_reg[1]_0 [3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \anodes_reg[5] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(\anodes_reg[1]_0 [3]),
        .Q(\anodes_reg[1]_0 [2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \anodes_reg[6] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(\anodes_reg[1]_0 [2]),
        .Q(\anodes_reg[1]_0 [1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \anodes_reg[7] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(\anodes_reg[1]_0 [1]),
        .Q(\anodes_reg[1]_0 [0]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \bars[0]_i_1 
       (.I0(\current_display_reg_n_0_[0] ),
        .I1(\current_display_reg_n_0_[2] ),
        .I2(\current_display_reg_n_0_[1] ),
        .O(\bars[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h48)) 
    \bars[1]_i_1 
       (.I0(\current_display_reg_n_0_[0] ),
        .I1(\current_display_reg_n_0_[2] ),
        .I2(\current_display_reg_n_0_[1] ),
        .O(\bars[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \bars[2]_i_1 
       (.I0(\current_display_reg_n_0_[0] ),
        .I1(\current_display_reg_n_0_[1] ),
        .I2(\current_display_reg_n_0_[2] ),
        .O(\bars[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h92)) 
    \bars[3]_i_1 
       (.I0(\current_display_reg_n_0_[2] ),
        .I1(\current_display_reg_n_0_[1] ),
        .I2(\current_display_reg_n_0_[0] ),
        .O(\bars[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB6)) 
    \bars[5]_i_1 
       (.I0(\current_display_reg_n_0_[1] ),
        .I1(\current_display_reg_n_0_[2] ),
        .I2(\current_display_reg_n_0_[0] ),
        .O(\bars[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h83)) 
    \bars[6]_i_1 
       (.I0(\current_display_reg_n_0_[0] ),
        .I1(\current_display_reg_n_0_[2] ),
        .I2(\current_display_reg_n_0_[1] ),
        .O(\bars[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \bars_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\bars[0]_i_1_n_0 ),
        .Q(Q[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \bars_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\bars[1]_i_1_n_0 ),
        .Q(Q[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \bars_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\bars[2]_i_1_n_0 ),
        .Q(Q[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \bars_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\bars[3]_i_1_n_0 ),
        .Q(Q[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \bars_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\current_display_reg_n_0_[0] ),
        .Q(Q[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \bars_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\bars[5]_i_1_n_0 ),
        .Q(Q[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \bars_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\bars[6]_i_1_n_0 ),
        .Q(Q[0]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \clk_counter[0]_i_1__0 
       (.I0(\current_display[2]_i_4_n_0 ),
        .I1(\current_display[2]_i_3_n_0 ),
        .I2(clk_counter_reg[10]),
        .I3(clk_counter_reg[12]),
        .O(\clk_counter[0]_i_1__0_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[0]_i_3 
       (.I0(clk_counter_reg[3]),
        .O(\clk_counter[0]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[0]_i_4 
       (.I0(clk_counter_reg[2]),
        .O(\clk_counter[0]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[0]_i_5 
       (.I0(clk_counter_reg[1]),
        .O(\clk_counter[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \clk_counter[0]_i_6 
       (.I0(clk_counter_reg[0]),
        .O(\clk_counter[0]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[12]_i_2__0 
       (.I0(clk_counter_reg[13]),
        .O(\clk_counter[12]_i_2__0_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[12]_i_3__0 
       (.I0(clk_counter_reg[12]),
        .O(\clk_counter[12]_i_3__0_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[4]_i_2__0 
       (.I0(clk_counter_reg[7]),
        .O(\clk_counter[4]_i_2__0_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[4]_i_3__0 
       (.I0(clk_counter_reg[6]),
        .O(\clk_counter[4]_i_3__0_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[4]_i_4__0 
       (.I0(clk_counter_reg[5]),
        .O(\clk_counter[4]_i_4__0_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[4]_i_5__0 
       (.I0(clk_counter_reg[4]),
        .O(\clk_counter[4]_i_5__0_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[8]_i_2 
       (.I0(clk_counter_reg[11]),
        .O(\clk_counter[8]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[8]_i_3 
       (.I0(clk_counter_reg[10]),
        .O(\clk_counter[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[8]_i_4 
       (.I0(clk_counter_reg[9]),
        .O(\clk_counter[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[8]_i_5 
       (.I0(clk_counter_reg[8]),
        .O(\clk_counter[8]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[0] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[0]_i_2_n_7 ),
        .Q(clk_counter_reg[0]),
        .R(1'b0));
  CARRY4 \clk_counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\clk_counter_reg[0]_i_2_n_0 ,\clk_counter_reg[0]_i_2_n_1 ,\clk_counter_reg[0]_i_2_n_2 ,\clk_counter_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\clk_counter_reg[0]_i_2_n_4 ,\clk_counter_reg[0]_i_2_n_5 ,\clk_counter_reg[0]_i_2_n_6 ,\clk_counter_reg[0]_i_2_n_7 }),
        .S({\clk_counter[0]_i_3_n_0 ,\clk_counter[0]_i_4_n_0 ,\clk_counter[0]_i_5_n_0 ,\clk_counter[0]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[10] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[8]_i_1_n_5 ),
        .Q(clk_counter_reg[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[11] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[8]_i_1_n_4 ),
        .Q(clk_counter_reg[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[12] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[12]_i_1_n_7 ),
        .Q(clk_counter_reg[12]),
        .R(1'b0));
  CARRY4 \clk_counter_reg[12]_i_1 
       (.CI(\clk_counter_reg[8]_i_1_n_0 ),
        .CO({\NLW_clk_counter_reg[12]_i_1_CO_UNCONNECTED [3:1],\clk_counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_clk_counter_reg[12]_i_1_O_UNCONNECTED [3:2],\clk_counter_reg[12]_i_1_n_6 ,\clk_counter_reg[12]_i_1_n_7 }),
        .S({1'b0,1'b0,\clk_counter[12]_i_2__0_n_0 ,\clk_counter[12]_i_3__0_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[13] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[12]_i_1_n_6 ),
        .Q(clk_counter_reg[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[1] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[0]_i_2_n_6 ),
        .Q(clk_counter_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[2] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[0]_i_2_n_5 ),
        .Q(clk_counter_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[3] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[0]_i_2_n_4 ),
        .Q(clk_counter_reg[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[4] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[4]_i_1__0_n_7 ),
        .Q(clk_counter_reg[4]),
        .R(1'b0));
  CARRY4 \clk_counter_reg[4]_i_1__0 
       (.CI(\clk_counter_reg[0]_i_2_n_0 ),
        .CO({\clk_counter_reg[4]_i_1__0_n_0 ,\clk_counter_reg[4]_i_1__0_n_1 ,\clk_counter_reg[4]_i_1__0_n_2 ,\clk_counter_reg[4]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clk_counter_reg[4]_i_1__0_n_4 ,\clk_counter_reg[4]_i_1__0_n_5 ,\clk_counter_reg[4]_i_1__0_n_6 ,\clk_counter_reg[4]_i_1__0_n_7 }),
        .S({\clk_counter[4]_i_2__0_n_0 ,\clk_counter[4]_i_3__0_n_0 ,\clk_counter[4]_i_4__0_n_0 ,\clk_counter[4]_i_5__0_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[5] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[4]_i_1__0_n_6 ),
        .Q(clk_counter_reg[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[6] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[4]_i_1__0_n_5 ),
        .Q(clk_counter_reg[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[7] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[4]_i_1__0_n_4 ),
        .Q(clk_counter_reg[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[8] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[8]_i_1_n_7 ),
        .Q(clk_counter_reg[8]),
        .R(1'b0));
  CARRY4 \clk_counter_reg[8]_i_1 
       (.CI(\clk_counter_reg[4]_i_1__0_n_0 ),
        .CO({\clk_counter_reg[8]_i_1_n_0 ,\clk_counter_reg[8]_i_1_n_1 ,\clk_counter_reg[8]_i_1_n_2 ,\clk_counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clk_counter_reg[8]_i_1_n_4 ,\clk_counter_reg[8]_i_1_n_5 ,\clk_counter_reg[8]_i_1_n_6 ,\clk_counter_reg[8]_i_1_n_7 }),
        .S({\clk_counter[8]_i_2_n_0 ,\clk_counter[8]_i_3_n_0 ,\clk_counter[8]_i_4_n_0 ,\clk_counter[8]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[9] 
       (.C(CLK),
        .CE(\clk_counter[0]_i_1__0_n_0 ),
        .D(\clk_counter_reg[8]_i_1_n_6 ),
        .Q(clk_counter_reg[9]),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \current_display[0]_i_1 
       (.I0(\current_display_reg_n_0_[0] ),
        .O(\current_display[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \current_display[1]_i_1 
       (.I0(\current_display_reg_n_0_[0] ),
        .I1(\current_display_reg_n_0_[1] ),
        .O(\current_display[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h4000)) 
    \current_display[2]_i_1 
       (.I0(clk_counter_reg[12]),
        .I1(clk_counter_reg[10]),
        .I2(\current_display[2]_i_3_n_0 ),
        .I3(\current_display[2]_i_4_n_0 ),
        .O(\current_display[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \current_display[2]_i_2 
       (.I0(\current_display_reg_n_0_[2] ),
        .I1(\current_display_reg_n_0_[0] ),
        .I2(\current_display_reg_n_0_[1] ),
        .O(\current_display[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0040000000000000)) 
    \current_display[2]_i_3 
       (.I0(clk_counter_reg[7]),
        .I1(clk_counter_reg[13]),
        .I2(clk_counter_reg[2]),
        .I3(clk_counter_reg[4]),
        .I4(clk_counter_reg[3]),
        .I5(clk_counter_reg[8]),
        .O(\current_display[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0010000000000000)) 
    \current_display[2]_i_4 
       (.I0(clk_counter_reg[6]),
        .I1(clk_counter_reg[5]),
        .I2(clk_counter_reg[1]),
        .I3(clk_counter_reg[11]),
        .I4(clk_counter_reg[0]),
        .I5(clk_counter_reg[9]),
        .O(\current_display[2]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \current_display_reg[0] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(\current_display[0]_i_1_n_0 ),
        .Q(\current_display_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \current_display_reg[1] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(\current_display[1]_i_1_n_0 ),
        .Q(\current_display_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \current_display_reg[2] 
       (.C(CLK),
        .CE(\current_display[2]_i_1_n_0 ),
        .D(\current_display[2]_i_2_n_0 ),
        .Q(\current_display_reg_n_0_[2] ),
        .R(1'b0));
endmodule

(* NotValidForBitStream *)
module top_lvl
   (CLK100MHZ,
    CA,
    AN,
    LED);
  input CLK100MHZ;
  output [0:7]CA;
  output [0:7]AN;
  output [0:15]LED;

  wire [0:7]AN;
  wire [0:7]AN_OBUF;
  wire [0:7]CA;
  wire [0:6]CA_OBUF;
  wire CLK100MHZ;
  wire CLK100MHZ_IBUF;
  wire CLK100MHZ_IBUF_BUFG;
  wire CLK1HZ_i_1_n_0;
  wire CLK1HZ_reg_n_0_BUFG;
  wire CLK1HZ_reg_n_0_BUFG_inst_n_0;
  wire CLK2HZ;
  wire CLK2HZ_i_1_n_0;
  wire CPU_INST_n_2;
  wire CPU_INST_n_3;
  wire CPU_INST_n_4;
  wire CPU_INST_n_5;
  wire CPU_INST_n_6;
  wire CPU_INST_n_7;
  wire CPU_INST_n_8;
  wire [0:15]LED;
  wire [0:15]LED_OBUF;
  wire PROGRAM_MEMORY_INST_n_0;
  wire PROGRAM_MEMORY_INST_n_10;
  wire PROGRAM_MEMORY_INST_n_8;
  wire PROGRAM_MEMORY_INST_n_9;
  wire [13:0]clk_counter;
  wire \clk_counter[0]_i_1_n_0 ;
  wire \clk_counter[11]_i_2_n_0 ;
  wire \clk_counter[11]_i_3_n_0 ;
  wire \clk_counter[11]_i_4_n_0 ;
  wire \clk_counter[11]_i_5_n_0 ;
  wire \clk_counter[12]_i_1_n_0 ;
  wire \clk_counter[12]_i_2_n_0 ;
  wire \clk_counter[12]_i_3_n_0 ;
  wire \clk_counter[12]_i_4_n_0 ;
  wire \clk_counter[13]_i_1_n_0 ;
  wire \clk_counter[13]_i_3_n_0 ;
  wire \clk_counter[13]_i_4_n_0 ;
  wire \clk_counter[13]_i_5_n_0 ;
  wire \clk_counter[3]_i_1_n_0 ;
  wire \clk_counter[4]_i_2_n_0 ;
  wire \clk_counter[4]_i_3_n_0 ;
  wire \clk_counter[4]_i_4_n_0 ;
  wire \clk_counter[4]_i_5_n_0 ;
  wire \clk_counter[6]_i_2_n_0 ;
  wire \clk_counter[6]_i_3_n_0 ;
  wire \clk_counter[6]_i_4_n_0 ;
  wire \clk_counter[6]_i_5_n_0 ;
  wire \clk_counter[7]_i_1_n_0 ;
  wire \clk_counter[8]_i_1_n_0 ;
  wire \clk_counter[9]_i_1_n_0 ;
  wire \clk_counter_reg[11]_i_1_n_0 ;
  wire \clk_counter_reg[11]_i_1_n_1 ;
  wire \clk_counter_reg[11]_i_1_n_2 ;
  wire \clk_counter_reg[11]_i_1_n_3 ;
  wire \clk_counter_reg[11]_i_1_n_4 ;
  wire \clk_counter_reg[11]_i_1_n_5 ;
  wire \clk_counter_reg[11]_i_1_n_6 ;
  wire \clk_counter_reg[11]_i_1_n_7 ;
  wire \clk_counter_reg[13]_i_2_n_7 ;
  wire \clk_counter_reg[4]_i_1_n_0 ;
  wire \clk_counter_reg[4]_i_1_n_1 ;
  wire \clk_counter_reg[4]_i_1_n_2 ;
  wire \clk_counter_reg[4]_i_1_n_3 ;
  wire \clk_counter_reg[4]_i_1_n_4 ;
  wire \clk_counter_reg[4]_i_1_n_5 ;
  wire \clk_counter_reg[4]_i_1_n_6 ;
  wire \clk_counter_reg[4]_i_1_n_7 ;
  wire \clk_counter_reg[6]_i_1_n_0 ;
  wire \clk_counter_reg[6]_i_1_n_1 ;
  wire \clk_counter_reg[6]_i_1_n_2 ;
  wire \clk_counter_reg[6]_i_1_n_3 ;
  wire \clk_counter_reg[6]_i_1_n_4 ;
  wire \clk_counter_reg[6]_i_1_n_5 ;
  wire \clk_counter_reg[6]_i_1_n_6 ;
  wire \clk_counter_reg[6]_i_1_n_7 ;
  wire [1:0]current_state;
  wire [37:39]douta;
  wire [4:0]sel0;
  wire [3:0]\NLW_clk_counter_reg[13]_i_2_CO_UNCONNECTED ;
  wire [3:1]\NLW_clk_counter_reg[13]_i_2_O_UNCONNECTED ;

  OBUF \AN_OBUF[0]_inst 
       (.I(AN_OBUF[0]),
        .O(AN[0]));
  OBUF \AN_OBUF[1]_inst 
       (.I(AN_OBUF[1]),
        .O(AN[1]));
  OBUF \AN_OBUF[2]_inst 
       (.I(AN_OBUF[2]),
        .O(AN[2]));
  OBUF \AN_OBUF[3]_inst 
       (.I(AN_OBUF[3]),
        .O(AN[3]));
  OBUF \AN_OBUF[4]_inst 
       (.I(AN_OBUF[4]),
        .O(AN[4]));
  OBUF \AN_OBUF[5]_inst 
       (.I(AN_OBUF[5]),
        .O(AN[5]));
  OBUF \AN_OBUF[6]_inst 
       (.I(AN_OBUF[6]),
        .O(AN[6]));
  OBUF \AN_OBUF[7]_inst 
       (.I(AN_OBUF[7]),
        .O(AN[7]));
  OBUF \CA_OBUF[0]_inst 
       (.I(CA_OBUF[0]),
        .O(CA[0]));
  OBUF \CA_OBUF[1]_inst 
       (.I(CA_OBUF[1]),
        .O(CA[1]));
  OBUF \CA_OBUF[2]_inst 
       (.I(CA_OBUF[2]),
        .O(CA[2]));
  OBUF \CA_OBUF[3]_inst 
       (.I(CA_OBUF[3]),
        .O(CA[3]));
  OBUF \CA_OBUF[4]_inst 
       (.I(CA_OBUF[4]),
        .O(CA[4]));
  OBUF \CA_OBUF[5]_inst 
       (.I(CA_OBUF[5]),
        .O(CA[5]));
  OBUF \CA_OBUF[6]_inst 
       (.I(CA_OBUF[6]),
        .O(CA[6]));
  OBUF \CA_OBUF[7]_inst 
       (.I(1'b1),
        .O(CA[7]));
  BUFG CLK100MHZ_IBUF_BUFG_inst
       (.I(CLK100MHZ_IBUF),
        .O(CLK100MHZ_IBUF_BUFG));
  IBUF CLK100MHZ_IBUF_inst
       (.I(CLK100MHZ),
        .O(CLK100MHZ_IBUF));
  LUT6 #(
    .INIT(64'hFFFFFFF700000008)) 
    CLK1HZ_i_1
       (.I0(clk_counter[9]),
        .I1(clk_counter[1]),
        .I2(clk_counter[11]),
        .I3(\clk_counter[13]_i_3_n_0 ),
        .I4(\clk_counter[12]_i_4_n_0 ),
        .I5(CLK1HZ_reg_n_0_BUFG_inst_n_0),
        .O(CLK1HZ_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    CLK1HZ_reg
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(CLK1HZ_i_1_n_0),
        .Q(CLK1HZ_reg_n_0_BUFG_inst_n_0),
        .R(1'b0));
  BUFG CLK1HZ_reg_n_0_BUFG_inst
       (.I(CLK1HZ_reg_n_0_BUFG_inst_n_0),
        .O(CLK1HZ_reg_n_0_BUFG));
  LUT6 #(
    .INIT(64'hFFFFFFF700000008)) 
    CLK2HZ_i_1
       (.I0(clk_counter[9]),
        .I1(clk_counter[1]),
        .I2(clk_counter[11]),
        .I3(\clk_counter[13]_i_3_n_0 ),
        .I4(\clk_counter[13]_i_4_n_0 ),
        .I5(CLK2HZ),
        .O(CLK2HZ_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    CLK2HZ_reg
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(CLK2HZ_i_1_n_0),
        .Q(CLK2HZ),
        .R(1'b0));
  CPU CPU_INST
       (.CLK1HZ_reg_n_0_BUFG(CLK1HZ_reg_n_0_BUFG),
        .D({CPU_INST_n_2,CPU_INST_n_3,CPU_INST_n_4,CPU_INST_n_5,CPU_INST_n_6,CPU_INST_n_7,CPU_INST_n_8}),
        .E(PROGRAM_MEMORY_INST_n_0),
        .\LED[0] ({LED_OBUF[0],LED_OBUF[1],LED_OBUF[2],LED_OBUF[3],LED_OBUF[4],LED_OBUF[7],LED_OBUF[8],LED_OBUF[9],LED_OBUF[11],LED_OBUF[12],LED_OBUF[13],LED_OBUF[14],LED_OBUF[15]}),
        .Q({sel0[4:3],sel0[1:0],douta[37],douta[38],douta[39]}),
        .current_state(current_state),
        .\current_state_reg[1]_0 (PROGRAM_MEMORY_INST_n_10),
        .\douta_reg[4] (PROGRAM_MEMORY_INST_n_8),
        .\douta_reg[6] (PROGRAM_MEMORY_INST_n_9));
  OBUF \LED_OBUF[0]_inst 
       (.I(LED_OBUF[0]),
        .O(LED[0]));
  OBUF \LED_OBUF[10]_inst 
       (.I(1'b0),
        .O(LED[10]));
  OBUF \LED_OBUF[11]_inst 
       (.I(LED_OBUF[11]),
        .O(LED[11]));
  OBUF \LED_OBUF[12]_inst 
       (.I(LED_OBUF[12]),
        .O(LED[12]));
  OBUF \LED_OBUF[13]_inst 
       (.I(LED_OBUF[13]),
        .O(LED[13]));
  OBUF \LED_OBUF[14]_inst 
       (.I(LED_OBUF[14]),
        .O(LED[14]));
  OBUF \LED_OBUF[15]_inst 
       (.I(LED_OBUF[15]),
        .O(LED[15]));
  OBUF \LED_OBUF[1]_inst 
       (.I(LED_OBUF[1]),
        .O(LED[1]));
  OBUF \LED_OBUF[2]_inst 
       (.I(LED_OBUF[2]),
        .O(LED[2]));
  OBUF \LED_OBUF[3]_inst 
       (.I(LED_OBUF[3]),
        .O(LED[3]));
  OBUF \LED_OBUF[4]_inst 
       (.I(LED_OBUF[4]),
        .O(LED[4]));
  OBUF \LED_OBUF[5]_inst 
       (.I(1'b0),
        .O(LED[5]));
  OBUF \LED_OBUF[6]_inst 
       (.I(1'b0),
        .O(LED[6]));
  OBUF \LED_OBUF[7]_inst 
       (.I(LED_OBUF[7]),
        .O(LED[7]));
  OBUF \LED_OBUF[8]_inst 
       (.I(LED_OBUF[8]),
        .O(LED[8]));
  OBUF \LED_OBUF[9]_inst 
       (.I(LED_OBUF[9]),
        .O(LED[9]));
  program_memory_mock PROGRAM_MEMORY_INST
       (.CLK2HZ(CLK2HZ),
        .D({CPU_INST_n_2,CPU_INST_n_3,CPU_INST_n_4,CPU_INST_n_5,CPU_INST_n_6,CPU_INST_n_7,CPU_INST_n_8}),
        .E(PROGRAM_MEMORY_INST_n_0),
        .\PC_reg[2] (PROGRAM_MEMORY_INST_n_9),
        .Q({sel0[4:3],sel0[1:0],douta[37],douta[38],douta[39]}),
        .current_state(current_state),
        .\data_out_bus_reg[11] (PROGRAM_MEMORY_INST_n_8),
        .\stack_w_ptr_reg[0] (PROGRAM_MEMORY_INST_n_10));
  ss_driver SS_DRIVER_INST
       (.CLK(CLK1HZ_reg_n_0_BUFG),
        .Q({CA_OBUF[0],CA_OBUF[1],CA_OBUF[2],CA_OBUF[3],CA_OBUF[4],CA_OBUF[5],CA_OBUF[6]}),
        .\anodes_reg[1]_0 ({AN_OBUF[0],AN_OBUF[1],AN_OBUF[2],AN_OBUF[3],AN_OBUF[4],AN_OBUF[5],AN_OBUF[6],AN_OBUF[7]}));
  LUT1 #(
    .INIT(2'h1)) 
    \clk_counter[0]_i_1 
       (.I0(clk_counter[0]),
        .O(\clk_counter[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[11]_i_2 
       (.I0(clk_counter[12]),
        .O(\clk_counter[11]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[11]_i_3 
       (.I0(clk_counter[11]),
        .O(\clk_counter[11]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[11]_i_4 
       (.I0(clk_counter[10]),
        .O(\clk_counter[11]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[11]_i_5 
       (.I0(clk_counter[9]),
        .O(\clk_counter[11]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \clk_counter[12]_i_1 
       (.I0(clk_counter[10]),
        .I1(\clk_counter[12]_i_3_n_0 ),
        .I2(\clk_counter[13]_i_3_n_0 ),
        .I3(clk_counter[11]),
        .I4(clk_counter[1]),
        .I5(clk_counter[9]),
        .O(\clk_counter[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFF700000000)) 
    \clk_counter[12]_i_2 
       (.I0(clk_counter[9]),
        .I1(clk_counter[1]),
        .I2(clk_counter[11]),
        .I3(\clk_counter[13]_i_3_n_0 ),
        .I4(\clk_counter[12]_i_4_n_0 ),
        .I5(\clk_counter_reg[11]_i_1_n_4 ),
        .O(\clk_counter[12]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \clk_counter[12]_i_3 
       (.I0(clk_counter[7]),
        .I1(clk_counter[3]),
        .I2(clk_counter[12]),
        .I3(clk_counter[13]),
        .O(\clk_counter[12]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'hFBFFFFFF)) 
    \clk_counter[12]_i_4 
       (.I0(clk_counter[12]),
        .I1(clk_counter[13]),
        .I2(clk_counter[7]),
        .I3(clk_counter[3]),
        .I4(clk_counter[10]),
        .O(\clk_counter[12]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000008)) 
    \clk_counter[13]_i_1 
       (.I0(clk_counter[9]),
        .I1(clk_counter[1]),
        .I2(clk_counter[11]),
        .I3(\clk_counter[13]_i_3_n_0 ),
        .I4(\clk_counter[13]_i_4_n_0 ),
        .O(\clk_counter[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFDFFF)) 
    \clk_counter[13]_i_3 
       (.I0(clk_counter[2]),
        .I1(clk_counter[4]),
        .I2(clk_counter[8]),
        .I3(clk_counter[0]),
        .I4(clk_counter[5]),
        .I5(clk_counter[6]),
        .O(\clk_counter[13]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'hFFDFFBFF)) 
    \clk_counter[13]_i_4 
       (.I0(clk_counter[10]),
        .I1(clk_counter[7]),
        .I2(clk_counter[3]),
        .I3(clk_counter[12]),
        .I4(clk_counter[13]),
        .O(\clk_counter[13]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[13]_i_5 
       (.I0(clk_counter[13]),
        .O(\clk_counter[13]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFF700000000)) 
    \clk_counter[3]_i_1 
       (.I0(clk_counter[9]),
        .I1(clk_counter[1]),
        .I2(clk_counter[11]),
        .I3(\clk_counter[13]_i_3_n_0 ),
        .I4(\clk_counter[12]_i_4_n_0 ),
        .I5(\clk_counter_reg[4]_i_1_n_5 ),
        .O(\clk_counter[3]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[4]_i_2 
       (.I0(clk_counter[4]),
        .O(\clk_counter[4]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[4]_i_3 
       (.I0(clk_counter[3]),
        .O(\clk_counter[4]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[4]_i_4 
       (.I0(clk_counter[2]),
        .O(\clk_counter[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[4]_i_5 
       (.I0(clk_counter[1]),
        .O(\clk_counter[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[6]_i_2 
       (.I0(clk_counter[8]),
        .O(\clk_counter[6]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[6]_i_3 
       (.I0(clk_counter[7]),
        .O(\clk_counter[6]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[6]_i_4 
       (.I0(clk_counter[6]),
        .O(\clk_counter[6]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \clk_counter[6]_i_5 
       (.I0(clk_counter[5]),
        .O(\clk_counter[6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFF700000000)) 
    \clk_counter[7]_i_1 
       (.I0(clk_counter[9]),
        .I1(clk_counter[1]),
        .I2(clk_counter[11]),
        .I3(\clk_counter[13]_i_3_n_0 ),
        .I4(\clk_counter[12]_i_4_n_0 ),
        .I5(\clk_counter_reg[6]_i_1_n_5 ),
        .O(\clk_counter[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFF700000000)) 
    \clk_counter[8]_i_1 
       (.I0(clk_counter[9]),
        .I1(clk_counter[1]),
        .I2(clk_counter[11]),
        .I3(\clk_counter[13]_i_3_n_0 ),
        .I4(\clk_counter[12]_i_4_n_0 ),
        .I5(\clk_counter_reg[6]_i_1_n_4 ),
        .O(\clk_counter[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFF700000000)) 
    \clk_counter[9]_i_1 
       (.I0(clk_counter[9]),
        .I1(clk_counter[1]),
        .I2(clk_counter[11]),
        .I3(\clk_counter[13]_i_3_n_0 ),
        .I4(\clk_counter[12]_i_4_n_0 ),
        .I5(\clk_counter_reg[11]_i_1_n_7 ),
        .O(\clk_counter[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[0] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter[0]_i_1_n_0 ),
        .Q(clk_counter[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[10] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter_reg[11]_i_1_n_6 ),
        .Q(clk_counter[10]),
        .R(\clk_counter[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[11] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter_reg[11]_i_1_n_5 ),
        .Q(clk_counter[11]),
        .R(\clk_counter[13]_i_1_n_0 ));
  CARRY4 \clk_counter_reg[11]_i_1 
       (.CI(\clk_counter_reg[6]_i_1_n_0 ),
        .CO({\clk_counter_reg[11]_i_1_n_0 ,\clk_counter_reg[11]_i_1_n_1 ,\clk_counter_reg[11]_i_1_n_2 ,\clk_counter_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clk_counter_reg[11]_i_1_n_4 ,\clk_counter_reg[11]_i_1_n_5 ,\clk_counter_reg[11]_i_1_n_6 ,\clk_counter_reg[11]_i_1_n_7 }),
        .S({\clk_counter[11]_i_2_n_0 ,\clk_counter[11]_i_3_n_0 ,\clk_counter[11]_i_4_n_0 ,\clk_counter[11]_i_5_n_0 }));
  FDSE #(
    .INIT(1'b0)) 
    \clk_counter_reg[12] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter[12]_i_2_n_0 ),
        .Q(clk_counter[12]),
        .S(\clk_counter[12]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[13] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter_reg[13]_i_2_n_7 ),
        .Q(clk_counter[13]),
        .R(\clk_counter[13]_i_1_n_0 ));
  CARRY4 \clk_counter_reg[13]_i_2 
       (.CI(\clk_counter_reg[11]_i_1_n_0 ),
        .CO(\NLW_clk_counter_reg[13]_i_2_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_clk_counter_reg[13]_i_2_O_UNCONNECTED [3:1],\clk_counter_reg[13]_i_2_n_7 }),
        .S({1'b0,1'b0,1'b0,\clk_counter[13]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[1] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter_reg[4]_i_1_n_7 ),
        .Q(clk_counter[1]),
        .R(\clk_counter[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[2] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter_reg[4]_i_1_n_6 ),
        .Q(clk_counter[2]),
        .R(\clk_counter[13]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b0)) 
    \clk_counter_reg[3] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter[3]_i_1_n_0 ),
        .Q(clk_counter[3]),
        .S(\clk_counter[12]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[4] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter_reg[4]_i_1_n_4 ),
        .Q(clk_counter[4]),
        .R(\clk_counter[13]_i_1_n_0 ));
  CARRY4 \clk_counter_reg[4]_i_1 
       (.CI(1'b0),
        .CO({\clk_counter_reg[4]_i_1_n_0 ,\clk_counter_reg[4]_i_1_n_1 ,\clk_counter_reg[4]_i_1_n_2 ,\clk_counter_reg[4]_i_1_n_3 }),
        .CYINIT(clk_counter[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clk_counter_reg[4]_i_1_n_4 ,\clk_counter_reg[4]_i_1_n_5 ,\clk_counter_reg[4]_i_1_n_6 ,\clk_counter_reg[4]_i_1_n_7 }),
        .S({\clk_counter[4]_i_2_n_0 ,\clk_counter[4]_i_3_n_0 ,\clk_counter[4]_i_4_n_0 ,\clk_counter[4]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[5] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter_reg[6]_i_1_n_7 ),
        .Q(clk_counter[5]),
        .R(\clk_counter[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[6] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter_reg[6]_i_1_n_6 ),
        .Q(clk_counter[6]),
        .R(\clk_counter[13]_i_1_n_0 ));
  CARRY4 \clk_counter_reg[6]_i_1 
       (.CI(\clk_counter_reg[4]_i_1_n_0 ),
        .CO({\clk_counter_reg[6]_i_1_n_0 ,\clk_counter_reg[6]_i_1_n_1 ,\clk_counter_reg[6]_i_1_n_2 ,\clk_counter_reg[6]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clk_counter_reg[6]_i_1_n_4 ,\clk_counter_reg[6]_i_1_n_5 ,\clk_counter_reg[6]_i_1_n_6 ,\clk_counter_reg[6]_i_1_n_7 }),
        .S({\clk_counter[6]_i_2_n_0 ,\clk_counter[6]_i_3_n_0 ,\clk_counter[6]_i_4_n_0 ,\clk_counter[6]_i_5_n_0 }));
  FDSE #(
    .INIT(1'b0)) 
    \clk_counter_reg[7] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter[7]_i_1_n_0 ),
        .Q(clk_counter[7]),
        .S(\clk_counter[12]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b0)) 
    \clk_counter_reg[8] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter[8]_i_1_n_0 ),
        .Q(clk_counter[8]),
        .S(\clk_counter[12]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b0)) 
    \clk_counter_reg[9] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter[9]_i_1_n_0 ),
        .Q(clk_counter[9]),
        .S(\clk_counter[12]_i_1_n_0 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
