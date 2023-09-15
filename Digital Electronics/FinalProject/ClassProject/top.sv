module top (input logic 	clk, start, reset,
	 
		output logic [55:0] count,
		output logic [63:0] Key, 
		output logic 	FoundKeyNum);
   
   logic 			UP;
   logic 			en1;
   logic 			en2;
   logic [63:0]		out;
   //logic[63:0]		in;
   logic [63:0]	ciphertext;
   logic [63:0]	ciphertext2;

   logic [63:0] 		plaintext_known;
   logic [63:0] 		ciphertext_known;

   
   //assign ciphertext_known = 64'h030d56022c3e8c47;
   //assign ciphertext_known = 64'h6DDF697C85C44369;   
   assign plaintext_known = 64'ha8f4dccb8a0b94c1;
   assign ciphertext_known = 64'h030d56022c3e8c47;
   
   // Put your solution here and remove the following assignments.
   
   FSM fsm (~clk, reset, start, FoundKeyNum, UP, en1, en2);
   
   UDL_Count #(56) counter (clk, reset, UP, 1'b0, 1'b0, 56'h0, count);   
   
   //key flip flop
   flopenr #(64) key (clk, reset, en2, out, Key);

   // DES
   DES des (out, plaintext_known, 1'b1, ciphertext);
   genParity8 parityCheck (count, out);
   //ciphertext flip flop
   flopenr #(64) reg1 (clk, reset, en1, ciphertext, ciphertext2);
   assign FoundKeyNum = (ciphertext2 == ciphertext_known);



endmodule // top


   module genParity(input logic [6:0] in, output logic [7:0] out);
  assign out[0] = ~^in;
  assign out[7:1] = in;
endmodule

module genParity8(input logic [55:0] count, output logic [63:0] out);
  genvar 						index;
  for(index = 0; index < 8; index++) begin
	genParity genParity(.in(count[7*index +: 7]), .out(out[8*index +: 8]));
  end
endmodule

 