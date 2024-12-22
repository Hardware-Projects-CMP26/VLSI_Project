module sequential_multiplier_tb();
    reg clk, rst, start;
    reg signed [31:0] multiplicand, multiplier;
    wire signed [31:0] product;
    wire done;

    integer success_count = 0;
    integer failure_count = 0;
    integer current_test = 0;

    sequential_multiplier dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product),
        .done(done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        start = 0;
        multiplicand = 0;
        multiplier = 0;
        #10 rst = 0;
        #10;

        // Test Case 1: Positive * Negative
        current_test = 1;
        run_test(32'd5, -32'd3, -32'd15);

        // Test Case 2: Positive * Positive
        current_test = 2;
        run_test(32'd4, 32'd7, 32'd28);

        // Test Case 3: Negative * Negative
        current_test = 3;
        run_test(-32'd6, -32'd4, 32'd24);

        // Test Case 4: Negative * Positive
        current_test = 4;
        run_test(-32'd8, 32'd5, -32'd40);

        // Test Case 5: Multiplication by zero
        current_test = 5;
        run_test(32'd123, 32'd0, 32'd0);

        // Test Case 6: Multiplication by one
        current_test = 6;
        run_test(32'd456, 32'd1, 32'd456);

        // Test Case 7: Random test 1 (large numbers)
        current_test = 7;
        run_test(32'd1000, 32'd2000, 32'd2_000_000);

        // Test Case 8: Random test 2 (max negative * small positive)
        current_test = 8;
        run_test(-32'd2147483647, 32'd2, -32'd4294967294);

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
        input signed [31:0] expected;
        begin
            multiplicand = a;
            multiplier = b;
            start = 1;
            @(posedge clk);
            start = 0;

            @(posedge done);
            #10;

            if (product === expected) begin
                $display("TestCase#%0d: success", current_test);
                success_count = success_count + 1;
            end else begin
                $display("TestCase#%0d: failed with input %0d and %0d and Output %0d", 
                    current_test, a, b, product);
                failure_count = failure_count + 1;
            end

            @(posedge clk);
            #10;
        end
    endtask

    // Timeout watchdog
    initial begin
        #1000000; 
        $display("Simulation timeout!");
        $finish;
    end

endmodule
