----
-- Project : Lab 11
-- Name    : Justin Peterson
-- Defines a simple full_adder entity and behavioral description.
----

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is 
port (
	A : in std_logic;
	B : in std_logic;
	Cin : in std_logic;

	Sum : out std_logic;
	Cout : out std_logic
);

end full_adder;

architecture df of full_adder is
	signal s_1, s_2, s_3 : std_logic := '0';
	
	begin
		Sum <= A xor B xor Cin;

		s_1 <= A and B;
		s_2 <= A and Cin;
		s_3 <= B and Cin;

		Cout <= s_1 or s_2 or s_3;
end;

architecture struct of full_adder is 
  component xor3 is 
    port (A, B, C : in std_logic;
          Y       : out std_logic);
  end component;
  
  component and2 is 
    port (A, B    : in std_logic;
          Y       : out std_logic);
  end component;
  
  component or3 is 
    port (A, B, C : in std_logic;
          Y       : out std_logic);
  end component;
  
  signal s_1, s_2, s_3 : std_logic := '0';
  
begin
  xor3_instance1 : xor3 port map (A=>A, B=>B, C=>Cin, Y=>Sum);
    
  and2_instance1 : and2 port map (A=>A, B=>B, Y=> s_1);
  and2_instance2 : and2 port map (A=>A, B=>Cin, Y=> s_2);
  and3_instance3 : and2 port map (A=>Cin, B=>B, Y=> s_3);
    
  or3_instance1 : or3 port map (A=>s_1, B=>s_2, C=>s_3, Y=>Cout);
end;

architecture halfandhalf of full_adder is   
  component or2 is 
    port (A, B    : in std_logic;
          Y       : out std_logic);
  end component;
  
  component half_adder is 
    port (h_a, h_b      : in std_logic;
          h_s, h_co     : out std_logic);
  end component;
  
  signal s_1, s_2, s_3 : std_logic := '0';
  
begin
  hadder_instance1 : half_adder port map (h_a => A, h_b => B, h_s => s_1, h_co => s_2);
  hadder_instance2 : half_adder port map (h_a => s_1, h_b => Cin, h_s => Sum, h_co => s_3);
  or2_instance1 : or2 port map (A => s_3, B => s_2, Y => Cout);
end;

	
