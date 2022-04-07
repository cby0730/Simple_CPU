module SLL1( sel, src, dout ) ;

 input sel ;
 input[31:0] src ;
 output [31:0] dout ;
 
 wire [31:0] out ;

 assign out[31] = src[30] ; assign out[30] = src[29] ; assign out[29] = src[28] ; assign out[28] = src[27] ; assign out[27] = src[26] ;
 assign out[26] = src[25] ; assign out[25] = src[24] ; assign out[24] = src[23] ; assign out[23] = src[22] ; assign out[22] = src[21] ;
 assign out[21] = src[20] ; assign out[20] = src[19] ; assign out[19] = src[18] ; assign out[18] = src[17] ; assign out[17] = src[16] ;
 assign out[16] = src[15] ; assign out[15] = src[14] ; assign out[14] = src[13] ; assign out[13] = src[12] ; assign out[12] = src[11] ;
 assign out[11] = src[10] ; assign out[10] = src[9] ; assign out[9] = src[8] ; assign out[8] = src[7] ; assign out[7] = src[6] ;
 assign out[6] = src[5] ; assign out[5] = src[4] ; assign out[4] = src[3] ; assign out[3] = src[2] ; assign out[2] = src[1] ;
 assign out[1] = src[0] ; assign out[0] = 1'b0 ;
 
 assign dout = (sel == 1'b1) ? out : src ;

endmodule