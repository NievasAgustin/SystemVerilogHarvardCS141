module two_bit_mux
  (
    input logic [1:0] a, b,
    input logic sel,
    output logic [1:0] f
  );
  mux mux_1 (.f(f[0]), .a(a[0]), .b(b[0]), .sel);
  mux mux_2 (.f(f[1]), .a(a[1]), .b(b[1]), .sel);
endmodule
