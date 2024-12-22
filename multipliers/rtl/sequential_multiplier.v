module sequential_multiplier (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [31:0] multiplicand,
    input wire [31:0] multiplier,
    output reg signed [31:0] product,
    output reg done
);

    localparam IDLE = 2'b00;
    localparam CALC = 2'b01;
    localparam FINISH = 2'b10;

    reg [1:0] state;
    reg [63:0] acc;
    reg [31:0] m;
    reg [31:0] q;
    reg [5:0] count;
    reg sign;

    wire [31:0] abs_multiplicand = multiplicand[31] ? -multiplicand : multiplicand;
    wire [31:0] abs_multiplier = multiplier[31] ? -multiplier : multiplier;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            acc <= 64'b0;
            m <= 32'b0;
            q <= 32'b0;
            count <= 6'b0;
            product <= 32'b0;
            done <= 1'b0;
            sign <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        acc <= 64'b0;
                        m <= abs_multiplier;
                        q <= abs_multiplicand;
                        count <= 6'b0;
                        done <= 1'b0;
                        state <= CALC;

                        sign <= multiplicand[31] ^ multiplier[31];
                    end
                end

                CALC: begin
                    if (count < 32) begin
                        if (m[0]) begin
                            acc <= acc + ({32'b0, q} << count);
                        end

                        m <= m >> 1;
                        count <= count + 1;
                    end
                    else begin
                        state <= FINISH;
                    end
                end

                FINISH: begin
                    // Apply sign to final result
                    product <= sign ? -acc[31:0] : acc[31:0];
                    done <= 1'b1;
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
