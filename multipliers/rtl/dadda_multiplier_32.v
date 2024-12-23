module carry_save_adder(A,B,Cin,Y,Cout);
  input A,B,Cin;
  output Y,Cout;

  assign Y = A^B^Cin;
  assign Cout = (A&B)|(A&Cin)|(B&Cin);

endmodule
module HA(a, b, Sum, Cout);

  input a, b;
  output Sum, Cout;

  assign Sum = a ^ b;
  assign Cout = a & b;

endmodule

module dadda_multiplier_8(
    input  [7:0] A,
    input  [7:0] B,
    output [15:0] Y
  );

  // Partial product generation
  wire [7:0] pp [7:0];
  wire [0:5]s1,c1;
  wire [0:13]s2,c2;
  wire [0:9]s3,c3;
  wire [0:11]s4,c4;
  wire [0:13]s5,c5;

  genvar i, j;
  generate
    for (i = 0; i < 8; i = i + 1)
    begin: pp_compute
      for (j = 0; j < 8; j = j + 1)
      begin: gen_bit
        assign pp[i][j] = A[j] & B[i];
      end
    end
  endgenerate
  // HA and Full Adders


  // dk+1 =dk * 3/2
  // stage 1 from 8 to 6 levels
  HA adder0(.a(pp[6][0]),.b(pp[5][1]),.Sum(s1[0]),.Cout(c1[0]));
  HA adder2(.a(pp[4][3]),.b(pp[3][4]),.Sum(s1[2]),.Cout(c1[2]));
  HA adder4(.a(pp[4][4]),.b(pp[3][5]),.Sum(s1[4]),.Cout(c1[4]));

  carry_save_adder adder1(.A(pp[7][0]),.B(pp[6][1]),.Cin(pp[5][2]),.Y(s1[1]),.Cout(c1[1]));
  carry_save_adder adder3(.A(pp[7][1]),.B(pp[6][2]),.Cin(pp[5][3]),.Y(s1[3]),.Cout(c1[3]));
  carry_save_adder adder5(.A(pp[7][2]),.B(pp[6][3]),.Cin(pp[5][4]),.Y(s1[5]),.Cout(c1[5]));

  //stage 2 from 6 levels to 4 levels
  HA adder6(.a(pp[4][0]),.b(pp[3][1]),.Sum(s2[0]),.Cout(c2[0]));
  HA adder8(.a(pp[2][3]),.b(pp[1][4]),.Sum(s2[2]),.Cout(c2[2]));


  carry_save_adder adder7(.A(pp[5][0]),.B(pp[4][1]),.Cin(pp[3][2]),.Y(s2[1]),.Cout(c2[1]));
  carry_save_adder adder9(.A(s1[0]),.B(pp[4][2]),.Cin(pp[3][3]),.Y(s2[3]),.Cout(c2[3]));
  carry_save_adder adder10(.A(pp[2][4]),.B(pp[1][5]),.Cin(pp[0][6]),.Y(s2[4]),.Cout(c2[4]));
  carry_save_adder adder11(.A(s1[1]),.B(s1[2]),.Cin(c1[0]),.Y(s2[5]),.Cout(c2[5]));
  carry_save_adder adder12(.A(pp[2][5]),.B(pp[1][6]),.Cin(pp[0][7]),.Y(s2[6]),.Cout(c2[6]));
  carry_save_adder adder13(.A(s1[3]),.B(s1[4]),.Cin(c1[1]),.Y(s2[7]),.Cout(c2[7]));
  carry_save_adder adder14(.A(c1[2]),.B(pp[2][6]),.Cin(pp[1][7]),.Y(s2[8]),.Cout(c2[8]));
  carry_save_adder adder15(.A(s1[5]),.B(c1[3]),.Cin(c1[4]),.Y(s2[9]),.Cout(c2[9]));
  carry_save_adder adder16(.A(pp[4][5]),.B(pp[3][6]),.Cin(pp[2][7]),.Y(s2[10]),.Cout(c2[10]));
  carry_save_adder adder17(.A(pp[7][3]),.B(c1[5]),.Cin(pp[6][4]),.Y(s2[11]),.Cout(c2[11]));
  carry_save_adder adder18(.A(pp[5][5]),.B(pp[4][6]),.Cin(pp[3][7]),.Y(s2[12]),.Cout(c2[12]));
  carry_save_adder adder19(.A(pp[7][4]),.B(pp[6][5]),.Cin(pp[5][6]),.Y(s2[13]),.Cout(c2[13]));

  // stage 3 from 4 to 3
  HA adder20(.a(pp[3][0]),.b(pp[2][1]),.Sum(s3[0]),.Cout(c3[0]));

  carry_save_adder adder21(.A(s2[0]),.B(pp[2][2]),.Cin(pp[1][3]),.Y(s3[1]),.Cout(c3[1]));
  carry_save_adder adder22(.A(s2[1]),.B(s2[2]),.Cin(c2[0]),.Y(s3[2]),.Cout(c3[2]));
  carry_save_adder adder23(.A(c2[1]),.B(c2[2]),.Cin(s2[3]),.Y(s3[3]),.Cout(c3[3]));
  carry_save_adder adder24(.A(c2[3]),.B(c2[4]),.Cin(s2[5]),.Y(s3[4]),.Cout(c3[4]));
  carry_save_adder adder25(.A(c2[5]),.B(c2[6]),.Cin(s2[7]),.Y(s3[5]),.Cout(c3[5]));
  carry_save_adder adder26(.A(c2[7]),.B(c2[8]),.Cin(s2[9]),.Y(s3[6]),.Cout(c3[6]));
  carry_save_adder adder27(.A(c2[9]),.B(c2[10]),.Cin(s2[11]),.Y(s3[7]),.Cout(c3[7]));
  carry_save_adder adder28(.A(c2[11]),.B(c2[12]),.Cin(s2[13]),.Y(s3[8]),.Cout(c3[8]));
  carry_save_adder adder29(.A(pp[7][5]),.B(pp[6][6]),.Cin(pp[5][7]),.Y(s3[9]),.Cout(c3[9]));
  //stage 4 from 3 to 2
  HA adder55(.a(pp[2][0]),.b(pp[1][1]),.Sum(s4[0]),.Cout(c4[0]));


  carry_save_adder adder30(.A(s3[0]),.B(pp[1][2]),.Cin(pp[0][3]),.Y(s4[1]),.Cout(c4[1]));
  carry_save_adder adder31(.A(c3[0]),.B(s3[1]),.Cin(pp[0][4]),.Y(s4[2]),.Cout(c4[2]));
  carry_save_adder adder32(.A(c3[1]),.B(s3[2]),.Cin(pp[0][5]),.Y(s4[3]),.Cout(c4[3]));
  carry_save_adder adder33(.A(c3[2]),.B(s3[3]),.Cin(s2[4]),.Y(s4[4]),.Cout(c4[4]));
  carry_save_adder adder34(.A(c3[3]),.B(s3[4]),.Cin(s2[6]),.Y(s4[5]),.Cout(c4[5]));
  carry_save_adder adder35(.A(c3[4]),.B(s3[5]),.Cin(s2[8]),.Y(s4[6]),.Cout(c4[6]));
  carry_save_adder adder36(.A(c3[5]),.B(s3[6]),.Cin(s2[10]),.Y(s4[7]),.Cout(c4[7]));
  carry_save_adder adder37(.A(c3[6]),.B(s3[7]),.Cin(s2[12]),.Y(s4[8]),.Cout(c4[8]));
  carry_save_adder adder38(.A(c3[7]),.B(s3[8]),.Cin(pp[4][7]),.Y(s4[9]),.Cout(c4[9]));
  carry_save_adder adder39(.A(c3[8]),.B(s3[9]),.Cin(c2[13]),.Y(s4[10]),.Cout(c4[10]));
  carry_save_adder adder40(.A(c3[9]),.B(pp[7][6]),.Cin(pp[6][7]),.Y(s4[11]),.Cout(c4[11]));
  //stage 5 from 2 to 1
  HA adder41(.a(pp[1][0]),.b(pp[0][1]),.Sum(Y[1]),.Cout(c5[0]));



  carry_save_adder adder42(.A(s4[0]),.B(pp[0][2]),.Cin(c5[0]),.Y(Y[2]),.Cout(c5[1]));
  carry_save_adder adder43(.A(c4[0]),.B(s4[1]),.Cin(c5[1]),.Y(Y[3]),.Cout(c5[2]));
  carry_save_adder adder44(.A(c4[1]),.B(s4[2]),.Cin(c5[2]),.Y(Y[4]),.Cout(c5[3]));
  carry_save_adder adder45(.A(c4[2]),.B(s4[3]),.Cin(c5[3]),.Y(Y[5]),.Cout(c5[4]));
  carry_save_adder adder46(.A(c4[3]),.B(s4[4]),.Cin(c5[4]),.Y(Y[6]),.Cout(c5[5]));
  carry_save_adder adder47(.A(c4[4]),.B(s4[5]),.Cin(c5[5]),.Y(Y[7]),.Cout(c5[6]));
  carry_save_adder adder48(.A(c4[5]),.B(s4[6]),.Cin(c5[6]),.Y(Y[8]),.Cout(c5[7]));
  carry_save_adder adder49(.A(c4[6]),.B(s4[7]),.Cin(c5[7]),.Y(Y[9]),.Cout(c5[8]));
  carry_save_adder adder50(.A(c4[7]),.B(s4[8]),.Cin(c5[8]),.Y(Y[10]),.Cout(c5[9]));
  carry_save_adder adder51(.A(c4[8]),.B(s4[9]),.Cin(c5[9]),.Y(Y[11]),.Cout(c5[10]));
  carry_save_adder adder52(.A(c4[9]),.B(s4[10]),.Cin(c5[10]),.Y(Y[12]),.Cout(c5[11]));
  carry_save_adder adder53(.A(c4[10]),.B(s4[11]),.Cin(c5[11]),.Y(Y[13]),.Cout(c5[12]));
  carry_save_adder adder54(.A(c4[11]),.B(pp[7][7]),.Cin(c5[12]),.Y(Y[14]),.Cout(c5[13]));
  assign Y[0] =  pp[0][0];
  assign Y[15] = c5[13];
