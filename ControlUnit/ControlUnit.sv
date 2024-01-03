module ControlUnit (
  input logic [5:0] opcode,
  output logic [2:0] alu_op,
  output logic reg_write,
  output logic mem_read,
  output logic mem_write,
  output logic reg_dst
);

  always_comb begin
    // Default values
    alu_op = 3'b000;
    reg_write = 0;
    mem_read = 0;
    mem_write = 0;
    reg_dst = 0;

    // Decode opcode to determine control signals
    case (opcode)
      6'h00: begin // ADD
        alu_op <= 3'b000;
        reg_write <= 1;
        mem_read <= 0;
        mem_write <= 0;
        reg_dst <= 1;
      end
      6'h01: begin // SUB
        alu_op <= 3'b001;
        reg_write <= 1;
        mem_read <= 0;
        mem_write <= 0;
        reg_dst <= 1;
      end
      6'h02: begin // AND
        alu_op <= 3'b010;
        reg_write <= 1;
        mem_read <= 0;
        mem_write <= 0;
        reg_dst <= 1;
      end
      6'h03: begin // OR
        alu_op <= 3'b011;
        reg_write <= 1;
        mem_read <= 0;
        mem_write <= 0;
        reg_dst <= 1;
      end
      // Add more cases for other instructions
      default: begin // Handle undefined opcode
        // Default values remain unchanged
      end
    endcase
  end
endmodule


`timescale 1ns / 1ps

module ControlUnit_tb;

  // Inputs
  logic [5:0] opcode;

  // Outputs
  logic [2:0] alu_op;
  logic reg_write;
  logic mem_read;
  logic mem_write;
  logic reg_dst;

  // Instantiate ControlUnit module
  ControlUnit myControlUnit (
    .opcode(opcode),
    .alu_op(alu_op),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .reg_dst(reg_dst)
  );

  // Testbench stimulus
  initial begin
    // Test case 1: ADD instruction
    opcode = 6'h00;
    #10;

    // Test case 2: SUB instruction
    opcode = 6'h01;
    #10;

    // Test case 3: AND instruction
    opcode = 6'h02;
    #10;

    // Test case 4: OR instruction
    opcode = 6'h03;
    #10;

    // Add more test cases for other instructions

    // Terminate simulation
    $finish;
  end

endmodule
