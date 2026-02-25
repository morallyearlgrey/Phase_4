module CONTROL (
    input [6:0] iOpcode,
    output reg oLui,
    output reg oPcSrc,
    output reg oMemRd,
    output reg oMemWr,
    output reg [2:0] oAluOp,
    output reg oMemtoReg,
    output reg oAluSrc1,
    output reg oAluSrc2,
    output reg oRegWrite,
    output reg oBranch,
    output reg oJump
  );

  // Very similar logic to decoder. Map opcode -> flags.
  always @(*)
  begin

    oLui      = 0;
    oPcSrc    = 0;
    oMemRd    = 0;
    oMemWr    = 0;
    oAluOp    = 3'b000;
    oMemtoReg = 0;
    oAluSrc1  = 0;
    oAluSrc2  = 0;
    oRegWrite = 0;
    oBranch   = 0;
    oJump     = 0;

    case (iOpcode)

      // R-type
      7'b0110011:
      begin
        oRegWrite = 1;
        oAluOp    = 3'b010;
      end

      // I-type ALU
      7'b0010011:
      begin
        oRegWrite = 1;
        oAluSrc2  = 1;
        oAluOp    = 3'b011;
      end

      // Load
      7'b0000011:
      begin
        oRegWrite = 1;
        oMemRd    = 1;
        oMemtoReg = 1;
        oAluSrc2  = 1;
      end

      // Store
      7'b0100011:
      begin
        oMemWr    = 1;
        oAluSrc2  = 1;
      end

      // Branch
      7'b1100011:
      begin
        oBranch   = 1;
        oPcSrc    = 1;
        oAluOp    = 3'b001;
      end

      // LUI
      7'b0110111:
      begin
        oRegWrite = 1;
        oLui      = 1;
        oAluSrc2  = 1;
      end

      // AUIPC
      7'b0010111:
      begin
        oRegWrite = 1;
        oAluSrc1  = 1;
        oAluSrc2  = 1;
      end

      // JAL
      7'b1101111:
      begin
        oRegWrite = 1;
        oJump     = 1;
        oPcSrc    = 1;
        oAluSrc1  = 1;
        oAluSrc2  = 1;
      end

      // JALR
      7'b1100111:
      begin
        oRegWrite = 1;
        oJump     = 1;
        oPcSrc    = 1;
        oAluSrc2  = 1;
      end

      default:
      begin
      end

    endcase
  end

endmodule
