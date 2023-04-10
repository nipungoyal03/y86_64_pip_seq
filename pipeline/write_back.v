module W(clk,W_stat,m_stat,M_icode,M_valE,m_valM,M_dstE,M_dstM,W_icode,W_valE,W_valM,W_dstE,W_dstM,W_stall);
    input clk;
    input [3:0] M_icode;
    input signed[63:0] M_valE,m_valM;
    input [3:0] M_dstE,M_dstM;
    input [3:0] m_stat;
    input W_stall;

    output reg[3:0] W_icode;
    output reg signed[63:0] W_valE,W_valM;
    output reg[3:0] W_dstE,W_dstM;
    output reg[3:0] W_stat;

   
    always @(posedge clk)
    begin
        if (!W_stall)
        begin
            W_stat  <= m_stat;
            W_icode <= M_icode;
            W_valE  <= M_valE;
            W_valM  <= m_valM;
            W_dstE  <= M_dstE;
            W_dstM  <= M_dstM;    
        end
    end
endmodule