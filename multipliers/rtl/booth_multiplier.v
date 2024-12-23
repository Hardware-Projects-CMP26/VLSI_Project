module booth_multiplier #(
    parameter WIDTH = 32
  )(
    input [WIDTH-1:0] multiplicand,  // This will be 'a'
    input [WIDTH-1:0] multiplier,    // This will be 'b'
    output reg [(2*WIDTH)-1:0] product
  );


  reg [1:0] booth_encoding;
  reg [WIDTH:0] partial_product;
  reg [(2*WIDTH)-1:0] shifted_partial_product;
  reg [(2*WIDTH)-1:0] accumulated_sum;


  wire [WIDTH:0] extended_multiplicand = {multiplicand[WIDTH-1], multiplicand};
  wire [WIDTH:0] neg_multiplicand = -extended_multiplicand;


  reg [WIDTH:0] multiplier_padded;
  integer i;

  always @(*)
  begin
    multiplier_padded = {multiplier, 1'b0};
    accumulated_sum = 0;


    for (i = 0; i < WIDTH; i = i + 1)
    begin
      booth_encoding = multiplier_padded[1:0];


      case (booth_encoding)
        2'b00, 2'b11:
          partial_product = 0;                  // 0
        2'b01:
          partial_product = extended_multiplicand;   // +M
        2'b10:
          partial_product = neg_multiplicand;   // -M
        default:
          partial_product = 0;
      endcase

      shifted_partial_product = $signed(partial_product) << i;
      accumulated_sum = accumulated_sum + shifted_partial_product;


      multiplier_padded = {1'b0, multiplier_padded[WIDTH:1]};
    end

    product = accumulated_sum;
  end

endmodule
