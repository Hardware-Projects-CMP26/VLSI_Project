module ripple_adder4(
  output [3:0] sum, 
  output cout, 
  input [3:0] a, b, 
  input cin
);
  
  wire [3:1] c;
  fulladder fa0(a[0], b[0], cin, sum[0], c[1]);
  fulladder fa[2:1](a[2:1], b[2:1], c[2:1], sum[2:1], c[3:2]);
  fulladder fa31(a[3], b[3], c[3], sum[3], cout);
  
endmodule