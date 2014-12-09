----
-- Project : Lab 13
-- Name    : Justin Peterson
-- File    : full_design.vhd
-- Structural design of the 4 input serial adder driven by state machine.
----

library ieee;
use ieee.std_logic_1164.all;

--Definition of all inputs and outputs

entity full_design is 
	port (
		in_a, in_b : in std_logic_vector (3 downto 0);
		clk, start, clear_sm : in std_logic;
		sum : out std_logic_vector (3 downto 0);
		carry, ready : out std_logic
	);
end full_design;
 
architecture structural of full_design is
  component full_design is
   	port (
		in_a, in_b : in std_logic_vector (3 downto 0);
		clk, start, clear_sm : in std_logic;
		sum : out std_logic_vector (3 downto 0);
		carry, ready : out std_logic
	);
  end component;
  component serial_adder is
    port (
		in_a, in_b : in std_logic_vector (3 downto 0);
		control : in std_logic_vector (1 downto 0);
		clk, clear_dp : in std_logic;
	
		sum : out std_logic_vector (3 downto 0);
		carry : out std_logic
	);
  end component;	
  component state_machine is
    port (
	  clk, start, clear_sm : in std_logic;
		   control_output : out std_logic_vector(3 downto 0)
	);
  end component;	
  
  signal s_1 : std_logic_vector(3 downto 0) := "0000";
  --Break the state signal apart into manageable segments defining ready, clear,
  --and control inputs to the adder.
  signal control_bits : std_logic_vector(1 downto 0) := "00";
  signal clear_dff : std_logic := '0';
  
  begin
    serial_adder_instance_1 : serial_adder port map (in_a => in_a, in_b => in_b, control => control_bits, clk => clk, clear_dp => clear_dff, sum => sum, carry => carry);
	state_machine_instance_1 : state_machine port map (clk => clk, start => start, clear_sm => clear_sm, control_output => s_1);
	
	--Assign and split apart intermittent signals. 
	control_bits <= s_1(1) & s_1(0);
	clear_dff <= s_1(2);
	ready <= s_1(3);
end structural;	  

        