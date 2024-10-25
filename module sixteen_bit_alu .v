module sixteen_bit_alu 
(

   input [15:0] A, 
   input [15:0] B,
   input clk, 
   input [3:0] ALU_FUN,
   output reg [15:0] ALU_OUT,
   output reg Carry_flag,
   output reg Arith_flag,
   output reg Logic_flag,
   output reg CMP_flag,
   output reg Shift_flag
 
); 
reg [15:0] ALU_Result ;
always @(*) 
begin
ALU_Result=0;
Carry_flag=0;
Arith_flag=0;
Logic_flag=0;
CMP_flag=0;
Shift_flag=0;

case (ALU_FUN) 
4'b0000: begin {Carry_flag,ALU_Result} =A+B; 
Arith_flag=1; 
 end
4'b0001: begin {Carry_flag,ALU_Result} =A-B; 
Arith_flag=1;
end 
 
4'b0010: begin{Carry_flag,ALU_Result} =A*B; 
Arith_flag=1;
end 
 
4'b0011:begin {Carry_flag,ALU_Result} =A/B; 
Arith_flag=1;
end 
 
4'b0100: begin ALU_Result =A&B; 
Logic_flag=1;
end 
 
4'b0101: begin ALU_Result =A|B; 
Logic_flag=1;
end 
 
4'b0110: begin ALU_Result =~(A&B); 
Logic_flag=1;
end 
 
4'b0111 : begin ALU_Result =~(A|B); 
Logic_flag=1;
end 
 
4'b1000: begin ALU_Result =A^B; 
Logic_flag=1;
end 
 
4'b1001 : begin ALU_Result =~(A^B); 
Logic_flag=1;
end 
 
4'b1010 : begin ALU_Result =(A==B)? 16'd1:16'd0; 
CMP_flag=1;
end 
 
 
4'b1011 : begin ALU_Result =(A>B)? 16'd2:16'd0; 
CMP_flag=1;
end 
 
4'b1100 : begin ALU_Result =(A<B)? 16'd3:16'd0; 
CMP_flag=1;
end 
 
4'b1101  : begin ALU_Result =A >> 1 ;
Shift_flag=1;
end 
4'b1110  : begin ALU_Result =A << 1 ;
Shift_flag=1;
end 
default : ALU_Result=16'd0;
endcase 
end 
always @(posedge clk) 
begin
ALU_OUT<=ALU_Result;
end 
endmodule