----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:32:57 11/19/2016 
-- Design Name: 
-- Module Name:    wb_mux - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity wb_mux is
	Port ( 
		CLK : in STD_LOGIC;
		
		-- data input
		IN_ADDR : in STD_LOGIC_VECTOR(15 downto 0);
		IN_DATA : in STD_LOGIC_VECTOR(15 downto 0);
		IN_PC : in STD_LOGIC_VECTOR(15 downto 0);
		
		-- data output
		OUT_WB_DATA : out STD_LOGIC_VECTOR(15 downto 0);
		
		-- control signal input
		IN_WB_CHOOSE : in WB_CHOOSE_TYPE;
		
		-- control signal output
	);
end wb_mux;

architecture Behavioral of wb_mux is

begin
	process(CLK)
	begin
		if (CLK'event and CLK = '1') then
			case IN_WB_CHOOSE is
				when ALU_ADDR =>
					OUT_WB_DATA <= IN_ADDR;
				when MEM_DARA =>
					OUT_WB_DATA <= IN_DATA;
				when PC_DATA =>
					OUT_WB_DATA <= IN_PC;
			end case;
		end if;
	end process;

end Behavioral;

