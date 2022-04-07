module ID_EX( RegDst, ALUSrc, MemWrite, MemRead, MemtoReg, RegWrite, ALUop, RD1, RD2, extend_immed, rt, rd, operation, funct, shamt, R31toReg, JaltoReg, rst, clk, en_reg, out_RegDst, out_ALUSrc, out_MemWrite, out_MemRead, out_MemtoReg, out_RegWrite, out_ALUop, out_RD1, out_RD2, out_extend_immed, out_rt, out_rd, out_funct, out_shamt, out_R31toReg, out_JaltoReg ) ;
  
  input rst, clk, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, en_reg, R31toReg, JaltoReg ;
  input [1:0] ALUop ;
  input [2:0] operation ;
  input [4:0] rt, rd, shamt ;
  input [5:0] funct ;
  input [31:0] PC, RD1, RD2, extend_immed ;

  output reg out_RegDst, out_ALUSrc, out_MemtoReg, out_RegWrite, out_MemRead, out_MemWrite, out_R31toReg, out_JaltoReg ;
  output reg [1:0] out_ALUop ;
  output reg [4:0] out_rt, out_rd, out_shamt ;
  output reg [5:0] out_funct ;
  output reg [31:0] out_RD1, out_RD2, out_extend_immed ;
  
  always @ ( posedge clk ) begin
    if ( rst ) begin

    out_RegDst <= 1'b0 ;
    out_ALUSrc <= 1'b0 ;
    out_MemWrite <= 1'b0 ;
    out_MemRead <= 1'b0 ;
    out_MemtoReg <= 1'b0 ;
    out_RegWrite <= 1'b0 ;
    out_ALUop <= 2'b0 ;
    out_RD1 <= 32'b0 ;
    out_RD2 <= 32'b0 ;
    out_extend_immed <= 32'b0 ;
    out_rt <= 5'b0 ;
    out_rd <= 5'b0 ;
    out_funct <= 6'b0 ;
    out_shamt <= 0 ;
    out_R31toReg <= 0 ;
    out_JaltoReg <= 0 ;

    end

    else if ( en_reg )  begin

    out_RegDst <= RegDst ;
    out_ALUSrc <= ALUSrc ;
    out_MemWrite <= MemWrite ;
    out_MemRead <= MemRead ;
    out_MemtoReg <= MemtoReg ;
    out_RegWrite <= RegWrite ;
    out_ALUop <= ALUop ;
    out_RD1 <= RD1 ;
    out_RD2 <= RD2 ;
    out_extend_immed <= extend_immed ;
    out_rt <= rt ;
    out_rd <= rd ;
    out_funct <= funct ;
    out_shamt <= shamt ;
    out_shamt <= 0 ;
    out_R31toReg <= R31toReg ;
    out_JaltoReg <= JaltoReg ;

    end
    
  end
  
endmodule