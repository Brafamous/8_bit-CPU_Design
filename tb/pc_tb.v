`timescale 1ns/1ps
module pc_tb(); 
parameter WIDTH = 8;

reg clk;
reg rst;
reg enable;

wire [WIDTH-1:0] pc_out;


//Signal connection
pc  #(
    .WIDTH(WIDTH)
    )
    DUT (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .pc_out(pc_out)
);

//Initialization
initial
begin
       clk =1'b0;
end

always #5 clk =~clk;

//Test Stimulus
initial
begin
    rst =1'b0;
    enable =1'b0;
    $monitor("time =%0t | reset =%b | enable =%b | pc_out=%d", $time, rst, enable, pc_out);

    //Test reset
    #10;
    rst =1'b1;
    #10;
    rst= 1'b0;

    //Test Enable Counting
    #10;
    enable =1'b1;
    #60;

    //Test Hold
    enable =1'b0;
    #30;

    //Reset During Operation
    enable=1'b1;
    #20;
    rst=1'b1;
    #10;
    rst=1'b0;

    #30;
    $finish;
end

endmodule
