//`include "full_adder.v"

module add64(S,overflow,A,B,control);

//output sum, output cout, input a, b, c_in

output signed [63:0] S;
input [1:0] control;

input signed [63:0] A;
input signed [63:0] B;
output overflow;

wire signed [63:0] tempA;
wire signed [63:0] tempB;
wire signed [63:0] tempS;
wire tempC;

wire x;
wire y;
reg temp;

xor(x,A[63],B[63]);


wire carry[64:0];

assign carry[0]=1'b0;

genvar i;

for(i=0;i<64;i=i+1)
begin
    
    assign tempA[i] = A[i];
    assign tempB[i] = B[i];
    full_adder f(tempS[i], carry[i+1],tempA[i] ,tempB[i],carry[i]);
    assign S[i] = tempS[i];
    

end

xor(y,A[63],S[63]);

always@(*)
begin

    if (x==1'b0)
    begin
        if(y==1'b1)
         temp = 1'b1; 
        else 
        temp = 1'b0; 
    end 
    else
      temp = 1'b0;

end 

assign overflow = temp;

endmodule