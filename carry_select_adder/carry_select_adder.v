module carry_select_adder (
    input  [31:0] A,
    input  [31:0] B,
    output [32:0] SUM
);
    wire [15:0] SUM_LOWER;
    wire [15:0] SUM_UPPER_C0, SUM_UPPER_C1;
    wire COUT_LOWER, COUT_UPPER;

    assign {COUT_LOWER, SUM_LOWER} = A[15:0] + B[15:0];
    
    assign SUM_UPPER_C0 = A[31:16] + B[31:16];                
    assign SUM_UPPER_C1 = A[31:16] + B[31:16] + 1'b1;         
    assign {COUT_UPPER, SUM[31:16]} = COUT_LOWER ? SUM_UPPER_C1 : SUM_UPPER_C0;

    assign SUM[15:0] = SUM_LOWER;
    assign SUM[32] = COUT_UPPER;
endmodule