module carry_look_ahead_adder (
    input signed [31:0] A, 
    input signed [31:0] B, 
    input Cin,    
    output reg signed [31:0] SUM, 
    output Cout,
    output Overflow
);

reg [31:0] G;
reg [31:0] P;
reg [32:0] Cins;

integer i;

always @* begin
    for (i = 0; i < 32; i = i + 1) begin
        G[i] = A[i] & B[i];
        P[i] = A[i] ^ B[i];
    end

    Cins[0] = Cin;
    for (i = 1; i < 32; i = i + 1) begin
        Cins[i] = G[i-1] | (P[i-1] & Cins[i-1]);
    end

    for (i = 0; i < 32; i = i + 1) begin
        SUM[i] = P[i] ^ Cins[i];
    end
end

assign Cout = G[31] | (P[31] & Cins[31]);
assign Overflow = (A[31] & B[31] & ~SUM[31]) | (~A[31] & ~B[31] & SUM[31]);

endmodule