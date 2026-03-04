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
  localparam DMEM_BYTES = K*4;

  reg [B-1:0] rDataMem [0:DMEM_BYTES-1]; // 4KB data memory, byte-addressable

  localparam DMEM_BASE = 32'h1001_0000;

  initial
  begin
    $readmemh("data.txt", rDataMem);
  end

  // Compute offset from base address
  wire [31:0] addr_off;
  assign addr_off = iAddress - DMEM_BASE;

  wire [11:0] byteAddress;
  assign byteAddress = addr_off[11:0];

  wire in_range;
  assign in_range = (addr_off < DMEM_BYTES);

  // read logic
  // combinational logic, determined by current input without past inputs
  always @(*)
  begin
    oReadData = 32'b0;
    if (iMemRead && in_range)
    begin
      case (iFunct3) // changes oreaddata depending on funct3
        // load byte, signextend
        3'b000:
        begin
          oReadData = {{24{rDataMem[byteAddress][7]}}, rDataMem[byteAddress]};
        end

        // load halfword, signextend
        3'b001:
        begin
          oReadData = {{16{rDataMem[byteAddress+1][7]}}, rDataMem[byteAddress+1], rDataMem[byteAddress]};
        end

        // load word
        3'b010:
        begin
          oReadData = {rDataMem[byteAddress+3], rDataMem[byteAddress+2], rDataMem[byteAddress+1], rDataMem[byteAddress]};
        end

        // load byte unsigned, zeroextend
        3'b100:
        begin
          oReadData = {24'b0, rDataMem[byteAddress]};
        end

        // load halfword unsigned, zeroextend
        3'b101:
        begin
          oReadData = {16'b0, rDataMem[byteAddress+1], rDataMem[byteAddress]};
        end

        default:
          oReadData = 32'b0;

      endcase
    end
  end

  // write logic
  // sequential, on clock edge with reset support
  always @(posedge iClk or negedge iRstN)
  begin
    if (!iRstN)
    begin
      // no-op on reset (relies on $readmemh initial)
    end
    else if (iMemWrite && in_range)
    begin
      case (iFunct3)
        // store byte
        3'b000:
        begin
          rDataMem[byteAddress] <= iWriteData[7:0];
        end

        // store half-word
        3'b001:
        begin
          rDataMem[byteAddress]   <= iWriteData[7:0];
          rDataMem[byteAddress+1] <= iWriteData[15:8];
        end

        // store word
        3'b010:
        begin
          rDataMem[byteAddress]   <= iWriteData[7:0];
          rDataMem[byteAddress+1] <= iWriteData[15:8];
          rDataMem[byteAddress+2] <= iWriteData[23:16];
          rDataMem[byteAddress+3] <= iWriteData[31:24];
        end

        default:
        begin
          // do nothing on unrecognized funct3
        end
      endcase
    end
  end

endmodule
