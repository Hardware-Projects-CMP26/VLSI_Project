module ripple_adder4(
  output [3:0] sum, 
  output cout, 
  input [3:0] a, b, 
  input cin
);
  
  wire [3:1] c; // Carry signals
  
  fulladder fa0(a[0], b[0], cin, sum[0], c[1]);
  fulladder fa1(a[1], b[1], c[1], sum[1], c[2]);
  fulladder fa2(a[2], b[2], c[2], sum[2], c[3]);
  fulladder fa3(a[3], b[3], c[3], sum[3], cout);
  
endmodule

