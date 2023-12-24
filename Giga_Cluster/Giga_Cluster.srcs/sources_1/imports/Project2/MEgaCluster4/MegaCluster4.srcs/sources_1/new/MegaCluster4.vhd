----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2023 01:58:19 PM
-- Design Name: 
-- Module Name: Mega_Cluster - Behavioral
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

entity MegaCluster4 is
 port(INPUT : in std_logic_vector(39 downto 0);
      OUTPUT : inout std_logic_vector(15 downto 0);
    --  Mini_cluster_en: in std_logic_vector(3 downto 0);
     Mega_en : in std_logic;
      clk : in std_logic);
end MegaCluster4;

architecture Behavioral of MegaCluster4 is
signal INPUT1 :std_logic_vector(39 downto 0);
signal INPUT2 : std_logic_vector(39 downto 0):="0000000000000000000000000000000000000000";
signal INPUT3 : std_logic_vector(39 downto 0);
signal INPUT4 : std_logic_vector(39 downto 0);
signal Mini_Cluster_en : std_logic_vector(3 downto 0);

signal out1 : std_logic_vector(31 downto 0);
signal out2 : std_logic_vector(31 downto 0);
signal out3 : std_logic_vector(31 downto 0);
signal out4 : std_logic_vector(31 downto 0);

signal OUTPUT1 : std_logic_vector(15 downto 0);

signal I : std_logic;
begin
I <= Mega_en;

Process(I,INPUT,INPUT2)
begin
--INPUT1 <= INPUT when (I = '1') else INPUT2;
--"ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
-- This if loop decides the input when the I i.e signal(Mega_en) is '1' or '0'.
if I='1' then
   INPUT1<= INPUT;
   else 
   INPUT1<=INPUT2;
end if;
end process;


Mini_Cluster_en <= INPUT1(35 downto 32);

MiniCluster0 : entity work.Mini_Cluster(Behavioral)
port map(INPUT => INPUT1(31 downto 0), OUTPUT=>out1, clk=>clk, Router_en => Mini_cluster_en(0));

MiniCluster1 : entity work.Mini_Cluster(Behavioral)
port map(INPUT => INPUT1(31 downto 0), OUTPUT=>out2, clk=>clk, Router_en => Mini_cluster_en(1));

INPUT3(39 downto 32) <= "00010100"; --giga , --mini
INPUT3(31 downto 24) <= out1(11 downto 8) & out2(3 downto 0);
INPUT3(23 downto 21)<="001";
INPUT3(20 downto 9)<="111100011111"; -- nop/ROR/ROL/nop
INPUT3(8) <= '0';
INPUT3(7 downto 4)<= "0110"; --CU en
INPUT3(3 downto 0)<="0001"; --mega en


MiniCluster2 : entity work.Mini_Cluster(Behavioral)
port map(INPUT => INPUT3(31 downto 0), OUTPUT=>out3, clk=>clk, Router_en => INPUT3(34));

INPUT4(39 downto 32) <= "00011000"; --giga , --mini
INPUT4(31 downto 24) <= out1(19 downto 16) & out2(27 downto 24);
INPUT4(23 downto 21)<="001";
INPUT4(20 downto 9)<="111100011111"; -- Nop/ROR/ROL/nop
INPUT4(8) <= '0';
INPUT4(7 downto 4)<= "0110"; --CU en
INPUT4(3 downto 0)<="0001"; --mega 

MiniCluster3 : entity work.Mini_Cluster(Behavioral)
port map(INPUT => INPUT4(31 downto 0), OUTPUT=>out4, clk=>clk, Router_en => INPUT4(35));


--OUTPUT1(39 downto 32)<="00010011"; --giga --mini
--The final output from the mega cluster 4
OUTPUT1 <= out3(23 downto 16) & out4(15 downto 8); 
--OUTPUT1(20 downto 9)<="111010010111";  --//Nop//
---OUTPUT1(8) <='0';
--OUTPUT1(7 downto 0)<="01100001"; --CUen -- Mega


--output that will be send out
OUTPUT<=OUTPUT1;
--At this statement I want to change the input of the blue cluster to the above OUTPUT ( signal) value. 
--I<='0' when(INPUT2(3 downto 0)<="0001") else '1'; 
--end process;


end Behavioral;
