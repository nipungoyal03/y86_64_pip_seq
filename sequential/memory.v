module memory(input flag_2,input [3:0]icode,ifun, input [63:0] valA, valB, valP, valE, output reg [63:0] valM, output reg error);

reg [63:0] memory [0:127];
reg flag1,flag2;

always @(negedge flag_2)
begin
    if(icode==4'h4 || icode==4'h5 || icode==4'h8 || icode==4'hA)
        flag1 = 1;
    else
        flag1 = 0;

    if(icode==4'h9 || icode==4'hB)
        flag2 = 1;
    else
        flag2 = 0;
end


always@(negedge flag_2)
begin
    #5;
    if((valE>64'd127 && flag1==1) || (valA>64'd127 && flag2==1))
    begin
        error=1'd1;
    end

    else if(icode==4'b0100)    //rmmovq
    begin 
        memory[valE] = valA; 
    end

    else if(icode==4'b0101)    //mrmovq 
    begin 
        valM = memory[valE]; 
    end

    else if(icode==4'b1000)    //call
    begin 
        memory[valE] = valP; 
    end

    else if(icode==4'b1001)    //ret
    begin 
        valM = memory[valA]; 
    end

    else if(icode==4'b1010)    //pushq
    begin 
        memory[valE] = valA; 
    end
    
    else if(icode==4'b1011)    //popq
    begin 
        valM = memory[valA]; 
    end
   
end

endmodule