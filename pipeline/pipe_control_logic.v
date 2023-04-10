module Pipe_control_logic(clk,D_icode,E_icode,M_icode,d_srcA,d_srcB,,E_dstM,e_Cnd,,m_stat,W_stat,F_stall,D_stall,D_bubble,E_bubble,M_bubble,W_stall);

    input [3:0] D_icode,E_icode,M_icode;
    input [3:0] d_srcA,d_srcB;
    input [3:0] E_dstM;
    input [3:0] m_stat,W_stat;
    input e_Cnd,clk; 

    output reg F_stall,D_stall,W_stall;
    output reg D_bubble,E_bubble,M_bubble;

    initial
    begin
        F_stall <= 1'b0;
        D_stall <= 1'b0; 
        D_bubble <= 1'b0;
        E_bubble <= 1'b0;
        M_bubble <= 1'b0;
        W_stall <= 1'b0; 
    end

    always @(posedge clk)
    begin
        #95

        F_stall <= 1'b0;
        D_stall <= 1'b0; 
        D_bubble <= 1'b0;
        E_bubble <= 1'b0;
        M_bubble <= 1'b0;
        W_stall <= 1'b0; 

        if(W_stat == 4'd2 ||  W_stat == 4'd1 || W_stat == 4'd3) // errors
        begin
            M_bubble <= 1'b1;
        end
        else if(m_stat == 4'd2 ||  m_stat == 4'd1 || m_stat == 4'd3) // errors
        begin
            M_bubble <= 1'b1;
        end
        else if(D_icode == 4'h9 || E_icode == 4'h9 || M_icode == 4'h9) // return statements
        begin
            F_stall <= 1'b1;
            D_bubble <= 1'b1;
        end
        else if(E_icode == 4'h5 || E_icode == 4'hB)
        begin
            if(E_dstM == d_srcA || E_dstM == d_srcB)
            begin
            F_stall <= 1'b1;
            D_stall <= 1'b1;
            E_bubble <= 1'b1;
            end
        end
        else if( E_icode == 4'h7 && !e_Cnd )
        begin
            D_bubble <= 1'b1;
            E_bubble <= 1'b1;
        end
        if(( E_icode == 4'h7 && !e_Cnd ) && (D_icode == 4'h9 || E_icode == 4'h9 || M_icode == 4'h9)) // misprediction + return
        begin
            F_stall <= 1'b1;
            D_bubble <= 1'd1;
            E_bubble <= 1'b1;
        end
        if(((E_icode == 4'h5 || E_icode == 4'hB)  && (E_dstM == d_srcA || E_dstM== d_srcB)) && (D_icode == 4'h9 || E_icode == 4'h9 || M_icode == 4'h9)) // load hazard + return
        begin
         F_stall <= 1'b1;
         D_stall <= 1'b1;
         E_bubble <= 1'b1;
        end
    
    end

endmodule