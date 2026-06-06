`timescale 1ns/1ps

module cpu_top_tb();

reg clk;
reg rst;
reg enable;

wire [7:0]  pc_value;
wire [15:0] instruction;
wire [3:0]  opcode;
wire [2:0]  rd;
wire [2:0]  rs1;
wire [2:0]  rs2;
wire [3:0]  alu_op;
wire        reg_write;
wire        mem_read;
wire        mem_write;

wire [7:0]  reg_data_a;
wire [7:0]  reg_data_b;
wire [7:0]  alu_result;
wire        zero_flag;
wire        carry_flag;
wire        negative_flag;

wire [7:0] mem_rd_data;
wire [7:0] writeback_data;

// DUT
cpu_top DUT (
    .clk(clk),
    .rst(rst),
    .enable(enable),

    .pc_value(pc_value),
    .instruction(instruction),
    .opcode(opcode),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),

    .alu_op(alu_op),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),

    .reg_data_a(reg_data_a),
    .reg_data_b(reg_data_b),
    .alu_result(alu_result),
    .zero_flag(zero_flag),
    .carry_flag(carry_flag),
    .negative_flag(negative_flag),

    .mem_rd_data(mem_rd_data),
    .writeback_data(writeback_data)
);

// Clock
initial begin
    clk = 1'b0;
end

always #5 clk = ~clk;

// Stimulus
initial begin
    rst    = 1'b0;
    enable = 1'b0;

    $monitor("Time=%0t | PC=%0d | Instr=%h | opcode=%b | rd=%0d | rs1=%0d | rs2=%0d | alu_op=%b | reg_write=%b | mem_read=%b | mem_write=%b | R_A=%0d | R_B=%0d | ALU_Result=%0d | Z=%b | C=%b | N=%b | MEM_RD=%0d | WB=%0d",
             $time, pc_value, instruction, opcode, rd, rs1, rs2, alu_op,
             reg_write, mem_read, mem_write, reg_data_a, reg_data_b,
             alu_result, zero_flag, carry_flag, negative_flag, mem_rd_data, writeback_data);

    // Reset CPU
    #10;
    rst = 1'b1;
    #10;
    rst = 1'b0;

    // Enable instruction fetch/execution
    #10;
    enable = 1'b1;

    // Let CPU execute several instructions
    #80;

    enable = 1'b0;

    #20;
    $finish;
end

endmodule