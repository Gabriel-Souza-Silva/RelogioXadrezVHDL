library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divclock is
    port (
		  clock     : in  std_logic;
		  reset		: in  std_logic;
		  enable		: in  std_logic;
        clock_div : out std_logic
    );
end divclock;

architecture exemplo of divclock is
	signal IQ	: unsigned(24 downto 0);
	signal pivo	: std_logic;
begin
	
	process (clock, reset, enable, IQ, pivo)
	begin
	
	if reset = '1' then
		IQ   <= (others => '0');
		pivo <= '0';

	elsif clock'event and clock = '1' then
		if enable = '1' then
			IQ <= IQ + 1;
		
			if IQ = 25000000 then 
				pivo <= not(pivo);
				IQ   <= (others => '0');
			end if;
		end if;
	end if;
	 
	clock_div <= pivo;
	end process;
	
end exemplo;