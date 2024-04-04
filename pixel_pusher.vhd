----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2024 11:09:48 PM
-- Design Name: 
-- Module Name: pixel_pusher - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pixel_pusher is
    Port (
        CLK, EN, VS, VID: in STD_LOGIC;
        PIXEL: in STD_LOGIC_VECTOR(7 downto 0);
        HCOUNT: in STD_LOGIC_VECTOR(9 downto 0);
        R,B: out STD_LOGIC_VECTOR(4 downto 0);
        G: out STD_LOGIC_VECTOR(5 downto 0);
        ADDR: out STD_LOGIC_VECTOR(17 downto 0));
end pixel_pusher;

architecture Behavioral of pixel_pusher is

    signal addr_counter: STD_LOGIC_VECTOR(17 downto 0);
begin
    ADDR<=addr_counter;
    addr_proc:process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(EN ='1' and VID = '1' and to_integer(unsigned(HCOUNT))<480) then
                addr_counter<=std_logic_vector(to_unsigned(to_integer(unsigned(HCOUNT))+1,18));
            end if;
            if(VS ='0') then
                addr_counter<=(others=>'0');
            end if;
        end if;
    end process;

    rgb_proc:process(CLK)
    begin 
        if(rising_edge(CLK)) then
            if(VID = '1' and EN = '1' and to_integer(unsigned(HCOUNT))<480) then
                R <= PIXEL(7 downto 5) & "00";
                G <= PIXEL(4 downto 2) & "000";
                B <= PIXEL(1 downto 0) & "000";
            else
                R <= (others=>'0');
                G <= (others=>'0');
                B <= (others=>'0');
            end if;
        end if;
    end process;



end Behavioral;
