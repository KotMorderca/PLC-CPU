library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ss_driver is port ( 
    clk    : in  STD_LOGIC;
    bars   : out STD_LOGIC_VECTOR(0 to 7);
    anodes : out STD_LOGIC_VECTOR(0 to 7);
    input  : in  STD_LOGIC_VECTOR(31 downto 0);
    dots   : in  STD_LOGIC_VECTOR(7 downto 0)
);
end ss_driver;

architecture Behavioral of ss_driver is

signal anodes_wire       : STD_LOGIC_VECTOR(7 downto 0) := "11111110";

begin
process(clk)
    variable clk_counter     : integer range 0 to 9999 := 0;
    variable current_display : integer range 0 to 7 := 7;
    
begin
    if rising_edge(clk) then
        anodes <= anodes_wire;
        case input(((4*current_display) + 3) downto (4*current_display)) is
            when x"0" => bars <= "0000001" & dots(current_display);
            when x"1" => bars <= "1001111" & dots(current_display);
            when x"2" => bars <= "0010010" & dots(current_display);
            when x"3" => bars <= "0000110" & dots(current_display);
            when x"4" => bars <= "1001100" & dots(current_display);
            when x"5" => bars <= "0100100" & dots(current_display);
            when x"6" => bars <= "0100000" & dots(current_display);
            when x"7" => bars <= "0001111" & dots(current_display);
            when x"8" => bars <= "0000000" & dots(current_display);
            when x"9" => bars <= "0000100" & dots(current_display);
            when x"A" => bars <= "0001000" & dots(current_display);
            when x"B" => bars <= "1100000" & dots(current_display);
            when x"C" => bars <= "0110001" & dots(current_display);
            when x"D" => bars <= "1000010" & dots(current_display);
            when x"E" => bars <= "0110000" & dots(current_display);
            when x"F" => bars <= "0111000" & dots(current_display);
        end case;
        
        if clk_counter=9999 then
            if current_display=0 then
                current_display := 7;
                anodes_wire <= "11111110";
            else
                current_display := current_display - 1;
                anodes_wire <= anodes_wire(6 downto 0) & '1';
            end if;            
            clk_counter := 0;
        else
            clk_counter := clk_counter + 1;
        end if;
    end if;
end process;
end Behavioral;