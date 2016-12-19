library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IO_controller is port ( 
    clk               : in    STD_LOGIC;
    rst_n_out         : out   STD_LOGIC := '1';
    address_bus       : in    STD_LOGIC_VECTOR(7 downto 0);
    data_out_bus      : in    STD_LOGIC_VECTOR(31 downto 0);
    data_in_bus       : out   STD_LOGIC_VECTOR(31 downto 0);
    control_bus       : in    STD_LOGIC_VECTOR(9 downto 0);
    ext_clk           : in    STD_LOGIC;
    ext_address_bus   : out   STD_LOGIC_VECTOR(7 downto 0) := x"00";
    ext_data_bus      : inout STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    ext_wr            : out   STD_LOGIC := '1';
    ext_rd            : out   STD_LOGIC := '1'
);
end IO_controller;

architecture Behavioral of IO_controller is

type IO_controller_phase is (MEMORY_PHASE, IOCOPY_PHASE);
type instruction_states is (TICK0, TICK1, TICK2, TICK3, TICK4, TICK5, TICK6);

type mem_type_d is array (0 to 7) of STD_LOGIC_VECTOR(31 downto 0);
type mem_type_a is array (0 to 23) of STD_LOGIC_VECTOR(15 downto 0);

signal current_phase   : IO_controller_phase           := MEMORY_PHASE;
signal current_tick    : instruction_states            := TICK0;
signal dio_mem         : mem_type_d                    := (others => (others => '0'));
signal aio_mem         : mem_type_a                    := (others => (others => '0'));
signal aio_addr        : STD_LOGIC_VECTOR(4 downto 0);

signal current_address : STD_LOGIC_VECTOR(7 downto 0)  := x"00";

signal counter         : integer range 0 to 32         := 0;
signal current_mem     : integer range 0 to 23         := 0;

constant divider       : integer := 4;
signal div_counter     : integer range 0 to divider-1  := 0;

