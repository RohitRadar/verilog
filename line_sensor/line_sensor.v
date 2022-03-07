module line_sensor(
	input clk_50,
	output [2:0] led,
	output adc_sck,
	output adc_cs_n,
	input adc_data,
	output adc_add 
);

//ADC CLOCK
integer clk_count = 0;
integer q_clk = 1;
always @(negedge clk_50)
	begin
		if (clk_count==10)
			begin
				clk_count = 0;
				q_clk =~ q_clk;
			end
		clk_count = clk_count+1;
	end
	assign adc_sck = q_clk;

//ADC CHIP SELECT
assign adc_cs_n = 1'b0;

//CHANNEL SELECT
integer cs_count = 0;
integer cs_check = 0;
reg [8:0] ch = 9'b111101110;
reg temp;
always @(negedge adc_sck)
	begin
		if ((cs_count>1)&&(cs_count<5))
			begin
				cs_count = cs_count+1;
				temp <= ch[8-(cs_count-3)-3*cs_check];
			end
		else if (cs_count==15)
			begin
				cs_count=0;
				cs_check=cs_check+1;
				if (cs_check==3)
					cs_check=0;
			end
		else
			begin
				temp <= 1'b0;
				cs_count=cs_count+1;
			end
	end
	assign adc_add = temp;

//ADC VALUE
integer adcvalue=200;
integer l1=1,l2=1,l3=1;
integer dch = 0;
integer doutc=0;
reg [11:0] adc1=12'b0, adc2=12'b0, adc3=12'b0, tempadc=12'b0;
always @(posedge adc_sck) 
	begin
		if(doutc<=16) 
			begin
				tempadc=tempadc<<1;
				tempadc[0]=adc_data;
				doutc=doutc+1;
			end
		if(doutc == 17)
			begin
				doutc= 1;
				dch = dch +1;
				if (dch == 1)
					begin
						adc1 =tempadc;
						if (adcvalue>adc1)
							l3=1;
						else
							l3=0;
					end
				else if (dch == 2)
					begin
						adc2 =tempadc;
						if (adcvalue>adc2)
							l2=1;
						else
							l2=0;
					end
				else if (dch == 3)
					begin
						adc3 =tempadc;
						if (adcvalue>adc3)
							l1=1;
						else
							l1=0;
						dch = 0;
					end
			end
	end
	assign led[0] = l1;
	assign led[1] = l2;
	assign led[2] = l3;
endmodule
