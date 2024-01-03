
// ALU (Arithmetic and Logic Unit) module
module ALU(
  input logic [31:0] operandA,
  input logic [31:0] operandB,
  input logic [2:0]  opcode,
  output logic [31:0] result,
  output logic zero_flag,
  output logic carry_out
);
  always_comb begin
    case (opcode)
      3'b000: result = operandA + operandB; // Addition
      3'b001: result = operandA - operandB; // Subtraction
      3'b010: result = operandA & operandB; // Bitwise AND
      3'b011: result = operandA | operandB; // Bitwise OR
      3'b100: result = operandA ^ operandB; // Bitwise XOR
      // Add more operations as needed
      default: result = 32'b0; 
// Default case (e.g., for an undefined opcode)
    endcase
    // Zero flag
    zero_flag = (result == 32'b0);

    // Carry out (for addition)
    carry_out = ((opcode == 3'b000) && (result < operandA));
  end
endmodule

// Testbench for ALU module
module ALU_Testbench;

  // Inputs
  logic [31:0] operandA;
  logic [31:0] operandB;
  logic [2:0]  opcode;

  // Outputs
  logic [31:0] result;
  logic zero_flag;
  logic carry_out;

  // Instantiate ALU
  ALU myALU(
    .operandA(operandA),
    .operandB(operandB),
    .opcode(opcode),
    .result(result),
    .zero_flag(zero_flag),
    .carry_out(carry_out)
  );

  // Testbench stimulus
  initial begin
    // Test case 1: Addition
    operandA = 8'h0A;
    operandB = 8'h05;
    opcode   = 3'b000;
    #10; // Wait for 10 time units
    // Add more test cases as needed

    // Test case 2: Subtraction
    operandA = 8'h0A;
    operandB = 8'h05;
    opcode   = 3'b001;
    #10;

    // Add more test cases as needed

    // Terminate simulation
    $finish;
  end

endmodule