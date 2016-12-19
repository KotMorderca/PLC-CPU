library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_lvl is port( 
    CLK100MHZSYS      : in    STD_LOGIC;
    CA                : out   STD_LOGIC_VECTOR(0 to 7);
    AN                : out   STD_LOGIC_VECTOR(0 to 7);
    LED               : out   STD_LOGIC_VECTOR(15 downto 0);
    SW                : in    STD_LOGIC_VECTOR(15 downto 0);
--Sekcja programatora
    DDR2_addr         : out   STD_LOGIC_VECTOR(12 downto 0);
    DDR2_ba           : out   STD_LOGIC_VECTOR(2 downto 0);
    DDR2_cas_n        : out   STD_LOGIC;
    DDR2_ck_n         : out   STD_LOGIC_VECTOR(0 to 0);
    DDR2_ck_p         : out   STD_LOGIC_VECTOR(0 to 0);
    DDR2_cke          : out   STD_LOGIC_VECTOR(0 to 0);
    DDR2_cs_n         : out   STD_LOGIC_VECTOR(0 to 0);
    DDR2_dm           : out   STD_LOGIC_VECTOR(1 downto 0);
    DDR2_dq           : inout STD_LOGIC_VECTOR(15 downto 0);
    DDR2_dqs_n        : inout STD_LOGIC_VECTOR(1 downto 0);
    DDR2_dqs_p        : inout STD_LOGIC_VECTOR(1 downto 0);
    DDR2_odt          : out   STD_LOGIC_VECTOR(0 to 0);
    DDR2_ras_n        : out   STD_LOGIC;
    DDR2_we_n         : out   STD_LOGIC;
    qspi_flash_io0_io : inout STD_LOGIC;
    qspi_flash_io1_io : inout STD_LOGIC;
    qspi_flash_ss_io  : inout STD_LOGIC;
    reset             : in    STD_LOGIC;
    usb_uart_rxd      : in    STD_LOGIC;
    usb_uart_txd      : out   STD_LOGIC
--Koniec sekcji programatora
);
end top_lvl;

architecture Behavioral of top_lvl is

signal data_out_wire         : STD_LOGIC_VECTOR(31 downto 0);
signal data_in_wire          : STD_LOGIC_VECTOR(31 downto 0);
signal address_wire          : STD_LOGIC_VECTOR(7 downto 0); 
signal control_wire          : STD_LOGIC_VECTOR(9 downto 0); 

signal prog_mem_address_wire : STD_LOGIC_VECTOR(5 downto 0);
signal prog_mem_data_wire    : STD_LOGIC_VECTOR(39 downto 0);

signal ss_input_wire         : STD_LOGIC_VECTOR(31 downto 0) := x"ABCD0123";
signal ss_dots_wire          : STD_LOGIC_VECTOR(7 downto 0) := "11111111";

signal cpu_rst_n_wire        : STD_LOGIC;
signal iom_rst_n_wire        : STD_LOGIC;
signal ext_data_bus_wire     : STD_LOGIC_VECTOR(15 downto 0);
signal ext_address_bus_wire  : STD_LOGIC_VECTOR(7 downto 0);
signal ext_wr_wire           : STD_LOGIC;
signal ext_rd_wire           : STD_LOGIC; 

signal CLK180_wire           : STD_LOGIC;
signal CLK_wire              : STD_LOGIC;

signal ub_addr_wire          : STD_LOGIC_VECTOR(5 downto 0);
signal ub_data_wire          : STD_LOGIC_VECTOR(39 downto 0);
signal ub_wr_wire            : STD_LOGIC;
signal ub_rst_n_wire         : STD_LOGIC;
signal ub_gpio_1             : STD_LOGIC_VECTOR(31 downto 0);
signal ub_gpio_2             : STD_LOGIC_VECTOR(15 downto 0);

