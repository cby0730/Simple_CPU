module MEM_WB( MemtoReg, RegWrite, alu, mux, rd, R31toReg, JaltoReg, rst, clk, out_MemtoReg, out_RegWrite, out_alu, out_mux, out_rd, out_R31toReg, out_JaltoReg ) ;
  
  input clk, RegWrite, MemtoReg, rst, R31toReg, JaltoReg ; 
  input [4:0] mux ; 
  input [31:0] alu, rd;

  output reg out_MemtoReg, out_RegWrite, out_R31toReg, out_JaltoReg ;
  output reg [4:0] out_mux ;
  output reg [31:0] out_alu, out_rd;
  
  always @ ( posedge clk ) begin
	if(rst)begin

    out_MemtoReg <= 1'b0 ;
    out_RegWrite <= 1'b0 ;
    out_alu <= 32'b0 ;
    out_mux <= 5'b0 ;
    out_rd <= 32'b0 ;
    out_R31toReg <= 1'b0 ;
    out_JaltoReg <= 1'b0 ;
	
	end
	
	else begin 
	
    out_MemtoReg <= MemtoReg ;
    out_RegWrite <= RegWrite ;
    out_alu <= alu ;
    out_mux <= mux ;
    out_rd <= rd ;
    out_R31toReg <= R31toReg ;
    out_JaltoReg <= JaltoReg ;
    
	end
  end
  
endmodule