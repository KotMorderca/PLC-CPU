library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU is generic (
    stack_depth      : integer
);
port ( 
    clk              : in  STD_LOGIC;
    rst_n            : in  STD_LOGIC;
    data_out_bus     : out STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
    data_in_bus      : in  STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
    address_bus      : out STD_LOGIC_VECTOR(7 downto 0) := x"00";
    control_bus      : out STD_LOGIC_VECTOR(9 downto 0) := "0000000000";
    prog_mem_address : out STD_LOGIC_VECTOR(5 downto 0) := "000000";
    prog_mem_data    : in  STD_LOGIC_VECTOR(39 downto 0);
    debug_bus        : out STD_LOGIC_VECTOR(31 downto 0) := x"00000000"
);
end CPU;

architecture Behavioral of CPU is

component ALU_mock port(
	CLK     : in  STD_LOGIC;
	RST_n   : in  STD_LOGIC;
	A       : in  STD_LOGIC_VECTOR(31 downto 0);
	B       : in  STD_LOGIC_VECTOR(31 downto 0);
	C       : out STD_LOGIC_VECTOR(31 downto 0);
	OV      : out STD_LOGIC;
	OP_CTRL : in  STD_LOGIC_VECTOR(26 downto 0);
	IDLE    : out STD_LOGIC
);
end component;

constant OP_ADD_I   : STD_LOGIC_VECTOR(26 downto 0) := x"800000" & "000";
constant OP_SUB_I   : STD_LOGIC_VECTOR(26 downto 0) := x"400000" & "000";
constant OP_MUL_I   : STD_LOGIC_VECTOR(26 downto 0) := x"200000" & "000";
constant OP_DIV_I   : STD_LOGIC_VECTOR(26 downto 0) := x"100000" & "000";
constant OP_NEG_I   : STD_LOGIC_VECTOR(26 downto 0) := x"080000" & "000";
constant OP_MOD_I   : STD_LOGIC_VECTOR(26 downto 0) := x"040000" & "000";
constant OP_GT_I    : STD_LOGIC_VECTOR(26 downto 0) := x"020000" & "000";
constant OP_GE_I    : STD_LOGIC_VECTOR(26 downto 0) := x"010000" & "000";
constant OP_NE_I    : STD_LOGIC_VECTOR(26 downto 0) := x"008000" & "000";
constant OP_LE_I    : STD_LOGIC_VECTOR(26 downto 0) := x"004000" & "000";
constant OP_LT_I    : STD_LOGIC_VECTOR(26 downto 0) := x"002000" & "000";
constant OP_ADD_R   : STD_LOGIC_VECTOR(26 downto 0) := x"001000" & "000";
constant OP_SUB_R   : STD_LOGIC_VECTOR(26 downto 0) := x"000800" & "000";
constant OP_MUL_R   : STD_LOGIC_VECTOR(26 downto 0) := x"000400" & "000";
constant OP_DIV_R   : STD_LOGIC_VECTOR(26 downto 0) := x"000200" & "000";
constant OP_NEG_R   : STD_LOGIC_VECTOR(26 downto 0) := x"000100" & "000";
constant OP_GT_R    : STD_LOGIC_VECTOR(26 downto 0) := x"000080" & "000";
constant OP_GE_R    : STD_LOGIC_VECTOR(26 downto 0) := x"000040" & "000";
constant OP_NE_R    : STD_LOGIC_VECTOR(26 downto 0) := x"000020" & "000";
constant OP_LE_R    : STD_LOGIC_VECTOR(26 downto 0) := x"000010" & "000";
constant OP_LT_R    : STD_LOGIC_VECTOR(26 downto 0) := x"000008" & "000";
constant OP_ITR     : STD_LOGIC_VECTOR(26 downto 0) := x"000004" & "000";
constant OP_ROUND   : STD_LOGIC_VECTOR(26 downto 0) := x"000002" & "000";
constant OP_SL      : STD_LOGIC_VECTOR(26 downto 0) := x"000001" & "000";
constant OP_SR      : STD_LOGIC_VECTOR(26 downto 0) := x"000000" & "100";
constant OP_RL      : STD_LOGIC_VECTOR(26 downto 0) := x"000000" & "010";
constant OP_RR      : STD_LOGIC_VECTOR(26 downto 0) := x"000000" & "001";


type states is (INIT, RUN, IOCOPY);
type instruction_states is (TICK0, TICK1, TICK2, TICK3);
type stack_b_type is array (0 to stack_depth-1) of STD_LOGIC;
type stack_w_type is array (0 to stack_depth-1) of STD_LOGIC_VECTOR(0 to 31);

