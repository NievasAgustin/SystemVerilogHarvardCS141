module fsm_two_states (
    input logic clk, rst,
    input logic in,
    output logic out
);
  typedef enum {s1, s2} state_t;

  state_t state_reg, state_next;

  
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state_reg <= S1;
        else
            state_reg <= state_next;
    end

  
    always_comb begin
        state_next = state_reg;
        out = 1'b0;

        case (state_reg)
            S1: begin
                if (in) begin
                    state_next = S2;  // Move to S2
                    out = 1'b1;       // Output 1
                end
                // If in == 0, stays in S1 with out = 0
            end
            S2: begin
              if (~in)
                state_next = S1;  // Move to S1 when in == 0
              end

        endcase
    end

endmodule
