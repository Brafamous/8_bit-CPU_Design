module data_memory #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 256,
    parameter ADDR_WIDTH = 8
)
(
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire [ADDR_WIDTH-1:0] addr,
    input wire [DATA_WIDTH-1:0] wr_data,

    output wire [DATA_WIDTH-1:0] rd_data
);

//Internal registers
reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];

//Loop variable
integer i;


//Reset operation
always @(posedge clk) begin
    if (rst) begin
    for (i = 0; i < DEPTH; i = i +1) begin
    memory[i] <= {DATA_WIDTH{1'b0}};
        end
    end

    else if (wr_en) begin
    memory[addr] <= wr_data;
    end
end

//Combinational Read Operation
assign rd_data = memory[addr];

endmodule