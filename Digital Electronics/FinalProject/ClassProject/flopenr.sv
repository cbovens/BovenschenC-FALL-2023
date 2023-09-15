// enabled asynchronously resettable flip flop
module flopenr #(parameter WIDTH = 8)
  (input logic              clk,
   input logic 		    reset,
   input logic 		    en, 
   input logic [WIDTH-1:0]  d, 
   output logic [WIDTH-1:0] q);

  // asynchronous reset 
  always_ff @(posedge clk, posedge reset)
    if      (reset) q <= {WIDTH{1'b0}};
    else if (~en)    q <= d;
endmodule
