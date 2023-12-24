----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2023 10:54:39 PM
-- Design Name: 
-- Module Name: register - Behavioral
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

entity D_flipflop is
    Port ( clk : in STD_LOGIC ;
            rst : in std_logic;
           D : in STD_LOGIC_vector(15 downto 0);
           Q : out STD_LOGIC_vector(15 downto 0));
end D_flipflop;

architecture Behavioral of D_flipflop is
signal curr_val:std_logic_vector(15 downto 0) := "0000000000000000"; 
begin
Flipflop:process (clk,D,rst)
 begin
 if (rst='1') then curr_val <="0000000000000000"; 
 elsif(clk='1') then curr_val <= D;
 elsif(clk='0') then  Q <= curr_val;
 end if;
 end process;

end Behavioral;
