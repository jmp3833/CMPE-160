-----------------------
library ieee;
use ieee.std_logic_1164.all;

entity xor3 is 
  port (A, B, C : in std_logic;
        Y : out std_logic);
end xor3;

architecture df of xor3 is 
begin
  Y <= A xor B xor C after 7 ns;
end;      

-----------------------
library ieee;
use ieee.std_logic_1164.all;

entity and2 is 
  port (A, B : in std_logic;
        Y : out std_logic);
end and2;

architecture df of and2 is 
begin
  Y <= A and B after 2 ns;
end; 
  
-----------------------
library ieee;
use ieee.std_logic_1164.all;

entity or3 is 
  port (A, B, C : in std_logic;
        Y : out std_logic);
end or3;

architecture df of or3 is 
begin
  Y <= A or B or C after 3 ns;
end;

-----------------------
-- Half adder component implementation to
-- assemble two half adders and an or into a 
--one bit full adder circuit. 
-----------------------
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is 
  port (h_a, h_b : in std_logic;
        h_s, h_co : out std_logic);
end half_adder;

architecture df of half_adder is 
begin
  h_s <= (not h_a and h_b) or (h_a and not h_b) after 3 ns;
  h_co <= h_a and h_b after 3 ns;
end;

-----------------------
library ieee;
use ieee.std_logic_1164.all;

entity or2 is 
  port (A, B : in std_logic;
        Y : out std_logic);
end or2;

architecture df of or2 is 
begin
  Y <= A or B after 3 ns;
end;
  