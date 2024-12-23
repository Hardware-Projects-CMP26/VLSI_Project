module carry_select_adder (
    input signed  [31:0] A,
    input signed  [31:0] B,
    output signed [32:0] SUM
);
    wire signed [16:0] SUM_LOWER; 
    wire signed [16:0] SUM_UPPER_C0; 
    wire signed [16:0] SUM_UPPER_C1;
    wire COUT_LOWER;

    assign {COUT_LOWER, SUM_LOWER[15:0]} = A[15:0] + B[15:0];

    wire signed [15:0] A_UPPER = A[31:16];
    wire signed [15:0] B_UPPER = B[31:16];

    assign SUM_UPPER_C0 = {1'b0, A_UPPER} + {1'b0, B_UPPER};   
    assign SUM_UPPER_C1 = {1'b0, A_UPPER} + {1'b0, B_UPPER} + 1'b1;

    assign SUM[31:16] = COUT_LOWER ? SUM_UPPER_C1[15:0] : SUM_UPPER_C0[15:0];

    assign SUM[15:0] = SUM_LOWER[15:0];
    assign SUM[32] = COUT_LOWER ? SUM_UPPER_C1[16] : SUM_UPPER_C0[16];
endmodule