signal CR_b          : stack_b_type                     := (others => '0');
signal CR_w          : stack_w_type                     := (others => (others => '0'));
signal CR_b_temp     : STD_LOGIC;
signal stack_b_ptr   : integer range 0 to stack_depth-1 := 0;
signal stack_w_ptr   : integer range 0 to stack_depth-1 := 0;

signal current_state : states                           := INIT;
signal current_tick  : instruction_states               := TICK0; 
signal PC            : STD_LOGIC_VECTOR(5 downto 0)     := "000000";
signal instruction   : STD_LOGIC_VECTOR(7 downto 0);
signal operand       : STD_LOGIC_VECTOR(31 downto 0);

signal OV_wire       : STD_LOGIC                        := '0';
signal A_wire        : STD_LOGIC_VECTOR(31 downto 0);
signal B_wire        : STD_LOGIC_VECTOR(31 downto 0);
signal C_wire        : STD_LOGIC_VECTOR(31 downto 0);
signal OP_CTRL_wire  : STD_LOGIC_VECTOR(26 downto 0)    := (others => '0');
signal IDLE_wire     : STD_LOGIC                        := '0';

begin


    ALU_INST : ALU_mock port map(
    	CLK     => clk,
        RST_n   => rst_n,
        A       => A_wire,
        B       => B_wire,
        C       => C_wire,
        OV      => OV_wire,
        OP_CTRL => OP_CTRL_wire,
        IDLE    => IDLE_wire
    );
    instruction <= prog_mem_data(39 downto 32);
    operand <= prog_mem_data(31 downto 0);
    prog_mem_address <= PC;
    process(clk)
    begin
        if rising_edge(clk) then
            
            if rst_n='0' then
                debug_bus <= x"0010C0B4";
                current_state <= INIT;
            else
                debug_bus <= PC(3 downto 0) & x"0" & instruction & x"000" & "000" & CR_b(stack_b_ptr);
                case current_state is
                when INIT =>
                    current_state <= RUN;
                    PC <= "000000";
                    stack_w_ptr <= 0;
                    stack_b_ptr <= 0;
                    control_bus <= "0000000000";
                    CR_b <= (others => '0');
                    CR_w <= (others => (others => '0'));
                when RUN =>
                    case instruction is
                        when x"00" => --LD Const
                            CR_b(stack_b_ptr) <= operand(0);
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"01" => --LD (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_b(stack_b_ptr) <= data_in_bus(0);
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"02" => --LD OV
                            CR_b(stack_b_ptr) <= OV_wire;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"03" => --LDN Const
                            CR_b(stack_b_ptr) <= NOT(operand(0));
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"04" => --LDN (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_b(stack_b_ptr) <= NOT(data_in_bus(0));
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"05" => --LDN OV
                            CR_b(stack_b_ptr) <= NOT(OV_wire);
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"06" => --NOT
                            CR_b(stack_b_ptr) <= NOT(CR_b(stack_b_ptr));
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"07" => --AND Const
                            CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) AND operand(0);
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"08" => --AND (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) AND data_in_bus(0);
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"09" => --ANDN Const
                            CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) AND NOT(operand(0));
                            control_bus <= "0000000000";
                            PC <= PC + 1; 
                                                                    
                        when x"0A" => --ANDN (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) AND NOT(data_in_bus(0));
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                        
                        when x"0B" => --OR Const
                            CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) OR operand(0);
                            control_bus <= "0000000000";
                            PC <= PC + 1; 
                            
                        when x"0C" => --OR (Arg) 
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) OR data_in_bus(0);
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"0D" => --ORN Const
                            CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) OR NOT(operand(0));
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"0E" => --ORN (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) OR NOT(data_in_bus(0));
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"0F" => --XOR Const 
                            CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) XOR operand(0);
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"10" => --X (Arg) 
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) XOR data_in_bus(0);
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"11" => --XORN Const
                            CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) XOR NOT(operand(0));
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"12" => --XORN (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_b(stack_b_ptr) <= CR_b(stack_b_ptr) XOR NOT(data_in_bus(0));
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"13" => --PUSH LD(Const)
                                CR_b(stack_b_ptr + 1) <= operand(0);
                                stack_b_ptr <= stack_b_ptr + 1;
                                control_bus <= "0000000000";
                                PC <= PC + 1;
                            
                        when x"14" => --PUSH LD(Arg)
                            case current_tick is
                                when TICK0 =>
                                    stack_b_ptr <= stack_b_ptr + 1;
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_b(stack_b_ptr) <= data_in_bus(0);
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;                                
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"15" => --PUSH
                            stack_b_ptr <= stack_b_ptr + 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"16" => --A) 
                            CR_b(stack_b_ptr - 1) <= CR_b(stack_b_ptr) AND CR_b(stack_b_ptr - 1);
                            stack_b_ptr <= stack_b_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"17" => --AN)
                            CR_b(stack_b_ptr - 1) <= CR_b(stack_b_ptr) AND NOT(CR_b(stack_b_ptr - 1));
                            stack_b_ptr <= stack_b_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"18" => --O)
                            CR_b(stack_b_ptr - 1) <= CR_b(stack_b_ptr) OR CR_b(stack_b_ptr - 1);
                            stack_b_ptr <= stack_b_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"19" => --ON)
                            CR_b(stack_b_ptr - 1) <= CR_b(stack_b_ptr) OR NOT(CR_b(stack_b_ptr - 1));
                            stack_b_ptr <= stack_b_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"1A" => --X)
                            CR_b(stack_b_ptr - 1) <= CR_b(stack_b_ptr) XOR CR_b(stack_b_ptr - 1);
                            stack_b_ptr <= stack_b_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"1B" => --XN)
                            CR_b(stack_b_ptr - 1) <= CR_b(stack_b_ptr) XOR NOT(CR_b(stack_b_ptr - 1));
                            stack_b_ptr <= stack_b_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"1C" => --ST
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    data_out_bus(0) <= CR_b(stack_b_ptr);
                                    control_bus <= "0100000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"1D" => --STN
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    data_out_bus(0) <= NOT(CR_b(stack_b_ptr));
                                    control_bus <= "0100000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                        
                        when x"1E" => --S
                            if CR_b(stack_b_ptr)='1' then
                                case current_tick is
                                    when TICK0 =>
                                        address_bus <= operand(7 downto 0);
                                        data_out_bus(0) <= '1';
                                        control_bus <= "0100000000";
                                        current_tick <= TICK1;
                                    when TICK1 =>
                                        control_bus <= "0000000000";
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    when others =>
                                        current_tick <= TICK0;
                                end case;
                            else
                                PC <= PC + 1;
                                control_bus <= "0000000000";
                            end if;
                        
                        when x"1F" => --R
                            if CR_b(stack_b_ptr)='1' then
                                case current_tick is
                                    when TICK0 =>
                                        address_bus <= operand(7 downto 0);
                                        data_out_bus(0) <= '0';
                                        control_bus <= "0100000000";
                                        current_tick <= TICK1;
                                    when TICK1 =>
                                        control_bus <= "0000000000";
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    when others =>
                                        current_tick <= TICK0;
                                end case;
                            else
                                PC <= PC + 1;
                                control_bus <= "0000000000";
                            end if;

                        when x"20" => --JMP
                            PC <= operand(5 downto 0);
                            control_bus <= "0000000000";
                            
                        when x"21" => --JMPC
                            if CR_b(stack_b_ptr)='1' then
                                PC <= operand(5 downto 0);
                            else
                                PC <= PC + 1;
                            end if;
                            control_bus <= "0000000000";
                            
                        when x"22" => --JMPCN
                            if CR_b(stack_b_ptr)='0' then
                                PC <= operand(5 downto 0);
                            else
                                PC <= PC + 1;
                            end if;
                            control_bus <= "0000000000";
                            
                        when x"23" => --JOV
                            if OV_wire='1' then
                                PC <= operand(5 downto 0);
                            else
                                PC <= PC + 1;
                            end if;
                            
                        when x"24" => --R_TRIG
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    address_bus <= operand(7 downto 0);
                                    CR_b(stack_b_ptr) <= NOT(data_in_bus(0)) AND CR_b(stack_b_ptr);
                                    data_out_bus(0) <= CR_b(stack_b_ptr);
                                    control_bus <= "0100000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"25" => --F_TRIG
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    address_bus <= operand(7 downto 0);
                                    CR_b(stack_b_ptr) <= data_in_bus(0) AND NOT(CR_b(stack_b_ptr));
                                    data_out_bus(0) <= CR_b(stack_b_ptr);
                                    control_bus <= "0100000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"26" => --NOP
                            control_bus <= "0000000000";
                            PC <= PC + 1;

                        when x"27" => --LD_w Const
                            CR_w(stack_w_ptr) <= operand;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"28" => --LD_w (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_w(stack_w_ptr) <= data_in_bus;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"29" => --LDN_w Const
                            CR_w(stack_w_ptr) <= NOT(operand);
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"2A" => --LDN_w (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_w(stack_w_ptr) <= NOT(data_in_bus);
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"2B" => --NOT_w
                            CR_w(stack_w_ptr) <= NOT(CR_w(stack_w_ptr));
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"2C" => --AND_w Const
                            CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) AND operand;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"2D" => --AND_w (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) AND data_in_bus;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"2E" => --ANDN_w Const
                            CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) AND NOT(operand);
                            control_bus <= "0000000000";
                            PC <= PC + 1; 
                                                                    
                        when x"2F" => --ANDN_w (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) AND NOT(data_in_bus);
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                                
                        when x"30" => --OR_w Const
                            CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) OR operand;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"31" => --OR_w (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) OR data_in_bus;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"32" => --ORN_w Const
                            CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) OR NOT(operand);
                            control_bus <= "0000000000";
                            PC <= PC + 1; 
                                                                    
                        when x"33" => --ORN_w (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) OR NOT(data_in_bus);
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                                
                        when x"34" => --XOR_w Const
                                CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) XOR operand;
                                control_bus <= "0000000000";
                                PC <= PC + 1;
                                
                            when x"35" => --XOR_w (Arg)
                                case current_tick is
                                    when TICK0 =>
                                        address_bus <= operand(7 downto 0);
                                        control_bus <= "0010000000";
                                        current_tick <= TICK1;
                                    when TICK1 =>
                                        CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) XOR data_in_bus;
                                        control_bus <= "0000000000";
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    when others =>
                                        current_tick <= TICK0;
                                end case;
                                
                            when x"36" => --XORN_w Const
                                CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) XOR NOT(operand);
                                control_bus <= "0000000000";
                                PC <= PC + 1; 
                                                                        
                            when x"37" => --XORN_w (Arg)
                                case current_tick is
                                    when TICK0 =>
                                        address_bus <= operand(7 downto 0);
                                        control_bus <= "0010000000";
                                        current_tick <= TICK1;
                                    when TICK1 =>
                                        CR_w(stack_w_ptr) <= CR_w(stack_w_ptr) XOR NOT(data_in_bus);
                                        control_bus <= "0000000000";
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    when others =>
                                        current_tick <= TICK0;
                                end case;
                                
                        when x"38" => --PUSH_w LD(Const)
                                CR_w(stack_w_ptr + 1) <= operand;
                                stack_w_ptr <= stack_w_ptr + 1;
                                control_bus <= "0000000000";
                                PC <= PC + 1;
                            
                        when x"39" => --PUSH_w LD(Arg)
                            case current_tick is
                                when TICK0 =>
                                    stack_w_ptr <= stack_w_ptr + 1;
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    CR_w(stack_w_ptr) <= data_in_bus;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;                                
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"3A" => --PUSH_w
                            stack_w_ptr <= stack_w_ptr + 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"3B" => --AND)_w
                            CR_w(stack_w_ptr - 1) <= CR_w(stack_w_ptr) AND CR_w(stack_w_ptr - 1);
                            stack_w_ptr <= stack_w_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"3C" => --ANDN)_w
                            CR_w(stack_w_ptr - 1) <= CR_w(stack_w_ptr) AND NOT(CR_w(stack_w_ptr - 1));
                            stack_w_ptr <= stack_w_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"3D" => --OR)_w
                            CR_w(stack_w_ptr - 1) <= CR_w(stack_w_ptr) OR CR_w(stack_w_ptr - 1);
                            stack_w_ptr <= stack_w_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"3E" => --ORN)_w
                            CR_w(stack_w_ptr - 1) <= CR_w(stack_w_ptr) OR NOT(CR_w(stack_w_ptr - 1));
                            stack_w_ptr <= stack_w_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"3F" => --XOR)_w
                            CR_w(stack_w_ptr - 1) <= CR_w(stack_w_ptr) XOR CR_w(stack_w_ptr - 1);
                            stack_w_ptr <= stack_w_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"40" => --XORN)_w
                            CR_w(stack_w_ptr - 1) <= CR_w(stack_w_ptr) XOR NOT(CR_w(stack_w_ptr - 1));
                            stack_w_ptr <= stack_w_ptr - 1;
                            control_bus <= "0000000000";
                            PC <= PC + 1;
                            
                        when x"41" => --ST_w
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    data_out_bus <= CR_w(stack_w_ptr);
                                    control_bus <= "0100000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"42" => --STN_w
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    data_out_bus <= NOT(CR_w(stack_w_ptr));
                                    control_bus <= "0100000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;

                        when x"43" => --EQ_w Const
                            control_bus <= "0000000000";
                            if operand=CR_w(stack_w_ptr) then
                                CR_b(stack_b_ptr) <= '1';
                            else
                                CR_b(stack_b_ptr) <= '0';
                            end if;
                            PC <= PC + 1;
                            
                        when x"44" => --EQ_w (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    if data_in_bus=CR_w(stack_w_ptr) then
                                        CR_b(stack_b_ptr) <= '1';
                                    else
                                        CR_b(stack_b_ptr) <= '0';
                                    end if;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                                                        
                        when x"45" => --SL Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_SL;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                                                    
                        when x"46" => --SL (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_SL;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                        
                        when x"47" => --SR Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_SR;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                                
                        when x"48" => --SR (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_SR;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"49" => --RL Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_RL;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"4A" => --RL (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_RL;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"4B" => --RR Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_RR;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"4C" => --RR (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_RR;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"4D" => --ITR
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= operand;
                                    OP_CTRL_wire <= OP_ITR;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"4E" => --ROUND
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= operand;
                                    OP_CTRL_wire <= OP_ROUND;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"4F" => --ADD_I Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_ADD_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"50" => --ADD_I (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_ADD_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"51" => --SUB_I Const 
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_SUB_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"52" => --SUB_I (Arg) 
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_SUB_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"53" => --MUL_I Const 
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_MUL_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"54" => --MUL_I (Arg) 
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_MUL_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"55" => --DIV_I Const 
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_DIV_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"56" => --DIV_I (Arg) 
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_DIV_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"57" => --NEG_I 
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    OP_CTRL_wire <= OP_DIV_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"58" => --GT_I Const 
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_GT_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"59" => --GT_I (Arg) 
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_GT_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"5A" => --GE_I Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_GE_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"5B" => --GE_I (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_GE_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"5C" => --NE_I Const
                            control_bus <= "0000000000";
                            if operand/=CR_w(stack_w_ptr) then
                                CR_b(stack_b_ptr) <= '1';
                            else
                                CR_b(stack_b_ptr) <= '0';
                            end if;
                            PC <= PC + 1;
                            
                        when x"5D" => --NE_I (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    if data_in_bus/=CR_w(stack_w_ptr) then
                                        CR_b(stack_b_ptr) <= '1';
                                    else
                                        CR_b(stack_b_ptr) <= '0';
                                    end if;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK0;
                                    PC <= PC + 1;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"5E" => --LE_I Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_LE_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"5F" => --LE_I (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_LE_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"60" => --LT_I Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_LT_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"61" => --LT_I (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_LT_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"62" => --MOD_I Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_MOD_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"63" => --MOD_I (Arg)
                            case current_tick is
                                when TICK0 =>
                                    address_bus <= operand(7 downto 0);
                                    control_bus <= "0010000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= data_in_bus;
                                    OP_CTRL_wire <= OP_MOD_I;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK2;
                                when TICK2 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"64" => --ADD_R Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_ADD_R;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"65" => --SUB_R Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_SUB_R;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"66" => --MUL_R Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_MUL_R;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"67" => --DIV_R Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_DIV_R;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_w(stack_w_ptr) <= C_wire;
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"68" => --GT_R  Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_GT_R;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"69" => --GE_R  Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_GE_R;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"6A" => --NE_R  Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_NE_R;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"6B" => --LE_R  Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_LE_R;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;
                            
                        when x"6C" => --LT_R  Const
                            case current_tick is
                                when TICK0 =>
                                    A_wire <= CR_w(stack_w_ptr);
                                    B_wire <= operand;
                                    OP_CTRL_wire <= OP_LT_R;
                                    control_bus <= "0000000000";
                                    current_tick <= TICK1;
                                when TICK1 =>
                                    OP_CTRL_wire <= (others => '0');
                                    if IDLE_wire='1' then
                                        CR_b(stack_b_ptr) <= C_wire(0);
                                        current_tick <= TICK0;
                                        PC <= PC + 1;
                                    end if;
                                when others =>
                                    current_tick <= TICK0;
                            end case;

                        when x"6D" => --CU  C
                        when x"6E" => --CD  C
                        when x"6F" => --SC  C
                        when x"70" => --RCT C,T
                        when x"71" => --TON T
                        when x"72" => --TP  T
                        when x"73" => --TOF T

                        when x"EF" => --STOP
                            PC <= PC;
                        when x"FF" => --END
                            current_state <= IOCOPY;
                            control_bus <= "1000000000";
                        when others => 
                            PC <= PC + 1;
                    end case;
                when IOCOPY =>
                    control_bus <= "0000000000";
                    data_out_bus <= x"00000000";
                    current_state <= IOCOPY;
                end case;
            end if;
        end if;
    end process;
end Behavioral;


