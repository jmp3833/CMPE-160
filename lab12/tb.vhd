----
-- Project : Lab 12
-- Name    : Justin Peterson
-- File    : tb.vhd
-- Testbench to automatically evaluate all architectures for the lab.
----

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb is
  --An entity never exists in a test bench.
end tb;

architecture behavior of tb is 

component Mux
  port(
       G1, G2 : in std_logic;
	   A, B : in std_logic;
	   C1, C2 : in std_logic_vector(3 downto 0);
	   Y1, Y2 : out std_logic
	);
end component;

signal sA, sB : std_logic := '0';
signal sG1, sG2 : std_logic := '1';
signal sC1 : std_logic_vector(3 downto 0) := "0101";
signal sC2 : std_logic_vector(3 downto 0) := "1010";

signal sY1_1, sY1_2, sY1_3 : std_logic := '0';
signal sY2_1, sY2_2, sY2_3 : std_logic := '0';

for UUT1 : Mux use entity work.Mux(data_flow);
for UUT2 : Mux use entity work.Mux(behavioral);
for UUT3 : Mux use entity work.Mux(double_four_to_one_mux);

begin
  
  UUT1 : Mux port map (A => sA, B => sB, G1 => sG1, G2 =>sG2, C1 => sC1, C2 =>sC2, Y1 =>sY1_1, Y2 =>sY2_1);
  UUT2 : Mux port map (A => sA, B => sB, G1 => sG1, G2 =>sG2, C1 => sC1, C2 =>sC2, Y1 =>sY1_2, Y2 =>sY2_2);
  UUT3 : Mux port map (A => sA, B => sB, G1 => sG1, G2 =>sG2, C1 => sC1, C2 =>sC2, Y1 =>sY1_3, Y2 =>sY2_3);
    
  process  
  --Stimulus processes
    begin
	  --Move A and B while reset switches are enabled. 
	  wait for 50 ns;
      sA  <= '0';
      sB <= '1';
      wait for 50 ns;
	  sA  <= '1';
      sB <= '0';
      wait for 50 ns;
	  sA  <= '1';
      sB <= '1';
      wait for 50 ns;
	  
	 --Re initialize values
	  sG1 <= '0';
	  sG2 <= '0';
	  sA <= '0';
	  sB <= '0';
	  wait for 50 ns;
	  
	  --Run through AB cycle again and grab mux values
      sA  <= '0';
      sB <= '1';
      wait for 50 ns;
	  sA  <= '1';
      sB <= '0';
      wait for 50 ns;
	  sA  <= '1';
      sB <= '1';
      wait for 50 ns;
	  
    end process;
  --End stimulus process
end;
      