endmodule

module dadda_multiplier_16(A,B,Y);

  input [15:0]A;
  input [15:0]B;

  output wire [31:0] Y;

  wire [15:0]y11,y12,y21,y22;

  //sum and carry of final 2 stages.
  wire [15:0]s1,c1;
  wire [22:0] c2;

  dadda_multiplier_8 d1(.A(A[7:0]),.B(B[7:0]),.Y(y11));
  dadda_multiplier_8 d2(.A(A[7:0]),.B(B[15:8]),.Y(y12));
  dadda_multiplier_8 d3(.A(A[15:8]),.B(B[7:0]),.Y(y21));
  dadda_multiplier_8 d4(.A(A[15:8]),.B(B[15:8]),.Y(y22));
  assign Y[7:0] = y11[7:0];

  //Stage 1 - reducing fom 3 to 2

  carry_save_adder c_11(.A(y11[8]),.B(y12[0]),.Cin(y21[0]),.Y(s1[0]),.Cout(c1[0]));
  assign Y[8] = s1[0];
  carry_save_adder c_12(.A(y11[9]),.B(y12[1]),.Cin(y21[1]),.Y(s1[1]),.Cout(c1[1]));
  carry_save_adder c_13(.A(y11[10]),.B(y12[2]),.Cin(y21[2]),.Y(s1[2]),.Cout(c1[2]));
  carry_save_adder c_14(.A(y11[11]),.B(y12[3]),.Cin(y21[3]),.Y(s1[3]),.Cout(c1[3]));
  carry_save_adder c_15(.A(y11[12]),.B(y12[4]),.Cin(y21[4]),.Y(s1[4]),.Cout(c1[4]));
  carry_save_adder c_16(.A(y11[13]),.B(y12[5]),.Cin(y21[5]),.Y(s1[5]),.Cout(c1[5]));
  carry_save_adder c_17(.A(y11[14]),.B(y12[6]),.Cin(y21[6]),.Y(s1[6]),.Cout(c1[6]));
  carry_save_adder c_18(.A(y11[15]),.B(y12[7]),.Cin(y21[7]),.Y(s1[7]),.Cout(c1[7]));
  carry_save_adder c_19(.A(y22[0]),.B(y12[8]),.Cin(y21[8]),.Y(s1[8]),.Cout(c1[8]));
  carry_save_adder c_110(.A(y22[1]),.B(y12[9]),.Cin(y21[9]),.Y(s1[9]),.Cout(c1[9]));
  carry_save_adder c_111(.A(y22[2]),.B(y12[10]),.Cin(y21[10]),.Y(s1[10]),.Cout(c1[10]));
  carry_save_adder c_112(.A(y22[3]),.B(y12[11]),.Cin(y21[11]),.Y(s1[11]),.Cout(c1[11]));
  carry_save_adder c_113(.A(y22[4]),.B(y12[12]),.Cin(y21[12]),.Y(s1[12]),.Cout(c1[12]));
  carry_save_adder c_114(.A(y22[5]),.B(y12[13]),.Cin(y21[13]),.Y(s1[13]),.Cout(c1[13]));
  carry_save_adder c_115(.A(y22[6]),.B(y12[14]),.Cin(y21[14]),.Y(s1[14]),.Cout(c1[14]));
  carry_save_adder c_116(.A(y22[7]),.B(y12[15]),.Cin(y21[15]),.Y(s1[15]),.Cout(c1[15]));

  //Stage 2 - reducing fom 2 to 1
  HA h1(.a(s1[1]),.b(c1[0]),.Sum(Y[9]),.Cout(c2[0]));


  carry_save_adder c_22(.A(s1[2]),.B(c1[1]),.Cin(c2[0]),.Y(Y[10]),.Cout(c2[1]));
  carry_save_adder c_23(.A(s1[3]),.B(c1[2]),.Cin(c2[1]),.Y(Y[11]),.Cout(c2[2]));
  carry_save_adder c_24(.A(s1[4]),.B(c1[3]),.Cin(c2[2]),.Y(Y[12]),.Cout(c2[3]));
  carry_save_adder c_25(.A(s1[5]),.B(c1[4]),.Cin(c2[3]),.Y(Y[13]),.Cout(c2[4]));
  carry_save_adder c_26(.A(s1[6]),.B(c1[5]),.Cin(c2[4]),.Y(Y[14]),.Cout(c2[5]));
  carry_save_adder c_27(.A(s1[7]),.B(c1[6]),.Cin(c2[5]),.Y(Y[15]),.Cout(c2[6]));
  carry_save_adder c_28(.A(s1[8]),.B(c1[7]),.Cin(c2[6]),.Y(Y[16]),.Cout(c2[7]));
  carry_save_adder c_29(.A(s1[9]),.B(c1[8]),.Cin(c2[7]),.Y(Y[17]),.Cout(c2[8]));
  carry_save_adder c_210(.A(s1[10]),.B(c1[9]),.Cin(c2[8]),.Y(Y[18]),.Cout(c2[9]));
  carry_save_adder c_211(.A(s1[11]),.B(c1[10]),.Cin(c2[9]),.Y(Y[19]),.Cout(c2[10]));
  carry_save_adder c_212(.A(s1[12]),.B(c1[11]),.Cin(c2[10]),.Y(Y[20]),.Cout(c2[11]));
  carry_save_adder c_213(.A(s1[13]),.B(c1[12]),.Cin(c2[11]),.Y(Y[21]),.Cout(c2[12]));
  carry_save_adder c_214(.A(s1[14]),.B(c1[13]),.Cin(c2[12]),.Y(Y[22]),.Cout(c2[13]));
  carry_save_adder c_215(.A(s1[15]),.B(c1[14]),.Cin(c2[13]),.Y(Y[23]),.Cout(c2[14]));
  carry_save_adder c_216(.A(y22[8]),.B(c1[15]),.Cin(c2[14]),.Y(Y[24]),.Cout(c2[15]));

  HA h2(.a(y22[9]),.b(c2[15]),.Sum(Y[25]),.Cout(c2[16]));
  HA h3(.a(y22[10]),.b(c2[16]),.Sum(Y[26]),.Cout(c2[17]));
  HA h4(.a(y22[11]),.b(c2[17]),.Sum(Y[27]),.Cout(c2[18]));
  HA h5(.a(y22[12]),.b(c2[18]),.Sum(Y[28]),.Cout(c2[19]));
  HA h6(.a(y22[13]),.b(c2[19]),.Sum(Y[29]),.Cout(c2[20]));
  HA h7(.a(y22[14]),.b(c2[20]),.Sum(Y[30]),.Cout(c2[21]));
  HA h8(.a(y22[15]),.b(c2[21]),.Sum(Y[31]),.Cout(c2[22]));



