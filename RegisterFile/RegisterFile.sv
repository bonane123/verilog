module RegisterFile (
  input wire [2:0] read_register1,
  input wire [2:0] read_register2,
  input wire [2:0] write_register,
  input wire write_enable,
  input wire [15:0] write_data,
  output reg [15:0] read_data1,
  output reg [15:0] read_data2
);

  // Define an array of 8 registers
  reg [15:0] registers [0:7];

  // Read data outputs
  assign read_data1 = registers[read_register1];
  assign read_data2 = registers[read_register2];

  // Write data logic
  always @(posedge write_enable) begin
    if (write_enable)
      registers[write_register] <= write_data;
    else
      registers[write_register] <= registers[write_register]; // No write if write_enable is not active
  end

endmodule


`timescale 1ns / 1ps

module RegisterFile_tb;

  // Inputs
  reg [2:0] read_register1, read_register2, write_register;
  reg write_enable;
  reg [15:0] write_data;

  // Outputs
  wire [15:0] read_data1, read_data2;

  // Instantiate the register file module
  RegisterFile dut (
    .read_register1(read_register1),
    .read_register2(read_register2),
    .write_register(write_register),
    .write_enable(write_enable),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
  );

  // Clock generation
  reg clk = 0;
  always #5 clk =~clk;

  // Initial block to apply inputs and observe outputs
  initial begin
    read_register1 = 3'b000; // Read from register 0
    read_register2 = 3'b001; // Read from register 1
    write_register = 3'b010; // Write to register 2
    write_enable = 1;
    write_data = 16'h1234;

    // Apply inputs
    #10 write_enable = 0;         // Disable write
    #10 read_register1 = 3'b011; // Read from register 3
    #10 read_register2 = 3'b010; // Read from register 2

    // Finish simulation after testing
    #10 $finish;
  end
endmodule
