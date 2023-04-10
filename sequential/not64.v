module not64(output signed [63:0] Ans,input signed [63:0] A);
 
    // not operator for 64 bits
    //for loop

    genvar i;

    for(i=0; i<64; i=i+1) begin
        not(Ans[i],A[i]);
    end
endmodule