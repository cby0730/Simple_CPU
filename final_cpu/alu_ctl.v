/*
	Title:	ALU Control Unit
	Author: Garfield (Computer System and Architecture Lab, ICE, CYCU)
	Input Port
		1. ALUOp: ����alu�O�n��+�٬O-�άO��L���O
		2. Funct: �p�G�O��L���O�h�γo��6�X�P�_
	Output Port
		1. ALUOperation: �̫�ѽX���������O
*/

module alu_ctl( ALUOp, Funct, ALUOperation, Multu, Sel );
    input [1:0] ALUOp;
    input [5:0] Funct;
	output reg Multu;
	output reg [1:0] Sel;
    output [2:0] ALUOperation;
    reg    [2:0] ALUOperation;

    // symbolic constants for instruction function code
    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or  = 6'd37;
    parameter F_slt = 6'd42;
    parameter F_sll = 6'd0;
	parameter F_mul = 6'd25;
    parameter F_mfhi = 6'd10;
    parameter F_mflo = 6'd12;

    // symbolic constants for ALU Operations
    parameter ALU_add = 3'b010;
    parameter ALU_sub = 3'b110;
    parameter ALU_and = 3'b000;
    parameter ALU_or  = 3'b001;
    parameter ALU_slt = 3'b111;
    parameter ALU_sll = 3'b011;

    always @(ALUOp or Funct)
    begin
		if ( Funct != F_mul ) begin
			Sel = 0;
			Multu = 0;
		end
        case (ALUOp) 
            2'b00 : ALUOperation = ALU_add;
            2'b01 : ALUOperation = ALU_sub;
            2'b10 : case (Funct) 
                        F_add : ALUOperation = ALU_add;
                        F_sub : ALUOperation = ALU_sub;
                        F_and : ALUOperation = ALU_and;
                        F_or  : ALUOperation = ALU_or;
                        F_slt : ALUOperation = ALU_slt;
			            F_sll : ALUOperation = ALU_sll ;
						F_mul : begin
								Multu = 1'b1;
								Sel = 2'b10; 
								end
						F_mfhi : Sel = 2'b01;
						F_mflo : Sel = 2'b10;
                        default ALUOperation = 3'bxxx;
                    endcase
            default ALUOperation = 3'bxxx;
        endcase
    end
endmodule

