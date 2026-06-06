`timescale 1ns/1ps

module instruction_decoder_tb();

reg  [15:0] instruction;

wire [3:0] opcode;
wire [2:0] rd;
wire [2:0] rs1;
wire [2:0] rs2;

// DUT
instruction_decoder DUT (
    .instruction(instruction),
    .opcode(opcode),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2)
);

initial begin
    $monitor("Time=%0t | instruction=%b | opcode=%b | rd=%b | rs1=%b | rs2=%b",
             $time, instruction, opcode, rd, rs1, rs2);

    // Example: ADD R1, R2, R3
    instruction = 16'b0000_001_010_011_000;
    #1;

    if (opcode == 4'b0000 && rd == 3'b001 && rs1 == 3'b010 && rs2 == 3'b011)
        $display("TEST PASSED: ADD R1, R2, R3 decoded correctly");
    else
        $display("TEST FAILED: ADD decode incorrect");

    // Example: STORE R4, R5, R6
    instruction = 16'b0111_100_101_110_000;
    #1;

    if (opcode == 4'b0111 && rd == 3'b100 && rs1 == 3'b101 && rs2 == 3'b110)
        $display("TEST PASSED: STORE decoded correctly");
    else
        $display("TEST FAILED: STORE decode incorrect");

    $finish;
    
end

endmodule