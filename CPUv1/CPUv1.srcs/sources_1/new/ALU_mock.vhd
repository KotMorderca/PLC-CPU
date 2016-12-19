library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_mock is port ( 
    CLK     : in  STD_LOGIC;
	RST_n   : in  STD_LOGIC;
	A       : in  STD_LOGIC_VECTOR(31 downto 0);
	B       : in  STD_LOGIC_VECTOR(31 downto 0);
	C       : out STD_LOGIC_VECTOR(31 downto 0);
	OV      : out STD_LOGIC;
	OP_CTRL : in  STD_LOGIC_VECTOR(26 downto 0);
	IDLE    : out STD_LOGIC
);
end ALU_mock;

architecture Behavioral of ALU_mock is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if OP_CTRL(0)='1' then
                C <= A xor B;
            end if;
        end if;
    end process;

end Behavioral;
