`timescale 1ns/1ns
module FA( augend, addend, carryout, cout, sum ) ;

 input augend, addend, carryout ;
 output cout, sum ;
 wire temp1, temp2, temp3 ;

 xor( temp1, augend, addend ) ;
 and( temp2, augend, addend ) ;
 and( temp3, temp1, carryout ) ;
 or( cout, temp2, temp3 ) ;
 xor( sum, temp1, carryout ) ;
 
endmodule