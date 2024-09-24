module eq_n
  #( param N = 4 )
  (
    input logic [N-1:0] a, b,
    output logic eq
  );
  logic [N-1 : 0] tmp;
  generate
    genvar i;
    for ( i = 0 ; i < N ; i = i+1 )
      xnor gen_u (tmp[i], a[i], b[i]);
  endgenerate
  assign eq = &tmp
endmodule
