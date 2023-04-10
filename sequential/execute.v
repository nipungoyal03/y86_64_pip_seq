`include "ALU.v"

module execute(flag_2,icode,ifun,valA,valB,valC,valE,zf,sf,of,cnd);

input flag_2;
input  [3:0]icode;
input  [3:0]ifun;
input signed [63:0]valA;
input signed [63:0]valB;
input signed [63:0]valC;
output reg signed [63:0] valE;
output reg  zf=0, sf=0,of=0;
output reg cnd;

reg [1:0]control;
reg signed [63:0]A;
reg signed [63:0]B;
wire signed [63:0]C;
wire overflow;


ALU dut(control,A,B,C,overflow);


always @(posedge flag_2)
begin

    zf=0;
    sf=0;
    of=0;

    if(icode == 4'd4 || icode==4'd5 || icode==4'd9 || icode==4'd11 || (icode==4'd6 && ifun==4'd0))
    begin
        control <= 2'b00;
    end
    else if(icode==4'd8 || icode==4'd10 || (icode==4'd6 && ifun==4'd1))
    begin
        control <= 2'b01;
    end
    else if(icode==4'd6 && ifun==4'd2)
    begin
        control <= 2'b10;
    end
    else if(icode==4'd6 && ifun==4'd3)
    begin
        control <= 2'b11;
    end

   //////////////////// cmovXX ////////////////

    if ((icode == 4'b0010)&&(ifun == 4'b0000)) //rrmovq
    begin
        
        cnd=1'b1;
        valE=valA;

    end

    else if ((icode == 4'b0010)&&(ifun == 4'b0001)) //cmovle
    begin
        if((sf^of)|zf)
        begin
            cnd=1'b1;
            valE = valA;
        end 
    end
        
    else if ((icode == 4'b0010)&&(ifun == 4'b0010)) //cmovl
        begin
            if(sf^of)
            begin
                cnd=1'b1;
                valE = valA;
            end
        end
        
    else if((icode == 4'b0010)&&(ifun == 4'b0011)) //cmove
        begin
            if(zf)
            begin
                cnd=1'b1;
                valE = valA;
            end 
        end
        
    else if((icode == 4'b0010)&&(ifun == 4'b0100)) //cmovne
        begin
            if(~zf)
            begin
                cnd=1'b1;
               valE = valA;
            end
        end
        
    else if((icode == 4'b0010)&&(ifun == 4'b0101)) //cmovge
        begin
            if(~(sf^of))
            begin
                cnd=1'b1;
               valE = valA;
            end
        end
        
    else if((icode == 4'b0010)&&(ifun == 4'b0110)) //cmovg
        begin
            if((~(sf^of)&(~zf)))  
            begin
                cnd=1'b1;
                valE = valA;
            end
        end

    else
    begin
        cnd=1'b0;
    end

     //////////////////// /irmovq ////////////////////
    if(icode == 4'b0011) 
    begin
        
        valE <= valC;
    end
      //////////////////// //rmmovq ////////////////////
    if(icode == 4'b0100) 
    begin
        A <= valB;
        B <= valC;
        
        #1;

        valE = C;
    end
    //////////////////// //mrmovq ////////////////////
    if(icode == 4'b0101) 
    begin
        A <= valB;
        B <= valC;
        
        #1;

        valE = C;
    end
        
    //////////////////// OPq ////////////////////

    if (icode == 4'b0110 && ifun == 4'b0000) //////// ADD
    begin
       
        A <= valA;
        B <= valB;
        #1
        valE = C;
        of = overflow;
        if(C[63] == 1'b1 )
            sf = 1'b1;
            
        if(C == 64'b0)
            zf = 1'b1;
 
        
    end

    if (icode == 4'b0110 && ifun == 4'b0001) //////// SUB
    begin
        
      
        A <= valA;
        B <= valB;
        #1
        valE = C;
        of = overflow;
        if(C[63] == 1'b1 )
            sf = 1;
            
        if(C == 64'b0)
            zf = 1;

        
    end

    if (icode == 4'b0110 && ifun == 4'b0010) //////// AND
    begin

        A <= valA;
        B <= valB;
     
        #1
        valE = C;
        of = overflow;
        if(C[63] == 1'b1 )
            sf = 1;

        if(C == 64'b0)
            zf = 1;

        
    end
    
      
    if (icode == 4'b0110 && ifun == 4'b0011) //////// XOR
    begin

        A <= valA;
        B <= valB;
        
        #1
        valE = C;
        of = overflow;
        if(C[63] == 1'b1 )
            sf = 1;
            
        if(C == 64'b0)
                zf = 1;
   

    end
        
    ///////////////////// jXX ///////////////////////////////
    
    
    if ((icode == 4'b0111)&&(ifun == 4'b0000)) //jmp
    begin
        
        cnd=1'b1;

    end
        
    else if((icode == 4'b0111)&&(ifun == 4'b0001))//jle
    begin
        if((sf^of)|zf)
        begin
            cnd=1'b1;
        end 
    end
        
    else if((icode == 4'b0111)&&(ifun == 4'b0010)) //jl
        begin
            if(sf^of)
            begin
                cnd=1'b1;
            end
        end
    else if((icode == 4'b0111)&&(ifun == 4'b0011)) //je
          begin
            if(zf)
            begin
                cnd=1'b1;
            end 
        end
    else if((icode == 4'b0111)&&(ifun == 4'b0100)) //jne
        begin
            if(~zf)
            begin
                cnd=1'b1;
            end
        end
    else if((icode == 4'b0111)&&(ifun == 4'b0101)) //jge
        begin
            if(~(sf^of))
            begin
                cnd=1'b1;
            end
        end
    else if((icode == 4'b0111)&&(ifun == 4'b0110)) //jg
        begin
            if((~(sf^of)&(~zf)))
            begin
                cnd=1'b1;
            end
        end
    else 
    begin
        cnd=1'b0;
    end

    ///////////////////// call //////////////////

    if(icode == 4'b1000) 
    begin
        A <= valB;
        B <= 64'b1000;
        
        #1
        valE = C;
    end

    ///////////////////// ret //////////////////

    if(icode == 4'b1001) 
    begin
        A <= valB;
        B <= 64'b1000;
        #1
        valE = C;
    end

    ///////////////////// //popq  //////////////////

    if(icode == 4'b1011) 
    begin
        A <= valA;
        B <= 64'b1000;
        #1
        valE = C;
    end

    if(icode == 4'b1010) //pushq 
    begin
        A <= valB;
        B <= 64'b1000;
        #1
        valE = C;
    end
    end

   endmodule

