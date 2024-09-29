module traffic_lights (
    input logic clk, rst,
    input logic Ta, Tb,
    output logic [2:0] La, Lb   //Each bit corresponds to Green, Yellow and Red respectively
);
    typedef enum logic [1:0] {s1, s2, s3, s4} state_t;

    state_t state_reg, state_next;
    logic [5:0] outs;
    logic [1:0] in;
    logic [22:0] timer;          // Timer for 5-second yellow light (log2(5 million) ≈ 23 bits)
    logic timer_done;

    localparam integer YELLOW_TIME = 23'd5_000_000;  // 5 seconds at 1 MHz

    always_comb begin
        in[0] = Ta;
        in[1] = Tb;
    end

//Responds asynchronous to changes in inputs, but the output is synchronous.
/*  ChatGPT recommendation:

Assign inputs to the in vector

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            in <= 2'b00; // Reset inputs
        end else begin
            in[0] <= Ta;
            in[1] <= Tb;
        end
    end


*/


    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state_reg <= s1;
            timer <= 23'd0;  // Initialize timer
        end else begin
            state_reg <= state_next;
            if (timer != 23'd0)
                timer <= timer - 1;  // Countdown timer
        end
    end

    always_comb begin
        // Default values
        state_next = state_reg;
        outs = 6'b100001;  // La = green, Lb = red
        timer_done = (timer == 0);

        case (state_reg)
            s1: begin
                outs = 6'b100001;  // La = green, Lb = red
                if (~in[0]) begin  
                    state_next = s2;
                    timer = YELLOW_TIME;  // Start 5-second yellow timer
                end
            end

            s2: begin
                outs = 6'b010001;  // La = yellow, Lb = red
                if (timer_done) begin
                    state_next = s3; 
                end
            end

            s3: begin
                outs = 6'b001100;  // La = red, Lb = green
                if (~in[1]) begin 
                    state_next = s4;
                    timer = YELLOW_TIME;  // Start 5-second yellow timer
                end
            end

            s4: begin
                outs = 6'b001010;  // La = red, Lb = yellow
                if (timer_done) begin
                    state_next = s1;
                end
            end
        endcase
    end

    assign La = outs[2:0];
    assign Lb = outs[5:3];

endmodule
