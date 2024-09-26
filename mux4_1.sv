module mux4_1
  #(parameter N=2)
  (
    input logic [N-1:0] a,b,c,d,
    input logic [1:0] sel,
    output logic [N-1:0] y
  );
  always_comb begin
    case(sel)
      2'b00: y=a;
      2'b01: y=b;
      2'b10: y=c;
      2'b11: y=d;
    endcase
  end
endmodule
