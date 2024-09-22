module n_bit_alu
  #(
    parameter N=32
  )
  (
    input logic [N-1:0] x, y,
    input logic [2:0] opcode,
    output logic [N-1:0] s,
    output logic count
  )
  localparam  op_add = 3'b001;
              op_sub = 3'b010;
              op_cmpr= 3'b100;
/...
endmodule
