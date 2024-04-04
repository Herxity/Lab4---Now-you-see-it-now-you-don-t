----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 12:20:44 AM
-- Design Name: 
-- Module Name: image_top_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top_tb is
--  Port ( );
end image_top_tb;

architecture Behavioral of image_top_tb is
    component image_top is
      Port ( CLK:in STD_LOGIC;
             VGA_HS, VGA_VS: out STD_LOGIC;
             VGA_R,VGA_B: out STD_LOGIC_VECTOR(4 downto 0);
             VGA_G: out STD_LOGIC_VECTOR(5 downto 0));
    end component;

    signal tb_clk,tb_hs,tb_vs,tb_vid: std_logic:='0';
    signal tb_r,tb_b: std_logic_vector(4 downto 0):=(others=>'0');
    signal tb_g: std_logic_vector(5 downto 0):=(others=>'0');
begin

    clk_gen_proc: process
    begin

        wait for 4 ns;
        tb_clk <= '1';

        wait for 4 ns;
        tb_clk <= '0';

    end process clk_gen_proc;


    dut:image_top
        Port map( CLK=>tb_clk,
             VGA_HS=>tb_hs,
              VGA_VS=>tb_vs,
             VGA_R=>tb_r,
             VGA_B=>tb_b,
             VGA_G=>tb_g);
end Behavioral;
