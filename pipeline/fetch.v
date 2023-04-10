

module Instruction_memory(clk,f_pc,f_icode,f_ifun,f_rA,f_rB,f_valC,imem_error,instr_valid);

input [63:0] f_pc;
input clk;
output reg [3:0] f_icode,f_ifun;
output reg [3:0] f_rA,f_rB;
output reg signed[63:0] f_valC;
output reg imem_error,instr_valid;

reg [7:0] instruction [247:0];

reg [0:79] instr;

initial
begin
    // define instruction memory

instruction[1] = 8'b00110000;
instruction[2] = 8'b11110000; 
instruction[3] = 8'b00000000; 
instruction[4] = 8'b00000000; 
instruction[5] = 8'b00000000; 
instruction[6] = 8'b00000000; 
instruction[7] = 8'b00000000; 
instruction[8] = 8'b00000000; 
instruction[9] = 8'b00000000; 
instruction[10] = 8'b00000111; 

instruction[11] = 8'b00110000;
instruction[12] = 8'b11110001; 
instruction[13] = 8'b00000000; 
instruction[14] = 8'b00000000; 
instruction[15] = 8'b00000000; 
instruction[16] = 8'b00000000; 
instruction[17] = 8'b00000000; 
instruction[18] = 8'b00000000; 
instruction[19] = 8'b00000000; 
instruction[20] = 8'b00000101; 

instruction[21] = 8'b00110000;
instruction[22] = 8'b11110010; 
instruction[23] = 8'b00000000; 
instruction[24] = 8'b00000000; 
instruction[25] = 8'b00000000; 
instruction[26] = 8'b00000000; 
instruction[27] = 8'b00000000; 
instruction[28] = 8'b00000000; 
instruction[29] = 8'b00000000; 
instruction[30] = 8'b00000100; 

instruction[31] = 8'b00110000;
instruction[32] = 8'b11110011; 
instruction[33] = 8'b00000000; 
instruction[34] = 8'b00000000; 
instruction[35] = 8'b00000000; 
instruction[36] = 8'b00000000; 
instruction[37] = 8'b00000000; 
instruction[38] = 8'b00000000; 
instruction[39] = 8'b00000000; 
instruction[40] = 8'b00000110; 

instruction[41] = 8'b01100000;
instruction[42] = 8'b00110010; 

instruction[43] = 8'b01100001;
instruction[44] = 8'b00000001; 

instruction[45] = 8'b10000000; 
instruction[46] = 8'b00000000; 
instruction[47] = 8'b00000000; 
instruction[48] = 8'b00000000; 
instruction[49] = 8'b00000000; 
instruction[50] = 8'b00000000; 
instruction[51] = 8'b00000000;
instruction[52] = 8'b00000000; 
instruction[53] = 8'b01011001; 

instruction[54] = 8'b01000000; 
instruction[55] = 8'b00100011; 
instruction[56] = 8'b00000000; 
instruction[57] = 8'b00000000; 
instruction[58] = 8'b00000000; 
instruction[59] = 8'b00000000; 
instruction[60] = 8'b00000000; 
instruction[61] = 8'b00000000;
instruction[62] = 8'b00000000; 
instruction[63] = 8'b00000111; 

instruction[64] = 8'b01010000; 
instruction[65] = 8'b10100011; 
instruction[66] = 8'b00000000; 
instruction[67] = 8'b00000000; 
instruction[68] = 8'b00000000; 
instruction[69] = 8'b00000000;
instruction[70] = 8'b00000000; 
instruction[71] = 8'b00000000;
instruction[72] = 8'b00000000; 
instruction[73] = 8'b00000111; 

instruction[74] = 8'b01100000;
instruction[75] = 8'b10100001;

instruction[76] = 8'b10100000;
instruction[77] = 8'b00101111;

instruction[78] = 8'b10110000;
instruction[79] = 8'b10111111;

instruction[80] = 8'b01110000;
instruction[81] = 8'b00000000; 
instruction[82] = 8'b00000000; 
instruction[83] = 8'b00000000; 
instruction[84] = 8'b00000000; 
instruction[85] = 8'b00000000; 
instruction[86] = 8'b00000000; 
instruction[87] = 8'b00000000; 
instruction[88] = 8'b01011110;

instruction[89] = 8'b01100010;
instruction[90] = 8'b00000001;

