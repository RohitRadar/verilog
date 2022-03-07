module rc_uart(
	input clk_50,
	output clk_uart,
	input rx_in,
	output [3:0]led
);


reg [7:0] input_data_reg;
reg [3:0] l=4'b0000;
integer bit_count=0;
reg [1:0] state=2'b00;

always @(negedge clk_uart)
	begin
		case (state)
		2'b00:
			begin
				if (rx_in==0)
					state=2'b01;
			end
		2'b01:
			begin
				if (bit_count<8)
					begin
						input_data_reg[bit_count]=rx_in;
						bit_count=bit_count+1;
					end
				else
					begin
						bit_count=0;
						l<=4'b0000;
						if (input_data_reg==8'b01110111)//w
							l[3]<=1'b1;
						else if (input_data_reg==8'b01100001)//a
							l[2]<=1'b1;
						else if (input_data_reg==8'b01110011)//s
							l[1]<=1'b1;
						else if (input_data_reg==8'b01100100)//d
							l[0]<=1'b1;
						else
							l<=4'b0000;
						state<=2'b00;
					end
			end
			default: state <= 2'b00;
		endcase
	end
	assign led=l;

integer count=0;
integer c=0;
always @(posedge clk_50)
	begin
		if (count<434/2)
				count=count+1;
		else
			begin
				count=0;
				c=~c;
			end
	end
	assign clk_uart=c;
endmodule
