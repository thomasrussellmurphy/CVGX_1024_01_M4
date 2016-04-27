// Module to provide a wait period before activating the sync
module afe_sync
       (
         input clk, reset_n,
         input enable,
         output sync
       );

reg [ 19: 0 ] counter;

reg sync_reg;
assign sync = sync_reg;

always @( posedge clk or negedge reset_n ) begin
  if ( ~reset_n )
  begin
    counter <= 20'hFFFFF;
    sync_reg <= 1'b0;
  end else
  begin
    if ( !enable )
    begin
      counter <= 20'hFFFFF;
    end else if ( counter != 20'b0 )
    begin
      counter <= counter - 1'b1;
    end else
    begin
      counter <= 20'b0;
    end
    // Single pulse at the end of the count
    sync_reg <= ( counter == 20'b1 );
  end
end

endmodule
