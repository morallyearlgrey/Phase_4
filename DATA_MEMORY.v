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

  reg [7:0] rDataMem [0:4095]; // 4KB data memory, byte-addressable

  // read logic (combinational)
  always @(*)
  begin
    if(iMemRead == 1)
    begin
      case (iFunct3)
        // load byte, signextend
        3'b000:
          oReadData = {{24{rDataMem[iAddress][7]}}, rDataMem[iAddress]};

        // load halfword, signextend
        3'b001:
          oReadData = {{16{rDataMem[iAddress+1][7]}}, rDataMem[iAddress+1], rDataMem[iAddress]};

        // load word
        3'b010:
          oReadData = {rDataMem[iAddress+3], rDataMem[iAddress+2], rDataMem[iAddress+1], rDataMem[iAddress]};

        // load byte unsigned, zeroextend
        3'b100:
          oReadData = {24'b0, rDataMem[iAddress]};

        // load halfword unsigned, zeroextend
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
  always @(posedge iClk)
  begin
    if(iMemWrite == 1)
    begin
      case (iFunct3)
        // store byte
        3'b000:
          rDataMem[iAddress] <= iWriteData[7:0];

        // store half-word
        3'b001:
        begin
          rDataMem[iAddress]   <= iWriteData[7:0];
          rDataMem[iAddress+1] <= iWriteData[15:8];
        end

        // store word
        3'b010:
        begin
          rDataMem[iAddress]   <= iWriteData[7:0];
          rDataMem[iAddress+1] <= iWriteData[15:8];
          rDataMem[iAddress+2] <= iWriteData[23:16];
          rDataMem[iAddress+3] <= iWriteData[31:24];
        end

        default:
          ;
      endcase
    end
  end

  initial
  begin
    reg [31:0] temp_mem [0:1023];
    integer k;
    for (k=0; k<1024; k=k+1)
      temp_mem[k] = 32'h0;
    $readmemh("data.txt", temp_mem);
    for (k=0; k<1024; k=k+1)
    begin
      rDataMem[k*4+0] = temp_mem[k][7:0];
      rDataMem[k*4+1] = temp_mem[k][15:8];
      rDataMem[k*4+2] = temp_mem[k][23:16];
      rDataMem[k*4+3] = temp_mem[k][31:24];
    end
  end

endmodule
