module mux
  (
    input logic a, b, sel,
    output logic f
  );
  
  logic nsel, f1, f2;
  and g1(f1,a,n_sel);
  and g2(f2, b, sel);
  or g3(f, f1, f2);
  not (n_sel, sel);
endmodule
