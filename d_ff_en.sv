module d_ff_en
  (
    input logic clk, rst, en,
    input logic d,
    output q
  );
  always_ff @(posedge clk, posedge rst) begin
    if (rst)
      q <= '0;
    else if (en)
      q <= d;
  end
endmodule
