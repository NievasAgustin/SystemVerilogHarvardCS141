module d_latch
  (
    input logic clk,
    input logic d,
    output logic q
  );
  always_latch
    if (clk)
      q <= d;
endmodule
