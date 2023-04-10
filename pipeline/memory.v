module M(clk,M_stat,E_stat,E_icode,e_Cnd,e_valE,E_valA,e_dstE,E_dstM,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,M_bubble);
    input clk;
    input [3:0] E_icode;
    input signed[63:0] e_valE,E_valA;
    input [3:0] e_dstE,E_dstM;
    input  e_Cnd;
    input [3:0] E_stat;
    input M_bubble;

    output reg[3:0] M_icode;
    output reg signed[63:0] M_valE,M_valA;
    output reg[3:0] M_dstE,M_dstM;
    output reg M_Cnd;
    output reg[3:0] M_stat;

    always @(posedge clk)
    begin
        if(M_bubble==1'b1)
        begin
            M_icode <= 4'h1;
            M_Cnd   <= e_Cnd;
            M_dstE  <= 4'hF;
            M_dstM  <= 4'hF;
        end

        if(M_bubble==1'b0)
        begin
            M_stat  <= E_stat;
            M_icode <= E_icode;
            M_Cnd   <= e_Cnd;
            M_valE  <= e_valE;
            M_valA <= E_valA;
            M_dstE  <= e_dstE;
            M_dstM  <= E_dstM;  
            
        end

    end
endmodule

module Addr(clk,M_icode,M_valE,M_valA,Addr_out);
    input[3:0] M_icode;
    input signed[63:0] M_valE;
    input signed[63:0] M_valA;
    input clk;

    output reg[63:0] Addr_out;

    always @(posedge clk)
    begin
        #5
        if (M_icode==4'h0)
        begin 
            // do nothing
        end
        else if (M_icode==4'h1)
        begin 
            // do nothing
        end
        else if (M_icode==4'h2)
        begin 
            // do nothing
        end
        else if (M_icode==4'h3)
        begin 
            // do nothing
        end
        else if (M_icode==4'h4)
        begin 
            Addr_out <= M_valE;
        end
        else if (M_icode==4'h5)
        begin 
            Addr_out <= M_valE;
        end
        else if (M_icode==4'h6)
        begin 
            // do nothing
        end
        else if (M_icode==4'h7)
        begin 
            // do nothing
        end
        else if (M_icode==4'h8)
        begin 
            Addr_out <= M_valE;
        end
        else if (M_icode==4'h9)
        begin 
            Addr_out <= M_valA;
        end
        else if (M_icode==4'hA)
        begin 
            Addr_out <= M_valE;
        end
        else if (M_icode==4'hB)
        begin 
            Addr_out <= M_valA;
        end
            
        
    end
endmodule

module Mem_control(clk,M_icode,read,write);

input[3:0] M_icode;
output reg read;
output reg write;
input clk;

    always @(posedge clk)
    begin
        #5
        if (M_icode==4'h0)
        begin
            read <= 1'b0;
            write <= 1'b0;
        end
        else if (M_icode==4'h1)
        begin
            read <= 1'b0;
            write <= 1'b0;
        end
        else if (M_icode==4'h2)
        begin
            read <= 1'b0;
            write <= 1'b0;
        end
        else if (M_icode==4'h3)
        begin
            read <= 1'b0;
            write <= 1'b0;
        end
        else if (M_icode==4'h4)
        begin
            read <= 1'b0;
            write <= 1'b1;
        end
        else if (M_icode==4'h5)
        begin
            read <= 1'b1;
            write <= 1'b0;
        end
        else if (M_icode==4'h6)
        begin
            read <= 1'b0;
            write <= 1'b0;
        end
        else if (M_icode==4'h7)
        begin
            read <= 1'b0;
            write <= 1'b0;
        end
        else if (M_icode==4'h8)
        begin
            read <= 1'b0;
            write <= 1'b1;
        end
        else if (M_icode==4'h9)
        begin
            read <= 1'b1;
            write <= 1'b0;
        end
        else if (M_icode==4'hA)
        begin
            read <= 1'b0;
            write <= 1'b1;
        end
        else if (M_icode==4'hB)
        begin
            read <= 1'b1;
            write <= 1'b0;
        end
                 
    end
endmodule

module Data_memory(clk,Addr_out,M_valA,read,write,m_valM,dmem_error);
    input clk;
    input [63:0] Addr_out;
    input signed [63:0] M_valA;
    input read,write;
    output reg signed[63:0] m_valM;
    output reg dmem_error;
    reg signed[63:0] memory [1023:0];

    always @(posedge clk)
    begin
        #7
      if(Addr_out > 1023)
      begin
        dmem_error <= 1'b1;
      end
      else
      begin
        dmem_error <= 1'b0;
      end

    end

    always @ (posedge clk)
    begin 
        #10
        if (read==1'b1)
        begin
            
                m_valM <= memory[Addr_out];
            
        end 
        
    end

    always @(posedge clk)
    begin
        #10
        if (write==1'b1)
        begin
            
                memory[Addr_out] <= M_valA;
            
        end
    end
    
endmodule

module memory_Stat(clk,M_stat,dmem_error,m_stat);
    input [3:0]M_stat;
    input   dmem_error,clk;
    output reg[3:0]m_stat;

    initial
    begin
        m_stat <= 4'd4;
    end

    always @(posedge clk)
    begin
        #15
        if(dmem_error==1'b1)
        begin
            m_stat <= 4'd1;
        end
        else
        begin
            m_stat <= M_stat;
        end
    end
endmodule