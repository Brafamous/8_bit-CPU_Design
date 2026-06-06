module cpu_top #(
    parameter PC_WIDTH     = 8,
    parameter INSTR_WIDTH  = 16,
    parameter ALU_OP_WIDTH = 4
)
(
    input wire clk,
    input wire rst,
    input wire enable,

    output wire [PC_WIDTH-1:0] pc_value,
    output wire [INSTR_WIDTH-1:0] instruction,
    output wire [3:0] opcode,
    output wire [2:0] rd,
    output wire [2:0] rs1,
    output wire [2:0] rs2,
    output wire [ALU_OP_WIDTH-1:0] alu_op,
    output wire reg_write,
    output wire mem_read,
    output wire mem_write,

    output wire [7:0] reg_data_a,
    output wire [7:0] reg_data_b,
    output wire [7:0] alu_result,
    output wire       zero_flag,
    output wire       carry_flag,
    output wire       negative_flag,
    output wire [7:0] mem_rd_data,
    output wire [7:0] writeback_data
);

assign writeback_data = mem_read ? mem_rd_data : alu_result;

// Program Counter
pc #(
    .WIDTH(PC_WIDTH)
) PC_UNIT (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .pc_out(pc_value)
);

// Instruction Memory
instruction_memory #(
    .WIDTH(INSTR_WIDTH),
    .DEPTH(256),
    .ADDR_WIDTH(PC_WIDTH)
) IMEM (
    .addr(pc_value),
    .instruction(instruction)
);

// Instruction Decoder
instruction_decoder DECODER (
    .instruction(instruction),
    .opcode(opcode),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2)
);

// Control Unit
control_unit #(
    .INSTR_WIDTH(INSTR_WIDTH),
    .ALU_OP_WIDTH(ALU_OP_WIDTH)
) CTRL (
    .instruction(instruction),
    .alu_op(alu_op),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write)
);

//Register File
register_file REGFILE (
    .clk(clk),
    .rst(rst),
    .wr_en(reg_write),
    .wr_addr(rd),
    .wr_data(writeback_data),
    .rd_addr_a(rs1),
    .rd_addr_b(rs2),
    .rd_data_a(reg_data_a),
    .rd_data_b(reg_data_b)
);

//ALU
alu ALU_UNIT (
    .A(reg_data_a),
    .B(reg_data_b),
    .alu_op(alu_op),
    .result(alu_result),
    .carry_flag(carry_flag),
    .zero_flag(zero_flag),
    .negative_flag(negative_flag)
);

//Data Memory
data_memory DMEM (
    .clk(clk),
    .rst(rst),
    .wr_en(mem_write),
    .addr(mem_write ? reg_data_b : reg_data_a),
    .wr_data(reg_data_a),
    .rd_data(mem_rd_data)
);
endmodule