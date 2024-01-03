// instruction_memory.v
module instruction_memory (
  input wire [7:0] address,
  output reg [15:0] instruction,
  input wire clk,
  input wire reset
);

  // Define the memory array with 256 words (16-bit each)
  reg [15:0] mem [0:255];

  // Always block to handle memory read
  always @(posedge clk or posedge reset) begin
    if (reset)
      instruction <= 16'h0000; // Reset the instruction to zero on reset
    else
      instruction <= mem[address];
  end

  // Initial block to initialize memory with some values (for testing)
  initial begin
    // Initialize memory with sample instructions (you can modify this)
    mem[0] <= 16'h1234;
    mem[1] <= 16'h5678;
    // Add more initializations as needed
  end
endmodule

// tb_instruction_memory.v
module tb_instruction_memory;

  // Inputs
  reg [7:0] address;
  reg clk;
  reg reset;

  // Outputs
  wire [15:0] instruction;

  // Instantiate the instruction memory module
  instruction_memory dut (
    .address(address),
    .clk(clk),
    .reset(reset),
    .instruction(instruction)
  );

  // Clock generation
  always begin
    #5 clk = ~clk; // Toggle clock every 5 time units
  end

  // Initial block to apply reset
  initial begin
    clk = 0;
    reset = 1;
    address = 8'h00;

    // Apply reset
    #10 reset = 0;

    // Test the instruction memory by reading different addresses
    #10 address = 8'h01; // Read from address 1
    #10 address = 8'h02; // Read from address 2
    // Add more test cases as needed

    // Finish simulation after testing
    #10 $finish;
  end
endmodule