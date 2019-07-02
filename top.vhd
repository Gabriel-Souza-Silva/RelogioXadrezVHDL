library ieee;
use ieee.std_logic_1164.all;

entity top is
    port (
        clock   : in  std_logic;								
        enable  : in  std_logic;	
		  reset   : in std_logic;		  
        seg     : out std_logic_vector(6 downto 0);
		  anodes  : out std_logic_vector(3 downto 0);
		  rco		 : out std_logic;
		  rco2    : out std_logic  	  
    );
end top;

architecture exemplo of top is
	 
	 component fd is
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
	end component;
	
	component uc is
   port(
      clock	: in std_logic;
		reset	: in std_logic;
		resetRelogio	: out std_logic;
		contaJ1	: in	std_logic;		
		en1	: out std_logic;
		en2	: out std_logic;
		rco   :  in std_logic;
		rco2   :  in std_logic
	);
	end component;
		

	signal en1   :  std_logic;	
	signal en2   :  std_logic;	
	signal resetRelogio   :  std_logic;	
	signal saida1   : std_logic_vector(6 downto 0);
   signal saida2   : std_logic_vector(6 downto 0);
   signal saida3   : std_logic_vector(6 downto 0);
   signal saida4   : std_logic_vector(6 downto 0);
	signal rcoAux1: std_logic;
	signal rcoAux2: std_logic;
	
begin
	uc1: uc port map(clock, reset, resetRelogio, enable, en1,en2, rcoAux1,rcoAux2);
   fd1: fd port map(clock, en1,en2, resetRelogio, rcoAux1,rcoAux2,anodes,seg);	
	rco <= rcoAux1;
	rco2 <= rcoAux2;
end exemplo;





