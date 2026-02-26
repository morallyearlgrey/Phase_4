`timescale 1ns / 1ps

module tb_DATA_MEMORY();
  reg [31:0] iAddress;
  reg [31:0] iWriteData;
  reg [2:0] iFunct3;
  reg iMemWrite;
  reg iMemRead;
  wire [31:0] oReadData;

  DATA_MEMORY uut (
                .iAddress(iAddress),
                .iWriteData(iWriteData),
                .iFunct3(iFunct3),
                .iMemWrite(iMemWrite),
                .iMemRead(iMemRead),
                .oReadData(oReadData)
              );

  initial
  begin
    iAddress = 0;
    iWriteData = 0;
    iFunct3 = 0;
    iMemWrite = 0;
    iMemRead = 0;
    #10;

    // Test Write Word
    $display("Testing Write Word...");
    iAddress = 32'h0000;
    iWriteData = 32'hDEADBEEF;
    iFunct3 = 3'b010;
    iMemWrite = 1;
    #10;
    iMemWrite = 0;
    #10;

    // Test Read Word
    $display("Testing Read Word...");
    iMemRead = 1;
    #10;
    if (oReadData === 32'hDEADBEEF)
      $display("SUCCESS: Read 0x%h", oReadData);
    else
      $display("FAILURE: Expected DEADBEEF, got %h", oReadData);
    iMemRead = 0;
    #10;

    // Test Write Byte
    $display("Testing Write Byte...");
    iAddress = 32'h0004;
    iWriteData = 32'h000000AA;
    iFunct3 = 3'b000;
    iMemWrite = 1;
    #10;
    iMemWrite = 0;
    #10;

    // Test Read Byte (Unsigned)
    iMemRead = 1;
    iFunct3 = 3'b100;
    #10;
    if (oReadData === 32'h000000AA)
      $display("SUCCESS: Read Byte 0x%h", oReadData);
    else
      $display("FAILURE: Expected AA, got %h", oReadData);
    iMemRead = 0;
    #10;

    $finish;
  end
endmodule
