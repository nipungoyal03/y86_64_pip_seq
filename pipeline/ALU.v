`include "full_adder.v"
`include "XOR/xor64.v"
`include "not64.v"
`include "SUB/sub64.v"
`include "ADD/add64.v"
`include "AND/and64.v"

module ALU(control,A,B,C,overflow);

input [1:0] control;
input signed [63:0] A;
input signed [63:0] B;
output signed [63:0] C;
reg signed [63:0] tempC;
wire overflow1;
wire overflow2;
wire overflow3;
wire overflow4;

reg OF1;


output overflow;

//assign OF = 1'b0 ;

wire signed [63:0] out1;
wire signed [63:0] out2;
wire signed [63:0] out3;
wire signed [63:0] out4;

wire signed [63:0] tempA;
wire signed [63:0] tempB;

assign tempA = A;
assign tempB = B;

//assign overflow = 1'b0;

add64 a(out1,overflow1,tempA,tempB,control);
sub64 s(out2,overflow2,tempA,tempB,control);
and64 a1(out3,overflow3,tempA,tempB,control);
xor64 x(out4,overflow4,tempA,tempB,control);
    

always@(*)
begin
    
    
    if (control == 2'b00) begin
        
        tempC = out1;
        OF1 = overflow1;
        
    end

    if (control == 2'b01) begin
        tempC = out2;
         OF1 = overflow2;

    end

    if (control == 2'b10) begin
        
       tempC = out3;
       OF1 = overflow3;
    end

    if (control == 2'b11) begin
        
        tempC = out4;
         OF1 = overflow4;
       
    end
    
   
end
assign C = tempC;
assign overflow = OF1;
//assign overflow = OF;

endmodule


