----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:15:54 10/28/2016 
-- Design Name: 
-- Module Name:    ram - Behavioral 
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram is
	port (
		SW : in STD_LOGIC_VECTOR(15 downto 0);
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		Ram1Addr : out STD_LOGIC_VECTOR(17 downto 0);
		L : out STD_LOGIC_VECTOR(15 downto 0);
		Ram1Data : inout STD_LOGIC_VECTOR(15 downto 0);
		Ram1OE : out STD_LOGIC;
		Ram1WE : out STD_LOGIC;
		Ram1EN : out STD_LOGIC;
		rdn : out STD_LOGIC;
		wrn : out STD_LOGIC
	);
end ram;

architecture Behavioral of ram is
	signal addr : STD_LOGIC_VECTOR(17 DOWNTO 0);
	signal data : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal adder16 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal adder18 : STD_LOGIC_VECTOR(17 DOWNTO 0);
BEGIN
PROCESS(CLK,RST)
	VARIABLE work_state : INTEGER RANGE 0 TO 4 := 0;
	-- 0:׼�������ַ
	-- 1:׼����������
	-- 2:��ʼд
	-- 3:��ʼ��
	-- 4:��̬
	--variable visit_state : INTEGER RANGE 0 TO 2 := 0;
	-- 0:д������ʼ
	-- 1:д��
	-- 2��д���ֿ�ʼ
	variable count : INTEGER;
	
	BEGIN
		adder16 <= "0000000000000001";
		adder18 <= "000000000000000001";
		IF(RST = '0') THEN	--��ʼ��
			work_state := 0;
			count := 0;
			rdn <= '1';
			wrn <= '1';
		ELSIF(CLK' EVENT AND CLK = '0') THEN
			case work_state is
				when 0 =>
					addr <= "00" & SW;
					work_state := work_state + 1;
					L <= "1111000011110000";

				when 1 =>
					data <= SW;
					work_state := work_state + 1;
					L(7 downto 0) <= addr(7 downto 0);--��ʾ�Ͱ�λ
					L(15 downto 8) <= data(7 downto 0);
					Ram1OE <= '1';--д
					Ram1WE <= '1';
					Ram1En <= '0';

				when 2 =>
					if(count < 10) then--������û��10
						addr <= addr + adder18;
						data <= data + adder16;
						Ram1Addr <= addr;
						Ram1Data <= data;
						Ram1OE <= '1';--д
						Ram1WE <= '0';
						L(7 downto 0) <= addr(7 downto 0);--��ʾ�Ͱ�λ
						L(15 downto 8) <= data(7 downto 0);
						count := count + 1;
					else
						addr <= addr - "000000000000001010";--�ָ�addr
						Ram1Addr <= addr - "000000000000001010";
						Ram1Data <= "ZZZZZZZZZZZZZZZZ";--д�����ݸ���̬
						Ram1OE <= '0';--��
						Ram1WE <= '1';
						L <= "1111111111111111";
						count := 0;--���ü�����
						work_state := 3;--�����״̬
					end if;
				
				when 3 =>
					if(count < 10) then--������û��10			
						Ram1Data <= "ZZZZZZZZZZZZZZZZ";--д�����ݸ���̬
						Ram1Addr <= addr + adder18;--׼���´�д��ram1addr
						addr <= addr + adder18;--����
						Ram1OE <= '0';--��
						Ram1WE <= '1';
						L <= Ram1Data;
						count := count + 1;
					else
						L <= "0101010101010101";
						count := 0;--���ü�����
						work_state := 4;--������̬				
					end if;
					
				when 4 =>
			end case;
			--end if;
		END IF;
	END PROCESS;
end Behavioral;

