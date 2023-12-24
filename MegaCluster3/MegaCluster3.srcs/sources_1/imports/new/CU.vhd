----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2023 02:40:43 PM
-- Design Name: 
-- Module Name: Shift - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CU is
--  Port ( );
port ( A: in std_logic_vector(3 downto 0);  -- input
        E : in std_logic;     -- enables the CU
        B : in std_logic_vector(3 downto 0);  -- input
        C : in std_logic_vector(2 downto 0); -- shift bit selection
        Sel : in std_logic_vector(2 downto 0); 
        Clk : in std_logic;
        reset : in std_logic;
        Y : inout std_logic_vector(7 downto 0)); -- output
        
end CU;

architecture Behavioral of CU is

signal store_out : std_logic_vector(15 downto 0);
signal input : std_logic_vector(15 downto 0);
signal A_in , B_in : std_logic_vector(3 downto 0);
signal Ys : std_logic_vector(7 downto 0);
begin
input <= (A & B)&Y;


Storage: entity work.D_flipflop(Behavioral)
port map(clk=>clk, rst=> reset, D=> input , Q=>store_out);
A_in <= store_out(15 downto 12);
B_in <= store_out(11 downto 8);

shift : process( A_in,E,C,B_in,Sel)
begin
if( E='1') then
    case sel is
    when "000" => Y <="000"& ('0'&A_in) +('0'& B_in);
    when "001" => Y <= "0000" & (A_in-B_in);
    when "010" => Y<= A_in*B_in;

    when "011" => Y<="0000" & (to_stdlogicvector(to_bitvector(A_in) rol to_integer(unsigned(C)))); -- Rotate shift left
    when "100" => Y<="0000" & (to_stdlogicvector(to_bitvector(A_in) ror to_integer(unsigned(C)))); -- Rotate shift right
    when "101" => Y<= "0000" & (A_in NAND B_in);
    when "110" => Y<= "0000" & (A_in XOR B_in);
    when "111" => Y<=  "00000000";
    when others => Y <= "00000000";
end case;
--else Y<="00000000";

end if;
--Y<=Ys;
end process;

end Behavioral;
