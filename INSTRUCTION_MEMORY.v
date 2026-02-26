// reads from instruction memory and outputs the instruction
module INSTRUCTION_MEMORY (
    input [31:0] iRdAddr,
    output [31:0] oInstr
  );
  // each instruction is 32 bits, memory is byte-addressable
  reg [7:0] rInstrMem [0:4095];
  assign oInstr = {rInstrMem[iRdAddr+3], rInstrMem[iRdAddr+2], rInstrMem[iRdAddr+1], rInstrMem[iRdAddr+0]};
  initial
  begin
    $readmemh("instr.txt", rInstrMem);
  end

endmodule
