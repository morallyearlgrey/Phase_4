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

    reg [31:0] memory [0:501];
    // read logic
    // combinational logic, determined by current input without past inputs
    // 
    always @(*) begin
        if(iMemRead == 1) begin
            case iFunct3 // take a look and return data sign extended too
                // lb
                3'b000:
                    assign oReadData = {24{memory[iAddress][7]}, memory[iAddress]};

                // lh
                3'b001:
                    assign oReadData = {16{memory[iAddress+1][15]}, memory[iAddress+1]};

                // lw
                3'b010:
                    assign oReadData = {16{memory[iAddress][15]}, memory[iAddress]};

                // lbu
                3'b100:

                // lhu
                3'b101:

            endcase
            
        end else begin 


        end    
    end



    // write logic


    
endmodule