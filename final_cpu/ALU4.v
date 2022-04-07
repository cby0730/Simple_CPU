`timescale 1ns/1ns
module ALU4( dataA, dataB, Signal, dataOut, cout, cin );
input [3:0] dataA ;
input [3:0] dataB ;
input [2:0] Signal ;
input cin ;
output [3:0] dataOut ;
output cout ;

wire [3:0] result ;
wire [2:0] c ;

ALU1 alu0( . dataA(dataA[0]), . dataB(dataB[0]), .Signal(Signal[2:0]), . dataOut(result[0]), . cout(c[0]), .cin(cin) ) ;

ALU1 alu1( . dataA(dataA[1]), . dataB(dataB[1]), .Signal(Signal[2:0]), . dataOut(result[1]), . cout(c[1]), .cin(c[0] ) ) ;

ALU1 alu2( . dataA(dataA[2]), . dataB(dataB[2]), .Signal(Signal[2:0]), . dataOut(result[2]), . cout(c[2]), .cin(c[1] ) ) ;

ALU1 alu3( . dataA(dataA[3]), . dataB(dataB[3]), .Signal(Signal[2:0]), . dataOut(result[3]), . cout(cout), .cin(c[2]) ) ;

assign dataOut = result ;

endmodule