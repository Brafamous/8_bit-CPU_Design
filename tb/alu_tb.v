`timescale 1ns/1ps

module alu_tb();

parameter DATA_WIDTH = 8;
parameter OP_WIDTH   = 4;

reg  [DATA_WIDTH-1:0] A;
reg  [DATA_WIDTH-1:0] B;
reg  [OP_WIDTH-1:0]   alu_op;

wire [DATA_WIDTH-1:0] result;
wire                  carry_flag;
wire                  zero_flag;
wire                  negative_flag;

// DUT Instantiation
alu #(
    .DATA_WIDTH(DATA_WIDTH),
    .OP_WIDTH(OP_WIDTH)
) DUT (
    .A(A),
    .B(B),
    .alu_op(alu_op),
    .result(result),
    .carry_flag(carry_flag),
    .zero_flag(zero_flag),
    .negative_flag(negative_flag)
);

initial begin
    $monitor("Time=%0t | A=%h | B=%h | alu_op=%b | result=%h | carry=%b | zero=%b | neg=%b",
             $time, A, B, alu_op, result, carry_flag, zero_flag, negative_flag);

    // ADD: 10 + 5 = 15
    A = 8'd10; B = 8'd5; alu_op = 4'b0000;
    #1;
    if (result == 8'd15)
        $display("TEST PASSED: ADD");
    else
        $display("TEST FAILED: ADD");

    // SUB: 10 - 5 = 5
    A = 8'd10; B = 8'd5; alu_op = 4'b0001;
    #1;
    if (result == 8'd5)
        $display("TEST PASSED: SUB");
    else
        $display("TEST FAILED: SUB");

    // AND
    A = 8'b10101010; B = 8'b11001100; alu_op = 4'b0010;
    #1;
    if (result == 8'b10001000)
        $display("TEST PASSED: AND");
    else
        $display("TEST FAILED: AND");

    // OR
    A = 8'b10101010; B = 8'b11001100; alu_op = 4'b0011;
    #1;
    if (result == 8'b11101110)
        $display("TEST PASSED: OR");
    else
        $display("TEST FAILED: OR");

    // XOR
    A = 8'b10101010; B = 8'b11001100; alu_op = 4'b0100;
    #1;
    if (result == 8'b01100110)
        $display("TEST PASSED: XOR");
    else
        $display("TEST FAILED: XOR");

    // NOT
    A = 8'b10101010; B = 8'd0; alu_op = 4'b0101;
    #1;
    if (result == 8'b01010101)
        $display("TEST PASSED: NOT");
    else
        $display("TEST FAILED: NOT");

    // SHIFT LEFT
    A = 8'b10000001; B = 8'd0; alu_op = 4'b0110;
    #1;
    if (result == 8'b00000010 && carry_flag == 1'b1)
        $display("TEST PASSED: SHL");
    else
        $display("TEST FAILED: SHL");

    // SHIFT RIGHT
    A = 8'b10000001; B = 8'd0; alu_op = 4'b0111;
    #1;
    if (result == 8'b01000000 && carry_flag == 1'b1)
        $display("TEST PASSED: SHR");
    else
        $display("TEST FAILED: SHR");

    // PASS A
    A = 8'hA5; B = 8'd0; alu_op = 4'b1000;
    #1;
    if (result == 8'hA5)
        $display("TEST PASSED: PASS");
    else
        $display("TEST FAILED: PASS");

    // ZERO FLAG
    A = 8'd5; B = 8'd5; alu_op = 4'b0001;
    #1;
    if (result == 8'd0 && zero_flag == 1'b1)
        $display("TEST PASSED: ZERO FLAG");
    else
        $display("TEST FAILED: ZERO FLAG");

    // NEGATIVE FLAG
    A = 8'h80; B = 8'd0; alu_op = 4'b1000;
    #1;
    if (negative_flag == 1'b1)
        $display("TEST PASSED: NEGATIVE FLAG");
    else
        $display("TEST FAILED: NEGATIVE FLAG");

    $finish;
end

endmodule