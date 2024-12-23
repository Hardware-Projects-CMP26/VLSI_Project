module carry_bypass_adder_tb;

    reg [31:0] A;
    reg [31:0] B;

    wire [32:0] SUM;

    reg [32:0] expected_SUM;
    reg error_flag;

    CSkipA32 uut (
        .A(A), 
        .B(B), 
        .SUM(SUM)
    );

    initial begin
        $monitor("Time = %0t | A = %h, B = %h, SUM = %h", $time, A, B, SUM);

        A = 32'h00000001;
        B = 32'h00000001;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1;
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;
        end
        
        A = 32'h7FFFFFFF;
        B = 32'h00000001;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1;
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;
        end
        

        A = 32'h00000000;
        B = 32'h12345678;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;
        end

        A = 32'h0000000F;
        B = 32'h00000010;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;  
        end

        A = 32'h80000000;
        B = 32'h80000000;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;  
        end

        A = 32'hFFFFFFFF;
        B = 32'h00000001;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;  
        end

        A = 32'h12345678;
        B = 32'h12345678;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;  
        end

        A = 32'h12345678;
        B = 32'hEDCBA987;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;  
        end

        A = 32'hA5A5A5A5;
        B = 32'h5A5A5A5A;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;  
        end

        A = 32'hFFFFFFFF;
        B = 32'hFFFFFFFF;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;  
        end

        A = 32'h00000000;
        B = 32'h00000000;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;  
        end

        A = 32'hFFFF0000;
        B = 32'hFFFF0000;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;  
        end
        
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        expected_SUM = A + B;
        #10;
        if (SUM !== expected_SUM) begin
            $display("ERROR at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b1; 
        end else begin
            $display("Passed at time %0t: A = %h, B = %h, SUM = %h, Expected = %h", $time, A, B, SUM, expected_SUM);
            error_flag = 1'b0;  
        end

        $finish;
    end

endmodule