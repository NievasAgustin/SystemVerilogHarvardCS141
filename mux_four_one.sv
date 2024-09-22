module mux_four_one
  (
    input logic a, b, c, d,
    input logic [1:0] sel,
    output logic f
  );
  logic f1, f2;
  mux mux_1 (.f(f1), .a, .b, .sel(sel[0]));
  mux mux_2 (.f(f2), .a(c), .b(d), .sel(sel[0]));
  mux mux_3 (.f, .a(f1), .b(f2), .sel(sel[1]));
endmodule
