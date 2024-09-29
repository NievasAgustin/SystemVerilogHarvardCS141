module ssd_controller 
#(
    parameter N = 32,       // Address width (32-bit for full 4GB space)
    parameter DATA_WIDTH = 32,  // Data width (32-bit words)
    parameter NUM_BLOCKS = 1024, // Number of blocks in SSD (1024 blocks)
    parameter PAGE_SIZE = 4096,  // Page size in bytes (4096 bytes = 4KB)
    parameter NUM_PAGES = 128    // Number of pages per block (128 pages per block)
)
(
    input logic clk, rst,          // Clock and reset signals
    input logic read, write,       // Control signals for read and write operations
    input logic [N-1:0] addr,      // 32-bit address
    input logic [DATA_WIDTH-1:0] data_in, // Input data for writing
    output logic ready, busy,      // Ready and busy signals
    output logic [DATA_WIDTH-1:0] data_out // Output data for reading
);

    // Internal memory structure representing the NAND flash storage
    // Each page has PAGE_SIZE bytes (PAGE_SIZE * 8 bits), and there are NUM_PAGES pages per block, and NUM_BLOCKS blocks
    logic [PAGE_SIZE*8-1:0] nand_flash [0:NUM_BLOCKS-1][0:NUM_PAGES-1];

    // Internal state machine states
    typedef enum logic [2:0] {IDLE, READ, WRITE, ERASE, GC, DONE} state_t;
    state_t state_reg, state_next;

  // Timer for simulating delays in read/write/erase operations (simulating real SSD latency, a flag update should be sufficient)
    logic [31:0] timer;
    logic timer_done;

    localparam integer WAIT_TIME = 32'd1000; // Simulated wait time for SSD operations

    // State Machine: Sequential block for state transitions based on clock and reset
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state_reg <= IDLE;   // On reset, go to IDLE state
            timer <= 32'd0;      // Reset the timer
        end else begin
            state_reg <= state_next; // Move to the next state
            if (timer != 0) 
                timer <= timer - 1;  // Decrement the timer during operations
        end
    end

    // Control logic: Combines signals and determines next state
    always_comb begin
        // Default signal values for the next state
        state_next = state_reg;
        ready = 0;
        busy = 1;
        data_out = 0;  // Clear the output by default
        timer_done = (timer == 0);  // Timer finishes when it hits 0

        // State machine control logic
        case (state_reg)
            IDLE: begin
                busy = 0;  // Not busy in the IDLE state
                if (read) begin  // If read request comes
                    state_next = READ;
                    timer = WAIT_TIME;  // Simulate some delay for the read operation
                end else if (write) begin  // If write request comes
                    state_next = WRITE;
                    timer = WAIT_TIME;  // Simulate delay for writing
                end else begin
                    state_next = IDLE;
                end
            end

            READ: begin
                if (timer_done) begin
                    // Extract the page and word from the address to fetch data
                    // Address [23:12] selects the page, and [11:0] selects the offset within the page
                    data_out = nand_flash[addr[23:12]][addr[11:0]];
                    ready = 1;  // Assert ready when data is ready
                    state_next = DONE;
                end
            end

            WRITE: begin
                if (timer_done) begin
                    // Write data to the NAND flash at the specified page and offset
                    nand_flash[addr[23:12]][addr[11:0]] = data_in;
                    ready = 1;  // Assert ready once the write is complete
                    state_next = DONE;
                end
            end

            ERASE: begin
                // This is where you'd add erase logic, which is required before writing to SSD
                // For now, just a placeholder with possible timer-based delay
                if (timer_done) begin
                    state_next = DONE;
                end
            end

            GC: begin
                // GC (Garbage Collection) state for SSD maintenance (future implementation)
                // Add logic here for managing NAND flash wear-leveling, block consolidation, etc.
                if (timer_done) begin
                    state_next = DONE;
                end
            end

            DONE: begin
                busy = 0;  // Operation is done, system is not busy
                state_next = IDLE;  // Go back to IDLE state
            end

            default: state_next = IDLE;  // Default state if something goes wrong
        endcase
    end

endmodule