begin
    process(clk, address_bus)
    begin
        aio_addr <= (address_bus(4) AND address_bus(3)) & (address_bus(4) AND NOT(address_bus(3))) & address_bus(2 downto 0);  
        if rising_edge(clk) then
            if current_phase=MEMORY_PHASE then
                rst_n_out <= '1';
                if control_bus(9)='0' then --IO_controller idle
                    if address_bus < x"68" AND address_bus >= x"60" AND control_bus(7)='1' then --odczyt DIW DQW 
                        data_in_bus <= dio_mem(CONV_INTEGER(address_bus(2 downto 0)));
                    elsif address_bus < x"68" AND address_bus >= x"60" AND control_bus(8)='1' then --zapis DIW DQW
                        dio_mem(CONV_INTEGER(address_bus(2 downto 0))) <= data_out_bus;
                        data_in_bus <= (others => 'Z');
                        
                    elsif address_bus < x"E0" AND address_bus >= x"C0" AND control_bus(7)='1' then --odczyt bit-band DIW  
                        data_in_bus(0) <= dio_mem(0)(CONV_INTEGER(address_bus(4 downto 0)));
                    elsif address_bus < x"E0" AND address_bus >= x"C0" AND control_bus(8)='1' then --zapis bit-band DIW
                        dio_mem(0)(CONV_INTEGER(address_bus(4 downto 0))) <= data_out_bus(0);
                        data_in_bus <= (others => 'Z');
    
                    elsif address_bus >= x"E0" AND control_bus(7)='1' then --odczyt bit-band DQW  
                        data_in_bus(0) <= dio_mem(4)(CONV_INTEGER(address_bus(4 downto 0)));
                    elsif address_bus >= x"E0" AND control_bus(8)='1' then --zapis bit-band DQW
                        dio_mem(4)(CONV_INTEGER(address_bus(4 downto 0))) <= data_out_bus(0);
                        data_in_bus <= (others => 'Z');
    
                    elsif address_bus < x"80" AND address_bus >= x"68" AND control_bus(7)='1' then --odczyt AI AO
                        data_in_bus(15 downto 0) <= aio_mem(CONV_INTEGER(aio_addr));
                    elsif address_bus < x"80" AND address_bus >= x"68" AND control_bus(8)='1' then --zapis AI AO
                        aio_mem(CONV_INTEGER(aio_addr)) <= data_out_bus(15 downto 0);
                        data_in_bus <= (others => 'Z');
                    else
                        data_in_bus <= (others => 'Z');
                    end if;
                else
                    rst_n_out <= '0';
                    current_phase <= IOCOPY_PHASE;                    
                end if;
            else
                data_in_bus <= (others => '0');
                if div_counter=(divider-1) then
                    div_counter <= 0;
                    case counter is
                    when 0 to 3 =>
                        ext_data_bus <= (others => 'Z');
                        case current_tick is
                        when TICK0 =>
                            ext_rd <= '1';
                            ext_address_bus <= current_address;
                            current_tick <= TICK1;
                        when TICK1 =>
                            ext_rd <= '0';
                            current_tick <= TICK2;
                        when TICK2 =>
                            ext_rd <= '1';
                            dio_mem(current_mem)(31 downto 16) <= ext_data_bus;
                            current_address <= current_address + 1;
                            current_tick <= TICK3;
                        when TICK3 =>
                            ext_rd <= '1';
                            ext_address_bus <= current_address;
                            current_tick <= TICK4;
                        when TICK4 =>
                            ext_rd <= '0';
                            current_tick <= TICK5;
                        when TICK5 =>
                            ext_rd <= '1';
                            dio_mem(current_mem)(15 downto 0) <= ext_data_bus;
                            current_address <= current_address + 1;
                            current_tick <= TICK6;
                        when TICK6 =>
                            current_mem <= current_mem + 1;
                            counter <= counter + 1;             
                            current_tick <= TICK0;  
                        when others =>
                            current_tick <= TICK0;
                        end case;
                    when 4 to 7 =>
                        case current_tick is
                        when TICK0 =>
                            ext_wr <= '1';
                            ext_address_bus <= current_address;
                            ext_data_bus <= dio_mem(current_mem)(31 downto 16);
                            current_tick <= TICK1;
                        when TICK1 =>
                            ext_wr <= '0';
                            current_address <= current_address + 1;
                            current_tick <= TICK2;
                        when TICK2 =>
                            ext_wr <= '1';
                            ext_address_bus <= current_address;
                            ext_data_bus <= dio_mem(current_mem)(15 downto 0);
                            current_tick <= TICK3;
                        when TICK3 =>
                            ext_wr <= '0';
                            current_address <= current_address + 1;
                            current_tick <= TICK4;
                        when TICK4 =>
                            ext_wr <= '1';
                            counter <= counter + 1;
                            current_mem <= current_mem + 1;
                            if counter=7 then
                                current_mem <= 0;
                            end if;               
                            current_tick <= TICK0;    
                        when others =>
                            current_tick <= TICK0;  
                        end case;
                    when 8 to 23 =>
                        ext_data_bus <= (others => 'Z');
                        case current_tick is
                        when TICK0 =>
                            ext_address_bus <= current_address;
                            current_tick <= TICK1;
                            ext_rd <= '1';
                        when TICK1 =>
                            current_tick <= TICK2;
                            ext_rd <= '0';
                        when TICK2 =>
                            ext_rd <= '1';
                            aio_mem(current_mem) <= ext_data_bus;
                            current_address <= current_address + 1;
                            counter <= counter + 1;
                            current_mem <= current_mem + 1;
                            current_tick <= TICK0;
                        when others =>
                            current_tick <= TICK0; 
                        end case;
                    when 24 to 31 =>
                        case current_tick is
                        when TICK0 =>
                            ext_address_bus <= current_address;
                            ext_data_bus <= aio_mem(current_mem);
                            current_tick <= TICK1;
                        when TICK1 =>
                            ext_wr <= '0';
                            current_address <= current_address + 1;
                            current_tick <= TICK2;
                        when TICK2 =>
                            ext_wr <= '1';
                            counter <= counter + 1;
                            current_mem <= current_mem + 1;
                            current_tick <= TICK0;
                        when others =>
                            current_tick <= TICK0;
                        end case;
                    when 32 =>
                        counter <= 0;
                        current_mem <= 0;
                        current_address <= x"00";
                        current_phase <= MEMORY_PHASE;
                        rst_n_out <= '1';
                    end case;
                else
                    div_counter <= div_counter + 1; 
                end if;
            end if;
        end if;
    end process;
end Behavioral;