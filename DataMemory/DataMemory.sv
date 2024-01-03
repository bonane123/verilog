
module DataMemory (
  input logic [7:0] address,
  input logic [31:0] write_data,
  input logic write_enable,
  output logic [31:0] read_data
);
  // Define the memory array with 256 words (32-bit each)
  logic [31:0] mem [0:255];

  // Read operation
  assign read_data = mem[address];

  // Write operation
  always_ff @(posedge write_enable) begin
    if (write_enable)
      mem[address] <= write_data;
  end
endmodule


`timescale 1ns / 1ps

module DataMemory_tb;

  // Inputs
  logic [7:0] address;
  logic [31:0] write_data;
  logic write_enable;

  // Outputs
  logic [31:0] read_data;

  // Instantiate DataMemory module
  DataMemory myDMEM (
    .address(address),
    .write_data(write_data),
    .write_enable(write_enable),
    .read_data(read_data)
  );

  // Testbench stimulus
  initial begin
    // Test case 1: Write data to memory
    address = 8'h0A;
    write_data = 32'hABCDEFF0;
    write_enable = 1;
    #10; // Wait for 10 time units

    // Test case 2: Read data from memory
    address = 8'h0A;
    write_enable = 0;
    #10;

    // Terminate simulation
    $finish;
  end

endmodule