module operator_demo;

  // Define some example vectors and variables
  logic [3:0] a, b, result;
  logic c, d;
  logic [7:0] concat_result;
  logic [3:0] replicated_value;
  logic x_value = 1'bX;  // Unknown value
  logic z_value = 1'bZ;  // High impedance value

  initial begin
    // Assignment
    a = 4'b1010;  // Assign a value to 'a'
    b = 4'b1100;  // Assign a value to 'b'
    c = 1'b1;     // Assign a value to 'c'
    d = 1'b0;     // Assign a value to 'd'

    // Ternary operator: condition ? true_expr : false_expr
    result = (c == 1'b1) ? a : b;  // If c is 1, assign a to result, otherwise b.
    $display("Ternary Operator Result: %b", result);

    // Bitwise operators (AND, OR, XOR, NOT)
    result = a & b;  // AND operation
    $display("Bitwise AND: %b & %b = %b", a, b, result);
    result = a | b;  // OR operation
    $display("Bitwise OR: %b | %b = %b", a, b, result);
    result = a ^ b;  // XOR operation
    $display("Bitwise XOR: %b ^ %b = %b", a, b, result);
    result = ~a;     // NOT operation (bitwise negation)
    $display("Bitwise NOT: ~%b = %b", a, result);

    // Logical operators (AND, OR, NOT)
    result[0] = c && d;  // Logical AND (single bit result)
    $display("Logical AND: %b && %b = %b", c, d, result[0]);
    result[0] = c || d;  // Logical OR
    $display("Logical OR: %b || %b = %b", c, d, result[0]);

    // Reduction operators
    result[0] = &a;  // Reduction AND (checks if all bits are 1)
    $display("Reduction AND of %b = %b", a, result[0]);
    result[0] = |a;  // Reduction OR (checks if any bit is 1)
    $display("Reduction OR of %b = %b", a, result[0]);
    result[0] = ^a;  // Reduction XOR (parity)
    $display("Reduction XOR of %b = %b", a, result[0]);

    // Arithmetic operators
    result = a + b;  // Addition
    $display("Addition: %b + %b = %b", a, b, result);
    result = a - b;  // Subtraction
    $display("Subtraction: %b - %b = %b", a, b, result);

    // Shift operators
    result = a << 1;  // Logical shift left
    $display("Logical Shift Left: %b << 1 = %b", a, result);
    result = a >> 1;  // Logical shift right
    $display("Logical Shift Right: %b >> 1 = %b", a, result);
    
    // Comparison operators
    result[0] = (a == b);  // Equality comparison
    $display("Equality: %b == %b = %b", a, b, result[0]);
    result[0] = (a != b);  // Inequality comparison
    $display("Inequality: %b != %b = %b", a, b, result[0]);

    // Concatenation
    concat_result = {a, b};  // Concatenate 'a' and 'b'
    $display("Concatenation of %b and %b = %b", a, b, concat_result);

    // Replication
    replicated_value = {4{c}};  // Replicate 'c' 4 times
    $display("Replication of %b = %b", c, replicated_value);

    // Interactions with X and Z
    // X (unknown) propagation with bitwise operators: X propagates if involved
    result = a & {4{x_value}};
    $display("Bitwise AND with X: %b & %b = %b", a, {4{x_value}}, result);

    // Z (high impedance) with bitwise operators: Z is treated as X in bitwise operations
    result = a & {4{z_value}};
    $display("Bitwise AND with Z: %b & %b = %b", a, {4{z_value}}, result);

    // Arithmetic with X and Z: Any operation involving X or Z results in X
    result = a + {4{x_value}};
    $display("Addition with X: %b + %b = %b", a, {4{x_value}}, result);

    // Shift operations with X and Z: If shift amount is X or Z, the result is X
    result = a << x_value;
    $display("Shift Left with X: %b << %b = %b", a, x_value, result);
  end

endmodule
