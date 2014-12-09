----
-- Project : Lab 13 - Part 1
-- Name    : Justin Peterson
-- File    : tb.vhd
-- Testbench for individual behavioral components
-- Not the entire full serial adder component.
----

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb is
  --An entity never exists in a test bench.
end tb;

architecture behavior of tb is 

component DM74LS194A
  port(
        clr, clk : in std_logic;
        mode, serial : in std_logic_vector (1 downto 0);
        parallel : in std_logic_vector (3 downto 0);
        outputs  : out std_logic_vector (3 downto 0)
	);
end component;

component full_adder
  port (a, b, c_in : in std_logic;
        c_out, f   : out std_logic);
end component;

--Full Adder Signals
signal sA, sB, sCin : std_logic := '0';
signal sCout, sF : std_logic := '0';
--DM74LS194A signals
signal sClr : std_logic := '0';
signal sMode, sSerial : std_logic_vector(1 downto 0) := "00";
signal sParallel, sOutputs : std_logic_vector(3 downto 0) := "1111";
signal sClk : std_logic := '0';

for UUT1 : DM74LS194A use entity work.DM74LS194A(behavioral);
for UUT2 : full_adder use entity work.full_adder(behavioral);

begin
  UUT1 : DM74LS194A port map (clr => sClr, clk => sClk, mode => sMode, serial => sSerial, parallel => sParallel, outputs => sOutputs );
  UUT2 : full_adder port map (a => sA, b => sB, c_in => sCin, c_out => sCout, f => sF ); 
  
  sClk <= not sClk after 50 ns;

  stimulus : process  
  --Stimulus processes
    begin
		wait for 55 ns;
		--Cycle through each value of A and B on full adder.
		sA <= '1';
		sB <= '1';
		sCin <= '1';
		--Turn off clear and set mode to load "1111" value
		sClr <= '1';
		sMode <= "11";
		wait for 100 ns;
		--Change carry value for adder, change mode of register to shift left
		sCin <= '0';
		sMode <= "10";
		wait for 100 ns;
		--Change in value for adder, change mode of register to shift right
		sA <= '0';
		sMode <= "01";
		wait for 50 ns;
    end process;
  --End stimulus process
end;
      