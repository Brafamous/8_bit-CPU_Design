//Register file: stores the CPU data into each re
//Number of Registers = 8
//Register Width      = 8 bits
//Address Width       = 3 bits

module register_file #(
    parameter DATA_WIDTH = 8,
    parameter NUM_REGS =8,
    parameter ADDR_WIDTH = 3
)
(
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire [ADDR_WIDTH-1:0] wr_addr,
    input wire [DATA_WIDTH-1:0] wr_data,
    input wire [ADDR_WIDTH-1:0] rd_addr_a,
    input wire [ADDR_WIDTH-1:0] rd_addr_b,

   output wire [DATA_WIDTH-1:0] rd_data_a,
   output wire [DATA_WIDTH-1:0] rd_data_b
);

//Internal registers
reg [DATA_WIDTH-1:0] registers [0:NUM_REGS-1];

//Reset logic
integer i;

always @(posedge clk) begin
    if (rst) begin
        for (i = 0; i < NUM_REGS; i = i + 1) begin
            registers[i] <= {DATA_WIDTH{1'b0}};
        end

        // Preload registers for CPU bring-up testing
        registers[1] <= 8'd5;  // R1 = 5
        registers[2] <= 8'd7;  // R2 = 7
    end

    else if (wr_en) begin
        registers[wr_addr] <= wr_data;
    end 
end

//Read Logic
assign rd_data_a = registers[rd_addr_a];
assign rd_data_b = registers[rd_addr_b];


endmodule
