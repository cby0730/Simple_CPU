module EX_MEM( MemWrite, MemRead, MemtoReg, RegWrite, RD2, alu, mux, R31toReg, JaltoReg, clk, out_MemWrite, out_MemRead, out_MemtoReg, out_RegWrite, out_RD2, out_alu, out_mux, rst, out_R31toReg, out_JaltoReg ) ;
  
  input clk, rst, MemtoReg, RegWrite, MemRead, MemWrite, R31toReg, JaltoReg ; 
  input [4:0] mux ; 
  input [31:0] RD2, alu ;

  output reg out_MemtoReg, out_RegWrite, out_MemRead, out_MemWrite, out_R31toReg, out_JaltoReg ;
  output reg [4:0] out_mux ;
  output reg [31:0] out_RD1, out_RD2, out_alu ;
  
  always @ ( posedge clk ) begin
	if ( rst ) begin
		out_MemWrite <= 1'b0 ;
		out_MemRead <= 1'b0 ;
		out_MemtoReg <= 1'b0 ;
		out_RegWrite <= 1'b0 ;
		out_RD2 <= 32'b0 ;
		out_alu <= 32'b0 ;
		out_mux <= 5'b0 ;
		out_R31toReg <= 1'b0 ;
		out_JaltoReg <= 1'b0 ;
	end
	else begin
		out_MemWrite <= MemWrite ;
		out_MemRead <= MemRead ;
		out_MemtoReg <= MemtoReg ;
		out_RegWrite <= RegWrite ;
		out_RD2 <= RD2 ;
		out_alu <= alu ;
		out_mux <= mux ;
		out_R31toReg <= R31toReg ; 
		out_JaltoReg <= JaltoReg ;
	end
    
  end
  
endmodule