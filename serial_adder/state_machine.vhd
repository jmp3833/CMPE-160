----
-- Project : Lab 13
-- Name    : Justin Peterson
-- File    : state_machine.vhd
-- Describes behavior of the state machine used to run the
-- four bit serial adder. 
----

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity state_machine is 
	Port ( clk, start, clear_sm : in std_logic;
		   control_output : out std_logic_vector(3 downto 0));
end state_machine;

architecture behavioral of state_machine is
	--Declare basic state types of the FSM
	type states is (IDLE, RESET, LOAD, HOLD, S1, S2, S3, S4);
	signal state, next_state : states;

begin
	--Combinatorial definition of the specific state machine. 
	NEXT_STATE_DECODE : process (clk, clear_sm)
	begin
		if (clear_sm = '1') then 
			next_state <= IDLE;
		else
			if(clk'event and clk = '1') then
				case(state) is 
					when IDLE =>
						if start = '0' then 
							next_state <= IDLE;
						else
							next_state <= RESET;
						end if;
					when RESET => next_state <= LOAD;
					when LOAD => next_state <= S1;
					when S1 => next_state <= S2;
					when S2 => next_state <= S3;
					when S3 => next_state <= S4;
					when S4 => next_state <= HOLD;
					when others => next_state <= IDLE;
				end case;
			end if;
		end if;
		--Push the state machine forward
		state <= next_state;
	end process;
	
	--Declaration of a single output process to describe 
	--the Control_Output variable. 
	
	out_proc : process(clk)
	begin
		if (clk'event and clk = '1') then
			case next_state is
				when IDLE => control_output <= "1100";
				when RESET => control_output <= "0000";
				when LOAD => control_output <= "0111";
				when HOLD => control_output <= "0100";
				when others => control_output <= "0101";
			end case;
		end if;
	end process out_proc;
end behavioral;