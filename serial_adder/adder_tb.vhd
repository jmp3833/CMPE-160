----
-- Project : Lab 13 - Part 1
-- Name    : Justin Peterson
-- File    : adder_tb.vhd
-- Tests the table of values in the Lab 13 description
-- Over a 4 bit serial adder with control unit. 
----

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity serial_adder_tb is
  --An entity never exists in a test bench.
end serial_adder_tb;

architecture behavior of serial_adder_tb is 

component serial_adder
  port (
		in_a, in_b : in std_logic_vector (3 downto 0);
		control : in std_logic_vector (1 downto 0);
		clk, clear_dp : in std_logic;
	
		sum : out std_logic_vector (3 downto 0);
		carry : out std_logic
  );
end component;

--Serial Adder Signals
signal sin_a, sin_b, ssum : std_logic_vector(3 downto 0) := "0000";
signal scontrol : std_logic_vector(1 downto 0) := "11";
signal sclk, scarry : std_logic := '0';
signal sclear_dp : std_logic := '1';

for UUT1 : serial_adder use entity work.serial_adder(structural);

begin
  UUT1 : serial_adder port map (in_a => sin_a, in_b => sin_b, control => scontrol, clk=>sclk, clear_dp => sclear_dp, sum => ssum, carry => scarry);
  sclk <= not sclk after 50 ns;

  stimulus : process  
  --Stimulus processes
    begin
		wait for 55 ns;
		sin_b <= "0100";
		scontrol <= "11";
		wait for 100 ns;
		scontrol <= "01";
		wait for 500 ns;
		sclear_dp <= '0';
		wait for 100 ns;
		sclear_dp <= '1';
		scontrol <= "11";
		sin_a <= "1100";
		sin_b <= "1110";
		wait for 100 ns;
		scontrol <= "01";
		wait for 500 ns;
		sclear_dp <= '0';
		wait for 100 ns;
		sclear_dp <= '1';
		scontrol <= "11";
		sin_a <= "1000";
		sin_b <= "1010";
		wait for 100 ns;
		scontrol <= "01";
		wait for 500 ns;
		sclear_dp <= '0';
		wait for 100 ns;
		sclear_dp <= '1';
		scontrol <= "11";
		sin_a <= "1111";
		sin_b <= "1111";
		wait for 100 ns;
		scontrol <= "01";
		wait for 500 ns;
		sclear_dp <= '0';
		wait for 100 ns;
		sclear_dp <= '1';
		scontrol <= "11";
		sin_a <= "1111";
		sin_b <= "0001";
		wait for 100 ns;
		scontrol <= "01";
		wait for 500 ns;
		sclear_dp <= '0';
		wait for 100 ns;
		sclear_dp <= '1';
		scontrol <= "11";
		sin_a <= "1010";
		sin_b <= "0101";
		wait for 100 ns;
		scontrol <= "01";
		wait for 500 ns;
		sclear_dp <= '0';
		wait for 100 ns;
		sclear_dp <= '1';
		scontrol <= "11";
		sin_a <= "1000";
		sin_b <= "0111";
		wait for 100 ns;
		scontrol <= "01";
    end process;
  --End stimulus process
end;
      