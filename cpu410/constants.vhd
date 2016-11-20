----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:30:26 11/18/2016 
-- Design Name: 
-- Module Name:    constants - Behavioral 
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
use ieee.numeric_std.all;

package constants is
	constant Pc_reset: std_logic := '1';	--pc是否reset的控制信�
	constant Pc_pause: std_logic := '1';	--pc是否pause的控制信�
	constant Pc_origin_address : std_logic_vector(15 downto 0) := "0000000000000000";	--pc的初始地址
	constant Pc_offset: std_logic_vector(15 downto 0) := "0000000000000001";	--每次pc的偏移量
	type RegArray is array(11 downto 0) of std_logic_vector(15 downto 0);	-- 11个寄存器�个通用？？？？？？�
	
	constant ZeroWord: std_logic_vector(15 downto 0) := "0000000000000000";	--�
	constant OneWord: std_logic_vector(15 downto 0) := "0000000000000001";	--1
	constant HIGH_RESIST : std_logic_vector(15 downto 0) := "ZZZZZZZZZZZZZZZZ";

	constant ReadEnable: std_logic := '1';
	constant WriteEnable: std_logic := '1';
	constant ReadDisable: std_logic := '0';
	constant WriteDisable: std_logic := '0';

	-- controller
	constant ZERO3: std_logic_vector(2 downto 0) := "000";
	constant ZERO4: std_logic_vector(3 downto 0) := "0000";
	constant ZERO16: std_logic_vector(15 downto 0) := "0000000000000000";


	-- funct
	constant OP_ADDIU: std_logic_vector(4 downto 0) := "01001"; -- 1
	constant OP_ADDIU3: std_logic_vector(4 downto 0) := "01000";	-- 2
	constant OP_SPECIAL: std_logic_vector(4 downto 0) := "01100";	-- 3 & 9 & 18 & 28 & 29
	constant OP_ADD_SUB_U: std_logic_vector(4 downto 0) := "11100"; -- 4 & 23
	constant OP_LOGIC: std_logic_vector(4 downto 0) := "11101";	-- 5 & 10 & 11 & 16 & 20 & 26 & 27
	constant OP_B: std_logic_vector(4 downto 0) := "00010";	-- 6
	constant OP_BEQZ: std_logic_vector(4 downto 0) := "00100"; -- 7
	constant OP_BNEZ: std_logic_vector(4 downto 0) := "00101";	-- 8
	constant OP_LI: std_logic_vector(4 downto 0) := "01101";	-- 12
	constant OP_LW: std_logic_vector(4 downto 0) := "10011";	-- 13
	constant OP_LW_SP: std_logic_vector(4 downto 0) := "10010";	-- 14
	constant OP_IH: std_logic_vector(4 downto 0) := "11110";	-- 15 & 17
	constant OP_NOP: std_logic_vector(4 downto 0) := "00001";	-- 19
	constant OP_SHIFT: std_logic_vector(4 downto 0) := "00110";	-- 21 & 22
	constant OP_SW: std_logic_vector(4 downto 0) := "11011";	-- 24
	constant OP_SW_SP: std_logic_vector(4 downto 0) := "11010";	-- 25
	constant OP_ADDSP3: std_logic_vector(4 downto 0) := "00000";	-- ano
	constant OP_SLTI: std_logic_vector(4 downto 0) := "01010";	-- 30
	constant OP_SLTUI: std_logic_vector(4 downto 0) := "01011";	-- ano

	-- 3 & 9 & 18 & 28 & 29
	constant SPECIAL_ADDSP: std_logic_vector(2 downto 0) := "011";	 -- 3
	constant SPECIAL_BTEQZ: std_logic_vector(2 downto 0) := "000";	-- 9
	constant SPECIAL_MTSP: std_logic_vector(2 downto 0) := "100";	-- 18
	constant SPECIAL_BTNEZ: std_logic_vector(2 downto 0) := "001";	-- 28
	constant SPECIAL_SW_RS: std_logic_vector(2 downto 0) := "010";	-- 29

	-- 4 & 23
	constant ADD_SUB_U_ADDU: std_logic_vector(1 downto 0) := "01";	-- 4
	constant ADD_SUB_U_SUBU: std_logic_vector(1 downto 0) := "11";	-- 23

	-- 5 & 10 & 11 & 16 & 20 & 26 & 27
	constant LOGIC_AND: std_logic_vector(4 downto 0) := "10011";	-- 5
	constant LOGIC_CMP: std_logic_vector(4 downto 0) := "01010";	-- 10
	constant LOGIC_PC: std_logic_vector(4 downto 0) := "00000";	-- see sub
		--sub function code for pc inst(7 downto 5)
		constant PC_JR: std_logic_vector(2 downto 0) := "000";	-- 11
		constant PC_MFPC: std_logic_vector(2 downto 0) := "010";	-- 16
		-- end sub --
	constant LOGIC_OR: std_logic_vector(4 downto 0) := "01101";	-- 20
	constant LOGIC_SRAV: std_logic_vector(4 downto 0) := "00111";	-- ano
	constant LOGIC_NOT: std_logic_vector(4 downto 0) := "01111";	-- ano
	constant LOGIC_SLLV: std_logic_vector(4 downto 0) := "00100";	-- 26
	constant LOGIC_SRLV: std_logic_vector(4 downto 0) := "00110";	-- 27

    -- 15 & 17
	constant IH_MFIH: std_logic_vector(7 downto 0) := "00000000";	-- 15
	constant IH_MTIH: std_logic_vector(7 downto 0) := "00000001";	-- 17

	-- 21 & 22
	constant SHIFT_SLL: std_logic_vector(1 downto 0) := "00";	-- 21
	constant SHIFT_SRA: std_logic_vector(1 downto 0) := "11";	-- 22
	constant SHIFT_SRL: std_logic_vector(1 downto 0) := "10";	-- ano


	-- controller tell alu work what
	constant THU_ID_ADD: std_logic_vector(4 downto 0) := "00000";
	constant THU_ID_BRANCH: std_logic_vector(4 downto 0) := "00001";
	constant THU_ID_BRANCHE: std_logic_vector(4 downto 0) := "00010";
	constant THU_ID_BRANCHN: std_logic_vector(4 downto 0) := "00011";
	constant THU_ID_ASSIGN: std_logic_vector(4 downto 0) := "00100";
	constant THU_ID_NOP: std_logic_vector(4 downto 0) := "00101";
	constant THU_ID_OR: std_logic_vector(4 downto 0) := "00110";
	constant THU_ID_SLL: std_logic_vector(4 downto 0) := "00111";
	constant THU_ID_SRA: std_logic_vector(4 downto 0) := "01000";
	constant THU_ID_SUB: std_logic_vector(4 downto 0) := "01001";
	constant THU_ID_SRL: std_logic_vector(4 downto 0) := "01010";
	constant THU_ID_NOT: std_logic_vector(4 downto 0) := "01011";
	constant THU_ID_AND: std_logic_vector(4 downto 0) := "01100";
	constant THU_ID_LOAD: std_logic_vector(4 downto 0) := "01101";
	constant THU_ID_JR: std_logic_vector(4 downto 0) := "01110";
	constant THU_ID_CMP: std_logic_vector(4 downto 0) := "01111";
	constant THU_ID_EQUAL: std_logic_vector(4 downto 0) := "10000";
	
	-- added by evan69
	-- constant defination for ex_mem_latch to MEM
	constant MEM_READ : STD_LOGIC_VECTOR(1 downto 0) := "01"; --控制数据存储器进行读
	constant MEM_WRITE : STD_LOGIC_VECTOR(1 downto 0) := "10"; --控制数据存储器进行写
	constant COM_STATUS_ADDR : std_logic_vector(15 downto 0) := "1011111100000001"; --BF01
	constant COM_DATA_ADDR : std_logic_vector(15 downto 0) := "1011111100000000"; --BF00
	
	-- control signal : WB_CHOOSE
	type WB_CHOOSE_TYPE is (
		ALU_ADDR,
		MEM_DATA,
		PC_DATA
	);
	
	-- record type for write back control signal
	type WB_CONTROL_SIGNAL_TYPE is record
		WB_FORWARD : STD_LOGIC;
		WB_CHOOSE : WB_CHOOSE_TYPE;
		REG_WN : STD_LOGIC;
	end record;
end package;



