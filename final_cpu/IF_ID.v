module IF_ID( instr, PC, rst, clk, out_instr, out_PC ) ;
  
  input clk, rst ;
  input [31:0] instr, PC ;
  output reg[31:0] out_instr, out_PC ;
  
  always @ ( posedge clk ) begin
    if( rst ) begin    

    out_instr <= 32'b0 ;
    out_PC <= 32'b0 ;

    end

    else begin

    out_instr <= instr ;
    out_PC <= PC ;

    end
    
  end
  
endmodule