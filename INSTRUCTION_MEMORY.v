// reads from instruction memory and outputs the instruction
module INSTRUCTION_MEMORY (
    input [31:0] iRdAddr,
    output [31:0] oInstr
  );
  // 500 instructions (will need to update based on autograder)
  // each instruction is 32 bits
  reg [31:0] rInstrMem [0:499];
  assign oInstr = rInstrMem[iRdAddr[10:2]]; // need to divide by 4 and slice to 9 bits
  initial
  begin
    $readmemh("instr.txt", rInstrMem);
  end

endmodule
