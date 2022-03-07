`timescale 1ns/1ps

module color_sensor_tb();
	reg clk_50,out;
	wire [3:0] s;
	wire [2:0] led; 
	wire oe;
	integer i,rc,gc,bc;
	
	parameter cycle=200;
	
	color_sensor DUT(.clk_50(clk_50),
						  .out(out),
						  .led(led),
						  .s(s),
						  .oe(oe)
						);
	always 
		begin
			clk_50=1'b0;
			#(cycle/2);
			clk_50 = 1'b1;
			#(cycle/2);
		end
	
	initial
		begin
			for (i=0; i<50; i=i+1) begin
				rc=($urandom%10)*700+2000;
				out = 1'b1;
				#200;
				out = 1'b0;
				#(rc/2); 
				out=1'b1;
				#(rc/2);
				out=1'b0;
				#200;
				
				gc=($urandom%10)*700+2000;
				out = 1'b1;
				#200;
				out = 1'b0;
				#(gc/2); 
				out=1'b1;
				#(gc/2); 
				out=1'b0;
				#200;
				
				bc=($urandom%10)*700+2000;
				out = 1'b1;
				#200;
				out = 1'b0;
				#(bc/2); 
				out=1'b1;
				#(bc/2); 
				out=1'b0;
				#200;
			end
			$finish;
		end
	
	initial $monitor("c=%b,led=%b",s[3:2],led);
endmodule
