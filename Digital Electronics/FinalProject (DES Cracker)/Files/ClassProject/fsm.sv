module FSM (clk, reset, start, Found, UP, en1, en2);

   input logic  clk;
   input logic  reset;
   input logic 	start;
   input logic Found;
   
   output logic UP;
   output logic en1;
   output logic en2;
  

   typedef enum logic [1:0] {Idle, UpCount, Store, FoundKey} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= Idle;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       Idle: begin
	  UP <= 1'b0;	 
	  en1 <= 1'b0;
	  en2 <= 1'b0; 
	  
	  if (start) nextstate <= UpCount;
	  else nextstate <= Idle;
       end
       UpCount: begin
	  UP <= 1'b1;	 
	  en1 <= 1'b0;
	  en2 <= 1'b0; 	  
	  nextstate <= Store;
       end

       Store: begin
	  UP <= 1'b0;	 
	  en1 <= 1'b1;
	  en2 <= 1'b0; 
	  
	  if(Found) nextstate <= FoundKey;
	  else nextstate <= UpCount;
       end

       FoundKey: begin
	  UP <= 1'b0;	 
	  en1 <= 1'b0;
	  en2 <= 1'b1; 
	  
	  if(~start) nextstate <= Idle;
	  else nextstate <= FoundKey;
       end
    

       default: begin
	  UP <= 1'b0;	
	  en1 <= 1'b0;	
	  en2 <= 1'b0;		  
	  nextstate <= Idle;

       end
     endcase
   
endmodule
