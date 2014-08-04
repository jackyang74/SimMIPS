module SinglePortRam
(
	input clk_i,
	input we_i,
	input [11:0] adr_i, 
	input [3:0] be_i, 
	input [31:0] dat_i,
	output[31:0] dat_o
);
	
	// use a multi-dimensional packed array
	//to model individual bytes within the word
	// (* ram_init_file = "ram_init.mif" *) logic [3:0][7:0] ram[0:4095];
	logic [3:0][7:0] ram[0:4095];
	integer i;
	initial
	begin
		ram[0] = 32'b001101_00000_00001_0000000000000000; //ori $1,$0,0
		ram[1] = 32'b001111_00000_00001_1010000000000000; //lui $1,0xA000
		ram[2] = 32'b001101_00000_00010_0000000001111000; //ori $2,$0,0xF0
		ram[3] = 32'b101011_00001_00010_0000000000000000; //sw $2,$1(0)
		for(i=4;i<4096;i=i+1)
			ram[i] = 0;
	end
	
	reg[31:0] q;
	always_ff@(posedge clk_i)
	begin
	if(we_i) 
		begin
			if(be_i[0]) ram[adr_i][0] <= dat_i[7:0];
			if(be_i[1]) ram[adr_i][1] <= dat_i[15:8];
			if(be_i[2]) ram[adr_i][2] <= dat_i[23:16];
			if(be_i[3]) ram[adr_i][3] <= dat_i[31:24];
		end
		q <= ram[adr_i];
	end
	
	assign dat_o = q;
endmodule
