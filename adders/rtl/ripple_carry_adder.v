module ripple_carry_adder(
    input signed [31:0] A,
    input signed [31:0] B,
   output signed [32:0] SUM
    );

  wire [30:0] w;
  wire Co;   

  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : fulladder_gen
      if (i == 0) begin
        fulladder u(A[i], B[i], 1'b0, SUM[i], w[i]);
      end else if (i == 31) begin
        fulladder u(A[i], B[i], w[i-1], SUM[i], Co);
      end else begin
        fulladder u(A[i], B[i], w[i-1], SUM[i], w[i]);
      end
    end
  endgenerate

  assign SUM[32] = Co;

endmodule

