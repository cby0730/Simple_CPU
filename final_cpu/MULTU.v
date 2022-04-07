module MULTU( clk, dataA, dataB, dataOut, Multu, reset );
  input clk;
  input reset;
  input Multu;
  input [31:0] dataA;
  input [31:0] dataB;
  output [63:0] dataOut;

  reg [63:0] temp;
  reg [31:0] mcnd;
  
  parameter MULTU = 6'd25;

  always@( posedge clk or reset or Multu ) begin
    if ( reset )
		temp = 64'b0 ;
	else
	begin
		if ( Multu ) begin
			temp = dataB;
			mcnd = dataA;
			
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd; // 1
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd; // 5
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd; // 10
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd; // 15
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd; // 20
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd; //25
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd; // 30
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd;
			end
			temp = temp >> 1;
			if ( temp[0] == 1'b1 ) begin
				temp[63:32] = temp[63:32] + mcnd; // 32
			end
			temp = temp >> 1;


		end
    end
  end
  assign 	dataOut = temp;
endmodule

