module fetch(icode,ifun,rA,rB,valC,valP,imem_error,flag_1,PC,halt);

    input flag_1;                             
    input [63:0] PC;                        
    reg [0:79] instr;                     
    output reg [3:0] icode, ifun;           
    output reg [3:0] rA, rB;               
    output reg [63:0] valC;                 
    output reg [63:0] valP;                 
    output reg imem_error=0,halt=0; 

     
  reg [7:0] instruction [0:172];
  initial begin

    instruction[1] = 8'b00110000; 
    instruction[2] = 8'b11110010; 
    instruction[3] = 8'b00000000; 
    instruction[4] = 8'b00000000; 
    instruction[5] = 8'b00000000; 
    instruction[6] = 8'b00000000; 
    instruction[7] = 8'b00000000; 
    instruction[8] = 8'b00000000; 
    instruction[9] = 8'b00000000; 
    instruction[10] = 8'b00000100; 

    instruction[11]  = 8'b00110000; 
    instruction[12]  = 8'b11110011; 
    instruction[13]  = 8'b00000000; 
    instruction[14]  = 8'b00000000; 
    instruction[15]  = 8'b00000000; 
    instruction[16]  = 8'b00000000; 
    instruction[17]  = 8'b00000000; 
    instruction[18] = 8'b00000000; 
    instruction[19] = 8'b00000000; 
    instruction[20] = 8'b00000001; 

    instruction[21]  = 8'b00110000; 
    instruction[22]  = 8'b11110001; 
    instruction[23]  = 8'b00000000; 
    instruction[24]  = 8'b00000000; 
    instruction[25]  = 8'b00000000; 
    instruction[26]  = 8'b00000000; 
    instruction[27]  = 8'b00000000; 
    instruction[28] = 8'b00000000; 
    instruction[29] = 8'b00000000; 
    instruction[30] = 8'b00000011;

    instruction[31]  = 8'b00110000; 
    instruction[32]  = 8'b11110000; 
    instruction[33]  = 8'b00000000; 
    instruction[34]  = 8'b00000000; 
    instruction[35]  = 8'b00000000; 
    instruction[36]  = 8'b00000000; 
    instruction[37]  = 8'b00000000; 
    instruction[38] = 8'b00000000; 
    instruction[39] = 8'b00000000; 
    instruction[40] = 8'b00000111;

    instruction[41]  = 8'b00110000; 
    instruction[42]  = 8'b00000100; 
    instruction[43]  = 8'b00000000; 
    instruction[44]  = 8'b00000000; 
    instruction[45]  = 8'b00000000; 
    instruction[46]  = 8'b00000000; 
    instruction[47]  = 8'b00000000; 
    instruction[48] = 8'b00000000; 
    instruction[49] = 8'b00000000; 
    instruction[50] = 8'b00010000; 

    instruction[51]  = 8'b10000000; 
    instruction[52]  = 8'b00000000; 
    instruction[53]  = 8'b00000000; 
    instruction[54]  = 8'b00000000; 
    instruction[55]  = 8'b00000000; 
    instruction[56]  = 8'b00000000; 
    instruction[57]  = 8'b00000000; 
    instruction[58] = 8'b00000000; 
    instruction[59] = 8'b01011010; 
    
    instruction[60]  = 8'b00010000;
    
    instruction[61] = 8'b01000000; 
    instruction[62] = 8'b00010011; 
    instruction[63] = 8'b00000000; 
    instruction[64] = 8'b00000000; 
    instruction[65] = 8'b00000000; 
    instruction[66] = 8'b00000000; 
    instruction[67] = 8'b00000000; 
    instruction[68] = 8'b00000000; 
    instruction[69] = 8'b00000000; 
    instruction[70] = 8'b00000010;  

    instruction[71] = 8'b01010000; 
    instruction[72] = 8'b01110011; 
    instruction[73] = 8'b00000000;  
    instruction[74] = 8'b00000000; 
    instruction[75] = 8'b00000000; 
    instruction[76] = 8'b00000000; 
    instruction[77] = 8'b00000000; 
    instruction[78] = 8'b00000000; 
    instruction[79] = 8'b00000000; 
    instruction[80] = 8'b00000010; 

    instruction[81] = 8'b01110000; 
    instruction[82] = 8'b00000000; 
    instruction[83] = 8'b00000000; 
    instruction[84] = 8'b00000000; 
    instruction[85] = 8'b00000000; 
    instruction[86] = 8'b00000000; 
    instruction[87] = 8'b00000000; 
    instruction[88] = 8'b00000000; 
    instruction[89] = 8'b01100011;
 

    instruction[90] = 8'b01100000; 
    instruction[91] = 8'b00000001; 

    instruction[92] = 8'b01100001; 
    instruction[93] = 8'b00100011;

    instruction[94] = 8'b01100010; 
    instruction[95] = 8'b00000001;

    instruction[96] = 8'b01100011; 
    instruction[97] = 8'b00000000;

    instruction[98] = 8'b10010000; 

    instruction[99] = 8'b10100000; 
    instruction[100] = 8'b00101111; 

    instruction[101] = 8'b10110000; 
    instruction[102] = 8'b00111111; 

    instruction[103] = 8'b00000000;

     

