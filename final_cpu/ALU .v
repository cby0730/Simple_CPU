`timescale 1ns/1ns
module ALU( ctl, a, b, result, shamt );

input [31:0] a ;
input [31:0] b ;
input [2:0] ctl ;
input [4:0] shamt ;
output [31:0] result ;

parameter AND = 3'b000;
parameter OR  = 3'b001;
parameter ADD = 3'b010;
parameter SUB = 3'b110;
parameter SLT = 3'b111;
parameter SLL = 3'b011 ;

wire [31:0] temp, sll_temp ;
wire [7:0] c ;
wire isinvert ;

assign isinvert = ( ctl == SLT ) ? 1 : ( ctl == SUB ) ? 1 : 0 ;

ALU4 alu0( .dataA(a[3:0]), .dataB(b[3:0]), . Signal(ctl[2:0]), . dataOut(temp[3:0]), . cout(c[0]), .cin(isinvert) ) ;

ALU4 alu1( .dataA(a[7:4]), .dataB(b[7:4]), . Signal(ctl[2:0]), . dataOut(temp[7:4]), . cout(c[1]), .cin(c[0]) ) ;

ALU4 alu2( .dataA(a[11:8]), .dataB(b[11:8]), . Signal(ctl[2:0]), . dataOut(temp[11:8]), . cout(c[2]), .cin(c[1]) ) ;

ALU4 alu3( .dataA(a[15:12]), .dataB(b[15:12]), . Signal(ctl[2:0]), . dataOut(temp[15:12]), . cout(c[3]), .cin(c[2]) ) ;

ALU4 alu4( .dataA(a[19:16]), .dataB(b[19:16]), . Signal(ctl[2:0]), . dataOut(temp[19:16]), . cout(c[4]), .cin(c[3]) ) ;

ALU4 alu5( .dataA(a[23:20]), .dataB(b[23:20]), . Signal(ctl[2:0]), . dataOut(temp[23:20]), . cout(c[5]), .cin(c[4]) ) ;

ALU4 alu6( .dataA(a[27:24]), .dataB(b[27:24]), . Signal(ctl[2:0]), . dataOut(temp[27:24]), . cout(c[6]), .cin(c[5]) ) ;

ALU4 alu7( .dataA(a[31:28]), .dataB(b[31:28]), . Signal(ctl[2:0]), . dataOut(temp[31:28]), . cout(c[7]), .cin(c[6]) ) ;

Shifter shifter( .dataA(b), .dataB(shamt), .dataOut(sll_temp) ) ;

assign result = ( ctl == SLT ) ? temp[31] : ( ctl == SLL ) ? sll_temp : temp ;

endmodule