`timescale 1ns / 1ps

module tb_TOP();
  reg iClk;
  reg iRstN;

  RISCV_TOP uut (
              .iClk(iClk),
              .iRstN(iRstN)
            );

  // Clock generation
  initial
    iClk = 0;
  always #5 iClk = ~iClk;

  initial
  begin
    // Initialize
    iRstN = 0; // Assert reset (active low)
    #20;
    iRstN = 1; // Release reset

    $display("Time | PC       | Instr    | ALU Result | RD Data");
    $monitor("%4t | %h | %h | %h   | %h",
             $time, uut.wPC, uut.wInstr, uut.wAluResult, uut.wWriteData);

    // Run for 150ns to see all instructions in program.hex
    #150;
    $finish;
  end
endmodule
