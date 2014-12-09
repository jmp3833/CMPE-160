----
-- Project : Lab 13 - Part 2
-- Name    : Justin Peterson
-- File    : state_machine_tb.vhd
-- Testbench for state machine which drives the serial adder
----

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity state_machine_tb is
  --An entity never exists in a test bench.
end state_machine_tb;

architecture behavior of state_machine_tb is 

component state_machine 
	Port ( clk, start, clear_sm : in std_logic;
		   control_output : out std_logic_vector(3 downto 0));
end component;

--State Machine Signals
signal clk, start, clear_sm : std_logic := '0';
signal control_output: std_logic_vector(3 downto 0) := "0000";

for UUT1 : state_machine use entity work.state_machine(behavioral);

begin
  UUT1 : state_machine port map (clk=>clk, start=>start, clear_sm =>clear_sm, control_output=>control_output );
  clk <= not clk after 50 ns;

  stimulus : process  
  --Stimulus processes
    begin
		--Set start value and test one clear cycle
		wait for 55 ns;
		start <= '1';
		wait for 500 ns;
		clear_sm <= '1';
		wait for 100 ns;
		clear_sm <= '0';
		--Let the state machine run!
		wait for 1200 ns;
    end process;
  --End stimulus process
end;
      