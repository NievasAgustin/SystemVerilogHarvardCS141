module shift_reg
  #( parameter N=8 )
  (
    input logic clk, rst, s_in,
    input logic [1:0] ctrl,
    input logic [N-1:0] d,
    output logic [N-1:0] q,
    output logic s_out
  );

  logic [N-1:0] r_reg, r_next;

  always_ff @(posedge clk, posedge rst)
    if(rst)
      r_reg <= '0;
  else
    r_reg <= r_next;

  always_comb
    unique case (ctrl)
      2'b00 : r_next = r_reg;
      2'b01 : r_next = {s_in, r_reg[N-1:1]};
      2'b10 : r_next = d;
    endcase

  assign q = r_reg ;
  assign s_out = r_reg[0];
endmodule
