module djikstras(
	input clk_50,
	input [7:0]starting_node,
	input [7:0]ending_node,
	output [63:0]direction_out
);

integer startnode=0;
integer endnode=0;
integer initialpos=4;
integer start_hold=0;
integer end_hold=0;

reg [63:0]output_dir;
reg [63:0]output_dir_reg;
assign direction_out=output_dir_reg;

parameter max = 37;
parameter size=31;
integer k=0, j=0;
integer min=0,pos=0;
integer path_count=0;
integer v=0;
integer a,b,c,d,e;

reg [1:0] state=0;
reg [1:0] djikstras_case=0;
reg [1:0] path_case=0;
reg [1:0] data_case=0;
reg [1:0] loop1=0;

reg wen_adj;
reg [size:0] adj_add;
reg [size:0] adj_input;
wire [size:0] adj_output;
reg wen_di;
reg [size:0] di_add;
reg [size:0] di_input;
wire [size:0] di_output;
reg wen_dn;
reg [size:0] dn_add;
reg [size:0] dn_input;
wire [size:0] dn_output;
reg wen_v;
reg [size:0] v_add;
reg signed [size:0] v_input;
wire signed [size:0] v_output;
reg wen_path;
reg [size:0] path_add;
reg signed [size:0] path_input;
wire signed [size:0] path_output;
RAM RAM(.clk_50(clk_50),
		  .wen_adj(wen_adj),
		  .adj_add(adj_add),
		  .adj_input(adj_input),
		  .adj_output(adj_output),

		  .wen_di(wen_di),
		  .di_add(di_add),
		  .di_input(di_input),
		  .di_output(di_output),

		  .wen_dn(wen_dn),
		  .dn_add(dn_add),
		  .dn_input(dn_input),
		  .dn_output(dn_output),

		  .wen_v(wen_v),
		  .v_add(v_add),
		  .v_input(v_input),
		  .v_output(v_output),

		  .wen_path(wen_path),
		  .path_add(path_add),
		  .path_input(path_input),
		  .path_output(path_output)
);

