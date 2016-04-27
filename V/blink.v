module blink
       (
         input clk, reset_n,
         output blink
       );

reg [ 20: 0 ] count;
reg blink_reg;

assign blink = blink_reg;

always @( posedge clk or negedge reset_n ) begin
  if ( ~reset_n )
  begin
    count <= 21'b0;
    blink_reg <= 1'b0;
  end else
  begin
    count <= count + 1'b1;
    blink_reg <= count[ 20 ];
  end
end
endmodule
