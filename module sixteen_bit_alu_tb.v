`timescale 1us / 1ps

module signed_16_bit_alu_tb;

   // Declare 16-bit signed inputs A and B
   reg signed [15:0] A;
   reg signed [15:0] B;
   // Clock signal
   reg clk;
   // ALU function selector        
   reg [3:0] ALU_FUN;
   // 16-bit signed output from ALU
   wire signed [15:0] ALU_OUT;
   // Flags for different ALU operations
   wire Carry_flag;      // Carry flag for arithmetic operations
   wire Arith_flag;      // Arithmetic operation flag
   wire Logic_flag;      // Logic operation flag
   wire CMP_flag;        // Comparison operation flag
   wire Shift_flag;      // Shift operation flag

   // Instantiate the ALU module, mapping ports to the testbench signals
   signed_16_bit_alu DUT (
      .A(A),             // Connect A to ALU module input
      .B(B),             // Connect B to ALU module input
      .clk(clk),         // Connect clock signal
      .ALU_FUN(ALU_FUN), // Connect ALU function selector
      .ALU_OUT(ALU_OUT), // ALU output
      .Carry_flag(Carry_flag), // Carry flag output
      .Arith_flag(Arith_flag), // Arithmetic flag output
      .Logic_flag(Logic_flag), // Logic flag output
      .CMP_flag(CMP_flag),     // Comparison flag output
      .Shift_flag(Shift_flag)  // Shift flag output
   );

   // Clock generation with a period of 10 microseconds (5 us high, 5 us low)
   initial clk = 0;
   always #5 clk = ~clk;

   // Define test sequences with 10-microsecond delay between each test case
   initial begin
      // Test addition operation
      A = 16'h0015; B = 16'h0025; ALU_FUN = 4'b0000;
      #10;
      $display("Addition: ALU_OUT = %d, Carry = %b, Arith = %b", ALU_OUT, Carry_flag, Arith_flag);

      // Test multiplication operation
      A = 16'h0004; B = 16'h0003; ALU_FUN = 4'b0010;
      #10;
      $display("Multiplication: ALU_OUT = %d, Carry = %b, Arith = %b", ALU_OUT, Carry_flag, Arith_flag);

      // Test division operation
      A = 16'h0010; B = 16'h0004; ALU_FUN = 4'b0011;
      #10;
      $display("Division: ALU_OUT = %d, Carry = %b, Arith = %b", ALU_OUT, Carry_flag, Arith_flag);

      // Test AND operation
      A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b0100;
      #10;
      $display("AND: ALU_OUT = %h, Logic = %b", ALU_OUT, Logic_flag);

      // Test OR operation
      A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b0101;
      #10;
      $display("OR: ALU_OUT = %h, Logic = %b", ALU_OUT, Logic_flag);

      // Test NAND operation
      A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b0110;
      #10;
      $display("NAND: ALU_OUT = %h, Logic = %b", ALU_OUT, Logic_flag);

      // Test NOR operation
      A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b0111;
      #10;
      $display("NOR: ALU_OUT = %h, Logic = %b", ALU_OUT, Logic_flag);

      // Test XOR operation
      A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b1000;
      #10;
      $display("XOR: ALU_OUT = %h, Logic = %b", ALU_OUT, Logic_flag);

      // Test XNOR operation
      A = 16'h00FF; B = 16'h0F0F; ALU_FUN = 4'b1001;
      #10;
      $display("XNOR: ALU_OUT = %h, Logic = %b", ALU_OUT, Logic_flag);

      // Test equality comparison
      A = 16'h00FF; B = 16'h00FF; ALU_FUN = 4'b1010;
      #10;
      $display("Equal: ALU_OUT = %d, CMP = %b", ALU_OUT, CMP_flag);

      // Test greater than comparison
      A = 16'h0100; B = 16'h00FF; ALU_FUN = 4'b1011;
      #10;
      $display("Greater: ALU_OUT = %d, CMP = %b", ALU_OUT, CMP_flag);

      // Test less than comparison
      A = 16'h00FF; B = 16'h0100; ALU_FUN = 4'b1100;
      #10;
      $display("Less: ALU_OUT = %d, CMP = %b", ALU_OUT, CMP_flag);

      // Test shift right operation
      A = 16'h00FF; ALU_FUN = 4'b1101;
      #10;
      $display("Shift Right: ALU_OUT = %h, Shift = %b", ALU_OUT, Shift_flag);

      // Test shift left operation
      A = 16'h00FF; ALU_FUN = 4'b1110;
      #10;
      $display("Shift Left: ALU_OUT = %h, Shift = %b", ALU_OUT, Shift_flag);

      // Test no operation
      A = 16'h0000; B = 16'h0000; ALU_FUN = 4'b1111;
      #10;
      $display("No operation: ALU_OUT = %h", ALU_OUT);

      // End of simulation
      $stop;
   end

endmodule

