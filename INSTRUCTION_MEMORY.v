// reads from instruction memory and outputs the instruction
module INSTRUCTION_MEMORY (
    input iRdAddr,
    output [31:0] oInstr
);
    // 500 instructions (will need to update based on autograder)
    // each instruction is 32 bits
    reg [31:0] memory [0:499];
    assign oInstr = memory[iRdAddr[31:2]]; // need to divide by 4
    
endmodule