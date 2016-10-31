----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:19:09 10/30/2016 
-- Design Name: 
-- Module Name:    chuankou - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity chuankou is
	port(
		CLK	:	in std_logic;
		RST	:	in std_logic;
		SW		:	in std_logic_vector(7 downto 0);	-- ����
		L		:	out std_logic_vector(7 downto 0);	-- LED�����
		Ram1Data 	: inout std_logic_vector(7 downto 0);	--˫��,��������
		Ram1WE		: out std_logic;	--RAM1дʹ��
		Ram1OE		: out std_logic;	--���ʹ��
		Ram1EN		: out std_logic;	--ʹ��
		data_ready 	: in std_logic;	--����׼���ź�
		tbre			: in std_logic;	--�������ݱ�־
		tsre			: in std_logic;	--���ݷ�����ϱ�־
		rdn			: out std_logic;	--������
		wrn			: out std_logic	--д����
	);
end chuankou;

architecture Behavioral of chuankou is
	type state_set is (
		init,		--	����״̬�Զ���
		write_state_1,
		write_state_2,
		write_state_3,
		write_state_4,
		read_state_1,
		read_state_2,
		read_state_3
		);
	signal state : state_set := init;
	signal data : std_logic_vector(7 downto 0);
begin
	process(CLK, RST)
	begin
		if (RST = '0') then		--reset��ʱ���ʼ����
			wrn <= '1'; 
			Ram1EN <= '1';
			Ram1OE <= '1';
			Ram1WE <= '1';
			rdn <= '1';	
			state <= init;
		elsif (CLK'event and CLK = '0') then
			case state is
				when init =>			-- ��ʼ��״̬
					state <= read_state_1;	-- ��ʼ״̬�������ĵ�һ��״̬
				when write_state_1 =>
					Ram1Data <= data + 1;	-- ׼������
					wrn <= '0';		-- wrn��0
					state <= write_state_2;
				when write_state_2 => 
					wrn <= '1';		-- wrn��1
					state <= write_state_3;
				when write_state_3 =>
					if (tbre = '1') then	-- �ȴ�tbreΪ1
						state <= write_state_4;
					end if;
				when write_state_4 => 
					if (tsre = '1') then	-- �ȴ�tsreΪ1���������
						state <= init;
					end if;
				when read_state_1 =>			-- ��׼��״̬
					rdn <= '1';		-- rdn��1
					Ram1Data <= (Others => 'Z');	-- Ram1���������ڸ���״̬
					state <= read_state_2;
				when read_state_2 =>	
					if (data_ready = '1') then	
						rdn <= '0';		-- rdn��0����ʼ��������������
						state <= read_state_3;
					else
						state <= read_state_1;	-- û׼���û�ȥ
					end if;
				when read_state_3 =>
					L <= Ram1Data;		-- ���մ��ڵ����ݣ���ʾ����
					data <= Ram1Data; -- ��¼���ݣ���1�󷵻�
					rdn <= '1';			-- �ر����ݶ���
					state <= write_state_1;				
			end case;
		
		end if;
	end process;
end Behavioral;

