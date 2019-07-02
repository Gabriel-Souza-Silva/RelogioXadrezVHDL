library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity contador is
	port (
		clock : in std_logic;
		enable1: in std_logic; 
		enable2: in std_logic; 
		Q1: out std_logic_vector(3 downto 0);
		Q12: out std_logic_vector(3 downto 0);
		Q2: out std_logic_vector(3 downto 0);
		Q22: out std_logic_vector(3 downto 0);
		RCO: out std_logic;
		RCO2 : out std_logic;
		reset : in std_logic
		);		
end contador;

architecture Behavioral of contador is
	signal IQ1	: unsigned(3 downto 0);
	signal IQ12	: unsigned(3 downto 0);
	signal IQ2	: unsigned(3 downto 0);
	signal IQ22	: unsigned(3 downto 0);
begin
	process (clock, enable1,enable2,IQ1,IQ12,IQ2,IQ22,reset)
	begin

		if reset = '1' then
			RCO <= '0';
			RCO2 <= '0';
			IQ1 <= (others => '0');
			IQ12 <= (others => '0');
			IQ2 <= (others => '0');
			IQ22 <= (others => '0');
		else
			if clock'event and clock = '1' then			
				--CONTA TEMPO 1
				if enable1 = '1' then
					IQ1 <= IQ1 + 1;
					
					if IQ1 = 9 then
						IQ1 <= (others => '0');
						IQ12 <= IQ12 + 1;
					end if;
					
					if	IQ12 = 4 then
						IQ12 <= (others => '0');
						RCO <= '1';
					end if;				
				end if;
				
				
				
				--CONTA TEMPO 2 
				if enable2 = '1' then
					IQ2 <= IQ2 + 1;
					
					if IQ2 = 9 then
						IQ2 <= (others => '0');
						IQ22 <= IQ22 + 1;
					end if;
					
					if	IQ22 = 4 then
						IQ22 <= (others => '0');
						RCO2 <= '1';
					end if;	
				end if;
			end if;
		end if;
				
		--ENVIA O TEMPO PARA CADA DISPLAY
		Q1	<= std_logic_vector(IQ1);
		Q12	<= std_logic_vector(IQ12);
		Q2	<= std_logic_vector(IQ2);
		Q22	<= std_logic_vector(IQ22);
	end process;
end Behavioral;
