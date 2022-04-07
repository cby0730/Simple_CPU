//	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
module mips_Pipeline( clk, rst );
	input clk, rst;
	
	// instruction bus
	wire[31:0] instr;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset;
    wire [25:0] jumpoffset;
	
	// datapath signals
    wire [4:0] rfile_wn, temp_rfile_wn;
    wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, temp_rfile_wd, alu_b, alu_out, alu_temp, b_tgt, pc_next,
                pc, pc_incr, dmem_rdata, jump_addr, branch_addr, Jal_addr;

	// control signals
    wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Zero, Jump, JaltoReg, R31toReg ;
    wire [1:0] ALUOp;
    wire [2:0] Operation;

//***********************第一部分會輸出的控制訊號*******************************
    wire[31:0] part1_out_pc, part1_out_instr ;
//***********************第一部分會輸出的控制訊號*******************************

//***********************第二部分會輸出的控制訊號*******************************
    wire part2_out_RegDst, part2_out_ALUSrc, part2_out_RegWrite, part2_out_MemWrite, part2_out_MemRead, part2_out_MemtoReg, part2_out_R31toReg, part2_out_JaltoReg ;

    wire [1:0] part2_out_ALUOp ; 
    wire [4:0] part2_out_rt, part2_out_rd, part2_out_shamt ;
    wire [5:0] part2_out_funct ;
    wire [31:0] part2_out_rd1, part2_out_rd2, part2_out_extend_immed ;
//***********************第二部分會輸出的控制訊號*******************************

//***********************第三部分會輸出的控制訊號*******************************
    wire part3_out_MemWrite, part3_out_MemRead, part3_out_MemtoReg, part3_out_RegWrite, part3_out_R31toReg, part3_out_JaltoReg ;

    wire [4:0] part3_out_mux ;
    wire [31:0] part3_out_ALUout, part3_out_rfile_rd2 ;
	// 乘法
	wire [63:0] MulAns;
	wire Multu;
	// ****************
	wire [1:0] ALU_ctl_Sel;
	wire [31:0] HiOut, LoOut;
//***********************第三部分會輸出的控制訊號*******************************

//***********************第四部分會輸出的控制訊號*******************************
    wire part4_out_RegWrite, part4_out_MemtoReg, part4_out_R31toReg, part4_out_JaltoReg ; //第四部分會輸出的控制訊號

    wire [31:0] part4_out_ALUout, part4_out_rd ;
	wire [4:0] part4_out_mux ;

//***********************第四部分會輸出的控制訊號*******************************
	
    assign opcode = part1_out_instr[31:26];
    assign rs = part1_out_instr[25:21];
    assign rt = part1_out_instr[20:16];
    assign rd = part1_out_instr[15:11];
    assign shamt = part1_out_instr[10:6];
    assign funct = part1_out_instr[5:0];
    assign immed = part1_out_instr[15:0];
    assign jumpoffset = part1_out_instr[25:0];
	
	// branch offset shifter
    assign b_offset = extend_immed << 2;
	
	// jump offset shifter & concatenation
	assign jump_addr = { pc_incr[31:28], jumpoffset <<2 };

    assign Zero = (rfile_rd1 == rfile_rd2) ? 1'b1 : 1'b0;

    assign Jal_addr = ( opcode == 6'd3 ) ? pc_incr : Jal_addr ;

	// module instantiations
	
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc) );

    and BR_AND(PCSrc, Branch, Zero);
	
    add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) );
	
    add32 BRADD( .a(part1_out_pc), .b(b_offset), .result(b_tgt) );

	// sign-extender
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed) );

    ALU alu( .ctl(Operation), .a(part2_out_rd1), .b(alu_b), .result(alu_temp), .shamt(part2_out_shamt) );

    mux2 #(5) RFMUX( .sel(part2_out_RegDst), .a(part2_out_rt), .b(part2_out_rd), .y(temp_rfile_wn) );
	
    mux2 #(5) R31MUX( .sel(part4_out_R31toReg), .a(part4_out_mux), .b(5'd31), .y(rfile_wn) );
	
	mux2 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(b_tgt), .y(branch_addr) );
	
    mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next) );
	
    mux2 #(32) ALUMUX( .sel(part2_out_ALUSrc), .a(part2_out_rd2), .b(part2_out_extend_immed), .y(alu_b) );

    mux2 #(32) WRMUX( .sel(part4_out_MemtoReg), .a(part4_out_ALUout), .b(part4_out_rd), .y(temp_rfile_wd) );
	
    mux2 #(32) JALMUX( .sel(part4_out_JaltoReg), .a(temp_rfile_wd), .b(Jal_addr), .y(rfile_wd) );
	
	mux3 #(32) ALUORHILOMUX( .sel(ALU_ctl_Sel), .a(alu_temp), .b(HiOut), .c(LoOut), .y(alu_out) );

    control_single CTL( .opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), 
                       .Jump(Jump), .ALUOp(ALUOp), .R31toReg(R31toReg), .JaltoReg(JaltoReg) );

    alu_ctl ALUCTL( .ALUOp(part2_out_ALUOp), .Funct(part2_out_funct), .ALUOperation(Operation), .Multu( Multu ), .Sel( ALU_ctl_Sel ) );
	

	reg_file RegFile( .clk(clk), .RegWrite(part4_out_RegWrite), .RN1(rs), .RN2(rt), .WN(rfile_wn), 
					  .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );

	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr) );

	memory DatMem( .clk(clk), .MemRead(part3_out_MemRead), .MemWrite(part3_out_MemWrite), .wd(part3_out_rfile_rd2), 
				   .addr(part3_out_ALUout), .rd(dmem_rdata) );	   
				   
	MULTU multiplier( .clk(clk), .dataA(part2_out_rd1), .dataB(part2_out_rd2), .dataOut(MulAns), .Multu(Multu), .reset(rst) );
	
	HiLo HiLo( .clk(clk), .MulAns(MulAns), .HiOut(HiOut), .LoOut(LoOut), .reset(rst) );
	
	IF_ID
