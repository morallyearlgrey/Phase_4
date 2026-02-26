`timescale 1ns / 1ps
module tb_DEBUG;
  reg clk;
  reg rst_n;

  RISCV_TOP dut (
              .iClk(clk),
              .iRstN(rst_n)
            );

  // Clock generation
  initial
  begin
    clk = 0;
    forever
      #5 clk = ~clk;
  end

  // Test sequence
  initial
  begin
    // Initialize
    rst_n = 0;
    #20;
    rst_n = 1;

    $display("Time | PC       | Instr    | Op  | rd | ALU Res  | WB Data  | RegW | x1 | x5 | x16 ");
    $display("--------------------------------------------------------------------------------------");

    // Monitor signals
    forever
      @(posedge clk)
     begin
       #2; // Wait for write to happen at edge then settle
       $display("%4d | %h | %h | %h | %2d | %h | %h | %b | %h | %h | %h",
                $time,
                dut.wPC,
                dut.wInstr,
                dut.wOpcode,
                dut.wRd,
                dut.wAluResult,
                dut.wWriteData,
                dut.wRegWrite,
                dut.register.registers[1],
                dut.register.registers[5],
                dut.register.registers[16]
               );
       if (dut.wInstr === 32'hxxxxxxxx)
         $finish;
     end
   end

   initial
   begin
     #300;
     $finish;
   end
 endmodule
