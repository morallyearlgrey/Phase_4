module DATA_MEMORY (
    input iClk,
    input iRstN,
    input [31:0] iAddress,
    input [31:0] iWriteData,
    input [2:0] iFunct3,
    input iMemWrite,
    input iMemRead,
    output reg [31:0] oReadData
  );
  reg [7:0] rDataMem [0:4095];

  always @(*)
  begin
    oReadData = 32'b0;
    if (iMemRead)
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
  end

  always @(posedge iClk)
  begin
    if (iMemWrite)
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

  initial
  begin: INITIAL_LOAD
    reg [31:0] temp_mem [0:1023];
    integer k;
    for (k=0; k<1024; k=k+1)
      temp_mem[k] = 32'hFFFFFFFF;
    $readmemh("data.txt", temp_mem);
    for (k=0; k<1024; k=k+1)
    begin
      if (temp_mem[k] != 32'hFFFFFFFF)
      begin
        rDataMem[k*4+0] = temp_mem[k][7:0];
        rDataMem[k*4+1] = temp_mem[k][15:8];
        rDataMem[k*4+2] = temp_mem[k][23:16];
        rDataMem[k*4+3] = temp_mem[k][31:24];
      end
    end
  end
endmodule
