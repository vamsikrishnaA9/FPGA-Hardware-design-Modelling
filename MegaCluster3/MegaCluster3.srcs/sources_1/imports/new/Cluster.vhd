----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2023 08:40:47 PM
-- Design Name: 
-- Module Name: Cluster - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
--use IEEE.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mini_Cluster is
--    port (A,B : in std_logic_vector(3 downto 0);
--            C,Sel : in std_logic_vector(2 downto 0);
--            Mini_Cluster_en : in std_logic_vector(3 downto 0);
--            Mega_Cluster_en : in std_logic_vector(3 downto 0);
--            clk,reset,Router_en : in std_logic);
 port(INPUT : in std_logic_vector(31 downto 0);
      OUTPUT : out std_logic_vector(31 downto 0) ;
      Router_en,clk : in std_logic);    
end Mini_Cluster;

architecture Behavioral of Mini_Cluster is
signal A,B :  std_logic_vector(3 downto 0);
signal C : std_logic_vector(2 downto 0);
signal Sel : std_logic_vector(11 downto 0);
signal CU_en :  std_logic_vector(3 downto 0);
signal Mega_Cluster_en :  std_logic_vector(3 downto 0);
signal reset :  std_logic;
signal Pass : std_logic_vector(31 downto 0);
signal INPUT1:std_logic_vector(31 downto 0);
--signal temp, temp2, temp3: std_logic;

--signal Pass_out: std_logic_vector(15 downto 0);
--signal var : integer;


begin
INPUT1 <= INPUT when (Router_en = '1') else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
A <=INPUT1(31 downto 28);
B <=INPUT1(27 downto 24);
C <=INPUT1(23 downto 21);
Sel <=INPUT1(20 downto 9);
--clk<=INPUT(9) ;
reset <=INPUT1(8);
CU_en <=INPUT1(7 downto 4);
Mega_Cluster_en <=INPUT1(3 downto 0);

CU0: entity work.CU(Behavioral)
port map(A=>A, B=>B,C=>C,Sel=>Sel(2 downto 0),
        Clk=>clk,reset=> reset,Y=>Pass(31 downto 24), E=>CU_en(0));

CU1: entity work.CU(Behavioral)
port map(A=>A, B=>B,C=>C,Sel=>Sel(5 downto 3),
        Clk=>clk,reset=> reset,Y=>Pass(23 downto 16), E=>CU_en(1));

CU2: entity work.CU(Behavioral)
port map(A=>A, B=>B,C=>C,Sel=>Sel(8 downto 6),
        Clk=>clk,reset=> reset,Y=>Pass(15 downto 8), E=>CU_en(2));

CU3: entity work.CU(Behavioral)
port map(A=>A, B=>B,C=>C,Sel=>Sel(11 downto 9),
        Clk=>clk,reset=> reset,Y=>Pass(7 downto 0), E=>CU_en(3));


--var <= to_integer(unsigned(Pass(8 downto 0)));

--process(Pass)
--begin

--for i in 0 to 31 loop
--    temp <= Pass(i) AND '1';
--    temp2 <= NOT temp;
--    temp3 <= temp OR temp2;
--    if(temp3 = '1') then
----  if(((Not Pass(i) AND '1') OR (Pass(i)*'1')) ='1') then
--   Pass_out(i)<= Pass(i);
--    end if; 
--   end loop;
--   end process;
   
--Pass_out <= Pass;
OUTPUT <= Pass;
end Behavioral;





