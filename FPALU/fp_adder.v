module ripple_4bit (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output Cout
  );
  wire [3:0] P;
  assign P=A ^ B;
  wire [3:0] Cout_temp;
  assign select=&P;
  assign Cout = (select == 1'b1) ? Cin : Cout_temp[3];
  assign {Cout_temp[0],Sum[0]} = A[0] + B[0] + Cin;
  assign {Cout_temp[1],Sum[1]} = A[1] + B[1] + Cout_temp[0];
  assign {Cout_temp[2],Sum[2]} = A[2] + B[2] + Cout_temp[1];
  assign {Cout_temp[3],Sum[3]} = A[3] + B[3] + Cout_temp[2];

endmodule
module Bypass_Adder (
    input [31:0] A,
    input [31:0] B,
    input Cin,
    output [31:0] Sum,
    output Cout
  );

  wire [8:0]Ctemp;
  assign Ctemp[0]=Cin;

  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1)
    begin : ripple_loop
      ripple_4bit R(
                    .A(A[(4*i+3):(4*i)]),
                    .B(B[(4*i+3):(4*i)]),
                    .Cin(Ctemp[i]),
                    .Sum(Sum[(4*i+3):(4*i)]),
                    .Cout(Ctemp[i+1])
                  );
    end
  endgenerate
  assign Cout=Ctemp[8];

endmodule

module fp_adder (
    input signed  [31:0] A,
    input signed [31:0] B,
    output signed [31:0] result
  );
  reg sign1, sign2;
  reg [7:0] exponent1, exponent2;
  reg signed [22:0] fraction1, fraction2;
  reg signed [31:0] fraction1_32, fraction2_32,fraction1_32neg,fraction2_32neg;
  wire signed [31:0] result_fraction_add, result_fraction_sub12,result_fraction_sub21;
  reg signed [22:0] result_fraction;
  reg signed [7:0] result_exponent;
  reg result_sign;
  reg [21:0] temp_fraction;
  integer i;
  wire cout,cin;
  assign cin=0;
  reg signed [7:0] exponent_diff;

  Bypass_Adder fraction_add(
                 .A(fraction1_32),
                 .B(fraction2_32),
                 .Cin(cin),
                 .Sum(result_fraction_add),
                 .Cout(cout)
               );
  Bypass_Adder fraction_sub12(
                 .A(fraction1_32),
                 .B(fraction2_32neg),
                 .Cin(cin),
                 .Sum(result_fraction_sub12),
                 .Cout(cout)
               );
  CarryBypass_Adder fraction_sub21(
                      .A(fraction1_32neg),
                      .B(fraction2_32),
                      .Cin(cin),
                      .Sum(result_fraction_sub21),
                      .Cout(cout)
                    );

  always @*
  begin
    sign1 = A[31];
    sign2 = B[31];
    exponent1 = A[30:23];
    exponent2 = B[30:23];
    fraction1 =  A[22:0];
    fraction2 =  B[22:0];
    exponent_diff = exponent1 - exponent2;
    if (exponent_diff < 0)
    begin
      exponent_diff = -exponent_diff;
      fraction1 = $signed(fraction1) >>> exponent_diff;
      result_exponent = exponent2;
      result_sign = sign2;
    end
    else
    begin
      fraction2 = $signed(fraction2) >>> exponent_diff;
      result_exponent = exponent1;
      result_sign = sign1;
    end

    fraction1_32 = { {9{fraction1[22]}}, fraction1 };
    fraction2_32 = { {9{fraction2[22]}}, fraction2 };
    if (sign1 == sign2)
    begin
      result_fraction=result_fraction_add[22:0];
    end
    else
    begin
      if (fraction1 > fraction2)
      begin
        fraction2_32neg= -fraction2_32;
        result_fraction=result_fraction_sub12[22:0];
        result_sign = sign1;
      end
      else
      begin
        fraction1_32neg= -fraction1_32;
        result_fraction=result_fraction_sub21[22:0];
        result_sign = sign2;
      end
    end
    temp_fraction=result_fraction[21:0];
    if (result_fraction==23'b0)
    begin
      temp_fraction=22'b0;
    end
    else
    begin
      for(i = 0; i < 22; i = i + 1)
      begin
        if(temp_fraction[21]==0)
        begin
          temp_fraction = temp_fraction <<1;
          result_exponent =result_exponent-1;
        end
      end
    end
    result_fraction[21:0]=temp_fraction;

  end

  // Construct the result
  assign result = {result_sign, result_exponent, result_fraction};

endmodule
