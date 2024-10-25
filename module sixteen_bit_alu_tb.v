`timescale 1ns / 1ps
module sixteen_bit_alu_tb; 
reg [15:0] A;
   reg [15:0] B;
   reg clk;
   reg [3:0] ALU_FUN;
   wire [15:0] ALU_OUT;
   wire Carry_flag;
   wire Arith_flag;
   wire Logic_flag;
   wire CMP_flag;
   wire Shift_flag; 

   sixteen_bit_alu DUT 
   (

        .A(A), 
        .B(B), 
        .clk(clk), 
        .ALU_FUN(ALU_FUN), 
        .ALU_OUT(ALU_OUT), 
        .Carry_flag(Carry_flag), 
        .Arith_flag(Arith_flag), 
        .Logic_flag(Logic_flag), 
        .CMP_flag(CMP_flag), 
        .Shift_flag(Shift_flag)

   );
   initial clk = 0;
   always #5000 clk = ~clk;
   initial 
   begin  
   A = 16'h0015; B = 16'h0025; ALU_FUN = 4'b0000; 
   #10000; 
   $display("Addition: ALU_OUT = %b, Carry = %b, Arith = %b", ALU_OUT, Carry_flag, Arith_flag); 
   A = 16'h0004; B = 16'h0003; ALU_FUN = 4'b0010; 
   #10000;
   $display("Multiplication: ALU_OUT = %b, Carry = %b, Arith = %b", ALU_OUT, Carry_flag, Arith_flag);
   A = 16'h0010; B = 16'h0004; ALU_FUN = 4'b0011; 
   #10000;
   $display("Division: ALU_OUT = %b, Carry = %b, Arith = %b", ALU_OUT, Carry_flag, Arith_flag);
   A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b0100; 
   #10000;
   $display("AND: ALU_OUT = %b, Logic = %b", ALU_OUT, Logic_flag);
   A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b0101; 
   #10000;
   $display("OR: ALU_OUT = %b, Logic = %b", ALU_OUT, Logic_flag);
   A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b0110; 
   #10000;
   $display("NAND: ALU_OUT = %b, Logic = %b", ALU_OUT, Logic_flag);
   A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b0111; 
   #10000;
   $display("NOR: ALU_OUT = %b, Logic = %b", ALU_OUT, Logic_flag);
   A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b1000; 
   #10000;
   $display("XOR: ALU_OUT = %b, Logic = %b", ALU_OUT, Logic_flag);
   A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b1001; 
   #10000;
   $display("XNOR: ALU_OUT = %b, Logic = %b", ALU_OUT, Logic_flag);
   A = 16'h00FF; B = 16'h00FF; ALU_FUN = 4'b1010; 
   #10000;
   $display("Equal: ALU_OUT = %b, CMP = %b", ALU_OUT, CMP_flag);
   A = 16'h0100; B = 16'h00FF; ALU_FUN = 4'b1011; 
   #10000;
   $display("Greater: ALU_OUT = %b, CMP = %b", ALU_OUT, CMP_flag);
   A = 16'h00FF; B = 16'h0100; ALU_FUN = 4'b1100; 
   #10000;
   $display("Less: ALU_OUT = %b, CMP = %b", ALU_OUT, CMP_flag);
   A = 16'h00FF; ALU_FUN = 4'b1101; 
   #10000;
   $display("Shift Right: ALU_OUT = %b, Shift = %b", ALU_OUT, Shift_flag);
   A = 16'h00FF; ALU_FUN = 4'b1110; 
   #10000;
   $display("Shift Left: ALU_OUT = %b, Shift = %b", ALU_OUT, Shift_flag);
   A = 16'h0000; B = 16'h0000; ALU_FUN = 4'b1111; 
   #10000;
   $display("no operation: ALU_OUT = %b", ALU_OUT);
   $stop;
   end
   endmodule 



