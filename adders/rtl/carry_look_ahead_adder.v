module carry_lookahead_adder (
    input signed [31:0]  A,
    input signed [31:0]  B,
    output signed [32:0] SUM
    );
      
  wire [32:0] w_C;
  wire [31:0] w_G, w_P, w_SUM;
    
  genvar i;
  generate
     for (i = 0; i < 32; i = i + 1) begin : full_adder_bits
        fulladder full_adder_bit
          ( 
             .X(A[i]),
             .Y(B[i]),
             .Ci(w_C[i]),
             .S(w_SUM[i]),
             .Co()
          );
     end
  endgenerate
    
  generate
     for (i = 0; i < 32; i = i + 1) begin : generate_terms
        assign w_G[i] = A[i] & B[i];
     end
  endgenerate
 
  generate
     for (i = 0; i < 32; i = i + 1) begin : propagate_terms
        assign w_P[i] = A[i] | B[i];
     end
  endgenerate
 
  assign w_C[0] = 1'b0;
  generate
     for (i = 1; i < 33; i = i + 1) begin : carry_terms
        assign w_C[i] = w_G[i-1] | (w_P[i-1] & w_C[i-1]);
     end
  endgenerate
    
  assign SUM = {w_C[32], w_SUM};
 
endmodule
