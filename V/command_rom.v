// ROM initializer to provide commands and data to the configuration system
module command_rom
       #(
         parameter SOURCE = "../rom_data/data.txt",
         parameter ADDRESS_WIDTH = 8;
         parameter COMMAND_WIDTH = 4,
         parameter DEVICE_DATA_WIDTH = 8
       )
       (
         input clk, reset_n,
         input [ ADDRESS_WIDTH - 1: 0 ] address,
         output [ COMMAND_WIDTH - 1: 0 ] controller_command,
         output [ DEVICE_DATA_WIDTH - 1: 0 ] device_data
       );

localparam ROM_WIDTH = COMMAND_WIDTH + DEVICE_DATA_WIDTH;

// Memory variable
reg [ ROM_WIDTH - 1: 0 ] rom[ 2 ** ADDRESS_WIDTH - 1: 0 ];

reg [ COMMAND_WIDTH: 0 ] command_reg;

assign controller_command = command_reg[ ROM_WIDTH - 1: ROM_WIDTH - COMMAND_WIDTH ];
assign device_data = command_reg[ DEVICE_DATA_WIDTH - 1: 0 ];

// ROM initialization
initial
begin
  // Read hex memory from SOURCE path relative to this file
  $readmemh( SOURCE, rom );
end

// ROM controller
always @( posedge clk ) begin
  command_reg <= rom[ address ];
end

endmodule
