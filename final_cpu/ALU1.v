`timescale 1ns/1ns
module ALU1( dataA, dataB, Signal, dataOut, cout, cin );
input dataA ;
input dataB ;
input [2:0] Signal ;
input cin ;
output dataOut ;
output cout ;

wire invert, addend, And, Or, Add ;

parameter AND = 3'b000;
parameter OR  = 3'b001;
parameter ADD = 3'b010;
parameter SUB = 3'b110;
parameter SLT = 3'b111;

assign invert = ( Signal == ADD ) ? 0 : 1 ;
assign addend = dataB ^ invert ;

assign And = dataA & dataB ;
assign Or = dataA | dataB ;
FA fa0 ( .augend(dataA), .addend(addend), .carryout(cin), .cout(cout), .sum(Add) ) ;


assign dataOut = ( Signal == AND ) ? And : ( Signal == OR ) ? Or : Add  ;

endmodule