module fp_multiplier_tb;

  reg [31:0] a;
  reg [31:0] b;
  wire [31:0] result;

  fp_multiplier uut (
                  .a(a),
                  .b(b),
                  .result(result)
                );

  initial
  begin
    // Test case 1: Multiplication of a positive and a negative number
    a = 32'h3f800000; // 1.0
    b = 32'hbf800000; // -1.0
    #10;
    $display("Test 1: %h x %h = %h", a, b, result);
    if (result !== 32'hbf800000)
      $display("Test 1 failed with input %h and %h. Expected %h but got %h", a, b, 32'hbf800000, result);

    // Test case 2: Multiplication of two positive numbers
    a = 32'h3f800000; // 1.0
    b = 32'h40000000; // 2.0
    #10;
    $display("Test 2: %h x %h = %h", a, b, result);
    if (result !== 32'h40000000)
      $display("Test 2 failed with input %h and %h. Expected %h but got %h", a, b, 32'h40000000, result);

    // Test case 3: Multiplication of two negative numbers
    a = 32'hbf800000; // -1.0
    b = 32'hbf800000; // -1.0
    #10;
    $display("Test 3: %h x %h = %h", a, b, result);
    if (result !== 32'h3f800000)
      $display("Test 3 failed with input %h and %h. Expected %h but got %h", a, b, 32'h3f800000, result);

    // Test case 4: Multiplication of a negative and a positive number
    a = 32'hbf800000; // -1.0
    b = 32'h40000000; // 2.0
    #10;
    $display("Test 4: %h x %h = %h", a, b, result);
    if (result !== 32'hc0000000)
      $display("Test 4 failed with input %h and %h. Expected %h but got %h", a, b, 32'hc0000000, result);

    // Test case 5: Multiplication by zero
    a = 32'h00000000; // 0.0
    b = 32'h40000000; // 2.0
    #10;
    $display("Test 5: %h x %h = %h", a, b, result);
    if (result !== 32'h00000000)
      $display("Test 5 failed with input %h and %h. Expected %h but got %h", a, b, 32'h00000000, result);

    // Test case 6: Multiplication by one
    a = 32'h3f800000; // 1.0
    b = 32'h3f800000; // 1.0
    #10;
    $display("Test 6: %h x %h = %h", a, b, result);
    if (result !== 32'h3f800000)
      $display("Test 6 failed with input %h and %h. Expected %h but got %h", a, b, 32'h3f800000, result);

    // Test case 7: Random test case 1
    a = 32'h40490fdb; // 3.141592
    b = 32'h3f800000; // 1.0
    #10;
    $display("Test 7: %h x %h = %h", a, b, result);
    if (result !== 32'h40490fdb)
      $display("Test 7 failed with input %h and %h. Expected %h but got %h", a, b, 32'h40490fdb, result);

    // Test case 8: Random test case 2
    a = 32'hc0490fd8; // -3.141592
    b = 32'h40000000; // 2.0
    #10;
    $display("Test 8: %h x %h = %h", a, b, result);
    if (result !== 32'hc0c90fd8)
      $display("Test 8 failed with input %h and %h. Expected %h but got %h", a, b, 32'hc0c90fd8, result);

    // Additional test case: Multiplying with NaN
    a = 32'h7fc00000; // NaN
    b = 32'h40000000; // 2.0
    #10;
    $display("Test 9: %h x %h = %h", a, b, result);
    if (result !== 32'h7fc00000)
      $display("Test 9 failed with input %h and %h. Expected %h but got %h", a, b, 32'h7fc00000, result);

    // Additional test case: Multiplying with infinity
    a = 32'h7f800000; // +Infinity
    b = 32'h7f800000; // +Infinity
    #10;
    $display("Test 10: %h x %h = %h", a, b, result);
    if (result !== 32'h7f800000)
      $display("Test 10 failed with input %h and %h. Expected %h but got %h", a, b, 32'h7f800000, result);

    // Finish simulation
    $stop;
  end

endmodule
