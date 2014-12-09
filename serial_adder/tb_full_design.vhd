----
-- Project : Lab 13 - Part 2
-- Name    : Justin Peterson
-- File    : tb_full_design.vhd
-- Testbench for entire simulation of serial adder with control unit.
----

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_full_design is
  --An entity never exists in a test bench.
end tb_full_design;

architecture behavior of tb_full_design is 

component full_design 
	port (
		in_a, in_b : in std_logic_vector (3 downto 0);
		clk, start, clear_sm : in std_logic;
		sum : out std_logic_vector (3 downto 0);
		carry, ready : out std_logic
	);
end component;

constant clk_period : time := 100 ns;
signal clk, start, carry, ready : std_logic := '0';
signal clear_sm : std_logic := '0';
signal in_a, in_b, sum: std_logic_vector(3 downto 0) := "0000";

for UUT1 : full_design use entity work.full_design(structural);

begin
  UUT1 : full_design port map (in_a => in_a, in_b => in_b, clk => clk, start => start, clear_sm => clear_sm, sum => sum, carry => carry, ready => ready);
  
  clk <= not clk after clk_period / 2;

  stimulus : process  
  --Stimulus processes
    begin
		--Set start value and test one clear cycle
		start <= '1';
		--
		in_a <= "0000";
		in_b <= "0100";
		wait for 800 ns;
		clear_sm <= '1';
		wait for 100 ns;
		clear_sm <= '0';
		in_a <= "1100";
		in_b <= "1110";
		wait for 800 ns;
		clear_sm <= '1';
		wait for 100 ns;
		clear_sm <= '0';
		in_a <= "1000";
		in_b <= "1010";
		wait for 800 ns;
		clear_sm <= '1';
		wait for 100 ns;
		clear_sm <= '0';
		in_a <= "1111";
		in_b <= "1111";
		wait for 800 ns;
		clear_sm <= '1';
		wait for 100 ns;
		clear_sm <= '0';
		in_a <= "1111";
		in_b <= "0001";
		wait for 800 ns;
		clear_sm <= '1';
		wait for 100 ns;
		clear_sm <= '0';
		in_a <= "1010";
		in_b <= "0101";
		wait for 800 ns;
		clear_sm <= '1';
		wait for 100 ns;
		clear_sm <= '0';
		in_a <= "1000";
		in_b <= "0111";
		wait for 1000 ns;
		
		wait;
    end process;
  --End stimulus process
end;
      