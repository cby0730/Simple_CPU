/*
	Title: MIPS Single Cycle CPU Testbench
	Author: Selene (Computer System and Architecture Lab, ICE, CYCU) 
*/
module tb_Pipeline();
	reg clk, rst;
	
	// �]�w�n����h��cycle �Y���椣���Цۦ�վ�
	parameter cycle_count = 16;
	
	// ���ͮɯߡA�g���G10���ɶ�
	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		$dumpfile("mips_Pipeline.vcd");
		$dumpvars(0,tb_Pipeline);
		rst = 1'b1;
		/*
			���O��ưO����A�ɦW"instr_mem.txt, data_mem.txt"�i�ۦ�ק�
			�C�@�欰1 Byte��ơA�H��ӤQ���i��Ʀr����
			�B��Little Endian�s�X
		*/
		$readmemh("instr_mem.txt", CPU.InstrMem.mem_array );
		$readmemh("data_mem.txt", CPU.DatMem.mem_array );
		// �]�w�Ȧs����l�ȡA�C�@�欰�@���Ȧs�����
		$readmemh("reg.txt", CPU.RegFile.file_array );
		#10;
		rst = 1'b0;
		
	end
	
	initial begin
		// �@��cycle 10���ɶ�
		# (cycle_count*10);
		$display( "%d, End of Simulation\n", $time/10-1 );
		$finish;
	end
	
	always @( posedge clk ) begin
		$display( "%d, PC:", $time/10-1, CPU.pc );
		if ( CPU.opcode == 6'd0 ) begin
			$display( "%d, wd: %d", $time/10-1, CPU.rfile_wd );
			if ( CPU.funct == 6'd32 ) $display( "%d, ADD\n", $time/10-1 );
			else if ( CPU.funct == 6'd34 ) $display( "%d, SUB\n", $time/10-1 );
			else if ( CPU.funct == 6'd36 ) $display( "%d, AND\n", $time/10-1 );
			else if ( CPU.funct == 6'd37 ) $display( "%d, OR\n", $time/10-1 );
			else if ( CPU.funct == 6'd25 ) $display( "%d, MULTU\n", $time/10-1 );
			else if ( CPU.funct == 6'd10 ) $display( "%d, MFHI\n", $time/10-1 );
			else if ( CPU.funct == 6'd12 ) $display( "%d, MFLO\n", $time/10-1 );
			else if ( CPU.funct == 6'd42 ) $display( "%d, SLT\n", $time/10-1 );
			else if ( CPU.funct == 6'd0 ) begin
				if ( CPU.rs == 5'd0 && CPU.rt == 5'd0 && CPU.rd == 5'd0 && CPU.shamt == 5'd0 )
					$display( "%d, NOP\n", $time/10-1 );
				else
					$display( "%d, SLL\n", $time/10-1 );
			end
		end
		else if ( CPU.opcode == 6'd9 ) $display( "%d, ADDIU\n", $time/10-1 ) ;
		else if ( CPU.opcode == 6'd35 ) $display( "%d, LW\n", $time/10-1 );
		else if ( CPU.opcode == 6'd43 ) $display( "%d, SW\n", $time/10-1 );
		else if ( CPU.opcode == 6'd4 ) $display( "%d, BEQ\n", $time/10-1 );
		else if ( CPU.opcode == 6'd2 ) $display( "%d, J\n", $time/10-1 );
		else if ( CPU.opcode == 6'd3 ) $display( "%d, JAL\n", $time/10-1 );

	end
	
	mips_Pipeline CPU( clk, rst );
	
endmodule
