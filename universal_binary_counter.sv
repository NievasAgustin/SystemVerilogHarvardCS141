module universal_binary_counter 
  #(
    parameter N = 8  // Parameterized width for the counter
   )
  (
    input logic clk,          // Clock input
    input logic rst,          // Asynchronous reset
    input logic syn_clr,      // Synchronous clear
    input logic load,         // Load control
    input logic en,           // Enable control
    input logic up,           // Count direction (1 for up, 0 for down)
    input logic [N-1:0] d,    // Data input for load operation
    output logic [N-1:0] q    // Output count value
  );

    logic [N-1:0] next_q;     // Internal signal for next state
    logic [3:0] ctrl;         // Packed control signals

    // Pack control signals into a single control word
    always_comb begin
        ctrl = {syn_clr, load, en, up};
    end

    // Combinational logic using 'case' statement with wildcards
    always_comb begin
        casez (ctrl)  // Use 'casez' for wildcard handling ('z' treats '?' as don't care)
            4'b1???: next_q = '0;             // syn_clr active (priority)
            4'b01??: next_q = d;              // load active (priority below syn_clr)
            4'b0011: next_q = q + 1;          // en = 1, up = 1: count up
            4'b0010: next_q = q - 1;          // en = 1, up = 0: count down
            default: next_q = q;              // Hold current value (pause or no en)
        endcase
    end

    // Sequential logic to update the counter on the rising edge of the clock
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            q <= '0;                           // Asynchronous reset to 0
        else
            q <= next_q;                       // Update the counter with next value
    end

endmodule
