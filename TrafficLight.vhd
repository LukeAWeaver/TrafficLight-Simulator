----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2017 04:18:57 PM
-- Design Name: 
-- Module Name: TrafficLight - Behavioral
-- Project Name: TrafficLight
-- Target Devices: 
-- Tool Versions: 
-- Description: 

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TrafficLight is
    Port ( rst : in STD_LOGIC;
           carew : in STD_LOGIC;
           clk : in STD_LOGIC;
           CW: in STD_LOGIC;
           CE: in STD_LOGIC;
           LeftNS: in STD_LOGIC;
           lights:out STD_LOGIC_VECTOR(5 downto 0);
           leftLight: out STD_LOGIC_VECTOR(2 downto 0));
end TrafficLight;

architecture Behavioral of TrafficLight is
type state_type is (GNS, YNS,GEW,YEW, LeftGNS, LeftYNS);
SIGNAL state: state_type;
Signal count : integer := 1;
begin
process(clk, rst)
begin

if (rst = '1') then
count <= 1;
lights <="100001";
state <= GNS;

elsif(rising_edge(clk)) then

count <= count + 1;

case state is

when GNS =>
lights <="100001";
leftLight <= "001";
if(CW = '1' OR CE = '1') then
count <= 1;
state <= YNS;
else 
state <=GNS;
end if;


when YNS => 
lights <="010001";
if(count > 300000000) THEN
count <= 1;
state <= GEW;
else 
state <=YNS;
END IF;

when GEW =>
lights <="001100";
leftLight <= "001";
if(CW = '0' AND CE ='0') then
count <= 1;
state <=YEW;
else 
state <=GEW;
end if;

when YEW =>
 -- add delay again here
 lights <="001010";
 IF(count >300000000) THEN
 count <=1;
    IF(LeftNS = '1') THEN
        state <= LeftGNS;
    else
        state <= GNS;
    end if;
 else 
 state <=YEW;
 END IF;
     
 when LeftGNS =>
    lights <= "001001";
    leftLight <="100";
    IF(count >300000000) THEN
        count <= 1;
        state <= LeftYNS;
    else
        state <= LeftGNS;
    end if;
 when LeftYNS =>
    lights <= "001001";
    leftLight <= "010";
    IF(count > 300000000) THEN
        count <=1;
        state <= GNS;
    end if;
end case;

end if;

end process;
end Behavioral;
