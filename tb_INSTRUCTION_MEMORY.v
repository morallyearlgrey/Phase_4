`timescale 1ns / 1ps

module tb_INSTRUCTION_MEMORY();
  reg [31:0] iRdAddr;
  wire [31:0] oInstr;

  INSTRUCTION_MEMORY uut (
                       .iRdAddr(iRdAddr),
                       .oInstr(oInstr)
                     );

  integer i;

  initial
  begin
    // Initialize memory with some fake instructions for testing
    // In a real scenario, this would be done via $readmemh
    for (i = 0; i < 10; i = i + 1)
    begin
      uut.memory[i] = 32'h10000000 + i;
    end

    $display("Time | Address | Instruction");
    $monitor("%4t | %h | %h", $time, iRdAddr, oInstr);

    iRdAddr = 32'h00000000;
    #10;
    iRdAddr = 32'h00000004;
    #10;
    iRdAddr = 32'h00000008;
    #10;
    iRdAddr = 32'h0000000C;
    #10;

    $finish;
  end
endmodule
