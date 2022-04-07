module SLL8( sel, src, dout ) ;

 input sel ;
 input[31:0] src ;
 output[31:0] dout ;
 
 wire[31:0] temp , out ;
 
 SLL4 sll0( .sel(sel), .src(src),  .dout(temp) ) ;
 SLL4 sll1( .sel(sel), .src(temp),  .dout(out) ) ;

 assign dout = out ;
 
endmodule