module carry_bypass_adder (
    input [31:0] A, 
    input [31:0] B, 
    input Cin,    
    output [31:0] SUM, 
    output Cout,
    output Overflow
);

wire [8:0]Ctemp;
assign Ctemp[0]=Cin;

 genvar i;
 generate
    for (i = 0; i < 8; i = i + 1) begin : ripple_loop
      ripple_adder4 R(
        .a(A[(4*i+3):(4*i)]),
        .b(B[(4*i+3):(4*i)]),
        .cin(Ctemp[i]),
        .sum(SUM[(4*i+3):(4*i)]),
        .cout(Ctemp[i+1])
      );
    end
  endgenerate
assign Cout=Ctemp[8];
assign Overflow = (A[31] & B[31] & ~SUM[31]) | (~A[31] & ~B[31] & SUM[31]);

endmodule