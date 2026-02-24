module ALU_CONTROL (
    input [2:0] iAluOp,
    input [2:0] iFunct3,
    input [6:0] iFunct7,
    output [3:0] oAluCtrl
);

/* iAluOp Descriptions:
    000
        ADD (default)
        loads, stores, JAL, JALR, AUIPC
    001
        Branch compare
        BEQ/BNE/BLT/BGE/etc.
    010
        R-type
        ADD/SUB/AND/OR/XOR/etc.
    011
        I-type ALU
        ADDI/ANDI/ORI/etc.
*/


    // ALU Control Values
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

always @(*) begin
    case (iAluOp)

        3'b000: // THE REST OF THE INSTRUCTIONS
        // I AM CONFUSED, SO THIS PORTION IS NOT DONE.....
        begin
            if(iFunct3 == 3'd0)
                oAluCtrl = LB;

            if(iFunct3 == 3'b001)
                oAluCtrl = LH;

            if(iFunct3 == 3'b010)
                oAluCtrl = LW;

            if(iFunct3 == 3'b100)
                oAluCtrl = LBU;

            if(iFunct3 == 3'b101)
                oAluCtrl = LHU;

            if(iFunct3 == 3'b111)
                oAluCtrl = ;

            if(iFunct3 == 3'd0)
                oAluCtrl = ;

            if(iFunct3 == 3'b001)
                oAluCtrl = ;

            if(iFunct3 == 3'b100)
                oAluCtrl = ;

            if(iFunct3 == 3'b101)
                oAluCtrl = ;

            if(iFunct3 == 3'b110)
                oAluCtrl = ;

            if(iFunct3 == 3'b111)
                oAluCtrl = ;
        end

        3'b001: // BRANCH INSTRUCTIONS
        begin
            if(iFunct3 == 3'd0)
                oAluCtrl = BEQ;

            if(iFunct3 == 3'b001)
                oAluCtrl = BNE;

            if(iFunct3 == 3'b100)
                oAluCtrl = BLT;

            if(iFunct3 == 3'b101)
                oAluCtrl = BGE;

            if(iFunct3 == 3'b110)
                oAluCtrl = BLTU;

            if(iFunct3 == 3'b111)
                oAluCtrl = BGEU;
        end

        3'b010: // R-TYPE INSTRUCTIONS
        begin
            if(iFunct3 == 3'd0 && iFunct7 == 7'd0)
                oAluCtrl = ADD;

            if(iFunct3 == 3'd0 && iFunct7 == 7'b0100000)
                oAluCtrl = SUB;

            if(iFunct3 == 3'b001 && iFunct7 == 7'd0)
                oAluCtrl = SLL;

            if(iFunct3 == 3'd010 && iFunct7 == 7'd0)
                oAluCtrl = SLT;

            if(iFunct3 == 3'b001 && iFunct7 = 7'd0)
                oAluCtrl = SLTU;

            if(iFunct3 == 3'b100 && iFunct7 == 7'd0)
                oAluCtrl = XOR;

            if(iFunct3 == 3'b101 && iFunct7 == 7'd0)
                oAluCtrl = SRL;

            if(iFunct3 == 3'b101 && iFunct7 == 7'd0100000)
                oAluCtrl = SRA;

            if(iFunct3 == 3'd110 && iFunct7 == 7'd0)
                oAluCtrl = OR;

            if(iFunct3 == 3'b111 && iFunct7 == 7'd0)
                oAluCtrl = AND;

        end

        3'b011: // I-TYPE INSTRUCTIONS
        begin
            if(iFunct3 == 3'd0)
                oAluCtrl = ADD;

            if(iFunct3 == 3'b001 && iFunct7 == 7'd0)
                oAluCtrl = SLL;

            if(iFunct3 == 3'b010)
                oAluCtrl = SLT;

            if(iFunct3 == 3'b011)
                oAluCtrl = SLTU;

            if(iFunct3 == 3'b100)
                oAluCtrl = XOR;

            if(iFunct3 == 3'b101 && iFunct7 == 7'd0)
                oAluCtrl = SRL;

            if(iFunct3 == 3'b101 && iFunct7 == 7'b0100000)
                oAluCtrl = SRA;

            if(iFunct3 == 3'b110)
                oAluCtrl = OR;

            if(iFunct3 == 3'b111)
                oAluCtrl = AND;
        end


    default: begin end
    endcase
end
    
endmodule
