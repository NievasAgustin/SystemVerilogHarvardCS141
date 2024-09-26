module d_ff_rst
  (
    input logic clk, rst,
    input logic d,
    output logic q
  );
  always @(posedge clk, posedge rst) begin
    if (rst)
      q <= '0;
    else
      q <= d;
  end
endmodule
