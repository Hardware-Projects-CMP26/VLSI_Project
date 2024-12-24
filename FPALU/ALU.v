module ALU (
    input signed [31:0] A,
    input signed [31:0] B,
    input select,
    output reg signed [31:0] result
  );


  wire signed [31:0] res_add;
  wire signed [31:0] res_mul;

  fp_adder adder_inst (
             .A(A),
             .B(B),
             .result(res_add)
           );

  fp_multiplier multiplier_inst (
                  .a(A),
                  .b(B),
                  .result(res_mul)
                );


  always @(*)
  begin
    if (select == 1)
    begin
      result = res_add;
    end
    else
    begin
      result = res_mul;
    end
  end

endmodule
