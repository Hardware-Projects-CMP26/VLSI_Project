module carry_select_adder (
    input  [31:0] A,
    input  [31:0] B,
    input Cin, 
    output [31:0] SUM,
    output Cout,
    output Overflow
);
    wire [31:0] Sum0, Sum1;
    wire [32:0] Carry0, Carry1;
    wire [31:0] CarryMux;

    assign Carry0[0] = 0;
    assign Carry1[0] = 1;


    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : fulladder_gen

            fulladder FA (
                .A(A[i]),
                .B(B[i]),
                .Cin(Carry0[i]),
                .SUM(Sum0[i]),
                .Cout(Carry0[i+1])
            );

            fulladder FA1 (
                .A(A[i]),
                .B(B[i]),
                .Cin(Carry1[i]),
                .SUM(Sum1[i]),
                .Cout(Carry1[i+1])
            );

            assign CarryMux[i] = (Cin == 0) ? Carry0[i+1] : Carry1[i+1];
            assign SUM[i] = (Cin == 0) ? Sum0[i] : Sum1[i];
        end
    endgenerate

    // Final carry-out
    assign Cout = CarryMux[31];
    assign Overflow = (A[31] & B[31] & ~SUM[31]) | (~A[31] & ~B[31] & SUM[31]);

endmodule