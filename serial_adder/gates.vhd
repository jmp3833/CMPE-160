----
-- Project : Lab 13
-- Name    : Justin Peterson
-- File    : gates.vhd
-- Describes all behavioral component architectures.
----

library ieee;
use ieee.std_logic_1164.all;

entity and2 is 
  port (a_a, a_b : in std_logic;
        a_y : out std_logic);
end and2;

architecture behavioral of and2 is begin
  process (a_a, a_b) is
    variable s_1 : std_logic_vector(1 downto 0);
    begin
      s_1 := a_a & a_b;
      
      case s_1 is 
        WHEN "11" => a_y <= '1' after 4 ns;
        WHEN others => a_y <= '0' after 4 ns;
      end case;   
  end process;
end behavioral; 
--------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity not2 is
  port (n_a : in std_logic;
        n_y : out std_logic );
end not2;

architecture behavioral of not2 is begin
  n_y <= not n_a after 2 ns; 
end behavioral; 

---------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity one_bit_full_adder is 
  port (a, b, c_in : in std_logic;
        c_out, f   : out std_logic);
end one_bit_full_adder;

architecture behavioral of one_bit_full_adder is begin
  process(a, b, c_in) is
  variable s_1, s_2: std_logic_vector(2 downto 0);
   begin 
     
    s_1 := a & b & c_in;
    s_2 := a & b & c_in;
    
    case s_1 is
      WHEN "011" =>c_out<= '1' after 8 ns;
      WHEN "101" =>c_out<= '1' after 8 ns;
      WHEN "110" =>c_out<= '1' after 8 ns;
      WHEN "111" =>c_out<= '1' after 8 ns;
      WHEN others =>c_out<= '0';
    end case;
    case s_2 is
      WHEN "001" =>f<= '1' after 8 ns;
      WHEN "010" =>f<= '1' after 8 ns;
      WHEN "100" =>f<= '1' after 8 ns;
      WHEN "111" =>f<= '1' after 8 ns;
      WHEN others =>f<= '0';
    end case;
    
  end process; 
end behavioral;

---------------------------------------
-- D flip flop declaration
-- Rising edge triggered, clk_enable input 
library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop is 
  port(d, clk, clk_enable : in std_logic ; 
              Q : out std_logic); 
end d_flip_flop ;

architecture behavioral of d_flip_flop is begin 
  process(clk) begin 
    if clk'EVENT and clk = '1' and clk_enable = '1' then 
      Q <= d; 
    end if; 
  end process; 
end behavioral;

---------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity four_bit_shift_register is
  port( clr, clk : in std_logic;
        mode, serial : in std_logic_vector (1 downto 0);
        parallel : in std_logic_vector (3 downto 0);
        outputs  : out std_logic_vector (3 downto 0));
end four_bit_shift_register;  

architecture behavioral of four_bit_shift_register is
  signal out1 : std_logic_vector(3 downto 0);
  begin
  outputs <= out1 after 22 ns;
  process(clk, clr) is begin
    if clr = '0' then 
      out1 <= "0000";
    elsif clk'EVENT and clk = '1' then
      if mode = "11" then
        out1 <= parallel;
      elsif mode = "01" then 
        if serial(0) = '1' then
          out1 <= '1' & out1(3) & out1(2) & out1(1);
        else
         out1 <= '0' & out1(3) & out1(2) & out1(1);
        end if;
      elsif mode = "10" then
        if serial(1) = '1' then
          out1 <= out1(2) & out1(1) & out1(0) & '1';
        else
          out1 <= out1(2) & out1(1) & out1(0) & '0';
        end if;
      else
        out1 <= out1;
      end if;
    end if;
  end process;
end behavioral;
    

    

  