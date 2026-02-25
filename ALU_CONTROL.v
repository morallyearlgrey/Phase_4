// Submit for phase 5
module ALU_CONTROL (
    input [2:0] iAluOp,
    input [2:0] iFunct3,
    input [6:0] iFunct7,
    output reg [3:0] oAluCtrl
  );

  // ALU operation
  localparam ADD = 4'b0000;
  localparam SUB = 4'b1000;
  localparam SLL = 4'b0001;
  localparam SRL = 4'b1001;
  localparam SRA = 4'b1101;
  localparam SLT = 4'b0010;
  localparam SLTU = 4'b0011;
  localparam XOR = 4'b0100;
  localparam OR = 4'b0110;
  localparam AND = 4'b0111;
  localparam BEQ = 4'b1000;
  localparam BNE = 4'b1100;
  localparam BLT = 4'b1010;
  localparam BGE = 4'b1110;
  always @(*)
  begin
    case (iAluOp)
      3'b000:
        oAluCtrl = ADD; // Load/Store/Jump/LUI
      3'b001:
      begin // Branch
        case (iFunct3)
          3'b000:
            oAluCtrl = BEQ;  // BEQ
          3'b001:
            oAluCtrl = BNE;  // BNE
          3'b100:
            oAluCtrl = BLT;  // BLT
          3'b101:
            oAluCtrl = BGE;  // BGE
          3'b110:
            oAluCtrl = 4'b1011; // BLTU (from notes)
          3'b111:
            oAluCtrl = 4'b1111; // BGEU (from notes)
          default:
            oAluCtrl = ADD;
        endcase
      end
      3'b011:
      begin // I-type ALU
        case (iFunct3)
          3'b000:
            oAluCtrl = ADD; // ADDI
          3'b010:
            oAluCtrl = SLT; // SLTI
          3'b011:
            oAluCtrl = SLTU;// SLTIU
          3'b100:
            oAluCtrl = XOR; // XORI
          3'b110:
            oAluCtrl = OR;  // ORI
          3'b111:
            oAluCtrl = AND; // ANDI
          3'b001:
            oAluCtrl = SLL; // SLLI
          3'b101:
            oAluCtrl = (iFunct7[5]) ? SRA : SRL; // SRLI / SRAI
          default:
            oAluCtrl = ADD;
        endcase
      end
      3'b010:
      begin // R-type
        case (iFunct3)
          3'b000:
            oAluCtrl = (iFunct7[5]) ? SUB : ADD;
          3'b001:
            oAluCtrl = SLL;
          3'b010:
            oAluCtrl = SLT;
          3'b011:
            oAluCtrl = SLTU;
          3'b100:
            oAluCtrl = XOR;
          3'b101:
            oAluCtrl = (iFunct7[5]) ? SRA : SRL;
          3'b110:
            oAluCtrl = OR;
          3'b111:
            oAluCtrl = AND;
          default:
            oAluCtrl = ADD;
        endcase
      end
      default:
        oAluCtrl = ADD;
    endcase
  end

endmodule
