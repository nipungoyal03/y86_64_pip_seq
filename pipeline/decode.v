
module D(clk,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,f_stat,D_bubble,D_stall,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat);
    input clk;
    input [3:0] f_icode,f_ifun;
    input [3:0] f_rA,f_rB;
    input signed[63:0] f_valC;
    input [63:0] f_valP;
    input [3:0] f_stat;
    input D_bubble;
    input D_stall;
    
    output reg[3:0] D_icode,D_ifun;
    output reg[3:0] D_rA,D_rB;
    output reg signed[63:0] D_valC;
    output reg [63:0] D_valP;
    output reg[3:0] D_stat;

    initial
    begin
        D_icode <= 4'h1;
    end

    always @(posedge clk)
    begin
        

        if(D_stall==1)
        begin
            // do nothing but recalculate previous stage
        end
        else if(D_stall==0 && D_bubble==1)
        begin
            D_icode <= 4'h1; 
            D_stat  <= f_stat;
        end
        else
        begin
            D_icode  <= f_icode;
            D_ifun  <= f_ifun;
            D_rA  <= f_rA;
            D_rB  <= f_rB;
            D_valC  <= f_valC;
            D_valP  <= f_valP;
            D_stat  <= f_stat;
        end
        
    end
    

endmodule

module src_A_B_logics(clk,D_icode,D_rA,D_rB,d_srcA,d_srcB);

    input[3:0] D_icode;
    input[3:0] D_rA,D_rB;
    input clk;
    output reg[3:0] d_srcA,d_srcB;

    always @(posedge clk)
    begin
        #5
        if(D_icode==4'd0)
        begin
            d_srcA<=4'd15;
            d_srcB<=4'd15;
        end
        else if(D_icode==4'd1)
        begin
            d_srcA<=4'd15;
            d_srcB<=4'd15;
        end
        else if(D_icode==4'd2)
        begin
            d_srcA<=D_rA;
            d_srcB<=4'd15;
        end
        else if(D_icode==4'd3)
        begin
            d_srcA<=4'd15;
            d_srcB<=4'd15;
        end
        else if(D_icode==4'd4)
        begin
            d_srcA<=D_rA;
            d_srcB<=D_rB;
        end
        else if(D_icode==4'd5)
        begin
            d_srcA<=4'd15;
            d_srcB<=D_rB;
        end
        else if(D_icode==4'd6)
        begin
            d_srcA<=D_rA;
            d_srcB<=D_rB;
        end
        else if(D_icode==4'd7)
        begin
            d_srcA<=4'd15;
            d_srcB<=4'd15;
        end
        else if(D_icode==4'd8)
        begin
            d_srcA<=4'd15;
            d_srcB<=4'd4;
        end
        else if(D_icode==4'd9)
        begin
            d_srcA<=4'd4;
            d_srcB<=4'd4;
        end
        else if(D_icode==4'd10)
        begin
            d_srcA<=D_rA;
            d_srcB<=4'd4;
        end
        else if(D_icode==4'd11)
        begin
            d_srcA<=4'd4;
            d_srcB<=4'd4;
        end

    end 
endmodule

module register_file(clk,W_dstE,W_icode, W_dstM, d_srcA , d_srcB , d_rvalA , d_rvalB , W_valM, W_valE);
    input clk;
    input [3:0] d_srcA,d_srcB;
    input [3:0] d_dstE,d_dstM,W_icode;
    input signed[63:0] W_valE,W_valM;
    input [3:0] W_dstE,W_dstM;
    output reg signed[63:0] d_rvalA,d_rvalB;

    reg signed[63:0] Registors [14:0];

    initial
    begin
        Registors[4] <= 64'd16;
    end


    always @ (posedge clk)
    begin
        #50
        if(d_srcA!=4'd15)
        begin
            d_rvalA <= Registors[d_srcA] ;
        end
        
        if(d_srcB!=4'd15)
        begin
            d_rvalB <= Registors[d_srcB] ;
        end

    end
    always @(posedge clk)
    begin   
        #1

        if(W_icode==4'd9)
        begin
            Registors[W_dstE] <= W_valE;
        end
        else
        begin
        
        if(W_dstE!=4'd15)
        begin
            Registors[W_dstE] <= W_valE;
            
        end
        
        if(W_dstM!=4'd15)
        begin
            Registors[W_dstM] <= W_valM;
        end

        end
        

    end

    always @(posedge clk)
    begin
        #102
        $display("rax = %d \n rbx = %d \n rcx = %d \n rdx = %d \n rsp = %d \n rbp = %d\n rdi = %d \n rsi = %d \n r8 = %d \n r9 = %d \n r10 = %d \n r11 = %d \n r12 = %d \n r13 = %d \n r14 = %d\n\n\n\n\n",Registors[0],Registors[1],Registors[2],Registors[3],Registors[4],Registors[5],Registors[6],Registors[7],Registors[8],Registors[9],Registors[10],Registors[11],Registors[12],Registors[13],Registors[14]);
    end


endmodule



module dst_E_M_logics(clk,D_icode,D_rA,D_rB,d_dstE,d_dstM);

    

    input[3:0] D_icode;
    input[3:0] D_rA,D_rB;
    input clk;
    output reg [3:0] d_dstE,d_dstM;

    always @(posedge clk)
    begin
        #5
        if(D_icode==4'd0)
        begin
            d_dstE<=4'd15;
            d_dstM<=4'd15;
        end
        else if(D_icode==4'd1)
        begin
            d_dstE<=4'd15;
            d_dstM<=4'd15;
        end
        else if(D_icode==4'd2)
        begin
            d_dstE<=D_rB;
            d_dstM<=4'd15;
        end
        else if(D_icode==4'd3)
        begin
            d_dstE<=D_rB;
            d_dstM<=4'd15;
        end
        else if(D_icode==4'd4)
        begin
            d_dstE<=4'd15;
            d_dstM<=4'd15;
        end
        else if(D_icode==4'd5)
        begin
            d_dstE<=4'd15;
            d_dstM<=D_rA;
        end
        else if(D_icode==4'd6)
        begin
            d_dstE<=D_rB;
            d_dstM<=4'd15;
        end
        else if(D_icode==4'd7)
        begin
            d_dstE<=4'd15;
            d_dstM<=4'd15;
        end
        else if(D_icode==4'd8)
        begin
            d_dstE<=4'd4;
            d_dstM<=4'd15;
        end
        else if(D_icode==4'd9)
        begin
            d_dstE<=4'd4;
            d_dstM<=4'd4;
        end
        else if(D_icode==4'd10)
        begin
            d_dstE<=4'd4;
            d_dstM<=4'd15;
        end
        else if(D_icode==4'd11)
        begin
            d_dstE<=4'd4;
            d_dstM<=D_rA;
        end

    end 
endmodule


module Forwarding_A_B_logics(clk,D_icode,D_valP,d_rvalA,d_rvalB,d_srcA,d_srcB,W_valE,W_dstE,W_valM,W_dstM,m_valM,M_dstM,M_valE,M_dstE,e_valE,e_dstE,d_valA,d_valB);
    input [3:0] D_icode,e_dstE,M_dstE,M_dstM,W_dstE,W_dstM,d_srcA,d_srcB;
    input [63:0] D_valP;
    input signed [63:0] d_rvalA,d_rvalB;
    input signed[63:0] e_valE;
    input signed[63:0] m_valM,M_valE;
    input signed[63:0] W_valE,W_valM;
    input clk;
    
    output reg signed[63:0] d_valA;
    output reg signed[63:0] d_valB;

    always @(posedge clk)
    begin
        #60
        if(D_icode==4'd0)
        begin
            // Do nothing
        end
        else if(D_icode==4'd1)
        begin
            // Do nothing
        end
        else if(D_icode==4'd2 || D_icode==4'd3 || D_icode==4'd4 || D_icode==4'd5 || D_icode==4'd6)
        begin
            if(d_srcA==e_dstE)
            begin
                d_valA <= e_valE;
            end
            else if(d_srcA==m_valM)
            begin
                d_valA <= m_valM;
            end
            else if(d_srcA==M_dstE)
            begin
                d_valA <= M_valE;
            end
            else if(d_srcA==W_dstM)
            begin
                d_valA <= W_valM;
            end
            else if(d_srcA==W_dstE)
            begin
                d_valA <= W_valE;
            end
            else
            begin
                d_valA <= d_rvalA;
            end

            if(d_srcB==e_dstE)
            begin
                d_valB <= e_valE;
            end
            else if(d_srcB==m_valM)
            begin
                d_valB <= m_valM;
            end
            else if(d_srcB==M_dstE)
            begin
                d_valB <= M_valE;
            end
            else if(d_srcB==W_dstM)
            begin
                d_valB <= W_valM;
            end
            else if(d_srcB==W_dstE)
            begin
                d_valB <= W_valE;
            end
            else
            begin
                d_valB <= d_rvalB;
            end
        end
        else if(D_icode==4'd7)
        begin
             d_valA <= D_valP;
        end
        else if(D_icode==4'd8)
        begin
            d_valA <= D_valP;
            d_valB <= d_rvalB;
        end
        else if(D_icode==4'd9 || D_icode==4'd10 || D_icode==4'd11)
        begin
            if(d_srcA==e_dstE)
            begin
                d_valA <= e_valE;
            end
            else if(d_srcA==m_valM)
            begin
                d_valA <= m_valM;
            end
            else if(d_srcA==M_dstE)
            begin
                d_valA <= M_valE;
            end
            else if(d_srcA==W_dstM)
            begin
                d_valA <= W_valM;
            end
            else if(d_srcA==W_dstE)
            begin
                d_valA <= W_valE;
            end
            else
            begin
                d_valA <= d_rvalA;
            end

            if(d_srcB==e_dstE)
            begin
                d_valB <= e_valE;
            end
            else if(d_srcB==m_valM)
            begin
                d_valB <= m_valM;
            end
            else if(d_srcB==M_dstE)
            begin
                d_valB <= M_valE;
            end
            else if(d_srcB==W_dstM)
            begin
                d_valB <= W_valM;
            end
            else if(d_srcB==W_dstE)
            begin
                d_valB <= W_valE;
            end
            else
            begin
                d_valB <= d_rvalB;
            end
        end
       
        
    end

endmodule

