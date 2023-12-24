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

entity Mega_Cluster is
 port(INPUT : in std_logic_vector(39 downto 0);
      OUTPUT : inout std_logic_vector(39 downto 0);
    --  Mini_cluster_en: in std_logic_vector(3 downto 0);
     Mega_en : in std_logic;
      clk : in std_logic);
end Mega_Cluster;

architecture Behavioral of Mega_Cluster is
signal INPUT1 :std_logic_vector(39 downto 0);
signal INPUT2 : std_logic_vector(39 downto 0);
signal Mini_Cluster_en : std_logic_vector(3 downto 0);

signal out1 : std_logic_vector(31 downto 0);
signal out2 : std_logic_vector(31 downto 0);
signal out3 : std_logic_vector(31 downto 0);
signal out4 : std_logic_vector(31 downto 0);

signal x: std_logic;
begin

INPUT1 <= INPUT when (Mega_en = '1') else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

Mini_Cluster_en <= INPUT1(35 downto 32);

MiniCluster0 : entity work.Mini_Cluster(Behavioral)
port map(INPUT => INPUT1(31 downto 0), OUTPUT=>out1, clk=>clk, Router_en => Mini_cluster_en(0));

MiniCluster1 : entity work.Mini_Cluster(Behavioral)
port map(INPUT => INPUT1(31 downto 0), OUTPUT=>out2, clk=>clk, Router_en => Mini_cluster_en(1));

MiniCluster2 : entity work.Mini_Cluster(Behavioral)
port map(INPUT => INPUT1(31 downto 0), OUTPUT=>out3, clk=>clk, Router_en => Mini_cluster_en(2));

MiniCluster3 : entity work.Mini_Cluster(Behavioral)
port map(INPUT => INPUT1(31 downto 0), OUTPUT=>out4, clk=>clk, Router_en => Mini_cluster_en(3));

process(x)
begin 
if x='1' then 
OUTPUT(39 downto 32) <= "00010001";
OUTPUT(31 downto 24) <= out1(11 downto 8) & out2(3 downto 0);
OUTPUT(23 downto 21)<="001";
OUTPUT(20 downto 9)<="011000101110"; -- NAND/ADD
OUTPUT(8) <= '0';
OUTPUT(7 downto 4)<= "0110"; --CU en
OUTPUT(3 downto 0)<="0001"; --mega en

INPUT2 <= OUTPUT;
x<='0';
end if;
end process;
--end if;

end Behavioral;
