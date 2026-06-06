module control_unit #(
    parameter INSTR_WIDTH =16,
    parameter ALU_OP_WIDTH = 4

)
(
input  wire [INSTR_WIDTH-1:0] instruction,

output reg [ALU_OP_WIDTH-1:0] alu_op,
output reg       reg_write,
output reg       mem_read,
output reg       mem_write
    
);

//Internal wires
wire [ALU_OP_WIDTH-1:0] opcode;
assign opcode = instruction[15:12];

always @(*) begin

    alu_op    = 4'b0000;
    reg_write = 1'b0;
    mem_read  = 1'b0;
    mem_write = 1'b0;

    case(opcode)

        4'b0000: begin // ADD
            alu_op    = 4'b0000;
            reg_write = 1'b1;
        end

        4'b0001: begin // SUB
            alu_op    = 4'b0001;
            reg_write = 1'b1;
        end

        4'b0010: begin // AND
            alu_op    = 4'b0010;
            reg_write = 1'b1;
        end

        4'b0011: begin // OR
            alu_op    = 4'b0011;
            reg_write = 1'b1;
        end

        4'b0100: begin // XOR
            alu_op    = 4'b0100;
            reg_write = 1'b1;
        end

        4'b0101: begin // NOT
            alu_op    = 4'b0101;
            reg_write = 1'b1;
        end

        4'b0110: begin // LOAD
            alu_op    = 4'b0000;
            reg_write = 1'b1;
            mem_read  = 1'b1;
        end

        4'b0111: begin // STORE
            alu_op    = 4'b0000;
            mem_write = 1'b1;
        end

        4'b1000: begin // MOV / PASS
            alu_op    = 4'b1000;
            reg_write = 1'b1;
        end

        default: begin
            alu_op    = 4'b0000;
            reg_write = 1'b0;
            mem_read  = 1'b0;
            mem_write = 1'b0;
        end

    endcase

end

endmodule