module pc_update(input clk,input [3:0] icode,input [63:0] PC,input cnd,input[63:0] valC,valM,valP,output reg [63:0] updated_pc);

  always@(posedge clk)
  begin
    #2
    if (icode==4'b0000)
      updated_pc=valP;

    if (icode==4'b0001)
      updated_pc=valP;

    if (icode==4'b0010)
       updated_pc=valP;

    if (icode==4'b0011)
        updated_pc=valP;

    if (icode==4'b0100)
       updated_pc=valP;
    
    if (icode==4'b0101)
       updated_pc=valP;

    if (icode==4'b0110)
       updated_pc=valP;

    if(icode==4'b0111) 
    begin
      if(cnd==1'b1)
        updated_pc=valC;
      
      else
        updated_pc=valP;

    end

    if(icode==4'b1000) 
    
      updated_pc=valC;
    
    if(icode==4'b1001) 
    
      updated_pc=valM;
   
    if (icode==4'b1010)
       updated_pc=valP;

    if (icode==4'b1011)
       updated_pc=valP;
    
    
  end

endmodule
