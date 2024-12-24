module parallel_fp_multiplier (
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] result
);
   
    wire sign_a = a[31];
    wire sign_b = b[31];
    wire [7:0] exp_a = a[30:23];
    wire [7:0] exp_b = b[30:23];
    wire [23:0] mant_a = {1'b1, a[22:0]}; 
    wire [23:0] mant_b = {1'b1, b[22:0]};
    wire [47:0] product = mant_a * mant_b;
    wire [8:0] sum_exp = exp_a + exp_b - 127;
    reg [7:0] final_exp;
    reg [22:0] final_mant;
    
    always @(*) begin
        if (product[47]) begin  
            final_exp = sum_exp + 1;
            final_mant = product[46:24];
        end else begin  
            final_exp = sum_exp;
            final_mant = product[45:23];
        end
        
        if ((exp_a == 0) || (exp_b == 0)) begin  
            final_exp = 0;
            final_mant = 0;
        end else if ((exp_a == 8'hFF) || (exp_b == 8'hFF)) begin  
            final_exp = 8'hFF;
            final_mant = 0;
        end
        result = {sign_a ^ sign_b, final_exp, final_mant};
    end
endmodule