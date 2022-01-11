`timescale 1ns/1ps

module rc_uart_tb();
	reg clk_50,rx_in;
	wire clk_uart;
	wire [3:0] led;
	
	parameter	cycle=200,
					wasd=434*200;
	rc_uart DUT(.clk_50(clk_50),
						.rx_in(rx_in),
						.clk_uart(clk_uart),
						.led(led)
					);
	always
		begin
			clk_50=1'b0;
			#(cycle/2);
			clk_50=1'b1;
			#(cycle/2);
		end
	task send();
	begin
		//01110111
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		//01100001
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		//01110011
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		//01100100
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b0;
		#(wasd);
		
		rx_in=1'b1;
		#(wasd);
		rx_in=1'b1;
		#(wasd);
		$finish;
	end
	endtask
	
	initial
		begin
			send;
		end
	initial $monitor("led=%b",led); 
endmodule