-- Sekcja programatora
signal qspi_flash_io0_i      : STD_LOGIC;
signal qspi_flash_io0_o      : STD_LOGIC;
signal qspi_flash_io0_t      : STD_LOGIC;
signal qspi_flash_io1_i      : STD_LOGIC;
signal qspi_flash_io1_o      : STD_LOGIC;
signal qspi_flash_io1_t      : STD_LOGIC;
signal qspi_flash_ss_i       : STD_LOGIC;
signal qspi_flash_ss_o       : STD_LOGIC;
signal qspi_flash_ss_t       : STD_LOGIC;
--Koniec sekcji programatora


component CPU generic (
    stack_depth      : integer
);
port ( 
    clk              : in  STD_LOGIC;
    rst_n            : in  STD_LOGIC;
    data_out_bus     : out STD_LOGIC_VECTOR(31 downto 0);
    data_in_bus      : in  STD_LOGIC_VECTOR(31 downto 0);
    address_bus      : out STD_LOGIC_VECTOR(7 downto 0);
    control_bus      : out STD_LOGIC_VECTOR(9 downto 0);
    prog_mem_address : out STD_LOGIC_VECTOR(5 downto 0);
    prog_mem_data    : in  STD_LOGIC_VECTOR(39 downto 0);
    debug_bus        : out STD_LOGIC_VECTOR(31 downto 0) := x"00000000"
);
end component;

component program_memory port (
    clk              : in  STD_LOGIC;
    addr_cpu         : in  STD_LOGIC_VECTOR(5 downto 0);
    dout_cpu         : out STD_LOGIC_VECTOR(39 downto 0);
    en_cpu           : in  STD_LOGIC;
    addr_prog        : in  STD_LOGIC_VECTOR(5 downto 0);
    din_prog         : in  STD_LOGIC_VECTOR(39 downto 0);
    wr_prog          : in  STD_LOGIC
);
end component;

component marker_memory is port ( 
    clk              : in  STD_LOGIC;
    address_bus      : in  STD_LOGIC_VECTOR(7 downto 0);
    data_out_bus     : in  STD_LOGIC_VECTOR(31 downto 0);
    data_in_bus      : out STD_LOGIC_VECTOR(31 downto 0);
    control_bus      : in  STD_LOGIC_VECTOR(9 downto 0)
);
end component;

