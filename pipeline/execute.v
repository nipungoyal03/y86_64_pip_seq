`include "ALU.v"
module E(clk,D_stat,E_stat,D_icode,D_ifun,D_valC,d_dstE,d_dstM,d_srcA,d_srcB,d_valA,d_valB,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,E_srcA,E_srcB,E_bubble);
    input clk;
    input [3:0] D_icode,D_ifun;
    input signed[63:0] D_valC;
    input signed[63:0] d_valA,d_valB;
    input [3:0] d_dstE,d_dstM;
    input [3:0] d_srcA,d_srcB;
    input [3:0] D_stat;
    input E_bubble;

    output reg[3:0] E_icode, E_ifun;
    output reg signed[63:0] E_valC;
    output reg signed[63:0] E_valA,E_valB;
    output reg[3:0] E_dstE,E_dstM;
    output reg[3:0] E_srcA,E_srcB;
    output reg[3:0] E_stat;

    initial
    begin
    E_icode <= 4'h1;  // nop
    end
    always @(posedge clk)
    begin
        if(!E_bubble)
        begin
            E_stat  <= D_stat;
            E_icode <= D_icode;
            E_ifun  <= D_ifun;
            E_valC  <= D_valC;
            E_valA  <= d_valA;
            E_valB  <= d_valB;
            E_dstE  <= d_dstE;
            E_dstM  <= d_dstM;
            E_srcA  <= d_srcA;
            E_srcB  <= d_srcB;
            
        end
        else
        begin
            E_icode <= 4'h1;
        end
    end
    

endmodule

module ALU_A_B_logics(clk,E_icode,E_valA,E_valB,E_valC,ALU_A,ALU_B);
input clk;
    input [3:0] E_icode;
    input signed[63:0] E_valA,E_valB,E_valC;
    output reg signed[63:0] ALU_A,ALU_B;
    
    always @ (posedge clk)
    begin
        #5
        if(E_icode == 4'd0)
        begin
            // do nothing
            ALU_A <= 64'd0;
            ALU_B <= 64'd0;
        end
        else if(E_icode == 4'd1)
        begin
            // do nothing
            ALU_A <= 64'd0;
            ALU_B <= 64'd0;
        end
        else if(E_icode == 4'd2)
        begin
            ALU_A <= E_valA;
            ALU_B <= 64'd0;
        end
        else if(E_icode == 4'd3)
        begin
            ALU_A <= E_valC;
            ALU_B <= 64'd0;
        end
        else if(E_icode == 4'd4)
        begin
            ALU_A <= E_valC;
            ALU_B <= E_valB;
        end
        else if(E_icode == 4'd5)
        begin
            ALU_A <= E_valC;
            ALU_B <= E_valB;
        end
        else if(E_icode == 4'd6)
        begin
            ALU_A <= E_valA;
            ALU_B <= E_valB;
        end
        else if(E_icode == 4'd7)
        begin
            // do nothing
            ALU_A <= 64'd0;
            ALU_B <= 64'd0;
        end
        else if(E_icode == 4'd8)
        begin
            ALU_A <= E_valB;
            ALU_B <= 64'd8;
        end
        else if(E_icode == 4'd9)
        begin
            ALU_A <= 64'd8;
            ALU_B <= E_valB;
        end
        else if(E_icode == 4'd10)
        begin
            ALU_A <= E_valB;
            ALU_B <= 64'd8;
        end
        else if(E_icode == 4'd11)
        begin
            ALU_A <= 64'd8;
            ALU_B <= E_valB;
        end

    end

endmodule

module ALU_fun(clk,E_icode,E_ifun,control);
    input clk;
    input [3:0] E_icode;
    input [3:0] E_ifun;
    output reg [1:0] control;

    
    always @ (posedge clk)
    begin
        #5
        if(E_icode==4'd6 && E_ifun==4'd0)
        begin
            control <= 2'b00;
        end
        else if(E_icode==4'd6 && E_ifun==4'd1)
        begin
            control <= 2'b01;
        end
        else if(E_icode==4'd6 && E_ifun==4'd2)
        begin
            control <= 2'b10;
        end
        else if(E_icode==4'd6 && E_ifun==4'd3)
        begin
            control <= 2'b11;
        end
        else if(E_icode==4'd9 || E_icode==4'd11)
        begin
            control <= 2'b00;
        end
        else if(E_icode==4'd8 || E_icode==4'd10)
        begin
            control <= 2'b01;
        end
        else
        begin
            control <= 2'b00;
        end
    end
endmodule


module ALU_overall(clk,E_icode,E_ifun,ALU_A,ALU_B,control,zf,of,sf,e_valE,m_stat,W_stat);
input [3:0] E_icode,E_ifun;
input signed [63:0]ALU_A;
input signed [63:0]ALU_B;
input [1:0]control;
input [3:0] m_stat,W_stat;
output reg signed [63:0]e_valE; 
output reg  zf,sf,of;
input clk;

reg signed [63:0]A;
reg signed [63:0]B;
reg [1:0] ctr;
wire signed [63:0]C;

wire overflow;


ALU dut(ctr,A,B,C,overflow);

initial 
begin
    of<=1'b0;
    sf<=1'b0;
    zf<=1'b0;
end

always @(posedge clk)
begin
    #10
    

    ctr<=control;
    A<=ALU_A;
    B<=ALU_B;
    #5

    e_valE<=C;

   
   

    if(E_icode==4'd6 && (m_stat!=4'd1 && m_stat !=4'd2 && m_stat !=4'd3) && (W_stat!=4'd1 && W_stat!=4'd2 && W_stat!=4'd3))
    begin
         of<=overflow;

        if(C[63] == 1'b1 )
        begin
            sf <= 1'b1;
        end
        else
        begin
            sf <= 1'b0;
        end
            
        if(C == 64'b0)
        begin
            zf <= 1'b1;
        end
        else
        begin
            zf <= 1'b0;
        end
    end


end

endmodule

module CC(clk,E_icode,E_ifun,sf,of,zf,e_Cnd);
    
    input[3:0] E_icode, E_ifun;
    input of,zf,sf,clk;
    output reg e_Cnd;
    initial
    begin
        e_Cnd <=0;
    end
    always @(posedge clk)
    begin
        #20


    if ((E_icode == 4'b0010)&&(E_ifun == 4'b0000)) //rrmovq
    begin
        
        e_Cnd<=1'b1;

    end

    else if ((E_icode == 4'b0010)&&(E_ifun == 4'b0001)) //cmovle
    begin
        if((sf^of)|zf)
        begin
            e_Cnd<=1'b1;
        end 
    end
        
    else if ((E_icode == 4'b0010)&&(E_ifun == 4'b0010)) //cmovl
        begin
            if(sf^of)
            begin
                e_Cnd<=1'b1;
            end
        end
        
    else if((E_icode == 4'b0010)&&(E_ifun == 4'b0011)) //cmove
        begin
            if(zf)
            begin
                e_Cnd<=1'b1;
            end 
        end
        
    else if((E_icode == 4'b0010)&&(E_ifun == 4'b0100)) //cmovne
        begin
            if(~zf)
            begin
                e_Cnd<=1'b1;
            end
        end
        
    else if((E_icode == 4'b0010)&&(E_ifun == 4'b0101)) //cmovge
        begin
            if(~(sf^of))
            begin
                e_Cnd<=1'b1;
            end
        end
        
    else if((E_icode == 4'b0010)&&(E_ifun == 4'b0110)) //cmovg
        begin
            if((~(sf^of)&(~zf)))  
            begin
                e_Cnd<=1'b1;
            end
        end
    else
    begin
        e_Cnd<=1'b0;
    end


    if ((E_icode == 4'b0111)&&(E_ifun == 4'b0000)) //jmp
    begin
        
        e_Cnd<=1'b1;

    end
        
    else if((E_icode == 4'b0111)&&(E_ifun == 4'b0001))//jle
    begin
        if((sf^of)|zf)
        begin
            e_Cnd<=1'b1;
        end 
    end
        
    else if((E_icode == 4'b0111)&&(E_ifun == 4'b0010)) //jl
        begin
            if(sf^of)
            begin
                e_Cnd<=1'b1;
            end
        end
    else if((E_icode == 4'b0111)&&(E_ifun == 4'b0011)) //je
          begin
            if(zf)
            begin
                e_Cnd<=1'b1;
            end 
        end
    else if((E_icode == 4'b0111)&&(E_ifun == 4'b0100)) //jne
        begin
            if(~zf)
            begin
                e_Cnd<=1'b1;
            end
        end
    else if((E_icode == 4'b0111)&&(E_ifun == 4'b0101)) //jge
        begin
            if(~(sf^of))
            begin
                e_Cnd<=1'b1;
            end
        end
    else if((E_icode == 4'b0111)&&(E_ifun == 4'b0110)) //jg
        begin
            if((~(sf^of)&(~zf)))
            begin
                e_Cnd<=1'b1;
            end
        end
    else 
    begin
        e_Cnd<=1'b0;
    end
        
    end

endmodule

module exe_dstE(clk,E_icode,E_dstE,e_Cnd,e_dstE);
    input [3:0] E_icode;
    input [3:0] E_dstE;
    input e_Cnd,clk;
    output reg[3:0] e_dstE;

    always @(posedge clk)
    begin
        #25
        if(E_icode==4'd2 && e_Cnd==1'b0)
        begin
            e_dstE <= 4'd15;
        end
        else
        begin
            e_dstE <= E_dstE;
        end
        
    end

endmodule

