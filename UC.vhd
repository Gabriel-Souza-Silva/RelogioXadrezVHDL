-- VHDL de uma Unidade de Controle para o circuito de soma de dois numeros com
-- saida registrada

library ieee;
use ieee.std_logic_1164.all;

entity uc is
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
end uc;

architecture Unidade_Controle of uc is
	type tipo_estado is (inicial, conta_tempo_j1, conta_tempo_j2, final);
	signal estado   : tipo_estado := inicial;
begin
	
	-- ================================================
	-- Logica de transicao de estados (sequencial)
	-- ================================================
	process (clock, reset, estado, contaJ1)
	begin
   
	-- O sinal de reset eh necessario para garantir a condicao de estado inicial
	if reset = '1' then
		estado <= inicial;
         
	elsif (clock'event and clock = '1') then
	
		case estado is
			--CONTANDO TEMPO JOGADOR 1 OU 2
			when inicial =>
				if reset = '0' then
					if contaJ1 = '1' then 
						estado <= conta_tempo_j1;
					else 
						estado <= conta_tempo_j2;
					end if;
				else
					estado <= inicial;
				end if;
			--CONTANDO TEMPO JOGADOR 1
			when conta_tempo_j1 =>
				if reset = '0' then
					
					if rco = '1' then
						estado <= final;
					elsif contaJ1 = '0' then
						estado <= conta_tempo_j2;
					else
						estado <= conta_tempo_j1;
					end if;					
				else
					estado <= inicial;
				end if;	
			--CONTANDO TEMPO JOGADOR 2
			when conta_tempo_j2 =>
				if reset = '0' then
					if rco2 = '1' then
						estado <= final;
					elsif contaJ1 = '0' then
						estado <= conta_tempo_j2;
					else
						estado <= conta_tempo_j1;
					end if;				
					
				else
					estado <= inicial;
				end if;
			
			when final =>
				estado <= final;
		end case;
	end if;
	
	end process;
   
	-- ================================================
	-- Logica de saida (combinatoria)
	-- ================================================
	with estado select en1 <=
		'1' when conta_tempo_j1,
		'0' when others;
	
	with estado select en2 <=
		'1' when conta_tempo_j2,
		'0' when others;
		
	with estado select resetRelogio <=
		'1' when inicial,
		'0' when others;
		
end Unidade_Controle;