always @(posedge clk_50)
begin
	case (state)
	0:
	begin
		startnode=starting_node;
		endnode=ending_node;
		start_hold=starting_node;
		end_hold=ending_node;
		if(j<max)
		begin
			case (data_case)
			0:
			begin
				wen_path=1;
				path_add=j;
				path_input=0;
				v_add=4*j+0;
				wen_v=1;
				v_input=0;
				data_case=1;
			end
			1:
			begin
				v_add=4*j+1;
				wen_v=1;
				v_input=9999;
				data_case=2;
			end
			2:
			begin
				v_add=4*j+2;
				wen_v=1;
				v_input=-1;
				data_case=3;
			end
			3:
			begin
				v_add=4*j+3;
				wen_v=1;
				v_input=0;
				j=j+1;
				data_case=0;
			end
			endcase
		end
		else
		begin
			v_add=4*(startnode-1)+1;
			wen_v=1;
			v_input=0;
			k=0;j=0;
			output_dir_reg=64'h0000000000000000;
			output_dir=64'h0000000000000000;
			djikstras_case=0;
			state=1;
		end
	end
	1:
	begin
		if(k<max)
		begin
			case(djikstras_case)
			0:
			begin
				if(j<max)
				begin
					case (data_case)
					0:
					begin
						wen_v=0;
						v_add=4*j+0;
						data_case=1;
					end
					1:
					begin
						a=v_output;
						wen_v=0;
						v_add=4*j+1;
						data_case=2;
					end
					2:
					begin
						b=v_output;
						if (a==0)
						begin
							min=b;
							pos=j;
							j=max;
						end
						j=j+1;
						data_case=0;
					end
					endcase
				end
				else
				begin
					j=0;
					djikstras_case=1;
				end
			end
			1:
			begin
				if(j<max)
				begin
					case (data_case)
					0:
					begin
						wen_v=0;
						v_add=4*j+1;
						data_case=1;
					end
					1:
					begin
						a=v_output;
						wen_v=0;
						v_add=4*j+0;
						data_case=2;
					end
					2:
					begin
						b=v_output;
						if (a<min && b==0)
						begin
							min=a;
							pos=j;
						end
						j=j+1;
						data_case=0;
					end
					endcase
				end
				else
				begin
					wen_v=1;
					v_add=4*pos+0;
					v_input=1;
					j=0;
					djikstras_case=2;
				end
			end
			2:
			begin
				if(j<max)
				begin
					case (data_case)
					0:
					begin
						wen_adj=0;
						adj_add=max*pos+j;
						wen_v=0;
						v_add=4*pos+1;
						data_case=1;
					end
					1:
					begin
						a=adj_output;
						b=v_output;
						wen_v=0;
						v_add=4*j+1;
						data_case=2;
					end
					2:
					begin
						c=v_output;
						if(a!=0)
						begin
							if(b+a<c)
							begin
								case(loop1)
								0:
								begin
									wen_v=1;
									v_add=4*j+1;
									v_input=b+a;
									loop1=1;
								end
								1:
								begin
									wen_v=1;
									v_add=4*j+2;
									v_input=pos;
									j=j+1;
									data_case=0;
									loop1=0;
								end
								endcase
							end
							else
							begin
								j=j+1;
								data_case=0;
							end
						end
						else
						begin
							j=j+1;
							data_case=0;
						end
					end
					endcase
				end
				else
				begin
					j=0;
					k=k+1;
					djikstras_case=0;
				end
			end
			endcase
		end
		else
		begin
			j=0; k=0;
			v=endnode-1;
			path_count=0;
			state=2;
		end
	end
	2:
	begin
		case(path_case)
		0:
		begin
			case(data_case)
			0:
			begin
				wen_v=0;
				v_add=4*v+2;
				data_case=1;
			end
			1:
			begin
				if (v_output!=-1)
				begin
					wen_path=1;
					path_add=path_count;
					path_input=v+1;
					path_count=path_count+1;
					v=v_output;
					data_case=0;
				end
				else
				begin
					wen_path=1;
					path_add=path_count;
					path_input=v+1;
					path_count=path_count+1;
					j=path_count-1;
					path_case=1;
					data_case=0;
				end
			end
			endcase
		end
		1:
		begin
			if (j>0)
			begin
				case(data_case)
				0:
				begin
					wen_path=0;
					path_add=j;
					data_case=1;
				end
				1:
				begin
					a=path_output;
					wen_path=0;
					path_add=j-1;
					data_case=2;
				end
				2:
				begin
					b=path_output;
					wen_di=0;
					di_add=max*(a-1)+b-1;
					wen_dn=0;
					dn_add=max*(a-1)+b-1;
					data_case=3;
				end
				3:
				begin
					c=di_output;
					d=dn_output;
					if (initialpos-c==0)
					begin
						k=k+1;
						output_dir=output_dir<<4;
						output_dir[3:0]=1;
						initialpos=d;
					end
					else if (initialpos-c==1||initialpos-d==-3)
					begin
						k=k+2;
						output_dir=output_dir<<4;
						output_dir[3:0]=4;
						output_dir=output_dir<<4;
						output_dir[3:0]=1;
						initialpos=d;
					end
					else if (initialpos-c==-1||initialpos-c==3)
					begin
						k=k+2;
						output_dir=output_dir<<4;
						output_dir[3:0]=2;
						output_dir=output_dir<<4;
						output_dir[3:0]=1;
						initialpos=d;
					end
					else
					begin
						k=k+2;
						output_dir=output_dir<<4;
						output_dir[3:0]=3;
						output_dir=output_dir<<4;
						output_dir[3:0]=1;
						initialpos=d;					
					end
					j=j-1;
					data_case=0;
				end
				endcase
			end
			else
			begin
				output_dir=output_dir<<64-4*k;
				output_dir_reg=output_dir;
				path_case=0;
				j=max;
				k=max;
				state=3;
			end	
		end
		endcase
	end
	3:
	begin
		wen_adj=0;
		wen_di=0;
		wen_dn=0;
		wen_v=0;
		wen_path=0;
		if(k<max)
		begin
			if(j<max)
			begin
			case(data_case)
				0:
				begin
					adj_add=max*k+j;
					di_add=max*k+j;
					dn_add=max*k+j;
					v_add=4*k+j/4;
					path_add=k;
					data_case=1;
				end
				1:
				begin
					a=adj_output;
					b=di_output;
					c=dn_output;
					d=v_output;
					e=a+b+c+d;
					data_case=0;
					j=j+1;
				end
			endcase
			end
			else
			begin
				j=0;
				k=k+1;
			end
		end
		else
		begin
			a=0;
			b=0;
			c=0;
			d=0;
			e=0;
			if (start_hold!=starting_node&&end_hold!=ending_node)
			begin
				k=0;j=0;
				min=0;pos=0;
				path_count=0;
				v=0;
				state=0;
				djikstras_case=0;
				path_case=0;
				data_case=0;
				loop1=0;
			end
		end
	end
	endcase
end
endmodule
