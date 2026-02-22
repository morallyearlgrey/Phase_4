// interacts with memory SEPARATE from instruction memory
// read and writes to store and load values
module DATA_MEMORY (
    input [31:0] iAddress,
    input [31:0] iWriteData,
    input [2:0] iFunct3, // selects width of the data; determines which read or store inst to do
    input iMemWrite,
    input iMemRead,
    output reg [31:0] oReadData
);

    reg [7:0] memory [0:1999]; // 8 bits=500 words
    // read logic
    // combinational logic, determined by current input without past inputs
    always @(*) begin
        if(iMemRead == 1) begin
            case iFunct3 // changes oreaddata depending on funct3
                // load byte, signextend
                3'b000:
                    oReadData = {{24{memory[iAddress+0][7]}, memory[iAddress+0]}};

                // load halfword, signextend
                3'b001:
                    oReadData = {{16{memory[iAddress+1][7]}}, memory[iAddress+1], memory[iAddress+0]};

                // load word
                3'b010:
                    oReadData = {memory[iAddress+3], memory[iAddress+2], memory[iAddress+1], memory[iAddress+0]};

                // load byte unsigned, zeroextend
                3'b100:
                    oReadData = {24'b0, memory[iAddress]};

                // load halfword unsigned, zeroextend
                3'b101:
                    oReadData = {16'b0, memory[iAddress+1], memory[iAddress+0]};

                default:
                    oReadData = 32'b0;

            endcase
            
        end else begin 

        end    
    end

    // write logic
    // in phase 3 wasn't combinational, but no clock here so
    always @(*) begin
        if(iMemWrite == 1) begin
            case (iFunct3)
                // store byte
                3'b000:
                    mem[iAddress+0] = iWriteData[7:0];

                // store half-word
                3'b001:
                    mem[iAddress+0] = iWriteData[7:0];
                    mem[iAddress+1] = iWriteData[15:8];

                // store word
                3'b010:
                    mem[iAddress+0] = iWriteData[7:0];
                    mem[iAddress+1] = iWriteData[15:8];
                    mem[iAddress+2] = iWriteData[23:16];
                    mem[iAddress+3] = iWriteData[31:24];

            endcase

        end

    end

endmodule