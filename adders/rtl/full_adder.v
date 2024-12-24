module fulladder(A, B, Cin, SUM, Cout);
  input A, B, Cin;
  output SUM, Cout;
  wire w1,w2,w3;


  xor G1(w1, A, B);
  xor G2(SUM, w1, Cin);
  and G3(w2, w1, Cin);
  and G4(w3, A, B);
  or G5(Cout, w2, w3);
endmodule