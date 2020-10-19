----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2020 06:30:03 AM
-- Design Name: 
-- Module Name: tb_new_page_add - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity testbench is
generic
(
  C_S_AXI_DATA_WIDTH             : integer              := 32;
  C_S_AXI_ADDR_WIDTH             : integer              := 4
);

end testbench;

architecture Behavioral of testbench is
    
    component design_1_wrapper is
    port (
        s_axi_aclk : in STD_LOGIC;
        s_axi_aresetn : in STD_LOGIC;
        S_AXI_awaddr : in STD_LOGIC_VECTOR ( C_S_AXI_ADDR_WIDTH-1 downto 0 );
        S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
        S_AXI_awvalid : in STD_LOGIC;
        S_AXI_awready : out STD_LOGIC;
        S_AXI_wdata : in STD_LOGIC_VECTOR ( C_S_AXI_DATA_WIDTH-1 downto 0 );
        S_AXI_wstrb : in STD_LOGIC_VECTOR ( (C_S_AXI_DATA_WIDTH/8)-1 downto 0 );
        S_AXI_wvalid : in STD_LOGIC;
        S_AXI_wready : out STD_LOGIC;
        S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
        S_AXI_bvalid : out STD_LOGIC;
        S_AXI_bready : in STD_LOGIC;
        S_AXI_araddr : in STD_LOGIC_VECTOR ( C_S_AXI_ADDR_WIDTH-1 downto 0 );
        S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
        S_AXI_arvalid : in STD_LOGIC;
        S_AXI_arready : out STD_LOGIC;
        S_AXI_rdata : out STD_LOGIC_VECTOR ( C_S_AXI_DATA_WIDTH-1 downto 0 );
        S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
        S_AXI_rvalid : out STD_LOGIC;
        S_AXI_rready : in STD_LOGIC
    );
    end component design_1_wrapper;
    
    signal S_AXI_ACLK                     :  std_logic;
    signal S_AXI_ARESETN                  :  std_logic;
    signal S_AXI_AWADDR                   :  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal S_AXI_AWVALID                  :  std_logic;
    signal S_AXI_WDATA                    :  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal S_AXI_WSTRB                    :  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    signal S_AXI_WVALID                   :  std_logic;
    signal S_AXI_BREADY                   :  std_logic;
    signal S_AXI_ARADDR                   :  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal S_AXI_ARVALID                  :  std_logic;
    signal S_AXI_RREADY                   :  std_logic;
    signal S_AXI_ARREADY                  : std_logic;
    signal S_AXI_RDATA                    : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal S_AXI_RRESP                    : std_logic_vector(1 downto 0);
    signal S_AXI_RVALID                   : std_logic;
    signal S_AXI_WREADY                   : std_logic;
    signal S_AXI_BRESP                    : std_logic_vector(1 downto 0);
    signal S_AXI_BVALID                   : std_logic;
    signal S_AXI_AWREADY                  : std_logic;
    signal S_AXI_AWPROT                   : std_logic_vector(2 downto 0);
    signal S_AXI_ARPROT                   : std_logic_vector(2 downto 0);

    
    Constant ClockPeriod : TIME := 5 ns;
    Constant ClockPeriod2 : TIME := 10 ns;
    shared variable ClockCount : integer range 0 to 50_000 := 10;
    signal sendIt : std_logic := '0';
    signal readIt : std_logic := '0';

