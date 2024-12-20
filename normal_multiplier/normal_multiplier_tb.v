module normal_multiplier_tb;
    reg signed [31:0] A; 
    reg signed [31:0] B; 
    wire signed [63:0] P; 
    reg signed [32:0] expected_result;

    normal_multiplier uut (
        .A(A),
        .B(B),
        .P(P)
    );

    integer success_count = 0;
    integer failure_count = 0;

    initial begin
        // TestCase #1: Multiplication of a positive and a negative number
        A = 32'sd10; B = -32'sd5;
        expected_result = A * B;
        #10;
        if (P !== expected_result) begin
            $display("ERROR at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end

        // TestCase #2: Multiplication of two positive numbers
        A = 32'sd10; B = 32'sd5; 
        expected_result = A * B;
        #10;
        if (P !== expected_result) begin
            $display("ERROR at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end

        // TestCase #3: Multiplication of two negative numbers
        A = -32'sd10; B = -32'sd5; 
        expected_result = A * B;
        #10;
        if (P !== expected_result) begin
            $display("ERROR at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end

        // TestCase #4: Multiplication of a negative and a positive number (Same as TestCase #1)
        A = -32'sd10; B = 32'sd5; 
        expected_result = A * B;
        #10;
        if (P !== expected_result) begin
            $display("ERROR at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end

        // TestCase #5: Multiplication by zero
        A = 32'sd0; B = 32'sd10; 
        expected_result = A * B;
        #10;
        if (P !== expected_result) begin
            $display("ERROR at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end

        // TestCase #6: Multiplication by one
        A = 32'sd1; B = 32'sd10; 
        expected_result = A * B;
        #10;
        if (P !== expected_result) begin
            $display("ERROR at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end

        // TestCase #7: Random test case 1
        A = 32'sd25; B = -32'sd12; 
        expected_result = A * B;
        #10;
        if (P !== expected_result) begin
            $display("ERROR at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end

        // TestCase #8: Random test case 2
        A = -32'sd8; B = 32'sd9; 
        expected_result = A * B;
        #10;
        if (P !== expected_result) begin
            $display("ERROR at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, P = %h, Expected = %h", $time, A, B, P, expected_result);
        end

        $finish;
    end
endmodule
