----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2023 07:09:32 PM
-- Design Name: 
-- Module Name: Giga_tb - Behavioral
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

entity Giga_tb is
--  Port ( );
end Giga_tb;

architecture Behavioral of Giga_tb is
signal INPUT : std_logic_vector(39 downto 0);
signal OUTPUT : std_logic_vector(15 downto 0);
signal Gig_en : std_logic;
signal clk: std_logic:='0';

begin
GigCluster:entity work.Giga_Cluster(Behavioral)
port map(INPUT => INPUT, OUTPUT=> OUTPUT, Gig_en=>Gig_en, clk=>clk);

clk <= not clk after 5ns;
stim:process
begin
Gig_en <='1';
wait for 50ns;

INPUT(39 downto 32)<="00010011"; --giga --mini
INPUT(31 downto 21)<="10110011001"; --Sel limes
INPUT(20 downto 9)<="011000101110";  --//ROL//Add/NAND//XOR
INPUT(8) <='0';
INPUT(7 downto 0)<="11111111"; --CUen -- Mega
--Mega_en<='0';

--finish;
end process;

end Behavioral;
