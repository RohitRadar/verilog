//red:https://wallpaperaccess.com/full/343670.png
//green:https://eskipaper.com/images/cool-green-wallpaper-1.jpg
//blue:https://wallpaperaccess.com/full/537582.jpg

module color_sensor(
	input clk_50,
	input out,
	output [2:0]led,
	output [3:0]s,
	output oe
);

assign s[1:0]=2'b11;
assign oe=1'b0;

integer rst=0;
reg [31:0] ar,ag,ab;
reg [2:0]l=3'b111;
integer count=0;
integer stop=0;
reg [1:0]c=2'b00;

always @(negedge out)
	begin
		stop=stop+1;
		rst=~rst;
		if ((rst==0)&&(stop==10))
			begin
				stop=0;
				case (c)
					2'b00:	
						begin 
							ar=count;
							c=2'b11;
						end
					2'b11:
						begin
							ag=count;
							c=2'b10;
						end	
					2'b10:	
						begin
							ab=count;
							c=2'b00;
							if (ar>ag)
								begin
									if (ab>ar)
										l=3'b001;
									else
										l=3'b100;
								end
							else
								begin 
									if (ab>ag)
										l=3'b001;
									else
										l=3'b010;
								end
						end
				endcase
			end
	end
	assign led=l;
	assign s[3:2]=c;
	

always @(negedge clk_50)
	begin
		if (rst==0)
			count=0;
		else
			count=count+1;
	end

endmodule
