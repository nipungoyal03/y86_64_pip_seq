`include "sub64.v"
`include "full_adder.v"
module sub64_test;

reg signed [63:0] A;
reg signed [63:0] B;

wire signed [63:0] S;
wire overflow;
reg [1:0] control;
//wire [63:0] US;

//S, Cout,A, B 


sub64 dut(S,overflow,A,B,control);

initial
    begin
        
        $dumpfile("sub64_test.vcd");
        $dumpvars(0,sub64_test);

        $monitor("time=%0t\nA = %b\nb = %b\nd = %b\nc = %b\n\n", $time, A, B,overflow,S);
        A = 64'b0;
        B = 64'b1;
     
        #100
        A = 64'b1;
        B = 64'b0;

        #100
        A = 64'b1;
        B = 64'b1;

         #100
        A = 64'b1111111111111111111111111111111111111111111111111111111111110000;
        B = 64'b0111111111111111111111111111111111111111111111111111111111111110;

    end
        // always @(*)
        // #100
        // $display("time=%0t\nA = %b\nb = %b\nd = %b\nc = %b\n\n", $time, A, B,US, S);

        
        //$monitor($time, "a=%b\t%d\n b=%b\t%d\n sum=%b\t%d\n, overflow=%b\n", a,a,b,b,sum, sum, OF);
        //$monitor("time: %0d\n a  : %b\t%d\n b  : %b\t%d\n sum: %b\t%d\n overflow=%b\n ", $time, a,b,sum);
        //$monitor("A = %b\nb = %b\nc = %b\n\n" , A, B, S);

       // #100
        //A = 64'b1111111111111111111111111111111111111111111111111111111111110000;
        //B = 64'b1111111111111111111111111111111111111111111111111111111111111110;


    
endmodule

