//-----------------------------------------------------------------------------
// Title         : ALU Behavioral Model
//-----------------------------------------------------------------------------

module add32(a, b, result);
  input [31:0] a, b;
  output [31:0] result;

  assign result = a + b;
endmodule

