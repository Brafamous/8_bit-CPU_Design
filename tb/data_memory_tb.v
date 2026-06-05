
`timescale 1ns/1ps
module data_memory_tb ();
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 256;
    parameter ADDR_WIDTH = 8;

    reg clk;
    reg rst;
    reg wr_en;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] wr_data;

    wire [DATA_WIDTH-1:0] rd_data;

//DUT Initialization

data_memory # (
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH)
)

DUT (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .addr(addr),
    .wr_data(wr_data),
    .rd_data(rd_data)
);

// Clock initialization
initial begin
    clk = 1'b0;
end

// Clock generation: 10 ns period
always #5 clk = ~clk;

initial begin

    // Initialize signals
    rst     = 1'b0;
    wr_en   = 1'b0;
    addr    = 8'd0;
    wr_data = 8'd0;

    $monitor("Time=%0t | rst=%b | wr_en=%b | addr=%0d | wr_data=%h | rd_data=%h",
              $time, rst, wr_en, addr, wr_data, rd_data);

    // -----------------------------
    // Test 1: Reset Memory
    // -----------------------------
    #10;
    rst = 1'b1;
    #10;
    rst = 1'b0;

    // -----------------------------
    // Test 2: Write AA to Address 10
    // -----------------------------
    #5;
    wr_en   = 1'b1;
    addr    = 8'd10;
    wr_data = 8'hAA;

    #10;           // wait for clock edge
    wr_en = 1'b0;

    // Read Address 10
    #1;
    if (rd_data == 8'hAA)
        $display("TEST PASSED: Address 10 = AA");
    else
        $display("TEST FAILED: Address 10");

    // -----------------------------
    // Test 3: Write 55 to Address 20
    // -----------------------------
    #5;
    wr_en   = 1'b1;
    addr    = 8'd20;
    wr_data = 8'h55;

    #10;
    wr_en = 1'b0;

    // Read Address 20
    #1;
    if (rd_data == 8'h55)
        $display("TEST PASSED: Address 20 = 55");
    else
        $display("TEST FAILED: Address 20");

    // -----------------------------
    // Test 4: Verify Address 10
    // -----------------------------
    addr = 8'd10;
    #1;

    if (rd_data == 8'hAA)
        $display("TEST PASSED: Address 10 still = AA");
    else
        $display("TEST FAILED: Address 10 corrupted");

    $finish;

end
endmodule