----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2020 06:56:31 AM
-- Design Name: 
-- Module Name: new_page_add_imp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity new_page_add_imp is
    generic (   ram_width: integer:= 8;
                ram_depth: integer:= 4000);
    Port ( addr : in STD_LOGIC_VECTOR (11 downto 0);
           mode : in STD_LOGIC_VECTOR (1 downto 0);
           byte_num : in STD_LOGIC_VECTOR (1 downto 0);
           data : in STD_LOGIC_VECTOR (15 downto 0);
           output : out STD_LOGIC_VECTOR (31 downto 0);
           clk: in STD_LOGIC;
           clr: in STD_LOGIC);
end new_page_add_imp;

architecture Behavioral of new_page_add_imp is

    type ram_type is array (0 to ram_depth-1) of std_logic_vector (ram_width-1 downto 0);
    signal tmp_ram: ram_type;
    signal tmp_output: std_logic_vector (31 downto 0);
begin

    process (clk)
    begin
        if rising_edge(clk) then
            if (clr = '1') then
                tmp_ram <= (others => (others => '0'));
            else
                case mode is
                    when b"01" =>
                        tmp_output <= x"00000000";
                        case byte_num is
                            when b"00" =>
                                tmp_ram(to_integer(unsigned(addr))) <= std_logic_vector (to_signed(to_integer(signed(data(7 downto 0))) + 1, ram_width));
                            when b"01" =>
                                tmp_ram(to_integer(unsigned(addr))) <= std_logic_vector (to_signed(to_integer(signed(data(7 downto 0))) + 1, ram_width));
                                tmp_ram(to_integer(unsigned(addr)) + 1) <= std_logic_vector (to_signed(to_integer(signed(data(15 downto 8))) + 1, ram_width));
                            when others =>
                        end case;
                    when b"10" =>
                        case byte_num is
                            when b"00" =>
                                tmp_output <= x"000000" & tmp_ram(to_integer(unsigned(addr)));
                            when b"01" =>
                                tmp_output <= x"0000" & tmp_ram(to_integer(unsigned(addr)) + 1) & tmp_ram(to_integer(unsigned(addr)));
                            when b"10" =>
                                tmp_output <= x"00" & tmp_ram(to_integer(unsigned(addr)) + 2) & tmp_ram(to_integer(unsigned(addr)) + 1) & tmp_ram(to_integer(unsigned(addr)));
                            when b"11" =>
                                tmp_output <= tmp_ram(to_integer(unsigned(addr)) + 3) & tmp_ram(to_integer(unsigned(addr)) + 2) & tmp_ram(to_integer(unsigned(addr)) + 1) & tmp_ram(to_integer(unsigned(addr)));
                            when others =>
                        end case;
                    when others =>
                end case;
            end if;
        end if;
    end process;

    process (tmp_output)
    begin
        output <= tmp_output;
    end process;
    
end Behavioral;
