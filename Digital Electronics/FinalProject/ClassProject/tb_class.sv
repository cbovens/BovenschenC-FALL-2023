`timescale 1ns/1ps
module stimulus_class();

  logic 	Start;
  logic 	reset;
  logic [63:0] Key;
  logic [55:0] count;
  logic [63:0] plaintext, ciphertext;
  
  localparam [55:0] countThreshold = 2**23;
  logic 	   FoundKeyNum;   
  
  logic 	   clk;   
  
  integer 	   outputFilePointer;
  integer 	   testVectorFilePointer;
  
  logic [31:0] vectornum;   

  // Replace with your plaintext and ciphertext
 assign plaintext = 64'ha8f4dccb8a0b94c1;
 assign ciphertext = 64'h030d56022c3e8c47;

  top dut (clk, Start, reset, count, Key, FoundKeyNum);

  initial 
    begin	
	  clk = 1'b0;
	  forever #5 clk = ~clk;
    end

  initial
    begin
	  vectornum = 0;
	  outputFilePointer = $fopen("count.out");
	end
	  

  always @(posedge clk) 
    begin
	  if (FoundKeyNum == 1'b1) begin
		$fdisplay(outputFilePointer, "%h %b | %h", Key, FoundKeyNum, count);
		$display("");
		$display("Found key!");
		$display("%h", Key);
		$display("");
		$stop();

      end
	end

  initial
    begin
	  // Initialize
	  #0   Start = 1'b0;	
	  #0   reset = 1'b1;
	  #101 reset = 1'b0;
	  #32  Start = 1'b1;
	 // #20  Start = 1'b0;
	  
    end 

endmodule // tb
