// 8-bit CPU ALU
// Supports arithmetic, logic, and shift operations
// Outputs result and status flags

module alu #(
    parameter DATA_WIDTH = 8,
    parameter OP_WIDTH   = 4
)
(
    input  wire [DATA_WIDTH-1:0] A,
    input  wire [DATA_WIDTH-1:0] B,
    input  wire [OP_WIDTH-1:0]   alu_op,

    output reg  [DATA_WIDTH-1:0] result,
    output reg                   carry_flag,
    output wire                  zero_flag,
    output wire                  negative_flag
);

// ALU operation codes
localparam ALU_ADD = 4'b0000;
localparam ALU_SUB = 4'b0001;
localparam ALU_AND = 4'b0010;
localparam ALU_OR  = 4'b0011;
localparam ALU_XOR = 4'b0100;
localparam ALU_NOT = 4'b0101;
localparam ALU_SHL = 4'b0110;
localparam ALU_SHR = 4'b0111;
localparam ALU_PASS= 4'b1000;

// Temporary extended result for carry/borrow
reg [DATA_WIDTH:0] temp_result;

always @(*) begin
    result      = {DATA_WIDTH{1'b0}};
    carry_flag  = 1'b0;
    temp_result = {(DATA_WIDTH+1){1'b0}};

    case (alu_op)

        ALU_ADD: begin
            temp_result = {1'b0, A} + {1'b0, B};
            result      = temp_result[DATA_WIDTH-1:0];
            carry_flag  = temp_result[DATA_WIDTH];
        end

        ALU_SUB: begin
            temp_result = {1'b0, A} - {1'b0, B};
            result      = temp_result[DATA_WIDTH-1:0];
            carry_flag  = temp_result[DATA_WIDTH]; // borrow indicator in unsigned subtraction
        end

        ALU_AND: begin
            result = A & B;
        end

        ALU_OR: begin
            result = A | B;
        end

        ALU_XOR: begin
            result = A ^ B;
        end

        ALU_NOT: begin
            result = ~A;
        end

        ALU_SHL: begin
            result     = A << 1;
            carry_flag = A[DATA_WIDTH-1];
        end

        ALU_SHR: begin
            result     = A >> 1;
            carry_flag = A[0];
        end

        ALU_PASS: begin
            result = A;
        end

        default: begin
            result     = {DATA_WIDTH{1'b0}};
            carry_flag = 1'b0;
        end

    endcase
end

assign zero_flag     = (result == {DATA_WIDTH{1'b0}});
assign negative_flag = result[DATA_WIDTH-1];

endmodule