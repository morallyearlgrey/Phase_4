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
    reg [31:0] temp_mem [0:1023];
    integer k;
    for (k=0; k<1024; k=k+1)
      temp_mem[k] = 32'h0;
    $readmemh("instr.txt", temp_mem);
    for (k=0; k<1024; k=k+1)
    begin
      rInstrMem[k*4+0] = temp_mem[k][7:0];
      rInstrMem[k*4+1] = temp_mem[k][15:8];
      rInstrMem[k*4+2] = temp_mem[k][23:16];
      rInstrMem[k*4+3] = temp_mem[k][31:24];
    end
  end

endmodule
