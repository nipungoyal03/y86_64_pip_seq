module halfadder(input a,input b, output sum,output carry);  
xor xor1(sum,a,b); 
and and1(carry,a,b); 
endmodule

module full_adder(output sum, output cout, input a, b, c_in);

wire w1;
wire w2;
halfadder h1(a, b, w1, w2);
wire w3;
halfadder h2(w1, c_in, sum, w3);
or o1(cout, w2, w3);
endmodule