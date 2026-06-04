`timescale 1ns/1ps

module instruction_memory_tb();
    parameter WIDTH = 16;
    parameter DEPTH =256;
    parameter ADDR_WIDTH =8;

//Signals
reg [ADDR_WIDTH-1:0] addr;
wire [WIDTH-1:0] instruction;

//DUT connection
instruction_memory  #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) 
DUT(
    .addr(addr),
    .instruction(instruction)
);

//Initialize
initial begin
    addr = 0;
    $monitor("time =%0t | addr = %0d | instruction = %0h", $time, addr, instruction);

    //Test Address 0
    addr = 8'd0;
    #1;
    if (instruction != 16'h1234)
        $display("TEST FAILED: addr 0");
    else
        $display("TEST PASSED: addr 0");

// addr = 8'd1;
    addr = 8'd1;
    #1;
    if (instruction != 16'hABCD)
        $display("TEST FAILED: addr 1");
    else
        $display("TEST PASSED: addr 1");

// addr = 8'd2;
    addr = 8'd2;
    #1;
    if (instruction != 16'h5678)
        $display("TEST FAILED: addr 2");
    else
        $display("TEST PASSED: addr 2");        


// addr = 8'd3;
    addr = 8'd3;
    #1;
    if (instruction != 16'hFFFF)
        $display("TEST FAILED: addr 3");
    else
        $display("TEST PASSED: addr 3");


// addr = 8'd100;
    addr = 8'd100;
    #1;
    if (instruction != 16'h0000)
        $display("TEST FAILED: addr 100");
    else
        $display("TEST PASSED: addr 100");

    $finish;
end

endmodule