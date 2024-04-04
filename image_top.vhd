----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2024 11:27:03 PM
-- Design Name: 
-- Module Name: image_top - Behavioral
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

entity image_top is
  Port ( CLK:in STD_LOGIC;
         VGA_HS, VGA_VS: out STD_LOGIC;
         VGA_R,VGA_B: out STD_LOGIC_VECTOR(4 downto 0);
         VGA_G: out STD_LOGIC_VECTOR(5 downto 0));
end image_top;

architecture Behavioral of image_top is

    component clock_div is
      Port ( clk : in STD_LOGIC;
             div : out STD_LOGIC);
    end component;
    
    component vga_ctrl is
        Port ( CLK : in STD_LOGIC;
             EN : in STD_LOGIC;
             HCOUNT : out STD_LOGIC_VECTOR(9 downto 0);
             VCOUNT : out STD_LOGIC_VECTOR(9 downto 0);
             VID : out STD_LOGIC;
             HS : out STD_LOGIC;
             VS : out STD_LOGIC);
    end component;

    component picture IS
      Port (
        clka : in STD_LOGIC;
        addra : in STD_LOGIC_VECTOR(17 DOWNTO 0);
        douta : out STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    end component;
    
    component pixel_pusher is
        Port (
            CLK, EN, VS, VID: in STD_LOGIC;
            PIXEL: in STD_LOGIC_VECTOR(7 downto 0);
            HCOUNT: in STD_LOGIC_VECTOR(9 downto 0);
            R,B: out STD_LOGIC_VECTOR(4 downto 0);
            G: out STD_LOGIC_VECTOR(5 downto 0);
            ADDR: out STD_LOGIC_VECTOR(17 downto 0));
    end component;
    
    --Signals
    signal en, vs, vid : STD_LOGIC:='0'; 
    signal pixel: STD_LOGIC_VECTOR(7 downto 0):=(others=>'0'); 
    signal addr: STD_LOGIC_VECTOR(17 downto 0):=(others=>'0'); 
    signal hcount:  STD_LOGIC_VECTOR(9 downto 0);
    signal vcount:  STD_LOGIC_VECTOR(9 downto 0);
begin

    div:clock_div
        port map(
            clk=>CLK,
            div=>en 
           );
       
    mem:picture
        port map(
            clka=>en,
            addra=>addr,
            douta=>pixel
            );   
    pusher:pixel_pusher
        port map(
                en=>en,
                clk=>clk,
                vs=>vs,
                vid=>vid,
                pixel=>pixel,
                addr=>addr,
                R=>VGA_R,
                G=>VGA_G,
                B=>VGA_B,
                hcount=>hcount
            );
    ctrl:vga_ctrl 
        Port map( 
             CLK=>clk,
             EN=>en,
             HCOUNT=>hcount,
             VCOUNT=>vcount,
             VID=>vid,
             HS=>VGA_HS,
             VS=>VGA_VS);

end Behavioral;
