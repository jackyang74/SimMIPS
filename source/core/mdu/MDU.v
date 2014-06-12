`include "../CPUConstants.v"
module MDU(
		clk_i,
		rst_i,
		mdu_op_i,
		mdu_a_i,
		mdu_b_i,
		mdu_data_o,
		mdu_pipeline_stall_o
);
	
input clk_i;
input rst_i;
input [3:0] mdu_op_i;
input [31:0]	mdu_a_i;
input [31:0]	mdu_b_i;
output [31:0] 	mdu_data_o;
output mdu_pipeline_stall_o;

	
reg [31:0] reg_HI,reg_LO;
reg sign;

/*wire related with Multiplier*/
wire[31:0] product_hi,product_lo;

/*wire related with Divider */
reg start;
wire [31:0] quotient,remainder;
reg ready;
wire divider_ready,divider_busy;
/*signal related with MDU controller*/
reg [1:0] mdu_out_sel;
reg hi_wr_en,lo_wr_en;
reg [1:0] hilo_sel;
wire [31:0] hi_data;
wire [31:0] lo_data;
reg pipeline_stall;

assign mdu_pipeline_stall_o = pipeline_stall;


always@(posedge clk_i)
begin
	if(rst_i)
		begin
			ready <= 0;
		end
	else
		begin
			if(divider_ready && !ready)
				ready <= 1'b1;
			else
				ready <= 0;
		end
end

always@(*)
begin
	sign = 0;
	start = 0;
	hi_wr_en = 0;
	lo_wr_en = 0;
	hilo_sel = 0;
	mdu_out_sel = 0;
	if(ready && (!divider_busy) && pipeline_stall)
		begin
			pipeline_stall = 0;
		end
	else
		begin
			pipeline_stall = 0;
			case(mdu_op_i)
				`MDU_OP_DIV:
					begin
						if(!divider_busy) 
							start = 1'b1;
						else 
							start = 1'b0;
						pipeline_stall = 1'b1;
						sign = 1'b1;
						hilo_sel = 2'd2;
					end
				`MDU_OP_DIVU:
					begin
						if(!divider_busy) 
							start = 1'b1;
						else 
							start = 1'b0;
						pipeline_stall = 1'b1;
						hilo_sel = 2'd2;
					end
				`MDU_OP_MUL:
					begin
						sign = 1'b1;
						mdu_out_sel = 2'd2;
						hilo_sel = 2'd1;
						hi_wr_en = 1'b1;
						lo_wr_en = 1'b1;
					end
				`MDU_OP_MULT:
					begin
						sign = 1'b1;
						hilo_sel = 2'd1;
						hi_wr_en = 1'b1;
						lo_wr_en = 1'b1;
					end
				`MDU_OP_MULTU:
					begin
						hilo_sel = 2'd1;
						hi_wr_en = 1'b1;
						lo_wr_en = 1'b1;
					end
				`MDU_OP_MFHI:
					begin
						mdu_out_sel = 2'd0;
					end
				`MDU_OP_MFLO:
					begin
						mdu_out_sel = 2'd1;
					end
				`MDU_OP_MTHI:
					begin
						hi_wr_en = 1'b1;
					end
				`MDU_OP_MTLO:
					begin
						lo_wr_en = 1'b1;
					end
				default:
					begin
					end
			endcase
	end
end


always@(posedge clk_i)
begin
	if(rst_i) 
		begin
			reg_HI <= 0;
			reg_LO <= 0;
		end
	else
		begin
			if(hi_wr_en)
				reg_HI <= hi_data;
			if(lo_wr_en)
				reg_LO <= lo_data;
		end
end



Multi_3_32 mdu_hi_sel(
	.a(mdu_a_i),
	.b(product_hi),
	.c(quotient),
	.sel(hilo_sel),
	.data(hi_data)
);

Multi_3_32 mdu_lo_sel(
	.a(mdu_b_i),
	.b(product_lo),
	.c(remainder),
	.sel(hilo_sel),
	.data(lo_data)
);

Multi_3_32 mdu_data_o_sel(
	.a(reg_HI),
	.b(reg_LO),
	.c(lo_data),
	.sel(mdu_out_sel),
	.data(mdu_data_o)
);

Divider Divider_inst(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.dividend_i(mdu_a_i),
	.divisior_i(mdu_b_i),
	.signed_i(sign),
	.start_i(start),
	.quotient_o(quotient),
	.remainder_o(remainder),
	.ready_o(divider_ready),
	.busy_o(divider_busy)
);

Multiplier Multiplier_inst(
		.multiplier_i(mdu_a_i),
		.multiplicand_i(mdu_b_i),
		.signed_i(sign),
		.product_hi_o(product_hi),
		.product_lo_o(product_lo)
);
endmodule
