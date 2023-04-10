module xor64(output signed [63:0] C ,output overflow,input signed [63:0] A,input signed [63:0] B,input [1:0] control);
    
    //always @(*) begin
    genvar i;
    for(i=0; i<64; i=i+1) begin
        xor(C[i], A[i], B[i]);
    end
    //end
    assign overflow = 1'b0;

endmodule