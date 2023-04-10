//`include "add64.v"
//`include "full_adder.v"
module add64_test;

reg signed [63:0] A;
reg signed [63:0] B;
wire signed [63:0] S;
reg [1:0] control;

wire overflow;

//S, Cout,A, B 


add64 dut(S,overflow,A,B,control);
        
initial
    begin
        $dumpfile("add64_test.vcd");
        $dumpvars(0,add64_test);
        
        A = 64'b0;
        B = 64'b1;
     
        #100
        A = 64'b1;
        B = 64'b0;

        #100
        A = 64'b1;
        B = 64'b1;

        #100
        A = 64'b1001111111111111111111111111111111111111111111111111111111110000;
        B = 64'b1001111111111111111111111111111111111111111111111111111111111110;

        #100
        A = 64'd30;
        B = 64'd50;


    end
        always @(*)
        #50
        $display("time=%0t\nA = %b\nB = %b\noverflow = %b\nC = %d\n\n", $time, A, B, overflow,S);

        
        //$monitor($time, "a=%b\t%d\n b=%b\t%d\n sum=%b\t%d\n, overflow=%b\n", a,a,b,b,sum, sum, OF);
        //$monitor("time: %0d\n a  : %b\t%d\n b  : %b\t%d\n sum: %b\t%d\n overflow=%b\n ", $time, a,b,sum);
        //$monitor("A = %b\nb = %b\nc = %b\n\n" , A, B, S);

       // #100
        //A = 64'b1111111111111111111111111111111111111111111111111111111111110000;
        //B = 64'b1111111111111111111111111111111111111111111111111111111111111110;


    
endmodule

