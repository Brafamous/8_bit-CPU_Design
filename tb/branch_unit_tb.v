`timescale 1ns/1ps

module branch_unit_tb();

parameter PC_WIDTH = 8;

reg  [3:0] opcode;
reg        zero_flag;
reg  [PC_WIDTH-1:0] branch_addr;

wire       branch_taken;
wire [PC_WIDTH-1:0] next_pc;

branch_unit #(
    .PC_WIDTH(PC_WIDTH)
) DUT (
    .opcode(opcode),
    .zero_flag(zero_flag),
    .branch_addr(branch_addr),
    .branch_taken(branch_taken),
    .next_pc(next_pc)
);

initial begin
    $monitor("Time=%0t | opcode=%b | zero=%b | branch_addr=%0d | branch_taken=%b | next_pc=%0d",
             $time, opcode, zero_flag, branch_addr, branch_taken, next_pc);

    // Test 1: JMP
    opcode = 4'b1001;
    zero_flag = 1'b0;
    branch_addr = 8'd20;
    #1;

    if (branch_taken == 1'b1 && next_pc == 8'd20)
        $display("TEST PASSED: JMP");
    else
        $display("TEST FAILED: JMP");

    // Test 2: BEQ with zero_flag = 1
    opcode = 4'b1010;
    zero_flag = 1'b1;
    branch_addr = 8'd30;
    #1;

    if (branch_taken == 1'b1 && next_pc == 8'd30)
        $display("TEST PASSED: BEQ TAKEN");
    else
        $display("TEST FAILED: BEQ TAKEN");

    // Test 3: BEQ with zero_flag = 0
    opcode = 4'b1010;
    zero_flag = 1'b0;
    branch_addr = 8'd40;
    #1;

    if (branch_taken == 1'b0 && next_pc == 8'd0)
        $display("TEST PASSED: BEQ NOT TAKEN");
    else
        $display("TEST FAILED: BEQ NOT TAKEN");

    // Test 4: Invalid opcode
    opcode = 4'b1111;
    zero_flag = 1'b1;
    branch_addr = 8'd50;
    #1;

    if (branch_taken == 1'b0 && next_pc == 8'd0)
        $display("TEST PASSED: INVALID OPCODE");
    else
        $display("TEST FAILED: INVALID OPCODE");

    $finish;
end

endmodule