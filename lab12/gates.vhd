----
-- Project : Lab 12
-- Name    : Justin Peterson
-- File    : gates.vhd
-- Describes all primitive logic gates using dataflow architectures.
----

library ieee;
use ieee.std_logic_1164.all;

entity and4 is 
  port (a_a, a_b, a_c, a_d : in std_logic;
        a_y : out std_logic);
end and4;

architecture df of and4 is 
begin
  a_y <= a_a and a_b and a_c and a_d after 7 ns;
end; 

--------------------------------------

library ieee;
use ieee.std_logic_1164.all;
  
entity or4 is 
  port (o_a, o_b, o_c, o_d : in std_logic;
        o_y : out std_logic);
end or4;

architecture df of or4 is 
begin
  o_y <= o_a or o_b or o_c or o_d after 7 ns;
end;

--------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity not2 is
  port (n_a : in std_logic;
        n_y : out std_logic );
end not2;

architecture df of not2 is begin
  n_y <= not n_a after 4 ns;
end;

---------------------------------------