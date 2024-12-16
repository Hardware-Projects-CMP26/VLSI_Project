module CSkipA32(output [32:0] SUM, input [31:0] A, B);
  
  wire [7:0] couts;
  wire [6:0] e;
  
  ripple_adder4 rca0(SUM[3:0], couts[0], A[3:0], B[3:0], 0);
  ripple_adder4 rca[7:1](SUM[31:4], couts[7:1], A[31:4], B[31:4], e[6:0]);
  
  SkipLogic skip0(e[0], A[3:0], B[3:0], 0, couts[0]);
  SkipLogic skip[6:1](e[6:1], A[27:4], B[27:4], e[5:0], couts[6:1]);
  SkipLogic skip7(SUM[32], A[31:28], B[31:24], e[6], couts[7]);

endmodule