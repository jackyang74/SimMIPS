`define MBUS_SLAVE_NUMBER	8
`define PBUS_SLAVE_NUMBER	8

//设备0地址范围0x00000000-0x00004000,共16KB
//拟分配给Timer
`define MBUS_SLAVE_0_HADDR	18'h0
`define MBUS_SLAVE_0_HADDR_WIDTH	18

//设备1地址范围0x50000100-0x5000017F,total 128B
//拟分配给UART
`define MBUS_SLAVE_1_HADDR	32'hFFFFFFFF
`define MBUS_SLAVE_1_HADDR_WIDTH	32

//设备2地址范围0x60000000-0x60001FFF,total 8192B
//拟分配给VGADevice 
`define MBUS_SLAVE_2_HADDR	32'hFFFFFFFF
`define MBUS_SLAVE_2_HADDR_WIDTH	32
//设备3地址范围0x50000080-0x500000FF,total 128B
//拟分配给KeyBoard
`define MBUS_SLAVE_3_HADDR 32'hFFFFFFFF
`define MBUS_SLAVE_3_HADDR_WIDTH 32

//设备4地址范围0x00000000-0x0001FFFF,total 131.072KB
//拟分配给RAM(M4K)
`define MBUS_SLAVE_4_HADDR 32'hFFFFFFFF
`define MBUS_SLAVE_4_HADDR_WIDTH 32

//设备5地址范围0x10000000-0x10200000,total 2MB
//FOR external sram
`define MBUS_SLAVE_5_HADDR 32'hFFFFFFFF
`define MBUS_SLAVE_5_HADDR_WIDTH 32

//设备6地址范围0x20000000-0x24000000,total 64MB
//FOR external sdram
`define MBUS_SLAVE_6_HADDR 32'hFFFFFFFF
`define MBUS_SLAVE_6_HADDR_WIDTH 32

`define MBUS_SLAVE_7_HADDR 32'hFFFFFFFF
`define MBUS_SLAVE_7_HADDR_WIDTH 32




//设备0地址范围0x00000000-0x0000007F,共128B
//拟分配给Timer
`define PBUS_SLAVE_0_HADDR	25'h0
`define PBUS_SLAVE_0_HADDR_WIDTH	25

//设备1地址范围0x00000080-0x000000FF,total 128B
//拟分配给UART
`define PBUS_SLAVE_1_HADDR	25'h1
`define PBUS_SLAVE_1_HADDR_WIDTH	25

//设备2地址范围0x60000000-0x60001FFF,total 8192B
//拟分配给VGADevice 
`define PBUS_SLAVE_2_HADDR	32'hFFFFFFFF
`define PBUS_SLAVE_2_HADDR_WIDTH	32

//设备3地址范围0x50000080-0x500000FF,total 128B
//拟分配给KeyBoard
`define PBUS_SLAVE_3_HADDR 32'hFFFFFFFF
`define PBUS_SLAVE_3_HADDR_WIDTH 32

//设备4地址范围0x00000000-0x0001FFFF,total 131.072KB
//拟分配给RAM(M4K)
`define PBUS_SLAVE_4_HADDR 32'hFFFFFFFF
`define PBUS_SLAVE_4_HADDR_WIDTH 32

//设备5地址范围0x10000000-0x10200000,total 2MB
//FOR external sram
`define PBUS_SLAVE_5_HADDR 32'hFFFFFFFF
`define PBUS_SLAVE_5_HADDR_WIDTH 32

//设备6地址范围0x20000000-0x24000000,total 64MB
//FOR external sdram
`define PBUS_SLAVE_6_HADDR 32'hFFFFFFFF
`define PBUS_SLAVE_6_HADDR_WIDTH 32

`define PBUS_SLAVE_7_HADDR 32'hFFFFFFFF
`define PBUS_SLAVE_7_HADDR_WIDTH 32