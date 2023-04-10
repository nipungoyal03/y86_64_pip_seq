
module sub64(S,overflow,A,B,control);

//output sum, output cout, input a, b, c_in

output signed [63:0] S;

output overflow;
input [1:0] control;

input signed [63:0] A;
input signed [63:0] B;

wire signed [63:0] tempA;
wire signed [63:0] tempB;
wire signed [63:0] tempS;
wire signed [63:0] Bnot;
wire tempC;
wire x;
xor(x,A[63],B[63]);
wire y;
reg temp;

wire [64:0] carry;

assign carry[0]=1'b1;

genvar k;
generate for(k=0;k<64;k=k+1)
        begin
            not(Bnot[k],B[k]);
            
        end
endgenerate



genvar i;

for(i=0;i<64;i=i+1)
begin
    
    assign tempA[i] = A[i];
    assign tempB[i] = Bnot[i];
    full_adder f(tempS[i], carry[i+1],tempA[i] ,tempB[i],carry[i]);
    assign S[i] = tempS[i];
   

end


xor(y,B[63],S[63]);

always@(*)
begin
    if (x==1'b1)
    begin
        if (y==1'b0)
            temp = 1'b1;
        else 
            temp = 1'b0;
    end
    else 
        temp = 1'b0;
end

assign overflow = temp;

endmodule