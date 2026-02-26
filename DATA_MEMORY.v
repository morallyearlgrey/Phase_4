// interacts with memory SEPARATE from instruction memory
// read and writes to store and load values
module DATA_MEMORY (
    input iClk,
    input iRstN,
    input [31:0] iAddress,
    input [31:0] iWriteData,
    input [2:0] iFunct3, // selects width of the data; determines which read or store inst to do
    input iMemWrite,
    input iMemRead,
    output reg [31:0] oReadData
  );

  reg [7:0] rDataMem [0:1999]; // 8 bits=500 words
  // read logic
  // combinational logic, determined by current input without past inputs
  always @(*)
  begin
    if(iMemRead == 1)
    begin
      case (iFunct3) // changes oreaddata depending on funct3
        // load byte, signextend
        3'b000:
          oReadData = {{24{rDataMem[iAddress+0][7]}}, rDataMem[iAddress+0]};

        // load halfword, signextend
        3'b001:
          oReadData = {{16{rDataMem[iAddress+1][7]}}, rDataMem[iAddress+1], rDataMem[iAddress+0]};

        // load word
        3'b010:
          oReadData = {rDataMem[iAddress+3], rDataMem[iAddress+2], rDataMem[iAddress+1], rDataMem[iAddress+0]};

        // load byte unsigned, zeroextend
        3'b100:
          oReadData = {24'b0, rDataMem[iAddress]};

        // load halfword unsigned, zeroextend
        3'b101:
          oReadData = {16'b0, rDataMem[iAddress+1], rDataMem[iAddress+0]};

        default:
          oReadData = 32'b0;

      endcase

    end
    else
    begin
      oReadData = 32'b0;

    end
  end

  // write logic
  // in phase 3 wasn't combinational, but no clock here so
  always @(*)
  begin
    if(iMemWrite == 1)
    begin
      case (iFunct3)
        // store byte
        3'b000:
          rDataMem[iAddress+0] = iWriteData[7:0];

        // store half-word
        3'b001:
        begin
          rDataMem[iAddress+0] = iWriteData[7:0];
          rDataMem[iAddress+1] = iWriteData[15:8];
        end

        // store word
        3'b010:
        begin
          rDataMem[iAddress+0] = iWriteData[7:0];
          rDataMem[iAddress+1] = iWriteData[15:8];
          rDataMem[iAddress+2] = iWriteData[23:16];
          rDataMem[iAddress+3] = iWriteData[31:24];
        end

        default:
          ;

      endcase

    end

  end

  initial
  begin
    $readmemh("data.txt", rDataMem);
  end

endmodule
