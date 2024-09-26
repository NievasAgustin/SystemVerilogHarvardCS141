module add_or_sub
  #(parameter N=4)
  (
    input logic [N-1:0] x, y,
    input logic add,
    output logic [N-1:0] z;
  );
  always_comb
    if (add)
      z = x+y;
  else
    z = x+y:
endmodule