endmodule
module dadda_multiplier_32(signed_A,signed_B,product);
  input [31:0] signed_A;
  input [31:0] signed_B;
  output wire [63:0] product;
  wire sign_a = signed_A[31];
  wire sign_b =  signed_B[31];
  wire final_sign = sign_a ^ sign_b;
  wire [31:0] A,B;
  wire [63:0] Y;
  assign A = sign_a ? (~signed_A + 1'b1) : signed_A;
  assign B = sign_b ? (~signed_B + 1'b1) : signed_B;


  wire [31:0]y11,y12,y21,y22;

  wire [31:0]s1,c1;
  wire [46:0]c2;
  dadda_multiplier_16 d1(.A(A[15:0]),.B(B[15:0]),.Y(y11));
  assign Y[15:0] = y11[15:0];

  dadda_multiplier_16 d2(.A(A[15:0]),.B(B[31:16]),.Y(y12));
  dadda_multiplier_16 d3(.A(A[31:16]),.B(B[15:0]),.Y(y21));
  dadda_multiplier_16 d4(.A(A[31:16]),.B(B[31:16]),.Y(y22));


  //Stage 1 - reducing fom 3 to 2

  carry_save_adder c_11(.A(y11[16]),.B(y12[0]),.Cin(y21[0]),.Y(s1[0]),.Cout(c1[0]));
  assign Y[16] = s1[0];
  carry_save_adder c_12(.A(y11[17]),.B(y12[1]),.Cin(y21[1]),.Y(s1[1]),.Cout(c1[1]));
  carry_save_adder c_13(.A(y11[18]),.B(y12[2]),.Cin(y21[2]),.Y(s1[2]),.Cout(c1[2]));
  carry_save_adder c_14(.A(y11[19]),.B(y12[3]),.Cin(y21[3]),.Y(s1[3]),.Cout(c1[3]));
  carry_save_adder c_15(.A(y11[20]),.B(y12[4]),.Cin(y21[4]),.Y(s1[4]),.Cout(c1[4]));
  carry_save_adder c_16(.A(y11[21]),.B(y12[5]),.Cin(y21[5]),.Y(s1[5]),.Cout(c1[5]));
  carry_save_adder c_17(.A(y11[22]),.B(y12[6]),.Cin(y21[6]),.Y(s1[6]),.Cout(c1[6]));
  carry_save_adder c_18(.A(y11[23]),.B(y12[7]),.Cin(y21[7]),.Y(s1[7]),.Cout(c1[7]));
  carry_save_adder c_19(.A(y11[24]),.B(y12[8]),.Cin(y21[8]),.Y(s1[8]),.Cout(c1[8]));
  carry_save_adder c_110(.A(y11[25]),.B(y12[9]),.Cin(y21[9]),.Y(s1[9]),.Cout(c1[9]));
  carry_save_adder c_111(.A(y11[26]),.B(y12[10]),.Cin(y21[10]),.Y(s1[10]),.Cout(c1[10]));
  carry_save_adder c_112(.A(y11[27]),.B(y12[11]),.Cin(y21[11]),.Y(s1[11]),.Cout(c1[11]));
  carry_save_adder c_113(.A(y11[28]),.B(y12[12]),.Cin(y21[12]),.Y(s1[12]),.Cout(c1[12]));
  carry_save_adder c_114(.A(y11[29]),.B(y12[13]),.Cin(y21[13]),.Y(s1[13]),.Cout(c1[13]));
  carry_save_adder c_115(.A(y11[30]),.B(y12[14]),.Cin(y21[14]),.Y(s1[14]),.Cout(c1[14]));
  carry_save_adder c_116(.A(y11[31]),.B(y12[15]),.Cin(y21[15]),.Y(s1[15]),.Cout(c1[15]));
  carry_save_adder c_117(.A(y22[0]),.B(y12[16]),.Cin(y21[16]),.Y(s1[16]),.Cout(c1[16]));
  carry_save_adder c_118(.A(y22[1]),.B(y12[17]),.Cin(y21[17]),.Y(s1[17]),.Cout(c1[17]));
  carry_save_adder c_119(.A(y22[2]),.B(y12[18]),.Cin(y21[18]),.Y(s1[18]),.Cout(c1[18]));
  carry_save_adder c_120(.A(y22[3]),.B(y12[19]),.Cin(y21[19]),.Y(s1[19]),.Cout(c1[19]));
  carry_save_adder c_121(.A(y22[4]),.B(y12[20]),.Cin(y21[20]),.Y(s1[20]),.Cout(c1[20]));
  carry_save_adder c_122(.A(y22[5]),.B(y12[21]),.Cin(y21[21]),.Y(s1[21]),.Cout(c1[21]));
  carry_save_adder c_123(.A(y22[6]),.B(y12[22]),.Cin(y21[22]),.Y(s1[22]),.Cout(c1[22]));
  carry_save_adder c_124(.A(y22[7]),.B(y12[23]),.Cin(y21[23]),.Y(s1[23]),.Cout(c1[23]));
  carry_save_adder c_125(.A(y22[8]),.B(y12[24]),.Cin(y21[24]),.Y(s1[24]),.Cout(c1[24]));
  carry_save_adder c_126(.A(y22[9]),.B(y12[25]),.Cin(y21[25]),.Y(s1[25]),.Cout(c1[25]));
  carry_save_adder c_127(.A(y22[10]),.B(y12[26]),.Cin(y21[26]),.Y(s1[26]),.Cout(c1[26]));
  carry_save_adder c_128(.A(y22[11]),.B(y12[27]),.Cin(y21[27]),.Y(s1[27]),.Cout(c1[27]));
  carry_save_adder c_129(.A(y22[12]),.B(y12[28]),.Cin(y21[28]),.Y(s1[28]),.Cout(c1[28]));
  carry_save_adder c_130(.A(y22[13]),.B(y12[29]),.Cin(y21[29]),.Y(s1[29]),.Cout(c1[29]));
  carry_save_adder c_131(.A(y22[14]),.B(y12[30]),.Cin(y21[30]),.Y(s1[30]),.Cout(c1[30]));
  carry_save_adder c_132(.A(y22[15]),.B(y12[31]),.Cin(y21[31]),.Y(s1[31]),.Cout(c1[31]));


  //Stage 1 - reducing fom 2 to 1
  // adding total sum and carry to get final output
  HA h1(.a(s1[1]),.b(c1[0]),.Sum(Y[17]),.Cout(c2[0]));


  carry_save_adder c_22(.A(s1[2]),.B(c1[1]),.Cin(c2[0]),.Y(Y[18]),.Cout(c2[1]));
  carry_save_adder c_23(.A(s1[3]),.B(c1[2]),.Cin(c2[1]),.Y(Y[19]),.Cout(c2[2]));
  carry_save_adder c_24(.A(s1[4]),.B(c1[3]),.Cin(c2[2]),.Y(Y[20]),.Cout(c2[3]));
  carry_save_adder c_25(.A(s1[5]),.B(c1[4]),.Cin(c2[3]),.Y(Y[21]),.Cout(c2[4]));
  carry_save_adder c_26(.A(s1[6]),.B(c1[5]),.Cin(c2[4]),.Y(Y[22]),.Cout(c2[5]));
  carry_save_adder c_27(.A(s1[7]),.B(c1[6]),.Cin(c2[5]),.Y(Y[23]),.Cout(c2[6]));
  carry_save_adder c_28(.A(s1[8]),.B(c1[7]),.Cin(c2[6]),.Y(Y[24]),.Cout(c2[7]));
  carry_save_adder c_29(.A(s1[9]),.B(c1[8]),.Cin(c2[7]),.Y(Y[25]),.Cout(c2[8]));
  carry_save_adder c_210(.A(s1[10]),.B(c1[9]),.Cin(c2[8]),.Y(Y[26]),.Cout(c2[9]));
  carry_save_adder c_211(.A(s1[11]),.B(c1[10]),.Cin(c2[9]),.Y(Y[27]),.Cout(c2[10]));
  carry_save_adder c_212(.A(s1[12]),.B(c1[11]),.Cin(c2[10]),.Y(Y[28]),.Cout(c2[11]));
  carry_save_adder c_213(.A(s1[13]),.B(c1[12]),.Cin(c2[11]),.Y(Y[29]),.Cout(c2[12]));
  carry_save_adder c_214(.A(s1[14]),.B(c1[13]),.Cin(c2[12]),.Y(Y[30]),.Cout(c2[13]));
  carry_save_adder c_215(.A(s1[15]),.B(c1[14]),.Cin(c2[13]),.Y(Y[31]),.Cout(c2[14]));
  carry_save_adder c_216(.A(s1[16]),.B(c1[15]),.Cin(c2[14]),.Y(Y[32]),.Cout(c2[15]));
  carry_save_adder c_217(.A(s1[17]),.B(c1[16]),.Cin(c2[15]),.Y(Y[33]),.Cout(c2[16]));
  carry_save_adder c_218(.A(s1[18]),.B(c1[17]),.Cin(c2[16]),.Y(Y[34]),.Cout(c2[17]));
  carry_save_adder c_219(.A(s1[19]),.B(c1[18]),.Cin(c2[17]),.Y(Y[35]),.Cout(c2[18]));
  carry_save_adder c_220(.A(s1[20]),.B(c1[19]),.Cin(c2[18]),.Y(Y[36]),.Cout(c2[19]));
  carry_save_adder c_221(.A(s1[21]),.B(c1[20]),.Cin(c2[19]),.Y(Y[37]),.Cout(c2[20]));
  carry_save_adder c_222(.A(s1[22]),.B(c1[21]),.Cin(c2[20]),.Y(Y[38]),.Cout(c2[21]));
  carry_save_adder c_223(.A(s1[23]),.B(c1[22]),.Cin(c2[21]),.Y(Y[39]),.Cout(c2[22]));
  carry_save_adder c_224(.A(s1[24]),.B(c1[23]),.Cin(c2[22]),.Y(Y[40]),.Cout(c2[23]));
  carry_save_adder c_225(.A(s1[25]),.B(c1[24]),.Cin(c2[23]),.Y(Y[41]),.Cout(c2[24]));
  carry_save_adder c_226(.A(s1[26]),.B(c1[25]),.Cin(c2[24]),.Y(Y[42]),.Cout(c2[25]));
  carry_save_adder c_227(.A(s1[27]),.B(c1[26]),.Cin(c2[25]),.Y(Y[43]),.Cout(c2[26]));
  carry_save_adder c_228(.A(s1[28]),.B(c1[27]),.Cin(c2[26]),.Y(Y[44]),.Cout(c2[27]));
  carry_save_adder c_229(.A(s1[29]),.B(c1[28]),.Cin(c2[27]),.Y(Y[45]),.Cout(c2[28]));
  carry_save_adder c_230(.A(s1[30]),.B(c1[29]),.Cin(c2[28]),.Y(Y[46]),.Cout(c2[29]));
  carry_save_adder c_231(.A(s1[31]),.B(c1[30]),.Cin(c2[29]),.Y(Y[47]),.Cout(c2[30]));
  carry_save_adder c_232(.A(y22[16]),.B(c1[31]),.Cin(c2[30]),.Y(Y[48]),.Cout(c2[31]));


  HA h2(.a(y22[17]),.b(c2[31]),.Sum(Y[49]),.Cout(c2[32]));
  HA h3(.a(y22[18]),.b(c2[32]),.Sum(Y[50]),.Cout(c2[33]));
  HA h4(.a(y22[19]),.b(c2[33]),.Sum(Y[51]),.Cout(c2[34]));
  HA h5(.a(y22[20]),.b(c2[34]),.Sum(Y[52]),.Cout(c2[35]));
  HA h6(.a(y22[21]),.b(c2[35]),.Sum(Y[53]),.Cout(c2[36]));
  HA h7(.a(y22[22]),.b(c2[36]),.Sum(Y[54]),.Cout(c2[37]));
  HA h8(.a(y22[23]),.b(c2[37]),.Sum(Y[55]),.Cout(c2[38]));
  HA h9(.a(y22[24]),.b(c2[38]),.Sum(Y[56]),.Cout(c2[39]));
  HA h10(.a(y22[25]),.b(c2[39]),.Sum(Y[57]),.Cout(c2[40]));
  HA h11(.a(y22[26]),.b(c2[40]),.Sum(Y[58]),.Cout(c2[41]));
  HA h12(.a(y22[27]),.b(c2[41]),.Sum(Y[59]),.Cout(c2[42]));
  HA h13(.a(y22[28]),.b(c2[42]),.Sum(Y[60]),.Cout(c2[43]));
  HA h14(.a(y22[29]),.b(c2[43]),.Sum(Y[61]),.Cout(c2[44]));
  HA h15(.a(y22[30]),.b(c2[44]),.Sum(Y[62]),.Cout(c2[45]));
  HA h16(.a(y22[31]),.b(c2[45]),.Sum(Y[63]),.Cout(c2[46]));

  assign product = final_sign ? (~Y + 1'b1) : Y;

endmodule
