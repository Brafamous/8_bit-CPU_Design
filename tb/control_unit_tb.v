`timescale 1ns/1ps

module control_unit_tb();

parameter INSTR_WIDTH  = 16;
parameter ALU_OP_WIDTH = 4;

reg  [INSTR_WIDTH-1:0] instruction;

wire [ALU_OP_WIDTH-1:0] alu_op;
wire reg_write;
wire mem_read;
wire mem_write;

// DUT Instantiation
control_unit #(
    .INSTR_WIDTH(INSTR_WIDTH),
    .ALU_OP_WIDTH(ALU_OP_WIDTH)
) DUT (
    .instruction(instruction),
    .alu_op(alu_op),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write)
);

initial begin
    $monitor("Time=%0t | instruction=%h | opcode=%b | alu_op=%b | reg_write=%b | mem_read=%b | mem_write=%b",
             $time, instruction, instruction[15:12], alu_op, reg_write, mem_read, mem_write);

    // ADD: opcode 0000
    instruction = 16'b0000_001_010_011_000;
    #1;
    if (alu_op == 4'b0000 && reg_write == 1'b1 && mem_read == 1'b0 && mem_write == 1'b0)
        $display("TEST PASSED: ADD");
    else
        $display("TEST FAILED: ADD");

    // SUB: opcode 0001
    instruction = 16'b0001_001_010_011_000;
    #1;
    if (alu_op == 4'b0001 && reg_write == 1'b1 && mem_read == 1'b0 && mem_write == 1'b0)
        $display("TEST PASSED: SUB");
    else
        $display("TEST FAILED: SUB");

    // AND: opcode 0010
    instruction = 16'b0010_001_010_011_000;
    #1;
    if (alu_op == 4'b0010 && reg_write == 1'b1 && mem_read == 1'b0 && mem_write == 1'b0)
        $display("TEST PASSED: AND");
    else
        $display("TEST FAILED: AND");

    // OR: opcode 0011
    instruction = 16'b0011_001_010_011_000;
    #1;
    if (alu_op == 4'b0011 && reg_write == 1'b1 && mem_read == 1'b0 && mem_write == 1'b0)
        $display("TEST PASSED: OR");
    else
        $display("TEST FAILED: OR");

    // XOR: opcode 0100
    instruction = 16'b0100_001_010_011_000;
    #1;
    if (alu_op == 4'b0100 && reg_write == 1'b1 && mem_read == 1'b0 && mem_write == 1'b0)
        $display("TEST PASSED: XOR");
    else
        $display("TEST FAILED: XOR");

    // NOT: opcode 0101
    instruction = 16'b0101_001_010_000_000;
    #1;
    if (alu_op == 4'b0101 && reg_write == 1'b1 && mem_read == 1'b0 && mem_write == 1'b0)
        $display("TEST PASSED: NOT");
    else
        $display("TEST FAILED: NOT");

    // LOAD: opcode 0110
    instruction = 16'b0110_001_000_000_101;
    #1;
    if (alu_op == 4'b0000 && reg_write == 1'b1 && mem_read == 1'b1 && mem_write == 1'b0)
        $display("TEST PASSED: LOAD");
    else
        $display("TEST FAILED: LOAD");

    // STORE: opcode 0111
    instruction = 16'b0111_001_000_000_101;
    #1;
    if (alu_op == 4'b0000 && reg_write == 1'b0 && mem_read == 1'b0 && mem_write == 1'b1)
        $display("TEST PASSED: STORE");
    else
        $display("TEST FAILED: STORE");

    // MOV/PASS: opcode 1000
    instruction = 16'b1000_001_010_000_000;
    #1;
    if (alu_op == 4'b1000 && reg_write == 1'b1 && mem_read == 1'b0 && mem_write == 1'b0)
        $display("TEST PASSED: MOV/PASS");
    else
        $display("TEST FAILED: MOV/PASS");

    // INVALID: opcode 1111
    instruction = 16'b1111_000_000_000_000;
    #1;
    if (alu_op == 4'b0000 && reg_write == 1'b0 && mem_read == 1'b0 && mem_write == 1'b0)
        $display("TEST PASSED: INVALID OPCODE DEFAULT");
    else
        $display("TEST FAILED: INVALID OPCODE DEFAULT");

    $finish;
end

endmodule