library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity program_memory_mock is port ( 
    clka  : in  STD_LOGIC;
    ena   : in  STD_LOGIC;
    addra : in  STD_LOGIC_VECTOR (4 downto 0);
    douta : out STD_LOGIC_VECTOR (39 downto 0)
);
end program_memory_mock;

architecture Behavioral of program_memory_mock is

type mem_type is array (0 to 31) of STD_LOGIC_VECTOR(39 downto 0);
signal prog_mem : mem_type := (
    x"01000000C0",
    x"2400000080",
    x"10000000E0",
    x"1C000000E0",
    x"01000000C1",
    x"1F000000E0",
    x"FF00000000",
    x"1C000000E3",
    x"01000000C4",
    x"1C000000E4",
    x"01000000C5",
    x"1C000000E5",
    x"01000000C6", 
    x"1C000000E6", 
    x"01000000C7", 
    x"1C000000E7", 
    x"01000000C8", 
    x"1C000000E8", 
    x"01000000C9", 
    x"1C000000E9", 
    x"01000000CA", 
    x"1C000000EA", 
    x"01000000CB", 
    x"1C000000EB", 
    x"01000000CC", 
    x"1C000000EC", 
    x"01000000CD", 
    x"1C000000ED", 
    x"01000000CE", 
    x"1C000000EE", 
    x"FF00000000", 
    x"FF0000001F"
);

begin
    process(clka)
    begin
        if rising_edge(clka) then
            if ena='1' then
                douta <= prog_mem(CONV_INTEGER(addra));
            end if;
        end if;
    end process;
end Behavioral;
