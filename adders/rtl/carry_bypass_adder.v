module CSkipA32(
  output signed [32:0] SUM, 
  input signed [31:0] A, B
);
  
  wire [7:0] couts;
  wire [6:0] e;
  
  ripple_adder4 rca0(SUM[3:0], couts[0], A[3:0], B[3:0], 1'b0);
  ripple_adder4 rca1(SUM[7:4], couts[1], A[7:4], B[7:4], e[0]);
  ripple_adder4 rca2(SUM[11:8], couts[2], A[11:8], B[11:8], e[1]);
  ripple_adder4 rca3(SUM[15:12], couts[3], A[15:12], B[15:12], e[2]);
  ripple_adder4 rca4(SUM[19:16], couts[4], A[19:16], B[19:16], e[3]);
  ripple_adder4 rca5(SUM[23:20], couts[5], A[23:20], B[23:20], e[4]);
  ripple_adder4 rca6(SUM[27:24], couts[6], A[27:24], B[27:24], e[5]);
  ripple_adder4 rca7(SUM[31:28], couts[7], A[31:28], B[31:28], e[6]);
  
  SkipLogic skip0(e[0], A[3:0], B[3:0], 1'b0, couts[0]);
  SkipLogic skip1(e[1], A[7:4], B[7:4], e[0], couts[1]);
  SkipLogic skip2(e[2], A[11:8], B[11:8], e[1], couts[2]);
  SkipLogic skip3(e[3], A[15:12], B[15:12], e[2], couts[3]);
  SkipLogic skip4(e[4], A[19:16], B[19:16], e[3], couts[4]);
  SkipLogic skip5(e[5], A[23:20], B[23:20], e[4], couts[5]);
  SkipLogic skip6(e[6], A[27:24], B[27:24], e[5], couts[6]);
  SkipLogic skip7(SUM[32], A[31:28], B[31:28], e[6], couts[7]);

endmodule

