----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2023 05:25:33 PM
-- Design Name: 
-- Module Name: Cluster_tb - Behavioral
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

entity Cluster_tb is
--  Port ( );
end Cluster_tb;

architecture Behavioral of Cluster_tb is
signal INPUT : std_logic_vector(39 downto 0);
signal OUTPUT: std_logic_vector(15 downto 0);
signal Router_en : std_logic;
signal clk: std_logic:='0';
begin
Cluster : entity work.Mini_Cluster(Behavioral)
port map(INPUT=>INPUT, OUTPUT=>OUTPUT, Router_en=>Router_en,clk=>clk);

clk <= not clk after 5ns;
stim:process
begin
Router_en <='1';
wait for 50ns;
--        A  / B /C / Sel12/cl/res/Mini/Mega
--INPUT <="1011 0011 001 101000000001 0 1100 1000";
INPUT(39 downto 32)<="00010001";
INPUT(31 downto 21)<="10110011001";
INPUT(20 downto 9)<="101000000001";
INPUT(8 downto 0)<="011001000";

end process;
end Behavioral;