if_id( .instr(instr), .PC(pc_incr), .rst(rst), .clk(clk), .out_instr(part1_out_instr), .out_PC(part1_out_pc) ) ;

	ID_EX
id_ex( .RegDst(RegDst), .ALUSrc(ALUSrc), .MemWrite(MemWrite), .MemRead(MemRead), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .ALUop(ALUOp), .RD1(rfile_rd1), .RD2(rfile_rd2), .extend_immed(extend_immed), .rt(rt), .rd(rd), .funct(funct), .shamt(shamt), .R31toReg(R31toReg), .JaltoReg(JaltoReg),
    .rst(rst), .clk(clk), .en_reg(1'b1), .out_RegDst(part2_out_RegDst), .out_ALUSrc(part2_out_ALUSrc), .out_MemWrite(part2_out_MemWrite), .out_MemRead(part2_out_MemRead), .out_MemtoReg(part2_out_MemtoReg), .out_RegWrite(part2_out_RegWrite), .out_ALUop(part2_out_ALUOp), .out_RD1(part2_out_rd1), .out_RD2(part2_out_rd2), .out_extend_immed(part2_out_extend_immed), .out_rt(part2_out_rt), .out_rd(part2_out_rd), .out_funct(part2_out_funct), .out_shamt(part2_out_shamt), .out_R31toReg(part2_out_R31toReg), .out_JaltoReg(part2_out_JaltoReg) ) ;

	EX_MEM
ex_mem( .MemWrite(part2_out_MemWrite), .MemRead(part2_out_MemRead), .MemtoReg(part2_out_MemtoReg), .RegWrite(part2_out_RegWrite), .RD2(part2_out_rd2), .alu(alu_out), .mux(temp_rfile_wn), .R31toReg(part2_out_R31toReg), .JaltoReg(part2_out_JaltoReg),
     .rst(rst), .clk(clk), .out_MemWrite(part3_out_MemWrite), .out_MemRead(part3_out_MemRead), .out_MemtoReg(part3_out_MemtoReg), .out_RegWrite(part3_out_RegWrite), .out_RD2(part3_out_rfile_rd2), .out_alu(part3_out_ALUout), .out_mux(part3_out_mux), .out_R31toReg(part3_out_R31toReg), .out_JaltoReg(part3_out_JaltoReg) ) ;

	MEM_WB
mem_wb( .MemtoReg(part3_out_MemtoReg), .RegWrite(part3_out_RegWrite), .alu(part3_out_ALUout), .mux(part3_out_mux), .rd(dmem_rdata), .R31toReg(part3_out_R31toReg), .JaltoReg(part3_out_JaltoReg),
     .rst(rst), .clk(clk), .out_MemtoReg(part4_out_MemtoReg), .out_RegWrite(part4_out_RegWrite), .out_alu(part4_out_ALUout), .out_mux(part4_out_mux), .out_rd(part4_out_rd), .out_R31toReg(part4_out_R31toReg), .out_JaltoReg(part4_out_JaltoReg) ) ;

endmodule


