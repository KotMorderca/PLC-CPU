library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DIO_module_mock is port( 
    clk             : in    STD_LOGIC;
    switches        : in    STD_LOGIC_VECTOR(15 downto 0);
    leds            : out   STD_LOGIC_VECTOR(15 downto 0);
    ext_address_bus : in    STD_LOGIC_VECTOR(7 downto 0);
    ext_data_bus    : inout STD_LOGIC_VECTOR(15 downto 0);
    ext_wr          : in    STD_LOGIC;
    ext_rd          : in    STD_LOGIC
);
end DIO_module_mock;

architecture Behavioral of DIO_module_mock is
    signal switches_wire : STD_LOGIC_VECTOR(15 downto 0);   
begin
    ext_data_bus <= switches_wire when (ext_address_bus=x"01" AND ext_rd='0') else (others => 'Z');
    process(clk)
    begin
        if rising_edge(clk) then
            switches_wire <= switches;
            if ext_address_bus=x"09" AND ext_wr='0' then
                leds <= ext_data_bus;
            end if;
        end if;
    end process;
end Behavioral;
