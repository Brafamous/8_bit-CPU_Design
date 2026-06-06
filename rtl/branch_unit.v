// Branch Unit
// Supports JMP and BEQ for 8-bit CPU

module branch_unit #(
    parameter PC_WIDTH = 8
)
(
    input  wire [3:0] opcode,
    input  wire       zero_flag,
    input  wire [PC_WIDTH-1:0] branch_addr,

    output reg        branch_taken,
    output reg  [PC_WIDTH-1:0] next_pc
);

localparam OP_JMP = 4'b1001;
localparam OP_BEQ = 4'b1010;

always @(*) begin
    branch_taken = 1'b0;
    next_pc      = {PC_WIDTH{1'b0}};

    case (opcode)

        OP_JMP: begin
            branch_taken = 1'b1;
            next_pc      = branch_addr;
        end

        OP_BEQ: begin
            if (zero_flag) begin
                branch_taken = 1'b1;
                next_pc      = branch_addr;
            end
        end

        default: begin
            branch_taken = 1'b0;
            next_pc      = {PC_WIDTH{1'b0}};
        end

    endcase
end

endmodule