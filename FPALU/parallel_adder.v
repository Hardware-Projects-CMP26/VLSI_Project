module parallel_fp_adder (
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] result
  );

  wire sign_a = a[31];
  wire sign_b = b[31];
  wire [7:0] exp_a = a[30:23];
  wire [7:0] exp_b = b[30:23];
  wire [24:0] mant_a = {2'b01, a[22:0]};
  wire [24:0] mant_b = {2'b01, b[22:0]};


  wire [7:0] exp_diff = (exp_a > exp_b) ? (exp_a - exp_b) : (exp_b - exp_a);
  wire [7:0] larger_exp = (exp_a > exp_b) ? exp_a : exp_b;

  wire [48:0] aligned_mant_a, aligned_mant_b;
  assign aligned_mant_a = (exp_a > exp_b) ? {mant_a, 24'b0} : (mant_a << (24 - exp_diff));
  assign aligned_mant_b = (exp_a > exp_b) ? (mant_b << (24 - exp_diff)) : {mant_b, 24'b0};


  wire [48:0] sum_path = aligned_mant_a + aligned_mant_b;
  wire [48:0] sub_path = (aligned_mant_a >= aligned_mant_b) ?
       aligned_mant_a - aligned_mant_b :
       aligned_mant_b - aligned_mant_a;


  function [5:0] count_leading_zeros;
    input [48:0] value;
    integer i;
    begin
      count_leading_zeros = 0;
      for (i = 48; i >= 0; i = i - 1)
        if (!value[i] && count_leading_zeros == (48-i))
          count_leading_zeros = count_leading_zeros + 1;
    end
  endfunction


  reg [48:0] pre_norm_mant;
  reg [7:0] pre_norm_exp;
  reg final_sign;

  always @(*)
  begin

    if (sign_a == sign_b)
    begin
      pre_norm_mant = sum_path;
      final_sign = sign_a;
    end
    else
    begin
      pre_norm_mant = sub_path;
      final_sign = (aligned_mant_a >= aligned_mant_b) ? sign_a : sign_b;
    end


    pre_norm_exp = larger_exp;
    if (pre_norm_mant[48])
    begin
      pre_norm_mant = pre_norm_mant >> 1;
      pre_norm_exp = pre_norm_exp + 1;
    end
    else
    begin
      automatic reg [5:0] lzc = count_leading_zeros(pre_norm_mant);
      pre_norm_mant = pre_norm_mant << lzc;
      pre_norm_exp = pre_norm_exp - lzc;
    end

    result = {final_sign, pre_norm_exp, pre_norm_mant[46:24]};
  end

endmodule
