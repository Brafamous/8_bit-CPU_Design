module instruction_memory #(
    parameter WIDTH = 16,
    parameter DEPTH =256,
    parameter ADDR_WIDTH =8
)
(
    input wire [ADDR_WIDTH-1:0] addr,

    output wire [WIDTH-1:0] instruction
);

//internal registers
reg [WIDTH-1:0] memory [0:DEPTH-1];


//loop integer
integer i;
//Initializing memory locations
initial begin
    for (i = 0; i < DEPTH; i = i + 1)begin
        memory[i] = {WIDTH{1'b0}};
    end

    // Sample instructions
// Program: STORE -> LOAD -> ADD

memory[0] = 16'b0111_000_001_010_000; // STORE R1 -> Memory[R2]
memory[1] = 16'b0110_011_010_000_000; // LOAD  R3 <- Memory[R2]
memory[2] = 16'b0000_100_001_011_000; // ADD   R4 = R1 + R3
memory[3] = 16'b0011_100_001_010_000; // OR    R4 = R1 | R2
memory[4] = 16'b0100_101_001_010_000; // XOR   R5 = R1 ^ R2
end

//Combinational Read Logic
assign instruction = memory[addr];

endmodule