module adder_comparison_tb();
  reg signed [31:0] A, B;             // Inputs
  reg Cin;                            // Cin

  wire signed [31:0] ripple_result;   // Ripple Carry Adder result
  wire signed [31:0] carry_select_result; // Carry Select Adder result
  wire signed [31:0] carry_lookahead_result; // Carry Lookahead Adder result
  wire signed [31:0] carry_skip_result;     // Carry Skip Adder result
  wire Cout_ripple, Cout_select, Cout_lookahead, Cout_skip; // Carry out signals
  wire Overflow_ripple, Overflow_select, Overflow_lookahead, Overflow_skip; // Overflow signals
  integer success_count = 0;  // Count of successful tests
  integer failure_count = 0;  // Count of failed tests
  integer current_test = 0;   // Test case ID

  // DUT instantiations
  ripple_carry_adder ripple_adder (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(ripple_result),
    .Cout(Cout_ripple),
    .Overflow(Overflow_ripple)
  );

  carry_select_adder select_adder (
    .A(A),
    .B(B),
    .Cin(Cin),
    .SUM(carry_select_result),
    .Cout(Cout_select),
    .Overflow(Overflow_select)
  );

  carry_look_ahead_adder lookahead_adder (
    .A(A),
    .B(B),
    .Cin(Cin),
    .SUM(carry_lookahead_result),
    .Cout(Cout_lookahead),
    .Overflow(Overflow_lookahead)
  );

  carry_bypass_adder skip_adder (
    .A(A),
    .B(B),
    .Cin(Cin),
    .SUM(carry_skip_result),
    .Cout(Cout_skip),
    .Overflow(Overflow_skip)
  );

  // Test Task

  task run_test;
    input signed [31:0] in_a;
    input signed [31:0] in_b;
    input in_cin;
    input signed [31:0] expected_sum;
    begin
      A = in_a;
      B = in_b;
      Cin = in_cin;
      #10; // Wait for results

      if ((ripple_result == expected_sum) && (carry_select_result == expected_sum) && (carry_lookahead_result == expected_sum) && (carry_skip_result == expected_sum)) begin
        $display("TestCase#%0d: success - All adders match expected result", current_test);
        success_count = success_count + 1;
      end else begin
        $display("TestCase#%0d: failed", current_test);
        $display("Inputs: %0d + %0d", in_a, in_b);
        $display("Cin: %0d", in_cin);
        $display("Expected: %0d", expected_sum);
        $display("Ripple Carry Result: %0d", ripple_result);
        $display("Carry Select Result: %0d", carry_select_result);
        $display("Carry Lookahead Result: %0d", carry_lookahead_result);
        $display("Carry Skip Result: %0d", carry_skip_result);
        $display("Cout Ripple: %0d", Cout_ripple);
        $display("Cout Select: %0d", Cout_select);
        $display("Cout Lookahead: %0d", Cout_lookahead);
        $display("Cout Skip: %0d", Cout_skip);
        $display("Overflow Ripple: %0d", Overflow_ripple);
        $display("Overflow Select: %0d", Overflow_select);
        $display("Overflow Lookahead: %0d", Overflow_lookahead);
        $display("Overflow Skip: %0d", Overflow_skip);
        failure_count = failure_count + 1;
      end
    end
  endtask

  // Testbench
  initial begin
    $display("=== Adder Comparison Test ===");

    // Test Case 1: Simple addition (10 + 15)
    current_test = 1;
    run_test(32'd10, 32'd15, 0, 33'd25);

    // Test Case 2: Addition of two large negative numbers (-2147483648 + -2147483648)
    current_test = 2;
    run_test(-32'd2147483648, -32'd2147483648, 0, -33'd4294967296);

    // Test Case 3: Addition of positive and negative resulting in zero (10 + -10)
    current_test = 3;
    run_test(32'd10, -32'd10, 0, 32'd0);

    // Test Case 4: Addition of two positive numbers (2147483647 + 2147483647)
    current_test = 4;
    run_test(32'd2147483647, 32'd2147483647, 0, 33'd4294967294);

    // Test Case 5: Addition of two negative numbers (-10 + -10)
    current_test = 5;
    run_test(-32'd10, -32'd10, 0, -33'd20);

    // Test Case 6: Random values resulting in a negative sum (-1431655766 + 1431655765)
    current_test = 6;
    run_test(-32'd1431655766, 32'd1431655765, 0, -33'd1);

    // Test Case 7: Zero plus negative number (0 + -1)
    current_test = 7;
    run_test(32'd0, -32'd1, 0, -33'd1);

    // Test Case 8: Overflow of two large positive numbers (2147483647 + 2147483647)
    current_test = 8;
    run_test(32'd2147483647, 32'd2147483647, 0, 33'd4294967294);

    // Final report
    $display("\n=== Final Report ===");
    $display("Total Test Cases: %0d", success_count + failure_count);
    $display("Successful Tests: %0d", success_count);
    $display("Failed Tests: %0d", failure_count);

    $finish;
  end
endmodule