instruction[91] = 8'b01100011;
instruction[92] = 8'b00000000;

instruction[93] = 8'b10010000;

instruction[94] = 8'b00010000;

instruction[95] = 8'b01100001;
instruction[96] = 8'b10100010;

instruction[97] = 8'b01110100;
instruction[98] = 8'b00000000; 
instruction[99] = 8'b00000000; 
instruction[100] = 8'b00000000; 
instruction[101] = 8'b00000000; 
instruction[102] = 8'b00000000; 
instruction[103] = 8'b00000000; 
instruction[104] = 8'b00000000; 
instruction[105] = 8'b01111110;

instruction[106] = 8'b00110000;
instruction[107] = 8'b11110101; 
instruction[108] = 8'b00000000; 
instruction[109] = 8'b00000000; 
instruction[110] = 8'b00000000; 
instruction[111] = 8'b00000000; 
instruction[112] = 8'b00000000; 
instruction[113] = 8'b00000000; 
instruction[114] = 8'b00000000; 
instruction[115] = 8'b00000001;

instruction[116] = 8'b00110000;
instruction[117] = 8'b11110110; 
instruction[118] = 8'b00000000; 
instruction[119] = 8'b00000000; 
instruction[120] = 8'b00000000; 
instruction[121] = 8'b00000000; 
instruction[122] = 8'b00000000; 
instruction[123] = 8'b00000000; 
instruction[124] = 8'b00000000; 
instruction[125] = 8'b00000010;

instruction[126] = 8'b00110000;
instruction[127] = 8'b11110111; 
instruction[128] = 8'b00000000; 
instruction[129] = 8'b00000000; 
instruction[130] = 8'b00000000; 
instruction[131] = 8'b00000000; 
instruction[132] = 8'b00000000; 
instruction[133] = 8'b00000000; 
instruction[134] = 8'b00000000; 
instruction[135] = 8'b00000011;

instruction[136] = 8'b00110000;
instruction[137] = 8'b11111000; 
instruction[138] = 8'b00000000; 
instruction[139] = 8'b00000000; 
instruction[140] = 8'b00000000; 
instruction[141] = 8'b00000000; 
instruction[142] = 8'b00000000; 
instruction[143] = 8'b00000000; 
instruction[144] = 8'b00000000; 
instruction[145] = 8'b00000100;

instruction[146] = 8'b01100001;
instruction[147] = 8'b00000001;

instruction[148] = 8'b00000000;

end

always @(posedge clk)
begin
    #55
    if(f_pc<64'd0 || f_pc>64'd148)
    begin
        imem_error=1'd1;
    end
    else
    begin
        imem_error=1'd0;
    end
instr={
        instruction[f_pc],
        instruction[f_pc+1],
        instruction[f_pc+2],
        instruction[f_pc+3],
        instruction[f_pc+4],
        instruction[f_pc+5],
        instruction[f_pc+6],
        instruction[f_pc+7],
        instruction[f_pc+8],
        instruction[f_pc+9]
      };

end

