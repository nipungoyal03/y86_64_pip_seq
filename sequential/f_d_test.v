
//`include "fetch/fetch.v"
//`include "decode/decode.v"
module f_d_test;
  reg flag_1,flag_2,flag_3,clk;
  reg [63:0] PC;
  
  
  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire signed [63:0] valC;
  wire signed [63:0] valP;
  wire imem_error,halt;
  wire signed [63:0] valE;
  wire zf,sf,of,cnd;


wire [63:0] updated_pc;
  
 

wire signed [63:0] valA;
wire signed [63:0] valB;
wire signed [63:0] valM;
//wire [63:0] registors [0:14];


reg signed [63:0] rax;
reg signed [63:0] rcx;
reg signed [63:0] rdx;
reg signed [63:0] rbx;
reg signed [63:0] rsp;
reg signed [63:0] rbp;
reg signed [63:0] rsi;
reg signed [63:0] rdi;
reg signed [63:0] r8;
reg signed [63:0] r9;
reg signed [63:0] r10;
reg signed [63:0] r11;
reg signed [63:0] r12;
reg signed [63:0] r13;
reg signed [63:0] r14;

wire signed [63:0] rax_f;
wire signed [63:0] rcx_f;
wire signed [63:0] rdx_f;
wire signed [63:0] rbx_f;
wire signed [63:0] rsp_f;
wire signed [63:0] rbp_f;
wire signed [63:0] rsi_f;
wire signed [63:0] rdi_f;
wire signed [63:0] r8_f;
wire signed [63:0] r9_f;
wire signed [63:0] r10_f;
wire signed [63:0] r11_f;
wire signed [63:0] r12_f;
wire signed [63:0] r13_f;
wire signed [63:0] r14_f;


  
 

  fetch fch(icode,ifun,rA,rB,valC,valP,imem_error,flag_1,PC,halt);
  pc_update pcu (clk,icode, PC,cnd,valC,valM,valP,updated_pc);
  decode deco(flag_1, icode, ifun, rA, rB, valA, valB, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);
  execute exec(flag_2,icode,ifun,valA,valB,valC,valE,zf,sf,of,cnd);
  memory mem(flag_2,icode,ifun,valA, valB, valP, valE,valM,error);
  write_back wr_b(flag_3, icode, ifun, rA, rB, valE, valM, rax_f, rcx_f, rdx_f, rbx_f, rsp_f, rbp_f, rsi_f, rdi_f, r8_f, r9_f, r10_f, r11_f, r12_f, r13_f, r14_f);

  always @(halt)
  begin
    #5
    if(halt==1'b1)
    begin
      $finish;
    end
  end
 

  initial begin 
    
    
    flag_1=0;
    flag_2=0;
    flag_3=0;
  
    clk=1;

    PC=64'd1;  
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc;
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;  

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;
    
    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

    PC=updated_pc; 
    #100 flag_1=~flag_1;
    #100 flag_1=~flag_1;   
    #100 flag_2=~flag_2;
    #100 clk=~clk;   
    #100 flag_2=~flag_2; 
    #100 flag_3=~flag_3;
    #100 flag_3=~flag_3;
    #100 clk=~clk;
    #100;

  end


//   initial 
// 		$monitor("flag_1=%d PC=%d icode=%b ifun=%b valA=%d valB=%d\n",flag_1,PC,icode,ifun,valA,valB);

// always @(posedge flag_2) begin
//     #50
// 		$display("PC=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC=%d\n valE=%d zf=%d sf=%d of=%d cnd=%d \n\n\n",PC,icode,ifun,rA,rB,valA,valB,valC,valE,zf,sf,of,cnd);
// end 

// always @(posedge flag_2) begin
//     #50
// 		$display("PC=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC=%d\n valE=%d zf=%d sf=%d of=%d cnd=%d \n rax=%d\n rcx=%d \n rdx=%d \n rbx=%d\n rsp=%d\n rbp=%d\n rsi=%d\n rdi=%d\n r8=%d\n r9=%d\n r10=%d\n r11=%d\n r12=%d\n r13=%d\n r14=%d\n \n\n\n",PC,icode,ifun,rA,rB,valA,valB,valC,valE,zf,sf,of,cnd,rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);
// end 



always @(posedge clk) begin

#50
		$display("PC=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC=%d\n valE=%d valM=%d zf=%d sf=%d of=%d cnd=%d updated_pc=%d\n rax=%d\n rcx=%d \n rdx=%d \n rbx=%d\n rsp=%d\n rbp=%d\n rsi=%d\n rdi=%d\n r8=%d\n r9=%d\n r10=%d\n r11=%d\n r12=%d\n r13=%d\n r14=%d \n \n\n\n",PC,icode,ifun,rA,rB,valA,valB,valC,valE,valM,zf,sf,of,cnd,updated_pc,rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);
end 

// always @(negedge flag_2) begin

// #50
// 		$display("PC=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC=%d\n valE=%d zf=%d sf=%d of=%d,valM=%d\n \n\n\n",PC,icode,ifun,rA,rB,valA,valB,valC,valE,zf,sf,of,cnd,valM);
// end 

always@(*)
begin

 rax = rax_f;
 rcx = rcx_f;
 rdx = rdx_f;
 rbx = rbx_f;
 rsp = rsp_f;
 rbp = rbp_f;
 rsi = rsi_f;
 rdi = rdi_f;
 r8  = r8_f;
 r9  = r9_f;
 r10 = r10_f;
 r11 = r11_f;
 r12 = r12_f;
 r13 = r13_f;
 r14 = r14_f;

end



endmodule