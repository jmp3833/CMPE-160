----
-- Project : Lab 12
-- Name    : Justin Peterson
-- File    : 74LS153.vhd
-- Outline for an IC which contains two 4:1 multiplexers
----

library ieee;
use ieee.std_logic_1164.all;

--Definition of all inputs and outputs

entity Mux is 
port (
	G1, G2 : in std_logic;
	A, B : in std_logic;
	C1, C2 : in std_logic_vector(3 downto 0);
	Y1, Y2 : out std_logic
);

end Mux;

--Simple behavioral description with one statement
--Per each multiplexer. 
architecture data_flow of Mux is begin
	Y1 <= '0' WHEN G1 = '1' ELSE
		C1(3) WHEN A = '0' AND B = '0' ELSE
		C1(2) WHEN A = '0' AND B = '1' ELSE
		C1(1) WHEN A = '1' AND B = '0' ELSE
		C1(0) WHEN A = '1' AND B = '1';

	Y2 <= '0' WHEN G2 = '1' ELSE
		C2(3) WHEN A = '0' AND B = '0' ELSE
		C2(2) WHEN A = '0' AND B = '1' ELSE
		C2(1) WHEN A = '1' AND B = '0' ELSE
		C2(0) WHEN A = '1' AND B = '1';
end data_flow;

--Behavioral architecture of each individual multiplexer.
--3 bits input resemble A, B, and G input of each individual Mux. 
architecture behavioral of Mux is begin
  process(C1, A, B, G1) is
  variable s_1: std_logic_vector(2 downto 0);
   begin 
    s_1 := G1 & A & B;
    case s_1 is
      WHEN "000" =>Y1<= C1(3) after 7 ns;
      WHEN "001" =>Y1<= C1(2) after 7 ns;
      WHEN "010" =>Y1<= C1(1) after 7 ns;
      WHEN "011" =>Y1<= C1(0) after 7 ns;
      WHEN others =>Y1<= '0';
    end case;
  end process; 
  
  process(C2, A, B, G2) is
  variable s_2: std_logic_vector(2 downto 0);
   begin 
    s_2 := G2 & A & B;
    case s_2 is
      WHEN "000" =>Y2<= C2(3) after 7 ns;
      WHEN "001" =>Y2<= C2(2) after 7 ns;
      WHEN "010" =>Y2<= C2(1) after 7 ns;
      WHEN "011" =>Y2<= C2(0) after 7 ns;
      WHEN others =>Y2<= '0';
    end case;
  end process;
 
end behavioral;

--Structural architecture with combination of two individual 4:1 MUX components. 
architecture double_four_to_one_mux of Mux is
  component four_to_one_mux is
    port(
      G : in std_logic;
     	A, B : in std_logic;
	    C : in std_logic_vector(3 downto 0);
	    Y : out std_logic
	  );
	 end component;
	 
begin
	 four_to_one_mux_instance_1 : four_to_one_mux port map (G=>G1, A=>A, B=>B, C=>C1, Y=>Y1);
	 four_to_one_mux_instance_2 : four_to_one_mux port map (G=>G1, A=>A, B=>B, C=>C2, Y=>Y2);
end double_four_to_one_mux;	  

        