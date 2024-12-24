`timescale 1ns / 1ps
module ALU_tb;
  // Declare inputs and outputs for the ALU
  reg signed [31:0] A, B;        // 32-bit IEEE 754 floating-point inputs
  reg select;                    // 1-bit select input for choosing operation (0 = multiply, 1 = add)
  wire signed [31:0] result;     // ALU result
  integer success_count, failure_count; // To track the number of successful and failed test cases

  // Instantiate the ALU module
  ALU uut (
        .A(A),
        .B(B),
        .select(select),
        .result(result)
      );

  // Test stimulus
  initial
  begin
    success_count = 0;
    failure_count = 0;

    // Display headers for the test results
    $display("A\t\tB\t\tSelect\tResult\t\t\tExpected Result");

    // --- Adder Test Cases ---
    select=1;
    A = 32'h7FFFFFFF;
    B = 32'h7FFFFFFF;
    #10;
    if (result == 32'h7ffffffe)
    begin
      $display("TestCase#1: success");
      success_count = success_count + 1;
    end
    else
    begin
      $display("TestCase#1: failed with input %h and %h and Output %h", A, B, result);
    end

    // Test Case 2: Overflow of negative numbers
    A = 32'hFF800000;
    B = 32'hFF800000;
    #10;
    if (result == 32'hFF800000)
    begin
      $display("TestCase#2: success");
      success_count = success_count + 1;
    end
    else
    begin
      $display("TestCase#2: failed with input %h and %h and Output %h", A, B, result);
    end

    // Test Case 3: Addition of positive and negative number
    A = 32'b00000010001001000000000000000000;
    B = 32'b10000001001001000000000000000000;
    #10;
    if (result == 32'b00000001101101100000000000000000)
    begin
      $display("TestCase#3: success");
      success_count = success_count + 1;
    end
    else
    begin
      $display("TestCase#3: failed with input %h and %h and Output %h", A, B, result);
    end

    // Test Case 4: Addition of positive and positive number
    A = 32'b00000001101000000000000000000000; //
    B = 32'b00000001001001000000000000000000; //
    #10;
    if (result == 32'b00000001101100100000000000000000)
    begin
      $display("TestCase#4: success");
      success_count = success_count + 1;
    end
    else
    begin
      $display("TestCase#4: failed with input %h and %h and Output %h", A, B, result);
    end

    // Test Case 5: Addition of negative and negative number
    A = 32'b10000001101000000000000000000000; //
    B = 32'b10000001001001000000000000000000; //
    #10;
    if (result == 32'b10000001101100100000000000000000)
    begin
      $display("TestCase#5: success");
      success_count = success_count + 1;
    end
    else
    begin
      $display("TestCase#5: failed with input %h and %h and Output %h", A, B, result);
    end

    // Test Case 6: Random test case 1
    A = 32'b10000010001001000000001000000000; // +1.0   0 0111 1111 000
    B = 32'b10000001000001000010000000010000; // +2.0   0 1000 0000
    #10;
    if (result == 32'b10000010001001010000101000000100)
    begin
      $display("TestCase#6: success");
      success_count = success_count + 1;
    end
    else
    begin
      $display("TestCase#6: failed with input %h and %h and Output %h", A, B, result);
    end

    // Test Case 7: Random test case 2
    A = 32'b01111111101000000000000000000000; // -1.0
    B = 32'b00000010001010100000000000000000; // -2.0
    #10;
    if (result == 32'b00000010001010110000000000000000)
    begin
      $display("TestCase#7: success");
      success_count = success_count + 1;
    end
    else
    begin
      $display("TestCase#7: failed with input %h and %h and Output %h", A, B, result);
    end

    // Test Case 8: Random test case 3
    A = 32'b10000010001001000000001000000000; // +0.3
    B = 32'b10000001100001000010000000010000; // +0.7
    #10;
    if (result == 32'b10000010001001100001001000001000)
    begin
      $display("TestCase#8: success");
      success_count = success_count + 1;
    end
    else
    begin
      $display("TestCase#8: failed with input %h and %h and Output %h", A, B, result);
    end

    // --- Multiplier Test Cases ---

    select = 0;
    A = 32'h3f800000; // 1.0
    B = 32'hbf800000; // -1.0
    #10;
    $display("Test 1: %h x %h = %h", A, B, result);
    if (result !== 32'hbf800000)
      $display("Test 1 failed with input %h and %h. Expected %h but got %h", A, B, 32'hbf800000, result);

    // Test case 2: Multiplication of two positive numbers
    A = 32'h3f800000; // 1.0
    B = 32'h40000000; // 2.0
    #10;
    $display("Test 2: %h x %h = %h", A, B, result);
    if (result !== 32'h40000000)
      $display("Test 2 failed with input %h and %h. Expected %h but got %h", A, B, 32'h40000000, result);

    // Test case 3: Multiplication of two negative numbers
    A = 32'hbf800000; // -1.0
    B = 32'hbf800000; // -1.0
    #10;
    $display("Test 3: %h x %h = %h", A, B, result);
    if (result !== 32'h3f800000)
      $display("Test 3 failed with input %h and %h. Expected %h but got %h", A, B, 32'h3f800000, result);

    // Test case 4: Multiplication of A negative and A positive number
    A = 32'hbf800000; // -1.0
    B = 32'h40000000; // 2.0
    #10;
    $display("Test 4: %h x %h = %h", A, B, result);
    if (result !== 32'hc0000000)
      $display("Test 4 failed with input %h and %h. Expected %h but got %h", A, B, 32'hc0000000, result);

    // Test case 5: Multiplication by zero
    A = 32'h00000000; // 0.0
    B = 32'h40000000; // 2.0
    #10;
    $display("Test 5: %h x %h = %h", A, B, result);
    if (result !== 32'h00000000)
      $display("Test 5 failed with input %h and %h. Expected %h but got %h", A, B, 32'h00000000, result);

    // Test case 6: Multiplication by one
    A = 32'h3f800000; // 1.0
    B = 32'h3f800000; // 1.0
    #10;
    $display("Test 6: %h x %h = %h", A, B, result);
    if (result !== 32'h3f800000)
      $display("Test 6 failed with input %h and %h. Expected %h but got %h", A, B, 32'h3f800000, result);

    // Test case 7: Random test case 1
    A = 32'h40490fdb; // 3.141592
    B = 32'h3f800000; // 1.0
    #10;
    $display("Test 7: %h x %h = %h", A, B, result);
    if (result !== 32'h40490fdb)
      $display("Test 7 failed with input %h and %h. Expected %h but got %h", A, B, 32'h40490fdb, result);

    // Test case 8: Random test case 2
    A = 32'hc0490fd8; // -3.141592
    B = 32'h40000000; // 2.0
    #10;
    $display("Test 8: %h x %h = %h", A, B, result);
    if (result !== 32'hc0c90fd8)
      $display("Test 8 failed with input %h and %h. Expected %h but got %h", A, B, 32'hc0c90fd8, result);


    // Additional test case: Multiplying with infinity
    A = 32'h7f800000; // +Infinity
    B = 32'h7f800000; // +Infinity
    #10;
    $display("Test 10: %h x %h = %h", A, B, result);
    if (result !== 32'h7f800000)
      $display("Test 10 failed with input %h and %h. Expected %h but got %h", A, B, 32'h7f800000, result);

    // --- Final Results ---
    $display("\nTotal successful test cases: %d", success_count);
    $display("Total failed test cases: %d", failure_count);

    $finish;  // End the simulation
  end
endmodule
