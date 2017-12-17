library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stopwatch_Top is port (
	
	--Clocks
	CLOCK_50			: in std_logic;
	CLOCK2_50			: in std_logic;
	CLOCK3_50			: in std_logic;
	CLOCK4_50			: in std_logic;
	
	--Reset Button
	RESET_N				: in std_logic;
	
	--Keys (Push Buttons) ACTIVE LOW
	KEY					: in std_logic_vector(3 downto 0);
		
	--Switches
	SW					: in std_logic_vector(9 downto 0);
	
	--LEDR (Red LEDs)
	LEDR				: out std_logic_vector(9 downto 0);
	
	--Seven Segment Displays
	HEX0				: out std_logic_vector(6 downto 0);
	HEX1				: out std_logic_vector(6 downto 0);
	HEX2				: out std_logic_vector(6 downto 0);
	HEX3				: out std_logic_vector(6 downto 0);
	HEX4				: out std_logic_vector(6 downto 0);
	HEX5				: out std_logic_vector(6 downto 0);
	
	--DRAM
	DRAM_ADDR			: out std_logic_vector(12 downto 0);
	DRAM_BA				: out std_logic_vector(1 downto 0);
	DRAM_CAS_N			: out std_logic;
	DRAM_CKE			: out std_logic;
	DRAM_CLK			: out std_logic;
	DRAM_CS_N			: out std_logic;
	DRAM_DQ				: inout std_logic_vector(15 downto 0);
	DRAM_LDQM			: out std_logic;
	DRAM_RAS_N			: out std_logic;
	DRAM_UDQM			: out std_logic;
	DRAM_WE_N			: out std_logic;
	
	--GPIOs
	GPIO_0				: inout std_logic_vector(35 downto 0);
	GPIO_1				: inout std_logic_vector(15 downto 0);
	
	--PS2
	PS2_CLK				: inout std_logic;
	PS2_CLK2			: inout std_logic;
	PS2_DAT				: inout std_logic;
	PS2_DAT2			: inout std_logic;
	
	--SD
	SD_CLK				: out std_logic;
	SD_CMD				: inout std_logic;
	SD_DATA				: inout std_logic_vector(3 downto 0);
	
	
	--VGA
	VGA_B				: out std_logic_vector(3 downto 0);
	VGA_G				: out std_logic_vector(3 downto 0);
	VGA_HS				: out std_logic;
	VGA_R				: out std_logic_vector(3 downto 0);
	VGA_VS				: out std_logic
	
);
end Stopwatch_Top ;

architecture overall of Stopwatch_Top is

	-- COMPONENT DECLARATION
	component PB_Sync is 
		port(
			PB_clk         : in std_logic;
			PB_reset       : in std_logic; --Active low
			PB_in     : in std_logic_vector(3 downto 0);
			PB_out    : out std_logic_vector(3 downto 0)
		);
	end component;

	component Switch_Sync is 
		port(
			SW_clk         : in std_logic;
			SW_reset       : in std_logic; --Active low
			SW_in     : in std_logic_vector(9 downto 0);
			SW_out    : out std_logic_vector(9 downto 0)
		);
	end component;

	component clk100Hz is
		port(
			clk_in      : in std_logic;
			clk_out     : out std_logic;
			reset       : in std_logic
		);
	end component;

	component counter is
		port(
			clk         : in std_logic;
			en          : in std_logic;
			reset       : in std_logic;
			minutes     : out std_logic_vector(7 downto 0);
			seconds     : out std_logic_vector(7 downto 0);
			fraction    : out std_logic_vector(7 downto 0)
		);
	end component;

	component sevenSegDecoder is
		port(
			in_1            : in std_logic_vector(7 downto 0);
			in_2            : in std_logic_vector(7 downto 0);
			in_3            : in std_logic_vector(7 downto 0);
			hex_0           : out std_logic_vector(6 downto 0); 
			hex_1           : out std_logic_vector(6 downto 0);
			hex_2           : out std_logic_vector(6 downto 0);
			hex_3           : out std_logic_vector(6 downto 0);
			hex_4           : out std_logic_vector(6 downto 0);
			hex_5           : out std_logic_vector(6 downto 0)
		);
	end component;
	
	-- INTERNAL SIGNALS 

	signal sync_pb			: std_logic_vector(3 downto 0);
	signal sync_sw			: std_logic_vector(9 downto 0);
	signal clk_100hz		: std_logic;
	signal out_min			: std_logic_vector(7 downto 0);
	signal out_sec			: std_logic_vector(7 downto 0);
	signal out_fra			: std_logic_vector(7 downto 0);


begin

	-- YOUR CODE HERE 

	Sync1: PB_Sync 
		port map(
			CLOCK_50,
			RESET_N,
			KEY(3 downto 0),
			sync_pb(3 downto 0)
		);

	Sync_2: Switch_Sync
		port map(
			CLOCK_50,
			RESET_N,
			SW(9 downto 0),
			sync_sw(9 downto 0)
		);

	clk_div: clk100Hz
		port map(
			CLOCK_50,
			clk_100hz,
			RESET_N
		);

	timing_unit: counter
		port map(
			clk_100hz,
			sync_sw(0),
			(sync_pb(0) or RESET_N),
			out_min,
			out_sec,
			out_fra
		);

	display_control: sevenSegDecoder
		port map(
			out_min,
			out_sec,
			out_fra,
			HEX0,
			HEX1,
			HEX2,
			HEX3,
			HEX4,
			HEX5
		);
	
	

end overall;