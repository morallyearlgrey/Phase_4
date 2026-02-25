`timescale 1ns / 1ps

module tb_CONTROL();
  reg [6:0] iOpcode;
  wire oLui, oPcSrc, oMemRd, oMemWr, oMemtoReg, oAluSrc1, oAluSrc2, oRegWrite, oBranch, oJump;
  wire [2:0] oAluOp;

  CONTROL uut (
            .iOpcode(iOpcode),
            .oLui(oLui),
            .oPcSrc(oPcSrc),
            .oMemRd(oMemRd),
            .oMemWr(oMemWr),
            .oAluOp(oAluOp),
            .oMemtoReg(oMemtoReg),
            .oAluSrc1(oAluSrc1),
            .oAluSrc2(oAluSrc2),
            .oRegWrite(oRegWrite),
            .oBranch(oBranch),
            .oJump(oJump)
          );

  initial
  begin
    $display("Time | Opcode | Br | Jmp | AluOp | MemRd | MemWr | RegWr");
    $monitor("%4t | %b | %b  | %b   | %b   | %b     | %b     | %b",
             $time, iOpcode, oBranch, oJump, oAluOp, oMemRd, oMemWr, oRegWrite);

    // Test R-type
    iOpcode = 7'b0110011;
    #10;
    // Test I-type ALU
    iOpcode = 7'b0010011;
    #10;
    // Test Load
    iOpcode = 7'b0000011;
    #10;
    // Test Store
    iOpcode = 7'b0100011;
    #10;
    // Test Branch
    iOpcode = 7'b1100011;
    #10;
    // Test LUI
    iOpcode = 7'b0110111;
    #10;
    // Test JAL
    iOpcode = 7'b1101111;
    #10;

    $finish;
  end
endmodule
