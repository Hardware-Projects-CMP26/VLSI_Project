module multiplier_comparison_tb();
  reg clk, rst, start;
  reg signed [31:0] multiplicand, multiplier;

  wire signed [63:0] seq_product;
  wire seq_done;

  wire signed [63:0] dadda_product;
  wire signed [63:0] norm_product;
  wire signed [63:0] booth_product;


  integer success_count = 0;
  integer failure_count = 0;
  integer current_test = 0;

  sequential_multiplier seq_mult (
                          .clk(clk),
                          .rst(rst),
                          .start(start),
                          .multiplicand(multiplicand),
                          .multiplier(multiplier),
                          .product(seq_product),
                          .done(seq_done)
                        );

  normal_multiplier norm_mult (
                      .A(multiplicand),
                      .B(multiplier),
                      .P(norm_product)
                    );
  dadda_multiplier_32 dadda(
                        .signed_A(multiplicand),
                        .signed_B(multiplier),
                        .product(dadda_product)

                      );
  booth_multiplier booth(
                     .multiplier(multiplier),
                     .multiplicand(multiplicand),
                     .product(booth_product)
                   );

  initial
  begin
    clk = 0;
    forever
      #5 clk = ~clk;
  end

  initial
  begin
    rst = 1;
    start = 0;
    multiplicand = 0;
    multiplier = 0;
    #10 rst = 0;
    #10;

    // Test Case 1: Positive * Negative
    current_test = 1;
    run_test(32'd5, -32'd3, -64'd15);

    // Test Case 2: Positive * Positive
    current_test = 2;
    run_test(32'd4, 32'd7, 64'd28);

    // Test Case 3: Negative * Negative
    current_test = 3;
    run_test(-32'd6, -32'd4, 64'd24);

    // Test Case 4: Negative * Positive
    current_test = 4;
    run_test(-32'd8, 32'd5, -64'd40);

    // Test Case 5: Multiplication by zero
    current_test = 5;
    run_test(32'd123, 32'd0, 64'd0);

    // Test Case 6: Multiplication by one
    current_test = 6;
    run_test(32'd456, 32'd1, 64'd456);

    // Test Case 7: Large numbers
    current_test = 7;
    run_test(32'd65536, 32'd65536, 64'd4294967296);

    // Test Case 8: Maximum negative numbers
    current_test = 8;
    run_test(-32'd2147483648, -32'd2147483648, 64'd4611686018427387904);

    #100;
    $display("\n=== Final Report ===");
    $display("Total Test Cases: %0d", success_count + failure_count);
    $display("Successful Tests: %0d", success_count);
    $display("Failed Tests: %0d", failure_count);
    $finish;
  end

  task run_test;
    input signed [31:0] a;
    input signed [31:0] b;
    input signed [63:0] expected;
    begin
      multiplicand = a;
      multiplier = b;
      start = 1;
      @(posedge clk);
      start = 0;

      @(posedge seq_done);
      #10;

      if (seq_product === expected && norm_product === expected && dadda_product === expected && booth_product === expected)
      begin
        $display("TestCase#%0d: success - ALL multipliers match expected result", current_test);
        success_count = success_count + 1;
      end
      else
      begin
        $display("TestCase#%0d: failed", current_test);
        $display("Inputs: %0d * %0d", a, b);
        $display("Expected: %0h", expected);
        $display("Sequential Result: %0h", seq_product);
        $display("Normal Result: %0h", norm_product);
        $display("DADDA Result: %0h", dadda_product);
        $display("Booth Result: %0h", booth_product);
        failure_count = failure_count + 1;
      end

      @(posedge clk);
      #10;
    end
  endtask

  // Timeout watchdog
  initial
  begin
    #1000000;
    $display("Simulation timeout!");
    $finish;
  end

endmodule
