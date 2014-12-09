----
-- Project : Lab 13
-- Name    : Justin Peterson
-- File    : serial_adder.vhd
-- Structurally describes a 4 bit serial adder with individual components. 
----

library ieee;
use ieee.std_logic_1164.all;

--Definition of all inputs and outputs

entity serial_adder is 
	port (
		in_a, in_b : in std_logic_vector (3 downto 0);
		control : in std_logic_vector (1 downto 0);
		clk, clear_dp : in std_logic;
	
		sum : out std_logic_vector (3 downto 0);
		carry : out std_logic
	);
end serial_adder;
 
architecture structural of serial_adder is
  component serial_adder is
    port (
		in_a, in_b : in std_logic_vector (3 downto 0);
		control : in std_logic_vector (1 downto 0);
		clk, clear_dp : in std_logic;
	
		sum : out std_logic_vector (3 downto 0);
		carry : out std_logic
	);
  end component;	
  component four_bit_shift_register is
	port( clr, clk : in std_logic;
        mode, serial : in std_logic_vector (1 downto 0);
        parallel : in std_logic_vector (3 downto 0);
        outputs  : out std_logic_vector (3 downto 0)
	);
  end component;
  component d_flip_flop is
	port(d, clk, clk_enable : in std_logic ; 
      Q : out std_logic
	);
  end component;
  component one_bit_full_adder is
	port (a, b, c_in : in std_logic;
        c_out, f   : out std_logic
	);
  end component;
  component two_input_and is
	port (a_a, a_b : in std_logic;
        a_y : out std_logic
	);
  end component;
  component inverter is
	port (n_a : in std_logic;
        n_y : out std_logic 
	);
  end component;
  signal s_1, s_2 : std_logic_vector(3 downto 0) := "0000";
  signal s_3, s_4, s_5 : std_logic := '0';
  signal s_6 : std_logic_vector(1 downto 0);
  
  begin
    four_bit_shift_register_instance_1 : four_bit_shift_register port map (clr => clear_dp, clk => clk, mode => control, parallel => in_a, serial => s_6, outputs => s_1 );
	four_bit_shift_register_instance_2 : four_bit_shift_register port map (clr => clear_dp, clk => clk, mode => control, parallel => in_b, serial => s_6, outputs => s_2 );
	d_flip_flop_instance_1 : d_flip_flop port map (d => s_3, clk => clk, clk_enable => clear_dp, Q => s_4);
	one_bit_full_adder_instance_1 : one_bit_full_adder port map (a => s_2(0), b => s_1(0), c_in => s_4, c_out => s_3, f => s_5);
	s_6 <= '0' & s_5;
	sum <= s_1 after 10 ns;
	carry <= s_4 after 10 ns;
end structural;	  

        