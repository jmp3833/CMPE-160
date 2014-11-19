----
-- Project : Lab 12
-- Name    : Justin Peterson
-- File    : four_to_one_mux.vhd
-- Structural architecture of a 4:1 mux using primitive gates.
-- Used to create the 74LS153 IC.
----

library ieee;
use ieee.std_logic_1164.all;

--Definition of single 4:1 mux
--With G reset input.
entity four_to_one_mux is 
port (
	G : in std_logic;
	A, B : in std_logic;
	C : in std_logic_vector(3 downto 0);
	Y : out std_logic
);

end four_to_one_mux;  

architecture struct of four_to_one_mux is
  
  component and4 is 
    port (a_a, a_b, a_c, a_d    : in std_logic;
          a_y       : out std_logic);
  end component;
  
  component or4 is 
    port (o_a, o_b, o_c, o_d : in std_logic;
          o_y       : out std_logic);
  end component;  
  
  component not2 is 
    port (n_a : in std_logic;
          n_y : out std_logic);
  end component; 
  
  signal s_1, s_2, s_3, s_4, n_1, n_2, n_3 : std_logic := '0';
  
begin  
  
  not2_instance1 : not2 port map (n_a=>G, n_y=>n_1);
  not2_instance2 : not2 port map (n_a=>A, n_y=>n_2);
  not2_instance3 : not2 port map (n_a=>B, n_y=>n_3);
  
  and4_instance1 : and4 port map (a_a=>n_1, a_b=>n_3, a_c=>n_2, a_d=>C(3), a_y=> s_1);
  and4_instance2 : and4 port map (a_a=>n_1, a_b=>n_3, a_c=>A, a_d=>C(1), a_y=> s_2);
  and4_instance3 : and4 port map (a_a=>n_1, a_b=>B, a_c=>n_2, a_d=>C(2), a_y=> s_3);
  and4_instance4 : and4 port map (a_a=>n_1, a_b=>B, a_c=>A, a_d=>C(0), a_y=> s_4);
    
  or4_instance1  : or4 port map (o_a=>s_1, o_b=>s_2, o_c=>s_3, o_d=>s_4, o_y=>Y);
    
end;

  
  

