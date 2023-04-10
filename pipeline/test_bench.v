module test_bench;


    // Fetch-stage wires    
    wire imem_error;
    wire [3:0] f_icode;
    wire [3:0] f_ifun;
    wire [ 3:0] f_rA;
    wire [ 3:0] f_rB;
    wire signed[63:0] f_valC;
    wire signed[63:0] f_valP;
    wire [63:0] f_predPC;
    wire [63:0] F_predPC;
    wire [63:0] f_pc;
    wire instr_valid;
    wire reg[3:0] f_stat;
    wire F_stall;

    // Decode-stage wires
    wire [3:0] d_dstE;
    wire [3:0] d_dstM;
    wire [3:0] d_srcA;
    wire signed[63:0] d_rvalA;
    wire [3:0] d_srcB;
    wire signed [63:0] d_valA;
    wire signed [63:0] d_valB;
    wire signed [63:0] d_rvalB;
    wire[3:0] D_icode;
    wire[3:0] D_rB;
    wire[3:0] D_ifun;
    wire[3:0] D_rA;
    wire [63:0] D_valP;
    wire signed[63:0] D_valC;
    wire [3:0] D_stat;
    wire D_bubble;
    wire D_stall;

    // Execute-stage wires
    wire signed [63:0]ALU_A;
    wire signed [63:0]ALU_B;
    wire  signed [63:0] e_valE; 
    wire  sf,of,zf;
    wire [1:0] control;
    wire [63:0] Addr_out;
    wire [3:0] E_icode;
    wire signed [63:0] E_valA;
    wire signed [63:0] E_valC;
    wire signed [63:0] E_valB;
    wire [3:0] E_ifun;
    wire e_Cnd;
    wire [3:0] E_dstE;
    wire [3:0] e_dstE;
    wire E_bubble;
    wire [3:0] E_dstM;
    wire [3:0] E_srcA;
    wire [3:0] E_srcB;
    wire [3:0] E_stat;

    // Memory wires
    wire [63:0] mem_addr;
    wire read;
    wire write;
    wire signed [63:0] m_valM;
    wire dmem_error;
    wire [3:0] m_stat;
    wire [3:0] M_icode;
    wire signed [63:0] M_valE;
    wire signed [63:0] M_valA;
    wire [3:0] M_dstE;
    wire [3:0] M_dstM;
    wire  M_Cnd;
    wire [3:0] M_stat;

    // Writeback wires
    wire [3:0] W_icode;
    wire signed [63:0] W_valE;
    wire signed [63:0] W_valM;
    wire [3:0] W_dstE;
    wire [3:0] W_dstM;
    wire [3:0] W_stat;
    wire [3:0] w_stat;
  
   

    // clock signal

    reg clk;

    initial begin

      $dumpfile("test_bench.vcd");
      $dumpvars(0,test_bench);

      clk=0;

      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
      #100 clk = ~clk;
    end

  
    
    // FETCH stage

    PC_Increment pc_incr(clk,f_pc,f_icode,f_valP);
    Predict_PC pred_pc(clk,f_icode,f_ifun,f_valP,f_valC,f_predPC);
    Instruction_memory instr_mem(clk,f_pc,f_icode,f_ifun,f_rA,f_rB,f_valC,imem_error,instr_valid);
    f_Stat f_s(clk,f_icode,imem_error,instr_valid,f_stat);
    F f(clk,F_stall,f_predPC,F_predPC);
    Select_PC sel_pc(clk,F_predPC,M_icode,M_Cnd,M_valA,W_icode,W_valM,f_pc);


    // DECODE stage

    register_file reg_fil(clk,W_dstE,W_icode, W_dstM, d_srcA , d_srcB , d_rvalA , d_rvalB , W_valM, W_valE);
    src_A_B_logics src_a_b_log(clk,D_icode,D_rA,D_rB,d_srcA,d_srcB);
    dst_E_M_logics dst_e_m_log(clk,D_icode,D_rA,D_rB,d_dstE,d_dstM);
    Forwarding_A_B_logics for_a_b_log(clk,D_icode,D_valP,d_rvalA,d_rvalB,d_srcA,d_srcB,W_valE,W_dstE,W_valM,W_dstM,m_valM,M_dstM,M_valE,M_dstE,e_valE,e_dstE,d_valA,d_valB);
    D d(clk,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,f_stat,D_bubble,D_stall,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat);

    // EXECUTE stage

    ALU_overall alu_o(clk,E_icode,E_ifun,ALU_A,ALU_B,control,zf,of,sf,e_valE,m_stat,W_stat);
    ALU_A_B_logics alu_a_b_log(clk,E_icode,E_valA,E_valB,E_valC,ALU_A,ALU_B);
    ALU_fun alu_f(clk,E_icode,E_ifun,control);
    CC cc(clk,E_icode,E_ifun,sf,of,zf,e_Cnd);
    exe_dstE ex_ds(clk,E_icode,E_dstE,e_Cnd,e_dstE);
    E e(clk,D_stat,E_stat,D_icode,D_ifun,D_valC,d_dstE,d_dstM,d_srcA,d_srcB,d_valA,d_valB,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,E_srcA,E_srcB,E_bubble);

    // MEMORY 

    Data_memory data_mem(clk,Addr_out,M_valA,read,write,m_valM,dmem_error);
    Mem_control mem_ctrl(clk,M_icode,read,write);
    Addr addr(clk,M_icode,M_valE,M_valA,Addr_out);
    memory_Stat mem_stat(clk,M_stat,dmem_error,m_stat);
    M m(clk,M_stat,E_stat,E_icode,e_Cnd,e_valE,E_valA,e_dstE,E_dstM,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,M_bubble);

    // WRITE-BACK

    W w(clk,W_stat,m_stat,M_icode,M_valE,m_valM,M_dstE,M_dstM,W_icode,W_valE,W_valM,W_dstE,W_dstM,W_stall);

    // Pipeline_control_logic
    Pipe_control_logic pip_ctrl_log(clk,D_icode,E_icode,M_icode,d_srcA,d_srcB,,E_dstM,e_Cnd,,m_stat,W_stat,F_stall,D_stall,D_bubble,E_bubble,M_bubble,W_stall);

    
    
    always @(posedge clk)
      begin    

        if(W_stat == 3'd3)
          $finish;

          #100;
          $display("FETCH \n");
          $display("f_pc = %d f_predpc = %d F_predPC = %d \n f_icode = %d f_ifun = %d f_rA = %d f_rB = %d f_valC = %d f_valP = %d f_stat = %d F_stall = %d",f_pc,f_predPC,F_predPC,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,f_stat,F_stall);
          $display("\nDECODE\n");
          $display("D_icode = %d D_ifun = %d D_rA = %d D_rB = %d D_valC = %d D_valP = %d d_srcA = %d d_srcB = %d d_valA = %d d_valB = %d d_rvalA = %d d_rvalB = %d d_dstE = %d d_dstM = %d D_bubble = %d D_stall = %d",D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,d_srcA,d_srcB,d_valA,d_valB,d_rvalA,d_rvalB,d_dstE,d_dstM,D_bubble,D_stall);
        
          $display("\nEXECUTE\n");
          $display("E_icode = %d E_ifun = %d E_valA = %d E_valB = %d E_valC = %d E_srcA = %d E_srcB = %d E_dstE = %d e_dstE = %d E_dstM = %d e_Cnd = %d sf = %d of = %d zf = %d control = %d ALU_A = %d ALU_B = %d E_bubble = %d Addr_out = %d E_stat = %d",E_icode,E_ifun,E_valA,E_valB,E_valC,E_srcA,E_srcB,E_dstE,e_dstE,E_dstM,e_Cnd,sf,of,zf,control,ALU_A,ALU_B,E_bubble,Addr_out,E_stat);
          $display("\nMEMORY\n");
          $display("M_icode = %d M_valA = %d M_valE = %d m_valM = %d M_dstE = %d M_dstM = %d M_Cnd = %d M_stat = %d m_stat = %d read = %d write = %d",M_icode,M_valA,M_valE,m_valM,M_dstE,M_dstM,M_Cnd,M_stat,m_stat,read,write);
          $display("\nWRITE-BACK\n");
          $display("W_icode = %d W_valE = %d W_valM = %d W_dstE = %d W_dstM = %d W_stat = %d\n",W_icode,W_valE,W_valM,W_dstE,W_dstM,W_stat);
        

      end

    
    

    
    
    

endmodule