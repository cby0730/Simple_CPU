//-----------------------------------------------------------------------------
// Title         : 2-1 multiplexer
//-----------------------------------------------------------------------------

module mux2( sel, a, b, y );
    parameter bitwidth=32;
    input sel;
    input  [bitwidth-1:0] a, b;
    output [bitwidth-1:0] y;

    assign y = sel ? b : a;
endmodule
