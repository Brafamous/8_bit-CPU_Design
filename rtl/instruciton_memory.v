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
    memory[0] = 16'h1234;
    memory[1] = 16'hABCD;
    memory[2] = 16'h5678;
    memory[3] = 16'hFFFF;
end

//Combinational Read Logic
assign instruction = memory[addr];

endmodule