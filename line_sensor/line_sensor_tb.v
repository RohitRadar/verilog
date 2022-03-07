`timescale 1ns/1ps

module line_sensor_tb();
	reg clk_50;
	wire [2:0] led;
	wire adc_add,adc_sck,adc_cs_n;
	reg adc_data;
	
	integer cycle=200;
	integer adc_cycle=200*20; // 5Mhz
	integer i,j,x;
	reg [15:0]data;
	line_sensor DUT(.clk_50(clk_50),
						.led(led),
						.adc_add(adc_add),
						.adc_sck(adc_sck),
						.adc_cs_n(adc_cs_n),
						.adc_data(adc_data)
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
			for (i=0; i<50; i=i+1) 
				begin
					x=$urandom%400;
					data[15:0]=x;
					for (j=15; j>-1; j=j-1)
						begin
							#(adc_cycle);
							adc_data=data[j];		
						end
				end
			$finish;
		end
	initial $monitor("led=%b,x=%d",led,x);
endmodule
