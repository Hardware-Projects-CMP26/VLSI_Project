module ripple_carry_adder(
    input signed [31:0] A,
    input signed [31:0] B,
    input Cin, 
    output [31:0] Sum,
    output Cout,
    output Overflow 
  );

  wire [32:0] Carry;
  assign Carry[0] = Cin;


  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : fulladder_gen
       fulladder FA (
                .A(A[i]),
                .B(B[i]),
                .Cin(Carry[i]),
                .SUM(Sum[i]),
                .Cout(Carry[i+1])
        );
    end
  endgenerate
  assign Cout = Carry[32];
  assign Overflow = Carry[31] ^ Carry[32]; 

endmodule