component ss_driver port ( 
    clk              : in  STD_LOGIC;
    bars             : out STD_LOGIC_VECTOR(0 to 7);
    anodes           : out STD_LOGIC_VECTOR(0 to 7);
    input            : in  STD_LOGIC_VECTOR(31 downto 0);
    dots             : in  STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component IO_controller port ( 
    clk              : in    STD_LOGIC;
    rst_n_out        : out   STD_LOGIC;
    address_bus      : in    STD_LOGIC_VECTOR(7 downto 0);
    data_out_bus     : in    STD_LOGIC_VECTOR(31 downto 0);
    data_in_bus      : out   STD_LOGIC_VECTOR(31 downto 0);
    control_bus      : in    STD_LOGIC_VECTOR(9 downto 0);
    ext_clk          : in    STD_LOGIC;
    ext_address_bus  : out   STD_LOGIC_VECTOR(7 downto 0);
    ext_data_bus     : inout STD_LOGIC_VECTOR(15 downto 0);
    ext_wr           : out   STD_LOGIC;
    ext_rd           : out   STD_LOGIC
);
end component;

component DIO_module_mock is port ( 
    clk              : in    STD_LOGIC;
    switches         : in    STD_LOGIC_VECTOR(15 downto 0);
    leds             : out   STD_LOGIC_VECTOR(15 downto 0);
    ext_address_bus  : in    STD_LOGIC_VECTOR(7 downto 0);
    ext_data_bus     : inout STD_LOGIC_VECTOR(15 downto 0);
    ext_wr           : in    STD_LOGIC;
    ext_rd           : in    STD_LOGIC
);
end component;

-- Sekcja programatora
component programator is port(
    usb_uart_rxd     : in    STD_LOGIC;
    usb_uart_txd     : out   STD_LOGIC;
    GPIO_2_tri_o     : out   STD_LOGIC_VECTOR(15 downto 0);
    GPIO_1_tri_o     : out   STD_LOGIC_VECTOR(31 downto 0);
    DDR2_dq          : inout STD_LOGIC_VECTOR(15 downto 0);
    DDR2_dqs_p       : inout STD_LOGIC_VECTOR(1 downto 0);
    DDR2_dqs_n       : inout STD_LOGIC_VECTOR(1 downto 0);
    DDR2_addr        : out   STD_LOGIC_VECTOR(12 downto 0);
    DDR2_ba          : out   STD_LOGIC_VECTOR(2 downto 0);
    DDR2_ras_n       : out   STD_LOGIC;      
    DDR2_cas_n       : out   STD_LOGIC;      
    DDR2_we_n        : out   STD_LOGIC;      
    DDR2_ck_p        : out   STD_LOGIC_VECTOR(0 to 0);
    DDR2_ck_n        : out   STD_LOGIC_VECTOR(0 to 0);
    DDR2_cke         : out   STD_LOGIC_VECTOR(0 to 0);
    DDR2_cs_n        : out   STD_LOGIC_VECTOR(0 to 0);
    DDR2_dm          : out   STD_LOGIC_VECTOR(1 downto 0);
    DDR2_odt         : out   STD_LOGIC_VECTOR(0 to 0);
    sys_clock        : in    STD_LOGIC;
    reset            : in    STD_LOGIC;
    qspi_flash_io0_i : in    STD_LOGIC;
    qspi_flash_io0_o : out   STD_LOGIC;
    qspi_flash_io0_t : out   STD_LOGIC;
    qspi_flash_io1_i : in    STD_LOGIC;
    qspi_flash_io1_o : out   STD_LOGIC;
    qspi_flash_io1_t : out   STD_LOGIC;
    qspi_flash_ss_i  : in    STD_LOGIC;
    qspi_flash_ss_o  : out   STD_LOGIC;
    qspi_flash_ss_t  : out   STD_LOGIC;
    clk_out3         : out   STD_LOGIC;
    clk_out4         : out   STD_LOGIC
);
end component programator;

component IOBUF is port(
    I                : in    STD_LOGIC;
    O                : out   STD_LOGIC;
    T                : in    STD_LOGIC;
    IO               : inout STD_LOGIC
);
end component IOBUF;
--Koniec sekcji programatora

begin
    
    CPU_INST: CPU generic map(
        stack_depth      => 16
    )
    port map(
        clk              => CLK_wire,
        rst_n            => cpu_rst_n_wire, 
        data_out_bus     => data_out_wire,
        data_in_bus      => data_in_wire,
        address_bus      => address_wire,
        control_bus      => control_wire,
        prog_mem_address => prog_mem_address_wire,
        prog_mem_data    => prog_mem_data_wire,
        debug_bus        => open
    );
    
    PROGRAM_MEMORY_INST : program_memory port map(
        clk              => CLK180_wire,
        addr_cpu         => prog_mem_address_wire,
        dout_cpu         => prog_mem_data_wire,
        en_cpu           => NOT(ub_wr_wire),
        addr_prog        => ub_addr_wire,
        din_prog         => ub_data_wire,
        wr_prog          => ub_wr_wire
    );
    
    MARKER_MEMORY_INST : marker_memory port map(
        clk              => CLK180_wire,
        address_bus      => address_wire,
        data_out_bus     => data_out_wire,
        data_in_bus      => data_in_wire,
        control_bus      => control_wire
    );       
    
    SS_DRIVER_INST : ss_driver port map(
        clk              => CLK_wire,
        bars             => CA,
        anodes           => AN,
        input            => ss_input_wire,
        dots             => ss_dots_wire
    );
    
    IO_CONTROLLER_INST : IO_controller port map(
        clk              => CLK180_wire,
        rst_n_out        => iom_rst_n_wire,
        address_bus      => address_wire,
        data_out_bus     => data_out_wire,
        data_in_bus      => data_in_wire,
        control_bus      => control_wire,
        ext_clk          => CLK_wire,
        ext_address_bus  => ext_address_bus_wire,
        ext_data_bus     => ext_data_bus_wire,
        ext_wr           => ext_wr_wire,
        ext_rd           => ext_rd_wire
    );
    
    DIO_MODULE_INST : DIO_module_mock port map( 
        clk             => CLK_wire,
        switches        => SW,
        leds            => LED,
        ext_address_bus => ext_address_bus_wire,
        ext_data_bus    => ext_data_bus_wire,
        ext_wr          => ext_wr_wire,
        ext_rd          => ext_rd_wire
    );
    
-- Sekcja programatora
    PROGRAMATOR_INST : programator port map(
        DDR2_addr(12 downto 0)    => DDR2_addr(12 downto 0),
        DDR2_ba(2 downto 0)       => DDR2_ba(2 downto 0),
        DDR2_cas_n                => DDR2_cas_n,
        DDR2_ck_n(0)              => DDR2_ck_n(0),
        DDR2_ck_p(0)              => DDR2_ck_p(0),
        DDR2_cke(0)               => DDR2_cke(0),
        DDR2_cs_n(0)              => DDR2_cs_n(0),
        DDR2_dm(1 downto 0)       => DDR2_dm(1 downto 0),
        DDR2_dq(15 downto 0)      => DDR2_dq(15 downto 0),
        DDR2_dqs_n(1 downto 0)    => DDR2_dqs_n(1 downto 0),
        DDR2_dqs_p(1 downto 0)    => DDR2_dqs_p(1 downto 0),
        DDR2_odt(0)               => DDR2_odt(0),
        DDR2_ras_n                => DDR2_ras_n,
        DDR2_we_n                 => DDR2_we_n,
        GPIO_1_tri_o(31 downto 0) => ub_gpio_1,
        GPIO_2_tri_o(15 downto 0) => ub_gpio_2,
        qspi_flash_io0_i          => qspi_flash_io0_i,
        qspi_flash_io0_o          => qspi_flash_io0_o,
        qspi_flash_io0_t          => qspi_flash_io0_t,
        qspi_flash_io1_i          => qspi_flash_io1_i,
        qspi_flash_io1_o          => qspi_flash_io1_o,
        qspi_flash_io1_t          => qspi_flash_io1_t,
        qspi_flash_ss_i           => qspi_flash_ss_i,
        qspi_flash_ss_o           => qspi_flash_ss_o,
        qspi_flash_ss_t           => qspi_flash_ss_t,
        reset                     => reset,
        sys_clock                 => CLK100MHZSYS,
        usb_uart_rxd              => usb_uart_rxd,
        usb_uart_txd              => usb_uart_txd,
        clk_out3                  => CLK_wire,
        clk_out4                  => CLK180_wire
    );
        
    qspi_flash_io0_iobuf : IOBUF port map(
        I   => qspi_flash_io0_o,
        IO  => qspi_flash_io0_io,
        O   => qspi_flash_io0_i,
        T   => qspi_flash_io0_t
    );
    
    qspi_flash_io1_iobuf : IOBUF port map(
        I   => qspi_flash_io1_o,
        IO  => qspi_flash_io1_io,
        O   => qspi_flash_io1_i,
        T   => qspi_flash_io1_t
    );
    
    qspi_flash_ss_iobuf : IOBUF port map(
        I   => qspi_flash_ss_o,
        IO  => qspi_flash_ss_io,
        O   => qspi_flash_ss_i,
        T   => qspi_flash_ss_t
    );
-- Koniec sekcji programatora
    ss_dots_wire   <= ub_wr_wire & ub_rst_n_wire & "111111";
    ub_data_wire   <= ub_gpio_2(7 downto 0) & ub_gpio_1(31 downto 0);
    ub_addr_wire   <= ub_gpio_2(13 downto 8);
    ub_wr_wire     <= ub_gpio_2(14);
    ub_rst_n_wire  <= ub_gpio_2(15);
    cpu_rst_n_wire <= ub_rst_n_wire AND iom_rst_n_wire;
    ss_input_wire  <= "00" & ub_addr_wire & x"00" & ub_data_wire(39 downto 32) & ub_data_wire(7 downto 0);
    
end Behavioral;