always @(instr)
begin
    #1

    f_icode=instr[0:3];
    f_ifun=instr[4:7];

    #1
    
    if(f_icode==4'd0)
        begin
            
        end
    if(f_icode==4'd1)
        begin
            
        end
    if(f_icode==4'd2)
        begin
            
            f_rA<=instr[8:11];
            f_rB<=instr[12:15];
        end
    if(f_icode==4'd3)
        begin
            
            f_rA<=instr[8:11];
            f_rB<=instr[12:15];
            f_valC<=instr[16:79];
        end
    if(f_icode==4'd4)
        begin
            
            f_rA<=instr[8:11];
            f_rB<=instr[12:15];
            f_valC<=instr[16:79];
        end
    if(f_icode==4'd5)
        begin
           
            f_rA<=instr[8:11];
            f_rB<=instr[12:15];
            f_valC<=instr[16:79];
        end
    if(f_icode==4'd6)
        begin
            
            f_rA<=instr[8:11];
            f_rB<=instr[12:15];
        end
    if(f_icode==4'd7)
        begin
            
            f_valC<=instr[8:71];
        end
    if(f_icode==4'd8)
        begin
           
            f_valC<=instr[8:71];
        end
    if(f_icode==4'd9)
        begin
            
        end
    if(f_icode==4'd10)
        begin
            
            f_rA<=instr[8:11];
            f_rB<=instr[12:15];
        end
    if(f_icode==4'd11)
        begin
            
            f_rA<=instr[8:11];
            f_rB<=instr[12:15];
            end


end


endmodule

module PC_Increment(clk,f_pc,f_icode,f_valP);
    input [63:0] f_pc;
    input [3:0] f_icode;
    input clk;
    output reg[63:0] f_valP;
    initial
    begin
        f_valP <= 64'd1;
    end
    always @(posedge clk)
    begin
        #57
        if(f_icode==4'd0)
            begin
                f_valP <= f_pc+1;
            end
        if(f_icode==4'd1)
            begin
                f_valP <= f_pc+1;
            end
        if(f_icode==4'd2)
            begin
                f_valP <= f_pc+2;
            end
        if(f_icode==4'd3)
            begin
                f_valP <= f_pc+10;
            end
        if(f_icode==4'd4)
            begin
                f_valP <= f_pc+10;
            end
        if(f_icode==4'd5)
            begin
                f_valP <= f_pc+10;
            end
        if(f_icode==4'd6)
            begin
                f_valP <= f_pc+2;
            end
        if(f_icode==4'd7)
            begin
                f_valP <= f_pc+9;
            end
        if(f_icode==4'd8)
            begin
                f_valP <= f_pc+9;
            end
        if(f_icode==4'd9)
            begin
                f_valP <= f_pc+1;
            end
        if(f_icode==4'd10)
            begin
                f_valP <= f_pc+2;
            end
        if(f_icode==4'd11)
            begin
                f_valP <= f_pc+2;
            end
    end
endmodule


module Predict_PC(clk,f_icode,f_ifun,f_valP,f_valC,f_predPC);
    input [3:0] f_icode;
    input [3:0] f_ifun;
    input signed[63:0] f_valC;
    input [63:0] f_valP;
    input clk;
    output reg[63:0] f_predPC;
    initial
    begin
        f_predPC <= 64'd1;
    end
    always @(posedge clk)
    begin
        #65
        if(f_icode==4'd7 && f_ifun==4'd0) // unconditional jump
        begin
            f_predPC<=f_valC;
        end
        else if(f_icode==4'd8) //call
        begin
            f_predPC<=f_valC;
        end
        else if(f_icode==4'd7 && f_ifun>4'd0) //conditional jump
        begin
            f_predPC<=f_valC;
        end
        else  // return will be taken care off in select_pc module
        begin
            f_predPC<=f_valP;
        end     
    end
    
endmodule

module Select_PC(clk,F_predPC,M_icode,M_Cnd,M_valA,W_icode,W_valM,f_pc);
    input [3:0] M_icode;
    input [3:0] W_icode;
    input M_Cnd,clk;
    input signed[63:0] M_valA;
    input signed[63:0] W_valM;
    input [63:0] F_predPC;
    output reg[63:0] f_pc;
    always @(posedge clk)
    begin
        #50

    if(M_icode == 4'd7 && M_Cnd==1'd0) // misprediction of conditional jump
    begin
        f_pc <= M_valA;
    end
    else if( W_icode == 4'd9 )  // return 
    begin
        f_pc <= W_valM;
    end
    else
    begin
        f_pc <= F_predPC;
    end
    end

endmodule


module f_Stat(clk,f_icode,imem_error,instr_valid,f_stat);
    input [3:0] f_icode;
    input imem_error;
    input instr_valid,clk;
    output reg[3:0] f_stat;

    always @(posedge clk)
    begin
        #65
        if(imem_error==1'd1) 
        begin
            f_stat <= 4'd1;
        end
        else if (instr_valid==1'd0)
        begin
            f_stat <= 4'd2;
        end
        else if (f_icode == 4'h0)  // halt condition
        begin
            f_stat <= 4'd3;
        end
        else 
        begin
            f_stat <= 4'd4;
        end
    end

endmodule

module F(clk,F_stall,f_predPC,F_predPC);
    input clk,F_stall;
    input [63:0] f_predPC;
    output reg[63:0] F_predPC;
    always @ (posedge clk)
    begin
        if (F_stall==1'd0)
        begin
            F_predPC <= f_predPC;
        end
    end
endmodule