----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2024 08:59:07 PM
-- Design Name: 
-- Module Name: vga_ctrl_tb - Behavioral
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

entity vga_ctrl_tb is
--  Port ( );
end vga_ctrl_tb;

architecture Behavioral of vga_ctrl_tb is
    component vga_ctrl is
        Port ( CLK : in STD_LOGIC;
             EN : in STD_LOGIC;
             HCOUNT : out STD_LOGIC_VECTOR(9 downto 0);
             VCOUNT : out STD_LOGIC_VECTOR(9 downto 0);
             VID : out STD_LOGIC;
             HS : out STD_LOGIC;
             VS : out STD_LOGIC);
    end component;
    
    component clock_div is
      Port ( clk : in std_logic;
             div : out std_logic);
    end component;
    
    signal tb_clk,tb_div,tb_hs,tb_vs,tb_vid: std_logic:='0';
    signal tb_vcount,tb_hcount: std_logic_vector(9 downto 0); 
    
    
begin
 
    clk_gen_proc: process
    begin

        wait for 4 ns;
        tb_clk <= '1';

        wait for 4 ns;
        tb_clk <= '0';

    end process clk_gen_proc;
   
   
    div: clock_div 
        port map(
            clk=>tb_clk,
            div=>tb_div
        );
    vgactrl: vga_ctrl 
        port map(
            clk=>tb_clk,
            en=>tb_div,
            hcount=>tb_hcount,
            vcount=>tb_vcount,
            vid
            hs
            vs
        );

end Behavioral;
