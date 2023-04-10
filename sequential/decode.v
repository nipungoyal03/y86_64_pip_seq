module decode(flag_1, icode, ifun, rA, rB, valA, valB, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);

input flag_1;
input [3:0] icode;
input [3:0] ifun;
input [3:0] rA;
input [3:0] rB;


reg [63:0] registors [0:14];

output reg [63:0] valA;
output reg [63:0] valB;

input [63:0] rax;
input [63:0] rcx;
input [63:0] rdx;
input [63:0] rbx;
input [63:0] rsp;
input [63:0] rbp;
input [63:0] rsi;
input [63:0] rdi;
input [63:0] r8;
input [63:0] r9;
input [63:0] r10;
input [63:0] r11;
input [63:0] r12;
input [63:0] r13;
input [63:0] r14;


always @ (negedge flag_1) 
    begin
    
        
        registors[0] = rax;
        registors[1] = rcx;
        registors[2] = rdx;
        registors[3] = rbx;
        registors[4] = rsp;
        registors[5] = rbp;
        registors[6] = rsi;
        registors[7] = rdi;
        registors[8] = r8;
        registors[9] = r9;
        registors[10] = r10;
        registors[11] = r11;
        registors[12] = r12;
        registors[13] = r13;
        registors[14] = r14;

        if(icode==4'b0010)  //cmovxx rA,rB
        begin
             valA <= registors[rA];
        end

       if(icode==4'b0100)  // rmmovq rA, D(rB)
        begin
            valA <= registors[rA];
            valB <= registors[rB];
        end

        
        if(icode==4'b0101)  // mrmovq D(rB), rA
        begin
            valB <= registors[rB];
        end
            
        
        if(icode==4'b0110)  // Opq rA, rB
        begin
            valA <= registors[rA];
            valB <= registors[rB];
        end

        
        if(icode==4'b1000)  // call 
        begin
            valB <= registors[4'b0100];
        end

        
        if(icode==4'b1001)  // ret
        begin
            valA <= registors[4'b0100];
            valB <= registors[4'b0100];
        end

        
        if(icode==4'b1010)  // pushq rA
        begin
            valA <= registors[rA];
            valB <= registors[4'b0100];
        end

        
        if(icode==4'b1011)  // popq rA
        begin
            valA <= registors[4'b0100];
            valB <= registors[rB];
        end   

        
        
    end 

endmodule