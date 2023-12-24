----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2023 08:02:09 PM
-- Design Name: 
-- Module Name: Mega_Cluster_tb - Behavioral
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
--use std.env.finish;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mega_Cluster_tb is
--  Port ( );
end Mega_Cluster_tb;

architecture Behavioral of Mega_Cluster_tb is
signal INPUT : std_logic_vector(39 downto 0);
signal OUTPUT: std_logic_vector(39 downto 0);
signal Mega_en : std_logic:='0';
signal clk: std_logic:='0';
begin
Cluster : entity work.Mega_Cluster(Behavioral)
port map(INPUT=>INPUT, OUTPUT=>OUTPUT, Mega_en=>Mega_en,clk=>clk);

clk <= not clk after 5ns;
stim:process
begin
Mega_en <='1';
wait for 50ns;
--        A  / B /C / Sel12/cl/res/Mini/Mega
--INPUT <="1011 0011 001 101000000001 0 1100 1000";
INPUT(39 downto 32)<="00010011"; --giga --mini
INPUT(31 downto 21)<="10110011001";
INPUT(20 downto 9)<="011000101110";  --//ROL//Add/NAND//XOR
INPUT(8) <='0';
INPUT(7 downto 0)<="11110001"; --CUen -- Mega
--Mega_en<='0';

--finish;
end process;
end Behavioral;
