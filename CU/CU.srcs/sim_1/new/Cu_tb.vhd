----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2023 11:48:33 PM
-- Design Name: 
-- Module Name: Cu_tb - Behavioral
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
use std.env.finish;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cu_tb is
--  Port ( );
end Cu_tb;

architecture Behavioral of Cu_tb is
signal  A: std_logic_vector(3 downto 0);  -- input
signal  E : std_logic;     -- enables the CU
signal  B :  std_logic_vector(3 downto 0);  -- input
signal  C : std_logic_vector(2 downto 0); -- shift bit selection
signal  Sel : std_logic_vector(2 downto 0); 
signal  Clk :  std_logic :='0';
signal  reset :  std_logic;
signal Y : std_logic_vector(7 downto 0);
--signal  Ys :  std_logic_vector(7 downto 0); -- output
begin

CU : entity work.CU(Behavioral)
port map(A=>A, E=>E, B=>B, C=>C, Sel=>Sel, Clk=>Clk, reset=> reset, Y=>Y);
clk <= not clk after 5ns;

stim :process
begin 
 E<='1'; C<="001"; reset <='0';
     Sel<="110"; wait for 50ns;
    A <= "1010"; B<="0101"; wait for 50ns;

finish;
end process;
end Behavioral;
