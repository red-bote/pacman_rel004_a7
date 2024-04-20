----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: red-bote
-- 
-- Create Date: 04/20/2024 12:49:01 PM
-- Design Name: 
-- Module Name: rtl_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: top level for pacman model
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

entity rtl_top is
    Port ( clk : in STD_LOGIC;
           JA : in STD_LOGIC_VECTOR(4 downto 0);
           btnC, btnU, btnR, btnL, btnD : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaBlue : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0);
           Hsync, Vsync : out STD_LOGIC;
           O_PMODAMP2_AIN : out STD_LOGIC;
           O_PMODAMP2_GAIN : out STD_LOGIC;
           O_PMODAMP2_SHUTD : out STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0));
end rtl_top;

architecture Behavioral of rtl_top is

    signal btns : std_logic_vector(4 downto 0);
    signal reset : std_logic;

begin

    -- active-low shutdown pin
    O_PMODAMP2_SHUTD <= sw(14);
    -- gain pin is driven high there is a 6 dB gain, low is a 12 dB gain 
    O_PMODAMP2_GAIN <= sw(15);

    --btns <= btnD & btnU & btnR & btnL;
--    btns <= JA;
    btns(0) <= not JA(0);
    btns(1) <= not JA(1);
    btns(2) <= not JA(2);
    btns(3) <= not JA(3);

    reset <= btnC;

u_pacman : entity work.PACMAN
  port map (
    O_VIDEO_R             => vgaRed,
    O_VIDEO_G             => vgaGreen,
    O_VIDEO_B             => vgaBlue,
    O_HSYNC               => Hsync,
    O_VSYNC               => Vsync,
    --
    O_AUDIO_L             => O_PMODAMP2_AIN,
    O_AUDIO_R             => open,
    --
    I_SW                  => sw(3 downto 0),
    I_BUTTON              => btns(3 downto 0),
    O_LED                 => led,
    --
    I_RESET               => reset,
    I_CLK_REF             => clk
    );

end Behavioral;
