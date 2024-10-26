// 16-bit signed ALU module
module signed_16_bit_alu (
    input signed [15:0] A,             // 16-bit signed input A
    input signed [15:0] B,             // 16-bit signed input B
    input clk,                         // Clock input for synchronous operations
    input [3:0] ALU_FUN,               // 4-bit control signal to select ALU operation
    output reg signed [15:0] ALU_OUT,  // 16-bit signed output for ALU result
    output reg Carry_flag,             // Flag to indicate carry in arithmetic operations
    output reg Arith_flag,             // Flag to indicate arithmetic operation
    output reg Logic_flag,             // Flag to indicate logical operation
    output reg CMP_flag,               // Flag to indicate comparison operation
    output reg Shift_flag              // Flag to indicate shift operation
);

    reg signed [15:0] ALU_Result;      // Internal register to hold intermediate ALU results

    // Combinational logic block to compute ALU operations based on ALU_FUN signal
    always @(*) begin
        // Initialize all outputs to zero to prevent latching
        ALU_Result = 0;
        Carry_flag = 0;
        Arith_flag = 0;
        Logic_flag = 0;
        CMP_flag = 0;
        Shift_flag = 0;

        // Select ALU operation based on the value of ALU_FUN
        case (ALU_FUN)
            // Addition operation with carry flag
            4'b0000: begin
                {Carry_flag, ALU_Result} = A + B;
                Arith_flag = 1;
            end
            // Subtraction operation with carry flag
            4'b0001: begin
                {Carry_flag, ALU_Result} = A - B;
                Arith_flag = 1;
            end
            // Multiplication operation
            4'b0010: begin
                ALU_Result = A * B;
                Arith_flag = 1;
            end
            // Division operation
            4'b0011: begin
                ALU_Result = A / B;
                Arith_flag = 1;
            end
            // Bitwise AND operation
            4'b0100: begin
                ALU_Result = A & B;
                Logic_flag = 1;
            end
            // Bitwise OR operation
            4'b0101: begin
                ALU_Result = A | B;
                Logic_flag = 1;
            end
            // Bitwise NAND operation 
            4'b0110: begin
                ALU_Result = ~(A & B);
                Logic_flag = 1;
            end
            // Bitwise NOR operation 
            4'b0111: begin
                ALU_Result = ~(A | B);
                Logic_flag = 1;
            end
            // Bitwise XOR operation
            4'b1000: begin
                ALU_Result = A ^ B;
                Logic_flag = 1;
            end
            // Bitwise XNOR operation 
            4'b1001: begin
                ALU_Result = ~(A ^ B);
                Logic_flag = 1;
            end
            // Comparison for equality (A == B) 
            4'b1010: begin
                if (A == B)
                    ALU_Result = 16'd1;
                else
                    ALU_Result = 16'd0;
                CMP_flag = 1;
            end
            // Comparison for greater than (A > B) 
            4'b1011: begin
                if (A > B)
                    ALU_Result = 16'd2;
                else
                    ALU_Result = 16'd0;
                CMP_flag = 1;
            end
            // Comparison for less than (A < B) 
            4'b1100: begin
                if (A < B)
                    ALU_Result = 16'd3;
                else
                    ALU_Result = 16'd0;
                CMP_flag = 1;
            end
            // Arithmetic right shift operation 
            4'b1101: begin
                ALU_Result = A >>> 1; // Arithmetic right shift 
                Shift_flag = 1;
            end
            // Arithmetic left shift operation 
            4'b1110: begin
                ALU_Result = A <<< 1; // Arithmetic left shift 
                Shift_flag = 1;
            end
            // Default case to set ALU result to zero
            default: ALU_Result = 16'd0;
        endcase
    end

    // Sequential block to update ALU_OUT on the rising edge of the clock
    always @(posedge clk) begin
        ALU_OUT <= ALU_Result; // Update output with the computed result
    end

endmodule
