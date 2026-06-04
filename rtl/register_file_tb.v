`timescale 1ns/1ps

module register_file_tb();

parameter DATA_WIDTH = 8;
parameter NUM_REGS   = 8;
parameter ADDR_WIDTH = 3;

reg clk;
reg rst;
reg wr_en;

reg [ADDR_WIDTH-1:0] wr_addr;
reg [DATA_WIDTH-1:0] wr_data;

reg [ADDR_WIDTH-1:0] rd_addr_a;
reg [ADDR_WIDTH-1:0] rd_addr_b;

wire [DATA_WIDTH-1:0] rd_data_a;
wire [DATA_WIDTH-1:0] rd_data_b;

//DUT Instantiation

register_file #(
    .DATA_WIDTH(DATA_WIDTH),
    .NUM_REGS(NUM_REGS),
    .ADDR_WIDTH(ADDR_WIDTH)
)
DUT(
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .rd_addr_a(rd_addr_a),
    .rd_addr_b(rd_addr_b),
    .rd_data_a(rd_data_a),
    .rd_data_b(rd_data_b)
);

// Clock initialization
initial begin
    clk = 1'b0;
end

// Clock generation: 10 ns period
always #5 clk = ~clk;

initial begin
    rst       = 1'b0;
    wr_en     = 1'b0;
    wr_addr   = 3'd0;
    wr_data   = 8'd0;
    rd_addr_a = 3'd0;
    rd_addr_b = 3'd0;

    $monitor("Time=%0t | rst=%b | wr_en=%b | wr_addr=%0d | wr_data=%h | rd_addr_a=%0d | rd_data_a=%h | rd_addr_b=%0d | rd_data_b=%h",
             $time, rst, wr_en, wr_addr, wr_data, rd_addr_a, rd_data_a, rd_addr_b, rd_data_b);

    // Reset
    #10;
    rst = 1'b1;
    #10;
    rst = 1'b0;

    // Write 8'hA5 to R4
    #5;
    wr_en   = 1'b1;
    wr_addr = 3'd4;
    wr_data = 8'hA5;
    #10;
    wr_en = 1'b0;

    // Read R4
    rd_addr_a = 3'd4;
    #1;

    if (rd_data_a == 8'hA5)
        $display("TEST PASSED: R4 = A5");
    else
        $display("TEST FAILED: R4 read incorrect");

    $finish;
end

endmodule