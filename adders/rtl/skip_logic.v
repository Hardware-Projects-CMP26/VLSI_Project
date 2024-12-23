module SkipLogic(
  output cin_next,
  input [3:0] a, b, 
  input cin, cout
);
  wire p0, p1, p2, p3, P, e;
  // OR gates for propagate signals
  or (p0, a[0], b[0]);
  or (p1, a[1], b[1]);
  or (p2, a[2], b[2]);
  or (p3, a[3], b[3]);
  // AND gates for propagate and generate logic
  and (P, p0, p1, p2, p3);
  and (e, P, cin);
  // OR gate for carry-in propagation
  or (cin_next, e, cout);

endmodule

