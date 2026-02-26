`timescale 1ns / 1ps

module tb_TOP();
  reg iClk;
  reg iRst;

  TOP uut (
        .iClk(iClk),
        .iRst(iRst)
      );

  // Clock generation
  initial
    iClk = 0;
  always #5 iClk = ~iClk;

  initial
  begin
    // Initialize
    iRst = 1;
    #20;
    iRst = 0;

    $display("Time | PC       | Instr    | ALU Result | RD Data");
    $monitor("%4t | %h | %h | %h   | %h",
             $time, uut.wPC, uut.wInstr, uut.wAluResult, uut.wWriteData);

    // Run for 100ns
    #100;
    $finish;
  end
endmodule
