module RAM (
		input clk_50,
		
		input wen_adj,
		input [31:0] adj_add,
		input [31:0] adj_input, 
		output [31:0] adj_output,

		input wen_di,
		input [31:0] di_add,
		input [31:0] di_input, 
		output [31:0] di_output,
		
		input wen_dn,
		input [31:0] dn_add,
		input [31:0] dn_input, 
		output [31:0] dn_output,
		
		input wen_v,
		input [31:0] v_add,
		input [31:0] v_input, 
		output [31:0] v_output,
		
		input wen_path,
		input [31:0] path_add,
		input [31:0] path_input, 
		output [31:0] path_output
);

	parameter max=37;
	parameter size=31;
	
	reg [size:0] adj[max*max:0];
	reg [size:0] adj_data_out;
	assign adj_output = adj_data_out;
	
	reg [size:0] di[max*max:0];
	reg [size:0] di_data_out;
	assign di_output = di_data_out;
	
	reg [size:0] dn[max*max:0];
	reg [size:0] dn_data_out;
	assign dn_output = dn_data_out;
	
	reg signed [size:0] v[4*max:0];
	reg signed [size:0] v_data_out;
	assign v_output = v_data_out;
	
	reg signed [size:0] path[max:0];
	reg signed [size:0] path_data_out;
	assign path_output = path_data_out;
	initial 
	begin : INIT
		integer i;
		for(i=0;i<max*max;i=i+1)
		begin
			adj[i] = 32'h00000000;
			di[i] = 32'h00000000;
			dn[i] = 32'h00000000;
		end
		adj[1]=3;adj[4]=1;adj[19]=4;adj[37]=3;adj[39]=2;adj[50]=3;adj[75]=2;adj[80]=1;adj[90]=4;adj[115]=1;adj[148]=1;adj[151]=1;adj[153]=1;adj[156]=1;adj[189]=1;adj[224]=1;adj[267]=1;adj[300]=1;adj[303]=1;adj[305]=1;adj[307]=1;adj[341]=1;adj[381]=1;adj[415]=1;adj[417]=1;adj[419]=1;adj[424]=1;adj[455]=1;adj[482]=3;adj[495]=1;adj[503]=2;adj[531]=1;adj[571]=1;adj[594]=4;adj[607]=1;adj[617]=2;adj[640]=1;adj[647]=1;adj[650]=1;adj[683]=1;adj[703]=4;adj[723]=2;adj[737]=3;adj[759]=2;adj[761]=1;adj[766]=1;adj[794]=1;adj[797]=1;adj[799]=3;adj[806]=2;adj[827]=2;adj[835]=3;adj[837]=1;adj[841]=1;adj[873]=1;adj[875]=2;adj[882]=3;adj[911]=2;adj[913]=1;adj[916]=1;adj[941]=2;adj[949]=1;adj[961]=4;adj[982]=1;adj[1021]=1;adj[1060]=1;adj[1094]=2;adj[1103]=1;adj[1108]=2;adj[1139]=1;adj[1170]=3;adj[1179]=1;adj[1183]=2;adj[1215]=1;adj[1255]=1;adj[1277]=3;adj[1291]=1;adj[1293]=2;adj[1324]=2;adj[1329]=2;adj[1331]=3;adj[1357]=4;adj[1363]=2;adj[1367]=3;
		di[1]=3;di[4]=4;di[19]=1;di[37]=1;di[39]=3;di[50]=4;di[75]=1;di[80]=4;di[90]=3;di[115]=3;di[148]=2;di[151]=1;di[153]=3;di[156]=4;di[189]=1;di[224]=2;di[267]=3;di[300]=2;di[303]=1;di[305]=3;di[307]=4;di[341]=1;di[381]=3;di[415]=2;di[417]=1;di[419]=3;di[424]=4;di[455]=1;di[482]=2;di[495]=3;di[503]=4;di[531]=1;di[571]=3;di[594]=2;di[607]=1;di[617]=4;di[640]=2;di[647]=3;di[650]=4;di[683]=1;di[703]=2;di[723]=3;di[737]=4;di[759]=1;di[761]=3;di[766]=4;di[794]=2;di[797]=1;di[799]=3;di[806]=4;di[827]=2;di[835]=1;di[837]=3;di[841]=4;di[873]=1;di[875]=3;di[882]=4;di[911]=1;di[913]=3;di[916]=4;di[941]=2;di[949]=1;di[961]=4;di[982]=2;di[1021]=2;di[1060]=2;di[1094]=2;di[1103]=3;di[1108]=4;di[1139]=1;di[1170]=2;di[1179]=3;di[1183]=4;di[1215]=1;di[1255]=1;di[1277]=2;di[1291]=3;di[1293]=4;di[1324]=2;di[1329]=1;di[1331]=3;di[1357]=3;di[1363]=2;di[1367]=1;
		dn[1]=3;dn[4]=4;dn[19]=4;dn[37]=1;dn[39]=3;dn[50]=4;dn[75]=1;dn[80]=4;dn[90]=4;dn[115]=3;dn[148]=2;dn[151]=1;dn[153]=3;dn[156]=4;dn[189]=1;dn[224]=2;dn[267]=3;dn[300]=2;dn[303]=1;dn[305]=3;dn[307]=4;dn[341]=1;dn[381]=3;dn[415]=2;dn[417]=1;dn[419]=3;dn[424]=4;dn[455]=1;dn[482]=2;dn[495]=3;dn[503]=4;dn[531]=1;dn[571]=3;dn[594]=1;dn[607]=1;dn[617]=4;dn[640]=2;dn[647]=3;dn[650]=4;dn[683]=1;dn[703]=3;dn[723]=3;dn[737]=4;dn[759]=1;dn[761]=3;dn[766]=4;dn[794]=2;dn[797]=1;dn[799]=3;dn[806]=4;dn[827]=2;dn[835]=1;dn[837]=3;dn[841]=4;dn[873]=1;dn[875]=3;dn[882]=4;dn[911]=1;dn[913]=3;dn[916]=4;dn[941]=2;dn[949]=1;dn[961]=1;dn[982]=2;dn[1021]=2;dn[1060]=2;dn[1094]=2;dn[1103]=3;dn[1108]=4;dn[1139]=1;dn[1170]=2;dn[1179]=3;dn[1183]=4;dn[1215]=1;dn[1255]=1;dn[1277]=2;dn[1291]=3;dn[1293]=3;dn[1324]=2;dn[1329]=2;dn[1331]=3;dn[1357]=2;dn[1363]=2;dn[1367]=1;
	end
	
	always @(negedge clk_50)
	begin
		if(wen_adj == 1) 
			adj[adj_add] <= adj_input;
		else
			adj_data_out <= adj[adj_add];
	end	
	always @(negedge clk_50)
	begin
		if(wen_di == 1) 
			di[di_add] <= di_input;
		else
			di_data_out <= di[di_add];
	end	
	always @(negedge clk_50)
	begin
		if(wen_dn == 1) 
			dn[dn_add] <= dn_input;
		else
			dn_data_out <= dn[dn_add];
	end	
	always @(negedge clk_50)
	begin
		if(wen_v == 1) 
			v[v_add] <= v_input;
		else
			v_data_out <= v[v_add];
	end
	always @(negedge clk_50)
	begin
		if(wen_path == 1) 
			path[path_add] <= path_input;
		else
			path_data_out <= path[path_add];
	end
endmodule
