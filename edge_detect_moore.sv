module edge_detect_moore
  (
    input logic clk, rst,
    input logic in,
    output logic out
  );
  typedef enum {s1, s2, s3} state_t;
  state_t state_reg, state_next;
  always_ff @(posedge clk, posedge rst)
    if(rst)
      state_reg <= s1;
  else
    state_reg <= state_next;

always_comb begin
  state_reg = state_next;
  out = 1'b0;
  unique case (state_reg)
    s1 :
      if (in)
        state_next = s2;
    s2 :
      out = 1'b1
      if (in)
        state_reg = s3;
    else
      state_reg = s1;
    s3 :
      if (~in)
        state_next = s1;
  endcase
end
endmodule
