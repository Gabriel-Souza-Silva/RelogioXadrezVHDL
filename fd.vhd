library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity fd is
    port (
        clock   : in  std_logic;									
        enable1   : in  std_logic;									
        enable2   : in  std_logic;									
        reset   : in  std_logic;
        --saida1   : out std_logic_vector(6 downto 0);
        --saida2   : out std_logic_vector(6 downto 0);
        --saida3   : out std_logic_vector(6 downto 0);
        --saida4   : out std_logic_vector(6 downto 0);
		  rco      : out std_logic;
		  rco2      : out std_logic;
		  anodes  	: out std_logic_vector(3 downto 0);
		  seg     : out std_logic_vector(6 downto 0)		  
	 );
end fd;

architecture Behavioral of fd is
	
	component divclock is
		 port (
			  clock     : in  std_logic;
			  reset		: in  std_logic;
			  enable		: in  std_logic;
			  clock_div : out std_logic
		 );
	end component;
	
	component contador is
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
	end component;
	
	component multiplexador is
    port(
        clock     : in  std_logic;
		  entrada3  : in  std_logic_vector(6 downto 0);
		  entrada2  : in  std_logic_vector(6 downto 0);
		  entrada1  : in  std_logic_vector(6 downto 0);
		  entrada0  : in  std_logic_vector(6 downto 0);
        sevenseg  : out std_logic_vector(6 downto 0);
        anodes  	: out std_logic_vector(3 downto 0));
	end component;
	
	component hex7seg is
		port (hex      : in  std_logic_vector(3 downto 0);
				display  : out std_logic_vector(6 downto 0)
				 );
	end component;
	
	signal clkdiv 	: std_logic;
	signal cont1		: std_logic_vector(3 downto 0);
	signal cont12		: std_logic_vector(3 downto 0);
	signal cont2		: std_logic_vector(3 downto 0);
	signal cont22		: std_logic_vector(3 downto 0);
	signal display1  :  std_logic_vector(6 downto 0);
	signal display2  :  std_logic_vector(6 downto 0);
	signal display3  :  std_logic_vector(6 downto 0);
	signal display4  :  std_logic_vector(6 downto 0);
	signal display  : std_logic_vector(6 downto 0);
	--signal anodes  :  std_logic_vector(3 downto 0);
	signal fim		: std_logic_vector(3 downto 0);
	
begin
	div: divclock port map(clock, reset, not(reset), clkdiv);
	cnt: contador port map(clkdiv, enable1,enable2, cont1, cont12, cont2, cont22, rco,rco2,reset);
	hex: hex7seg  port map(cont1, display1);
	hex2: hex7seg  port map(cont12, display2);
	hex3: hex7seg  port map(cont2, display3);
	hex4: hex7seg  port map(cont22,display4);	
	multi : multiplexador port map(clock,display1,display2,display3,display4,seg,anodes);
end Behavioral;

