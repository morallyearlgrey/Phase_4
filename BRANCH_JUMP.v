// Submit for phase 5
module BRANCH_JUMP (
    input iBranch,
    input iJump,
    input iZero,
    input [31:0] iOffset,
    input [31:0] iPc,
    input [31:0] iRs1,
    input iPcSrc,
    output reg [31:0] oPc
  );

  always @(*)
  begin
    if (iJump | (iBranch & iZero))
    begin
      oPc = (iPcSrc ? iRs1 : iPc) + iOffset;
    end
    else
    begin
      oPc = iPc + 32'd4;
    end
  end

endmodule
