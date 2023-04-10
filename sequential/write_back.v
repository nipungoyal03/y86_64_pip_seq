module write_back(input flag_3, input [3:0] icode, input [3:0] ifun, input [3:0] rA,input [3:0] rB, input [63:0] valE, valM, output reg [63:0] rax, output reg [63:0] rcx, output reg [63:0] rdx, output reg [63:0] rbx, output reg [63:0] rsp, output reg [63:0] rbp, output reg [63:0] rsi, output reg [63:0] rdi, output reg [63:0] r8, output reg [63:0] r9, output reg [63:0] r10, output reg [63:0] r11,output reg [63:0] r12,output reg [63:0] r13,output reg [63:0] r14);

reg [63:0] registors [0:14];



always@(posedge flag_3)
    begin

        if(icode==4'b0010)   // cmovxx rA, rB
        begin 
            registors[rB] = valE; 
        end

        if(icode==4'b0011)   // irmovq rA, rB
        begin 
            registors[rB] = valE;
        end

        
        if(icode==4'b0101)   // mrmovq D(rB), rA
        begin 
            registors[rA] = valM; 
        end

        
        if(icode==4'b0110) // Opq rA, rB  
        begin 
            registors[rB] = valE; 
        end

        
        if(icode==4'b1000)   // call Dest
        begin 
            registors[4'b0100] = valE; 
        end

        
        if(icode==4'b1001)   // ret
        begin 
            registors[4'b0100] = valE; 
        end

        
        if(icode==4'b1010)   // pushq rA
        begin 
            registors[4'b0100] = valE;
        end

        
        if(icode==4'b1011)   // popq rA
        begin 
            registors[4'b0100] = valE;
            registors[rA] = valM;
        end

        rax = registors[4'd0];
        rcx = registors[4'd1];
        rdx = registors[4'd2];
        rbx = registors[4'd3];
        rsp = registors[4'd4];
        rbp = registors[4'd5];
        rsi = registors[4'd6];
        rdi = registors[4'd7];
        r8 = registors[4'd8];
        r9 = registors[4'd9];
        r10 = registors[4'd10];
        r11 = registors[4'd11];
        r12 = registors[4'd12];
        r13 = registors[4'd13];
        r14 = registors[4'd14];
        
    end

    
    
endmodule