end
  
  always@(PC) begin
    
    instr={
      instruction[PC],
      instruction[PC+1],
      instruction[PC+2],
      instruction[PC+3],
      instruction[PC+4],
      instruction[PC+5],
      instruction[PC+6],
      instruction[PC+7],
      instruction[PC+8],
      instruction[PC+9]
    };
  end
   
   
    always@(posedge flag_1)
    begin 
        
        if(PC>172)
        begin
            imem_error=1;
        end
        
        icode = instr[0:3];
        ifun = instr[4:7];
        
        
        if(icode==4'b0000) // halt
        begin
        valP=PC+64'd1; 
        halt=1;
        
        end

        else if(icode==4'b0001) // nop
        begin
        valP=PC+64'd1; 
        
        end
                     
        else if(icode==4'b0010) // cmovq
        begin

        valP=PC+1; 
        rA = instr[8:11];
        rB = instr[12:15];
        valP=valP+64'd1; 
        
        end
        
        else if(icode==4'b0011) // irmovq
        begin

        valP=PC+1; 
        rA = instr[8:11];
        rB = instr[12:15];
        valP=valP+1;
        valC = instr[16:79];
        valP=valP+64'd8;
        
         
        end

       else if(icode==4'b0100) // rmmovq
        begin

        valP=PC+1; 
        rA = instr[8:11];
        rB = instr[12:15];
        valP=valP+1;
        valC = instr[16:79];
        valP=valP+64'd8;
        
         
        end

        else if(icode==4'b0101) // mrmovq
        begin

        valP=PC+1; 
        rA = instr[8:11];
        rB = instr[12:15];
        valP=valP+1;
        valC = instr[16:79];
        valP=valP+64'd8;
        
         
        end


        else if(icode==4'b0110) // OPq
        begin

        valP=PC+1; 
        rA = instr[8:11];
        rB = instr[12:15];
        valP=valP+64'd1; 
        
         
        end
        
        else if(icode==4'b0111)     //jxx
        begin   

            valP=PC+1;               
            valC=instr[8:71];
            valP=valP+64'd8;
            

        end


        else if(icode==4'b1000)     //call
        begin   

            valP=PC+1;               
            valC=instr[8:71];
            valP=valP+64'd8;
            

        end

        else if(icode==4'b1001)   //ret  
        begin 
                                 
            valP=PC+64'd1;
            

        end

        else if(icode==4'b1010) // pushq
        begin

        valP=PC+1; 
        rA = instr[8:11];
        rB = instr[12:15];
        valP=valP+64'd1;  
        

        end

        else if(icode==4'b1011) // popq
        begin

        valP=PC+1; 
        rA = instr[8:11];
        rB = instr[12:15];
        valP=valP+64'd1; 
        

        end
    
    end

endmodule