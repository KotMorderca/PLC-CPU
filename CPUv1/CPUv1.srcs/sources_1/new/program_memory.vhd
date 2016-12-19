library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity program_memory is port ( 
    clk       : in STD_LOGIC;
    addr_cpu  : in STD_LOGIC_VECTOR (5 downto 0);
    dout_cpu  : out STD_LOGIC_VECTOR (39 downto 0);
    en_cpu    : in STD_LOGIC;
    addr_prog : in STD_LOGIC_VECTOR (5 downto 0);
    din_prog  : in STD_LOGIC_VECTOR (39 downto 0);
    wr_prog   : in STD_LOGIC
);
end program_memory;

architecture Behavioral of program_memory is

    type mem_type is array (0 to 63) of STD_LOGIC_VECTOR(39 downto 0);
    signal prog_mem : mem_type := (x"0000000000",x"FF00000000", others => (others => '0'));

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if wr_prog='1' then
                prog_mem(CONV_INTEGER(addr_prog)) <= din_prog;
            elsif en_cpu='1' then
                dout_cpu <= prog_mem(CONV_INTEGER(addr_cpu));
            end if;
        end if;
    end process;

end Behavioral;
