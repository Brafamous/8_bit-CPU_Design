//Program Counter Design
//Features: Synchronous operation, Active-high reset, Enable signal and Parameterized width

module pc 
#(
    parameter WIDTH = 8 
)(
    input wire clk,rst,enable,
    output reg [WIDTH-1:0] pc_out
);

always @(posedge clk) begin
    if (rst) begin
    pc_out <= {WIDTH{1'b0}};
    end 

    else if (enable) begin
    pc_out <= pc_out + 1'b1;
    end
end
endmodule