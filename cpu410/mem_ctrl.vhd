----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:30:58 11/18/2016 
-- Design Name: 
-- Module Name:    mem_ctrl - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.constants.all;

entity mem_ctrl is
	port(
		-- control signal
		CLK : in STD_LOGIC;
		RAM_READ_WRITE : in STD_LOGIC_VECTOR(1 downto 0);
		-- data signal
		RAM_ADDR : in STD_LOGIC_VECTOR(15 downto 0);
		RAM_DATA : in STD_LOGIC_VECTOR(15 downto 0);
		-- data output
		RAM_OUTPUT : out STD_LOGIC_VECTOR(15 downto 0);
		
		-- inner signal, out to ram
		Ram1Addr : out STD_LOGIC_VECTOR(15 downto 0);
		Ram1Data : inout STD_LOGIC_VECTOR(15 downto 0);
		Ram1OE : out STD_LOGIC;
		Ram1WE : out STD_LOGIC;
		Ram1EN : out STD_LOGIC
	);
end mem_ctrl;

architecture Behavioral of mem_ctrl is
	type state_set is (
		init,
		writing,
		reading
	);
	signal state : state_set := init;
	
begin
	process(CLK)
		begin
		if (CLK'event and CLK = '1') then
			case state is
				when init =>
					Ram1EN <= '0';
					--Ram1EN <= '0';
					if RAM_READ_WRITE = MEM_WRITE then
						state <= writing;
						Ram1OE <= '1';
						Ram1WE <= '1';
						Ram1Data <= RAM_DATA;
						Ram1Addr <= RAM_ADDR;
					elsif RAM_READ_WRITE = MEM_READ then
						state <= reading;
						Ram1OE <= '1';
						Ram1WE <= '1';
						Ram1Data <= "ZZZZZZZZZZZZZZZZ";
						Ram1Addr <= RAM_ADDR;
					end if;
						
				when writing =>
					Ram1WE <= '0';
					RAM_OUTPUT <= "1111111111111111";
					state <= init;
				
				when reading =>
					Ram1OE <= '0';
					RAM_OUTPUT <= Ram1Data;
					state <= init;
			end case;
		end if;
	end process;
end Behavioral;

