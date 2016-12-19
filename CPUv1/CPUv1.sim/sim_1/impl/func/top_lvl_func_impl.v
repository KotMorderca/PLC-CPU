// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Thu Jul 02 22:47:18 2015
// Host        : Piotrek-Dom running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               D:/Dropbox/mgr/Workspaces/Vivado/CPUv1/CPUv1.sim/sim_1/impl/func/top_lvl_func_impl.v
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
    CLK1HZ,
    E,
    \douta_reg[4] ,
    \current_state_reg[1]_0 );
  output [1:0]current_state;
  output [6:0]D;
  output [12:0]\LED[0] ;
  input \douta_reg[6] ;
  input [6:0]Q;
  input CLK1HZ;
  input [0:0]E;
  input \douta_reg[4] ;
  input \current_state_reg[1]_0 ;

  wire CLK1HZ;
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
        .WCLK(CLK1HZ),
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
        .WCLK(CLK1HZ),
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
        .WCLK(CLK1HZ),
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
        .WCLK(CLK1HZ),
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
        .WCLK(CLK1HZ),
        .WE(\douta_reg[4] ));
  LUT6 #(
    .INIT(64'h000000009AAA0000)) 
    \PC[0]_i_2 
       (.I0(addra[0]),
        .I1(\PC[0]_i_3_n_0 ),
        .I2(addra[2]),
        .I3(addra[1]),
        .I4(current_state[0]),
        .I5(\douta_reg[6] ),
        .O(\PC[0]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \PC[0]_i_3 
       (.I0(addra[3]),
        .I1(addra[4]),
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
       (.C(CLK1HZ),
        .CE(E),
        .D(\PC[0]_i_2_n_0 ),
        .Q(addra[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PC_reg[1] 
       (.C(CLK1HZ),
        .CE(E),
        .D(\PC[1]_i_1_n_0 ),
        .Q(addra[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PC_reg[2] 
       (.C(CLK1HZ),
        .CE(E),
        .D(\PC[2]_i_1_n_0 ),
        .Q(addra[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PC_reg[3] 
       (.C(CLK1HZ),
        .CE(E),
        .D(\PC[3]_i_1_n_0 ),
        .Q(addra[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PC_reg[4] 
       (.C(CLK1HZ),
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
       (.C(CLK1HZ),
        .CE(1'b1),
        .D(\current_state[0]_i_1_n_0 ),
        .Q(current_state[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \current_state_reg[1] 
       (.C(CLK1HZ),
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
       (.C(CLK1HZ),
        .CE(current_state[0]),
        .D(addra[0]),
        .Q(\LED[0] [12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[11] 
       (.C(CLK1HZ),
        .CE(current_state[0]),
        .D(data_out_bus0[4]),
        .Q(\LED[0] [4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[12] 
       (.C(CLK1HZ),
        .CE(current_state[0]),
        .D(data_out_bus0[3]),
        .Q(\LED[0] [3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[13] 
       (.C(CLK1HZ),
        .CE(current_state[0]),
        .D(data_out_bus0[2]),
        .Q(\LED[0] [2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[14] 
       (.C(CLK1HZ),
        .CE(current_state[0]),
        .D(data_out_bus0[1]),
        .Q(\LED[0] [1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[15] 
       (.C(CLK1HZ),
        .CE(current_state[0]),
        .D(data_out_bus0[0]),
        .Q(\LED[0] [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[1] 
       (.C(CLK1HZ),
        .CE(current_state[0]),
        .D(addra[1]),
        .Q(\LED[0] [11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[2] 
       (.C(CLK1HZ),
        .CE(current_state[0]),
        .D(addra[2]),
        .Q(\LED[0] [10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[3] 
       (.C(CLK1HZ),
        .CE(current_state[0]),
        .D(addra[3]),
        .Q(\LED[0] [9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[4] 
       (.C(CLK1HZ),
        .CE(current_state[0]),
        .D(addra[4]),
        .Q(\LED[0] [8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[7] 
       (.C(CLK1HZ),
        .CE(1'b1),
        .D(current_state[1]),
        .Q(\LED[0] [7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[8] 
       (.C(CLK1HZ),
        .CE(1'b1),
        .D(current_state[0]),
        .Q(\LED[0] [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_out_bus_reg[9] 
       (.C(CLK1HZ),
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
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h80020002)) 
    \douta[38]_i_1 
       (.I0(addra[2]),
        .I1(addra[0]),
        .I2(addra[1]),
        .I3(addra[3]),
        .I4(addra[4]),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h82020002)) 
    \douta[39]_i_1 
       (.I0(addra[4]),
        .I1(addra[0]),
        .I2(addra[1]),
        .I3(addra[3]),
        .I4(addra[2]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \douta[3]_i_1 
       (.I0(addra[1]),
        .I1(addra[3]),
        .I2(addra[4]),
        .I3(addra[2]),
        .I4(addra[0]),
        .O(D[6]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h81000000)) 
    \douta[4]_i_1 
       (.I0(addra[1]),
        .I1(addra[0]),
        .I2(addra[2]),
        .I3(addra[3]),
        .I4(addra[4]),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h80000014)) 
    \douta[6]_i_1 
       (.I0(addra[4]),
        .I1(addra[3]),
        .I2(addra[1]),
        .I3(addra[2]),
        .I4(addra[0]),
        .O(D[4]));
  LUT5 #(
    .INIT(32'h81051110)) 
    \douta[7]_i_1 
       (.I0(addra[0]),
        .I1(addra[4]),
        .I2(addra[3]),
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
    .INIT(16'h9AA6)) 
    \stack_w_ptr[2]_i_1 
       (.I0(stack_w_ptr[2]),
        .I1(Q[3]),
        .I2(stack_w_ptr[1]),
        .I3(stack_w_ptr[0]),
        .O(\stack_w_ptr[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \stack_w_ptr[3]_i_1 
       (.I0(current_state[0]),
        .I1(current_state[1]),
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
       (.C(CLK1HZ),
        .CE(\current_state_reg[1]_0 ),
        .D(\stack_w_ptr[0]_i_1_n_0 ),
        .Q(stack_w_ptr[0]),
        .R(\stack_w_ptr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stack_w_ptr_reg[1] 
       (.C(CLK1HZ),
        .CE(\current_state_reg[1]_0 ),
        .D(\stack_w_ptr[1]_i_1_n_0 ),
        .Q(stack_w_ptr[1]),
        .R(\stack_w_ptr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stack_w_ptr_reg[2] 
       (.C(CLK1HZ),
        .CE(\current_state_reg[1]_0 ),
        .D(\stack_w_ptr[2]_i_1_n_0 ),
        .Q(stack_w_ptr[2]),
        .R(\stack_w_ptr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stack_w_ptr_reg[3] 
       (.C(CLK1HZ),
        .CE(\current_state_reg[1]_0 ),
        .D(\stack_w_ptr[3]_i_3_n_0 ),
        .Q(stack_w_ptr[3]),
        .R(\stack_w_ptr[3]_i_1_n_0 ));
endmodule

module program_memory_mock
   (E,
    Q,
    \data_out_bus_reg[11] ,
    \PC_reg[1] ,
    \stack_w_ptr_reg[0] ,
    current_state,
    D,
    CLK2HZ__0);
  output [0:0]E;
  output [6:0]Q;
  output \data_out_bus_reg[11] ;
  output \PC_reg[1] ;
  output \stack_w_ptr_reg[0] ;
  input [1:0]current_state;
  input [6:0]D;
  input CLK2HZ__0;

  wire CLK2HZ__0;
  wire [6:0]D;
  wire [0:0]E;
  wire \PC_reg[1] ;
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
        .O(\PC_reg[1] ));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[37] 
       (.C(CLK2HZ__0),
        .CE(1'b1),
        .D(D[2]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[38] 
       (.C(CLK2HZ__0),
        .CE(1'b1),
        .D(D[1]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[39] 
       (.C(CLK2HZ__0),
        .CE(1'b1),
        .D(D[0]),
        .Q(Q[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[3] 
       (.C(CLK2HZ__0),
        .CE(1'b1),
        .D(D[6]),
        .Q(Q[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[4] 
       (.C(CLK2HZ__0),
        .CE(1'b1),
        .D(D[5]),
        .Q(Q[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[6] 
       (.C(CLK2HZ__0),
        .CE(1'b1),
        .D(D[4]),
        .Q(Q[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \douta_reg[7] 
       (.C(CLK2HZ__0),
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

(* ECO_CHECKSUM = "6d59dd75" *) 
(* NotValidForBitStream *)
module top_lvl
   (CLK100MHZ,
    LED);
  input CLK100MHZ;
  output [0:15]LED;

  wire CLK100MHZ;
  wire CLK100MHZ_IBUF;
  wire CLK100MHZ_IBUF_BUFG;
  wire CLK1HZ;
  wire CLK1HZ_i_1_n_0;
  wire CLK2HZ;
  wire CLK2HZ__0;
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
  wire [1:1]clk_counter;
  wire \clk_counter[0]_i_1_n_0 ;
  wire \clk_counter_reg_n_0_[1] ;
  wire [1:0]current_state;
  wire [37:39]douta;
  wire [4:0]sel0;

  BUFG CLK100MHZ_IBUF_BUFG_inst
       (.I(CLK100MHZ_IBUF),
        .O(CLK100MHZ_IBUF_BUFG));
  IBUF CLK100MHZ_IBUF_inst
       (.I(CLK100MHZ),
        .O(CLK100MHZ_IBUF));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h78)) 
    CLK1HZ_i_1
       (.I0(CLK2HZ),
        .I1(\clk_counter_reg_n_0_[1] ),
        .I2(CLK1HZ),
        .O(CLK1HZ_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    CLK1HZ_reg
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(CLK1HZ_i_1_n_0),
        .Q(CLK1HZ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h6)) 
    CLK2HZ_i_1
       (.I0(CLK2HZ),
        .I1(CLK2HZ__0),
        .O(CLK2HZ_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    CLK2HZ_reg
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(CLK2HZ_i_1_n_0),
        .Q(CLK2HZ__0),
        .R(1'b0));
  CPU CPU_INST
       (.CLK1HZ(CLK1HZ),
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
       (.CLK2HZ__0(CLK2HZ__0),
        .D({CPU_INST_n_2,CPU_INST_n_3,CPU_INST_n_4,CPU_INST_n_5,CPU_INST_n_6,CPU_INST_n_7,CPU_INST_n_8}),
        .E(PROGRAM_MEMORY_INST_n_0),
        .\PC_reg[1] (PROGRAM_MEMORY_INST_n_9),
        .Q({sel0[4:3],sel0[1:0],douta[37],douta[38],douta[39]}),
        .current_state(current_state),
        .\data_out_bus_reg[11] (PROGRAM_MEMORY_INST_n_8),
        .\stack_w_ptr_reg[0] (PROGRAM_MEMORY_INST_n_10));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \clk_counter[0]_i_1 
       (.I0(CLK2HZ),
        .O(\clk_counter[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \clk_counter[1]_i_1 
       (.I0(CLK2HZ),
        .I1(\clk_counter_reg_n_0_[1] ),
        .O(clk_counter));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[0] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(\clk_counter[0]_i_1_n_0 ),
        .Q(CLK2HZ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[1] 
       (.C(CLK100MHZ_IBUF_BUFG),
        .CE(1'b1),
        .D(clk_counter),
        .Q(\clk_counter_reg_n_0_[1] ),
        .R(1'b0));
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
