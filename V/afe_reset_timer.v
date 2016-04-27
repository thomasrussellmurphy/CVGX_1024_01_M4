// Module to time the reset and wait sequence for the AFE7225
// Time for successful reset not specified
// Reset high-time must be >100ns
module afe_reset_timer
       (
         input clk, reset_n,
         output device_reset,
         output done
       );

reg [ 15: 0 ] counter;
reg device_reset_reg, done_reg;

assign device_reset = device_reset_reg;
assign done = done_reg;

always @( posedge clk or negedge reset_n ) begin
  if ( ~reset_n )
  begin
    counter <= 16'hFFFF;
    device_reset_reg <= 1'b1;  // Default to resetting device
    done_reg <= 1'b0;
  end else
  begin
    // Count down, then stop
    if ( counter != 16'b0 )
    begin
      counter <= counter - 1'b1;
    end

    // Run the reset for some more cycles
    if ( counter > 16'hFFF0 )
    begin
      // Maintaining active-high reset
      device_reset_reg <= 1'b1;
    end else
    begin
      device_reset_reg <= 1'b0;
    end

    // Declare the reset done when the counter hits zero
    done_reg <= ( counter == 16'b0 );
  end
end

endmodule