begin

  -- instance "led_controller_v1_0_1"
  IP: design_1_wrapper 
    port map (
      S_axi_aclk    => S_AXI_ACLK,
      S_axi_aresetn => S_AXI_ARESETN,
      S_AXI_awaddr  => S_AXI_AWADDR,
      S_AXI_awprot  => S_AXI_AWPROT,
      S_AXI_awvalid => S_AXI_AWVALID,
      S_AXI_awready => S_AXI_AWREADY,
      S_AXI_wdata   => S_AXI_WDATA,
      S_AXI_wstrb   => S_AXI_WSTRB,
      S_AXI_wvalid  => S_AXI_WVALID,
      S_AXI_wready  => S_AXI_WREADY,
      S_AXI_bresp   => S_AXI_BRESP,
      S_AXI_bvalid  => S_AXI_BVALID,
      S_AXI_bready  => S_AXI_BREADY,
      S_AXI_araddr  => S_AXI_ARADDR,
      S_AXI_arprot  => S_AXI_ARPROT,
      S_AXI_arvalid => S_AXI_ARVALID,
      S_AXI_arready => S_AXI_ARREADY,
      S_AXI_rdata   => S_AXI_RDATA,
      S_AXI_rresp   => S_AXI_RRESP,
      S_AXI_rvalid  => S_AXI_RVALID,
      S_AXI_rready  => S_AXI_RREADY);

 -- Generate S_AXI_ACLK signal
 GENERATE_REFCLOCK : process
 begin
   wait for (ClockPeriod / 2);
   ClockCount:= ClockCount+1;
   S_AXI_ACLK <= '1';
   wait for (ClockPeriod / 2);
   S_AXI_ACLK <= '0';
 end process;

 -- Initiate process which simulates a master wanting to write.
 -- This process is blocked on a "Send Flag" (sendIt).
 -- When the flag goes to 1, the process exits the wait state and
 -- execute a write transaction.
 send : PROCESS
 BEGIN
    S_AXI_AWVALID<='0';
    S_AXI_WVALID<='0';
    S_AXI_BREADY<='0';
    loop
        wait until sendIt = '1';
        wait until S_AXI_ACLK= '0';
            S_AXI_AWVALID<='1';
            S_AXI_WVALID<='1';
        wait until (S_AXI_AWREADY and S_AXI_WREADY) = '1';  --Client ready to read address/data        
            S_AXI_BREADY<='1';
        wait until S_AXI_BVALID = '1';  -- Write result valid
            assert S_AXI_BRESP = "00" report "AXI data not written" severity failure;
            S_AXI_AWVALID<='0';
            S_AXI_WVALID<='0';
            S_AXI_BREADY<='1';
        wait until S_AXI_BVALID = '0';  -- All finished
            S_AXI_BREADY<='0';
    end loop;
 END PROCESS send;

  -- Initiate process which simulates a master wanting to read.
  -- This process is blocked on a "Read Flag" (readIt).
  -- When the flag goes to 1, the process exits the wait state and
  -- execute a read transaction.
  read : PROCESS
  BEGIN
    S_AXI_ARVALID<='0';
    S_AXI_RREADY<='0';
     loop
         wait until readIt = '1';
         wait until S_AXI_ACLK= '0';
             S_AXI_ARVALID<='1';
             S_AXI_RREADY<='1';
         wait until (S_AXI_RVALID and S_AXI_ARREADY) = '1';  --Client provided data
            assert S_AXI_RRESP = "00" report "AXI data not written" severity failure;
             S_AXI_ARVALID<='0';
            S_AXI_RREADY<='0';
     end loop;
  END PROCESS read;


 -- 
 tb : PROCESS
 BEGIN
        S_AXI_ARESETN<='0';
        sendIt<='0';
    wait for 15 ns;
        S_AXI_ARESETN<='1';
    
    -- write
        S_AXI_AWADDR<=x"0";
        S_AXI_WDATA<=x"02010005";
        S_AXI_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_BVALID = '1';
    wait until S_AXI_BVALID = '0';  --AXI Write finished
        S_AXI_WSTRB<=b"0000";
    
    -- write
        S_AXI_AWADDR<=x"0";
        S_AXI_WDATA<=x"00000006";
        S_AXI_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_BVALID = '1';
    wait until S_AXI_BVALID = '0';  --AXI Write finished
        S_AXI_WSTRB<=b"0000";
    
    -- read
    S_AXI_ARADDR<=x"4";
        readIt<='1';                --Start AXI Read from Slave
        wait for 1 ns; readIt<='0'; --Clear "Start Read" Flag
    wait until S_AXI_RVALID = '1';
    wait until S_AXI_RVALID = '0';
    
    
--        S_AXI_AWADDR<=x"0";
--        S_AXI_WDATA<=x"00000000";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";
            
--        S_AXI_AWADDR<=x"0";
--        S_AXI_WDATA<=x"00000001";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";
        
--        S_AXI_AWADDR<=x"0";
--        S_AXI_WDATA<=x"00000002";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";
        
--        S_AXI_AWADDR<=x"4";
--        S_AXI_WDATA<=x"A5A5A5A5";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";
        
--        S_AXI_ARADDR<=x"0";
--        readIt<='1';                --Start AXI Read from Slave
--        wait for 1 ns; readIt<='0'; --Clear "Start Read" Flag
--    wait until S_AXI_RVALID = '1';
--    wait until S_AXI_RVALID = '0';
--        S_AXI_ARADDR<=x"4";
--        readIt<='1';                --Start AXI Read from Slave
--        wait for 1 ns; readIt<='0'; --Clear "Start Read" Flag
--    wait until S_AXI_RVALID = '1';
--    wait until S_AXI_RVALID = '0';
        
     wait; -- will wait forever
 END PROCESS tb;

end Behavioral;
