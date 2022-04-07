module SLL2( sel, src, dout ) ;

 input sel ;
 input[31:0] src ;
 output[31:0] dout ;
 
 wire[31:0] temp, out ;

 SLL1 sll0( .sel(sel), .src(src),  .dout(temp) ) ;
 SLL1 sll1( .sel(sel), .src(temp),  .dout(out) ) ;
 
 assign dout = out ;

endmodule