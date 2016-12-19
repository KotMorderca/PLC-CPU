library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity marker_memory is port ( 
    clk            : in  STD_LOGIC;
    address_bus    : in  STD_LOGIC_VECTOR(7 downto 0);
    data_out_bus   : in  STD_LOGIC_VECTOR(31 downto 0);
    data_in_bus    : out STD_LOGIC_VECTOR(31 downto 0);
    control_bus    : in  STD_LOGIC_VECTOR(9 downto 0)
);
end marker_memory;

architecture Behavioral of marker_memory is

type mem_type is array (0 to 63) of STD_LOGIC_VECTOR(31 downto 0);
signal marker_mem : mem_type := (others => (others => '0'));

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if address_bus < x"40" AND control_bus(7)='1' then --odczyt MW
                data_in_bus <= marker_mem(CONV_INTEGER(address_bus(5 downto 0)));
            elsif address_bus < x"40" AND control_bus(8)='1' then --zapis MW
                marker_mem(CONV_INTEGER(address_bus(5 downto 0))) <= data_out_bus;
                data_in_bus <= (others => 'Z');
            elsif address_bus < x"C0" AND address_bus >= x"80" AND control_bus(7)='1' then --odczyt bit-band MW0 i MW1
                data_in_bus(0) <= marker_mem(CONV_INTEGER('0' & address_bus(5)))(CONV_INTEGER(address_bus(4 downto 0)));
            elsif address_bus < x"C0" AND address_bus >= x"80" AND control_bus(8)='1' then --zapis bit-band MW0 i MW1
                marker_mem(CONV_INTEGER('0' & address_bus(5)))(CONV_INTEGER(address_bus(4 downto 0))) <= data_out_bus(0);
                data_in_bus <= (others => 'Z');
            else
                data_in_bus <= (others => 'Z');
            end if;
        end if;
    end process;
end Behavioral;
