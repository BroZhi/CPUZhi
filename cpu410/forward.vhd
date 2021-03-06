library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity forward is
  port (
	clk: in std_logic;
  	reg_bus: in std_logic_vector(11 downto 0) ;
  	reg_prev: in std_logic_vector(3 downto 0) ;
 	reg_prev1: in std_logic_vector(3 downto 0) ;
 	reg_prev2: in std_logic_vector(3 downto 0);
 	reg_prev_type: in std_logic_vector(1 downto 0);
 	reg_choose1: out std_logic_vector(1 downto 0) ;
 	reg_choose2: out std_logic_vector(1 downto 0) ;
 	reg_choose0: out std_logic_vector(1 downto 0)
  ) ;
end entity ; -- forward

architecture Behavioral of forward is
	signal reg1: std_logic_vector(3 downto 0) ;
	signal reg2: std_logic_vector(3 downto 0) ;
	signal reg0: std_logic_vector(3 downto 0) ;
	signal reg1_prev_type: std_logic_vector(1 downto 0) ;
	--signal reg2_prev_type: std_logic_vector(1 downto 0) ;
	signal nxt_reg1: std_logic_vector(1 downto 0) ;
	signal nxt_reg2: std_logic_vector(1 downto 0) ;
begin
	reg1 <= reg_bus(11 downto 8);
	reg2 <= reg_bus(7 downto 4);
	reg0 <= reg_bus(3 downto 0);
	process(clk, reg0, reg1, reg2, reg_bus, reg_prev, reg_prev1, reg_prev2, reg_prev_type, reg1_prev_type)
	begin
		if reg0 = reg_prev1 and reg1_prev_type = WB_EXE then
			reg_choose0 <= REG_CHOOSE1_EXEFWD;
		elsif reg0 = reg_prev2 and reg0 /= IMG_REG then
		-- only choose the forward value when the refered reg is not IMG one
		-- it is a must since though the reg0 is IMG, `reg1` may not.
		-- In this way, reg1 might be choosen to a wrong value due to IMG_REG = IMG_REG
		-- no need in others since even a wrong reg1 or reg2 are useless.
			reg_choose0 <= REG_CHOOSE1_MEMFWD;
		else
			reg_choose0 <= REG_CHOOSE1_RF;
		end if;

		if reg1 = reg_prev and reg_prev_type = WB_EXE then
			nxt_reg1 <= ALU_CHOOSE1_EXEFWD;
		elsif reg1 = reg_prev1 then
			nxt_reg1 <= ALU_CHOOSE1_MEMFWD;
		else
			nxt_reg1 <= ALU_CHOOSE1_REG1;
		end if ;

		if reg2 = reg_prev and reg_prev_type = WB_EXE then
			nxt_reg2 <= ALU_CHOOSE2_EXEFWD;
		elsif reg2 = reg_prev1 then
			nxt_reg2 <= ALU_CHOOSE2_MEMFWD;
		else
			nxt_reg2 <= ALU_CHOOSE2_RI;
		end if;
		if rising_edge(clk) then
			reg1_prev_type <= reg_prev_type;
			--reg2_prev_type <= reg1_prev_type;
			reg_choose1 <= nxt_reg1;
			reg_choose2 <= nxt_reg2;
		end if;
	end process ; -- identifier

end architecture ; -- Behavioral