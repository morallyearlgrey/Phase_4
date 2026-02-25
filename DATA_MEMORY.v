// Submit for phase 5
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

  localparam B = 8;
  localparam K = 1024;

  reg [B-1:0] rDataMem [0:(K*4)-1]; // 4KB data memory, byte-addressable

  initial
  begin
    $readmemh("data.txt", rDataMem);
  end

  // read logic (combinational)
  always @(*)
  begin
    if(iMemRead == 1)
    begin
      case (iFunct3)
        3'b000:
          oReadData = {{24{rDataMem[iAddress][7]}}, rDataMem[iAddress]};
        3'b001:
          oReadData = {{16{rDataMem[iAddress+1][7]}}, rDataMem[iAddress+1], rDataMem[iAddress]};
        3'b010:
          oReadData = {rDataMem[iAddress+3], rDataMem[iAddress+2], rDataMem[iAddress+1], rDataMem[iAddress]};
        3'b100:
          oReadData = {24'b0, rDataMem[iAddress]};
        3'b101:
          oReadData = {16'b0, rDataMem[iAddress+1], rDataMem[iAddress]};
        default:
          oReadData = 32'b0;
      endcase
    end
    else
    begin
      oReadData = 32'b0;
    end
  end

  // write logic (sequential)
  always @(posedge iClk or negedge iRstN)
  begin
    if (!iRstN)
    begin
      // Optional: initialize or reset memory logic if needed
    end
    else if (iMemWrite == 1)
    begin
      case (iFunct3)
        3'b000:
          rDataMem[iAddress] <= iWriteData[7:0];
        3'b001:
        begin
          rDataMem[iAddress] <= iWriteData[7:0];
          rDataMem[iAddress+1] <= iWriteData[15:8];
        end
        3'b010:
        begin
          rDataMem[iAddress] <= iWriteData[7:0];
          rDataMem[iAddress+1] <= iWriteData[15:8];
          rDataMem[iAddress+2] <= iWriteData[23:16];
          rDataMem[iAddress+3] <= iWriteData[31:24];
        end
        default:
          ;
      endcase
    end
  end

endmodule
