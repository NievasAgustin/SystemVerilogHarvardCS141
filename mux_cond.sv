module mux
  (
    input logic a, b, c, sel,
    output logic f
  );
  assign f = sel ? b : a;
endmodule
