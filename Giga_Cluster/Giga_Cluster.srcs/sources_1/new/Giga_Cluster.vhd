----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2023 05:53:09 PM
-- Design Name: 
-- Module Name: Giga_Cluster - Behavioral
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

entity Giga_Cluster is
--  Port ( );
port( INPUT : in std_logic_vector(39 downto 0);
      OUTPUT : out std_logic_vector(15 downto 0);
      Gig_en : in std_logic;
      clk : in std_logic);
end Giga_Cluster;


architecture Behavioral of Giga_Cluster is
-- various signals used for assignements
signal INPUT1 : std_logic_vector(39 downto 0);
signal INPUT2 : std_logic_vector(39 downto 0);
signal INPUT3 : std_logic_vector( 39 downto 0);
signal INPUT4 : std_logic_vector( 39 downto 0);
signal INPUT5 : std_logic_vector(39 downto 0):="0000000000000000000000000000000000000000";
signal OUT1 : std_logic_vector(39 downto 0);
signal OUT2 : std_logic_vector(39 downto 0);
signal OUT3 : std_logic_vector(39 downto 0);
signal OUT4 : std_logic_vector(15 downto 0);
--signal Mega_Cluster_en : std_logic_vector(3 downto 0);
signal I : std_logic;
begin
I <= Gig_en;

Process(I,INPUT,INPUT5)
begin
--INPUT1 <= INPUT when (I = '1') else INPUT2;
--"ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
-- This if loop decides the input when the I i.e signal(Mega_en) is '1' or '0'.
if I='1' then   -- Giga module enabling 
   INPUT1<= INPUT;
   else 
   INPUT1<=INPUT5;
end if;
end process;
-- port mapping mega cluster 0
MegaCluster0 : entity work.Mega_Cluster(Behavioral)
port map(INPUT=> INPUT1, OUTPUT=> OUT1, clk=>clk, Mega_en=> INPUT(0)); 

--Process(INPUT, OUT1)
--begin
--if INPUT(0)='1' then 
INPUT2<= OUT1;
--else INPUT2 <="0000000000000000000000000000000000000000";
--end if;
--end process;

-- Port mapping the Mega cluster 1 
MegaCluster1 : entity work.MegaCluster2(Behavioral)
port map(INPUT=>INPUT2, OUTPUT=> OUT2, clk=>clk, Mega_en=>INPUT2(1));

INPUT3 <= OUT2;

--port mapping mega cluster 2
MegaCluster2 : entity work.MegaCluster3(Behavioral)
port map(INPUT => INPUT3, OUTPUT=> OUT3, clk=>clk, Mega_en =>INPUT3(2));

INPUT4<= OUT3;
--port mapping meg cluster 3
MegaCluster3 : entity work.MegaCluster4(Behavioral)
port map(INPUT=> INPUT4, OUTPUT=> OUT4, clk => clk, Mega_en => INPUT4(3));

OUTPUT<= OUT4; -- total output



end Behavioral;
