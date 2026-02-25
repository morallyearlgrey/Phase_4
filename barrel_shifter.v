// /* verilator lint_off DECLFILENAME */
// // /*
// //     Implements barrel shifter
// //     Allows for shifting left, right, and shift left arithmetic

// //     Input:
// //         32 bit input wire i: stores data for value to be shifted
// //         5 bit s:             shift amount value, 5 total stages to accomodate 32 bit numbers
// //         3 bit func3:         wire to determine is sll or srl
// //         7 bit fun7:          wire to determine if srl arithemtic or not

// //     Output:
// //         32 bit wire o: final resulting value shifted by s
// // Referenced off of: https://github.com/Adithya-S-Bhat/Barrel-Shifter-16-bit-Using-Verilog/blob/main/bitshift.v
// // */

module mux2 (input wire i0, i1, j, output wire o);
  assign o = (j == 1'b0) ? i0 : i1;
endmodule

// op: 00=SLL, 01=SRL/SRA, 10=ROL, 11=ROR
module mux4 (input wire [0:3] i, input wire [1:0] j, output wire o);
  wire t0, t1;
  mux2 m_lo (i[0], i[1], j[0], t0);
  mux2 m_hi (i[2], i[3], j[0], t1);
  mux2 m_final (t0, t1, j[1], o);
endmodule

module rl1_32(input wire [31:0] i, input wire [1:0] op, input wire fill, output wire [31:0] o);
  mux4 m0  ({1'b0,   i[1],  i[31], i[1]},  op, o[0]);

  mux4 m1  ({i[0],   i[2],  i[0],  i[2]},  op, o[1]);
  mux4 m2  ({i[1],   i[3],  i[1],  i[3]},  op, o[2]);
  mux4 m3  ({i[2],   i[4],  i[2],  i[4]},  op, o[3]);
  mux4 m4  ({i[3],   i[5],  i[3],  i[5]},  op, o[4]);
  mux4 m5  ({i[4],   i[6],  i[4],  i[6]},  op, o[5]);
  mux4 m6  ({i[5],   i[7],  i[5],  i[7]},  op, o[6]);
  mux4 m7  ({i[6],   i[8],  i[6],  i[8]},  op, o[7]);
  mux4 m8  ({i[7],   i[9],  i[7],  i[9]},  op, o[8]);
  mux4 m9  ({i[8],   i[10], i[8],  i[10]}, op, o[9]);
  mux4 m10 ({i[9],   i[11], i[9],  i[11]}, op, o[10]);
  mux4 m11 ({i[10],  i[12], i[10], i[12]}, op, o[11]);
  mux4 m12 ({i[11],  i[13], i[11], i[13]}, op, o[12]);
  mux4 m13 ({i[12],  i[14], i[12], i[14]}, op, o[13]);
  mux4 m14 ({i[13],  i[15], i[13], i[15]}, op, o[14]);
  mux4 m15 ({i[14],  i[16], i[14], i[16]}, op, o[15]);
  mux4 m16 ({i[15],  i[17], i[15], i[17]}, op, o[16]);
  mux4 m17 ({i[16],  i[18], i[16], i[18]}, op, o[17]);
  mux4 m18 ({i[17],  i[19], i[17], i[19]}, op, o[18]);
  mux4 m19 ({i[18],  i[20], i[18], i[20]}, op, o[19]);
  mux4 m20 ({i[19],  i[21], i[19], i[21]}, op, o[20]);
  mux4 m21 ({i[20],  i[22], i[20], i[22]}, op, o[21]);
  mux4 m22 ({i[21],  i[23], i[21], i[23]}, op, o[22]);
  mux4 m23 ({i[22],  i[24], i[22], i[24]}, op, o[23]);
  mux4 m24 ({i[23],  i[25], i[23], i[25]}, op, o[24]);
  mux4 m25 ({i[24],  i[26], i[24], i[26]}, op, o[25]);
  mux4 m26 ({i[25],  i[27], i[25], i[27]}, op, o[26]);
  mux4 m27 ({i[26],  i[28], i[26], i[28]}, op, o[27]);
  mux4 m28 ({i[27],  i[29], i[27], i[29]}, op, o[28]);
  mux4 m29 ({i[28],  i[30], i[28], i[30]}, op, o[29]);
  mux4 m30 ({i[29],  i[31], i[29], i[31]}, op, o[30]);
  mux4 m31 ({i[30],  fill,  i[30], i[0]},  op, o[31]);
endmodule

module rl2_32(input wire [31:0] i, input wire [1:0] op, input wire fill, output wire [31:0] o);
  
  mux4 m0  ({1'b0, i[2], i[30], i[2]}, op, o[0]);
  mux4 m1  ({1'b0, i[3], i[31], i[3]}, op, o[1]);

  mux4 m2  ({i[0], i[4], i[0], i[4]}, op, o[2]);
  mux4 m3  ({i[1], i[5], i[1], i[5]}, op, o[3]);
  mux4 m4  ({i[2], i[6], i[2], i[6]}, op, o[4]);
  mux4 m5  ({i[3], i[7], i[3], i[7]}, op, o[5]);
  mux4 m6  ({i[4], i[8], i[4], i[8]}, op, o[6]);
  mux4 m7  ({i[5], i[9], i[5], i[9]}, op, o[7]);
  mux4 m8  ({i[6], i[10], i[6], i[10]}, op, o[8]);
  mux4 m9  ({i[7], i[11], i[7], i[11]}, op, o[9]);
  mux4 m10 ({i[8], i[12], i[8], i[12]}, op, o[10]);
  mux4 m11 ({i[9], i[13], i[9], i[13]}, op, o[11]);
  mux4 m12 ({i[10], i[14], i[10], i[14]}, op, o[12]);
  mux4 m13 ({i[11], i[15], i[11], i[15]}, op, o[13]);
  mux4 m14 ({i[12], i[16], i[12], i[16]}, op, o[14]);
  mux4 m15 ({i[13], i[17], i[13], i[17]}, op, o[15]);
  mux4 m16 ({i[14], i[18], i[14], i[18]}, op, o[16]);
  mux4 m17 ({i[15], i[19], i[15], i[19]}, op, o[17]);
  mux4 m18 ({i[16], i[20], i[16], i[20]}, op, o[18]);
  mux4 m19 ({i[17], i[21], i[17], i[21]}, op, o[19]);
  mux4 m20 ({i[18], i[22], i[18], i[22]}, op, o[20]);
  mux4 m21 ({i[19], i[23], i[19], i[23]}, op, o[21]);
  mux4 m22 ({i[20], i[24], i[20], i[24]}, op, o[22]);
  mux4 m23 ({i[21], i[25], i[21], i[25]}, op, o[23]);
  mux4 m24 ({i[22], i[26], i[22], i[26]}, op, o[24]);
  mux4 m25 ({i[23], i[27], i[23], i[27]}, op, o[25]);
  mux4 m26 ({i[24], i[28], i[24], i[28]}, op, o[26]);
  mux4 m27 ({i[25], i[29], i[25], i[29]}, op, o[27]);
  mux4 m28 ({i[26], i[30], i[26], i[30]}, op, o[28]);
  mux4 m29 ({i[27], i[31], i[27], i[31]}, op, o[29]);
  mux4 m30 ({i[28], fill, i[28], i[0]}, op, o[30]);
  mux4 m31 ({i[29], fill, i[29], i[1]}, op, o[31]);
endmodule

module rl4_32(input wire [31:0] i, input wire [1:0] op, input wire fill, output wire [31:0] o);
  mux4 m0  ({1'b0, i[4], i[28], i[4]}, op, o[0]);
  mux4 m1  ({1'b0, i[5], i[29], i[5]}, op, o[1]);
  mux4 m2  ({1'b0, i[6], i[30], i[6]}, op, o[2]);
  mux4 m3  ({1'b0, i[7], i[31], i[7]}, op, o[3]);
  mux4 m4  ({i[0], i[8], i[0], i[8]}, op, o[4]);
  mux4 m5  ({i[1], i[9], i[1], i[9]}, op, o[5]);
  mux4 m6  ({i[2], i[10], i[2], i[10]}, op, o[6]);
  mux4 m7  ({i[3], i[11], i[3], i[11]}, op, o[7]);
  mux4 m8  ({i[4], i[12], i[4], i[12]}, op, o[8]);
  mux4 m9  ({i[5], i[13], i[5], i[13]}, op, o[9]);
  mux4 m10 ({i[6], i[14], i[6], i[14]}, op, o[10]);
  mux4 m11 ({i[7], i[15], i[7], i[15]}, op, o[11]);
  mux4 m12 ({i[8], i[16], i[8], i[16]}, op, o[12]);
  mux4 m13 ({i[9], i[17], i[9], i[17]}, op, o[13]);
  mux4 m14 ({i[10], i[18], i[10], i[18]}, op, o[14]);
  mux4 m15 ({i[11], i[19], i[11], i[19]}, op, o[15]);
  mux4 m16 ({i[12], i[20], i[12], i[20]}, op, o[16]);
  mux4 m17 ({i[13], i[21], i[13], i[21]}, op, o[17]);
  mux4 m18 ({i[14], i[22], i[14], i[22]}, op, o[18]);
  mux4 m19 ({i[15], i[23], i[15], i[23]}, op, o[19]);
  mux4 m20 ({i[16], i[24], i[16], i[24]}, op, o[20]);
  mux4 m21 ({i[17], i[25], i[17], i[25]}, op, o[21]);
  mux4 m22 ({i[18], i[26], i[18], i[26]}, op, o[22]);
  mux4 m23 ({i[19], i[27], i[19], i[27]}, op, o[23]);
  mux4 m24 ({i[20], i[28], i[20], i[28]}, op, o[24]);
  mux4 m25 ({i[21], i[29], i[21], i[29]}, op, o[25]);
  mux4 m26 ({i[22], i[30], i[22], i[30]}, op, o[26]);
  mux4 m27 ({i[23], i[31], i[23], i[31]}, op, o[27]);
  mux4 m28 ({i[24], fill, i[24], i[0]}, op, o[28]);
  mux4 m29 ({i[25], fill, i[25], i[1]}, op, o[29]);
  mux4 m30 ({i[26], fill, i[26], i[2]}, op, o[30]);
  mux4 m31 ({i[27], fill, i[27], i[3]}, op, o[31]);
endmodule

module rl8_32(input wire [31:0] i, input wire [1:0] op, input wire fill, output wire [31:0] o);
  mux4 m0  ({1'b0, i[8], i[24], i[8]}, op, o[0]);
  mux4 m1  ({1'b0, i[9], i[25], i[9]}, op, o[1]);
  mux4 m2  ({1'b0, i[10], i[26], i[10]}, op, o[2]);
  mux4 m3  ({1'b0, i[11], i[27], i[11]}, op, o[3]);
  mux4 m4  ({1'b0, i[12], i[28], i[12]}, op, o[4]);
  mux4 m5  ({1'b0, i[13], i[29], i[13]}, op, o[5]);
  mux4 m6  ({1'b0, i[14], i[30], i[14]}, op, o[6]);
  mux4 m7  ({1'b0, i[15], i[31], i[15]}, op, o[7]);

  mux4 m8  ({i[0], i[16], i[0], i[16]}, op, o[8]);
  mux4 m9  ({i[1], i[17], i[1], i[17]}, op, o[9]);
  mux4 m10 ({i[2], i[18], i[2], i[18]}, op, o[10]);
  mux4 m11 ({i[3], i[19], i[3], i[19]}, op, o[11]);
  mux4 m12 ({i[4], i[20], i[4], i[20]}, op, o[12]);
  mux4 m13 ({i[5], i[21], i[5], i[21]}, op, o[13]);
  mux4 m14 ({i[6], i[22], i[6], i[22]}, op, o[14]);
  mux4 m15 ({i[7], i[23], i[7], i[23]}, op, o[15]);
  mux4 m16 ({i[8], i[24], i[8], i[24]}, op, o[16]);
  mux4 m17 ({i[9], i[25], i[9], i[25]}, op, o[17]);
  mux4 m18 ({i[10], i[26], i[10], i[26]}, op, o[18]);
  mux4 m19 ({i[11], i[27], i[11], i[27]}, op, o[19]);
  mux4 m20 ({i[12], i[28], i[12], i[28]}, op, o[20]);
  mux4 m21 ({i[13], i[29], i[13], i[29]}, op, o[21]);
  mux4 m22 ({i[14], i[30], i[14], i[30]}, op, o[22]);
  mux4 m23 ({i[15], i[31], i[15], i[31]}, op, o[23]);

  mux4 m24 ({i[16], fill, i[16], i[0]}, op, o[24]);
  mux4 m25 ({i[17], fill, i[17], i[1]}, op, o[25]);
  mux4 m26 ({i[18], fill, i[18], i[2]}, op, o[26]);
  mux4 m27 ({i[19], fill, i[19], i[3]}, op, o[27]);
  mux4 m28 ({i[20], fill, i[20], i[4]}, op, o[28]);
  mux4 m29 ({i[21], fill, i[21], i[5]}, op, o[29]);
  mux4 m30 ({i[22], fill, i[22], i[6]}, op, o[30]);
  mux4 m31 ({i[23], fill, i[23], i[7]}, op, o[31]);
endmodule

module rl16_32(input wire [31:0] i, input wire [1:0] op, input wire fill, output wire [31:0] o);
  mux4 m0  ({1'b0, i[16], i[16], i[16]}, op, o[0]);
  mux4 m1  ({1'b0, i[17], i[17], i[17]}, op, o[1]);
  mux4 m2  ({1'b0, i[18], i[18], i[18]}, op, o[2]);
  mux4 m3  ({1'b0, i[19], i[19], i[19]}, op, o[3]);
  mux4 m4  ({1'b0, i[20], i[20], i[20]}, op, o[4]);
  mux4 m5  ({1'b0, i[21], i[21], i[21]}, op, o[5]);
  mux4 m6  ({1'b0, i[22], i[22], i[22]}, op, o[6]);
  mux4 m7  ({1'b0, i[23], i[23], i[23]}, op, o[7]);
  mux4 m8  ({1'b0, i[24], i[24], i[24]}, op, o[8]);
  mux4 m9  ({1'b0, i[25], i[25], i[25]}, op, o[9]);
  mux4 m10 ({1'b0, i[26], i[26], i[26]}, op, o[10]);
  mux4 m11 ({1'b0, i[27], i[27], i[27]}, op, o[11]);
  mux4 m12 ({1'b0, i[28], i[28], i[28]}, op, o[12]);
  mux4 m13 ({1'b0, i[29], i[29], i[29]}, op, o[13]);
  mux4 m14 ({1'b0, i[30], i[30], i[30]}, op, o[14]);
  mux4 m15 ({1'b0, i[31], i[31], i[31]}, op, o[15]);

  mux4 m16 ({i[0],  fill, i[0],  i[0]},  op, o[16]);
  mux4 m17 ({i[1],  fill, i[1],  i[1]},  op, o[17]);
  mux4 m18 ({i[2],  fill, i[2],  i[2]},  op, o[18]);
  mux4 m19 ({i[3],  fill, i[3],  i[3]},  op, o[19]);
  mux4 m20 ({i[4],  fill, i[4],  i[4]},  op, o[20]);
  mux4 m21 ({i[5],  fill, i[5],  i[5]},  op, o[21]);
  mux4 m22 ({i[6],  fill, i[6],  i[6]},  op, o[22]);
  mux4 m23 ({i[7],  fill, i[7],  i[7]},  op, o[23]);
  mux4 m24 ({i[8],  fill, i[8],  i[8]},  op, o[24]);
  mux4 m25 ({i[9],  fill, i[9],  i[9]},  op, o[25]);
  mux4 m26 ({i[10], fill, i[10], i[10]}, op, o[26]);
  mux4 m27 ({i[11], fill, i[11], i[11]}, op, o[27]);
  mux4 m28 ({i[12], fill, i[12], i[12]}, op, o[28]);
  mux4 m29 ({i[13], fill, i[13], i[13]}, op, o[29]);
  mux4 m30 ({i[14], fill, i[14], i[14]}, op, o[30]);
  mux4 m31 ({i[15], fill, i[15], i[15]}, op, o[31]);
endmodule

module bitshift_stage_manual(
    input wire [31:0] i, 
    input wire s, 
    input wire [1:0] op, 
    input wire fill, 
    output wire [31:0] o
);
    wire [31:0] t;
    rl1_32 r (i, op, fill, t); 

    // mux to identify if to shift that bit or pass
    // Stage Selection Muxes: if s=0, o=i; if s=1, o=t
    mux2 m00(i[0],  t[0],  s, o[0]);
    mux2 m01(i[1],  t[1],  s, o[1]);
    mux2 m02(i[2],  t[2],  s, o[2]);
    mux2 m03(i[3],  t[3],  s, o[3]);
    mux2 m04(i[4],  t[4],  s, o[4]);
    mux2 m05(i[5],  t[5],  s, o[5]);
    mux2 m06(i[6],  t[6],  s, o[6]);
    mux2 m07(i[7],  t[7],  s, o[7]);
    mux2 m08(i[8],  t[8],  s, o[8]);
    mux2 m09(i[9],  t[9],  s, o[9]);
    mux2 m10(i[10], t[10], s, o[10]);
    mux2 m11(i[11], t[11], s, o[11]);
    mux2 m12(i[12], t[12], s, o[12]);
    mux2 m13(i[13], t[13], s, o[13]);
    mux2 m14(i[14], t[14], s, o[14]);
    mux2 m15(i[15], t[15], s, o[15]);
    mux2 m16(i[16], t[16], s, o[16]);
    mux2 m17(i[17], t[17], s, o[17]);
    mux2 m18(i[18], t[18], s, o[18]);
    mux2 m19(i[19], t[19], s, o[19]);
    mux2 m20(i[20], t[20], s, o[20]);
    mux2 m21(i[21], t[21], s, o[21]);
    mux2 m22(i[22], t[22], s, o[22]);
    mux2 m23(i[23], t[23], s, o[23]);
    mux2 m24(i[24], t[24], s, o[24]);
    mux2 m25(i[25], t[25], s, o[25]);
    mux2 m26(i[26], t[26], s, o[26]);
    mux2 m27(i[27], t[27], s, o[27]);
    mux2 m28(i[28], t[28], s, o[28]);
    mux2 m29(i[29], t[29], s, o[29]);
    mux2 m30(i[30], t[30], s, o[30]);
    mux2 m31(i[31], t[31], s, o[31]);
endmodule

module bitshift_stage_manual2(
    input wire [31:0] i, 
    input wire s, 
    input wire [1:0] op, 
    input wire fill, 
    output wire [31:0] o
);
    wire [31:0] t;
    rl2_32 r (i, op, fill, t); 

    // mux to identify if to shift that bit or pass
    // Stage Selection Muxes: if s=0, o=i; if s=1, o=t
    mux2 m00(i[0],  t[0],  s, o[0]);
    mux2 m01(i[1],  t[1],  s, o[1]);
    mux2 m02(i[2],  t[2],  s, o[2]);
    mux2 m03(i[3],  t[3],  s, o[3]);
    mux2 m04(i[4],  t[4],  s, o[4]);
    mux2 m05(i[5],  t[5],  s, o[5]);
    mux2 m06(i[6],  t[6],  s, o[6]);
    mux2 m07(i[7],  t[7],  s, o[7]);
    mux2 m08(i[8],  t[8],  s, o[8]);
    mux2 m09(i[9],  t[9],  s, o[9]);
    mux2 m10(i[10], t[10], s, o[10]);
    mux2 m11(i[11], t[11], s, o[11]);
    mux2 m12(i[12], t[12], s, o[12]);
    mux2 m13(i[13], t[13], s, o[13]);
    mux2 m14(i[14], t[14], s, o[14]);
    mux2 m15(i[15], t[15], s, o[15]);
    mux2 m16(i[16], t[16], s, o[16]);
    mux2 m17(i[17], t[17], s, o[17]);
    mux2 m18(i[18], t[18], s, o[18]);
    mux2 m19(i[19], t[19], s, o[19]);
    mux2 m20(i[20], t[20], s, o[20]);
    mux2 m21(i[21], t[21], s, o[21]);
    mux2 m22(i[22], t[22], s, o[22]);
    mux2 m23(i[23], t[23], s, o[23]);
    mux2 m24(i[24], t[24], s, o[24]);
    mux2 m25(i[25], t[25], s, o[25]);
    mux2 m26(i[26], t[26], s, o[26]);
    mux2 m27(i[27], t[27], s, o[27]);
    mux2 m28(i[28], t[28], s, o[28]);
    mux2 m29(i[29], t[29], s, o[29]);
    mux2 m30(i[30], t[30], s, o[30]);
    mux2 m31(i[31], t[31], s, o[31]);
endmodule

module bitshift_stage_manual4(
    input wire [31:0] i, 
    input wire s, 
    input wire [1:0] op, 
    input wire fill, 
    output wire [31:0] o
);
    wire [31:0] t;
    rl4_32 r (i, op, fill, t); 

    // mux to identify if to shift that bit or pass
    // Stage Selection Muxes: if s=0, o=i; if s=1, o=t
    mux2 m00(i[0],  t[0],  s, o[0]);
    mux2 m01(i[1],  t[1],  s, o[1]);
    mux2 m02(i[2],  t[2],  s, o[2]);
    mux2 m03(i[3],  t[3],  s, o[3]);
    mux2 m04(i[4],  t[4],  s, o[4]);
    mux2 m05(i[5],  t[5],  s, o[5]);
    mux2 m06(i[6],  t[6],  s, o[6]);
    mux2 m07(i[7],  t[7],  s, o[7]);
    mux2 m08(i[8],  t[8],  s, o[8]);
    mux2 m09(i[9],  t[9],  s, o[9]);
    mux2 m10(i[10], t[10], s, o[10]);
    mux2 m11(i[11], t[11], s, o[11]);
    mux2 m12(i[12], t[12], s, o[12]);
    mux2 m13(i[13], t[13], s, o[13]);
    mux2 m14(i[14], t[14], s, o[14]);
    mux2 m15(i[15], t[15], s, o[15]);
    mux2 m16(i[16], t[16], s, o[16]);
    mux2 m17(i[17], t[17], s, o[17]);
    mux2 m18(i[18], t[18], s, o[18]);
    mux2 m19(i[19], t[19], s, o[19]);
    mux2 m20(i[20], t[20], s, o[20]);
    mux2 m21(i[21], t[21], s, o[21]);
    mux2 m22(i[22], t[22], s, o[22]);
    mux2 m23(i[23], t[23], s, o[23]);
    mux2 m24(i[24], t[24], s, o[24]);
    mux2 m25(i[25], t[25], s, o[25]);
    mux2 m26(i[26], t[26], s, o[26]);
    mux2 m27(i[27], t[27], s, o[27]);
    mux2 m28(i[28], t[28], s, o[28]);
    mux2 m29(i[29], t[29], s, o[29]);
    mux2 m30(i[30], t[30], s, o[30]);
    mux2 m31(i[31], t[31], s, o[31]);
endmodule

module bitshift_stage_manual8(
    input wire [31:0] i, 
    input wire s, 
    input wire [1:0] op, 
    input wire fill, 
    output wire [31:0] o
);
    wire [31:0] t;
    rl8_32 r (i, op, fill, t);

    // mux to identify if to shift that bit or pass
    // Stage Selection Muxes: if s=0, o=i; if s=1, o=t
    mux2 m00(i[0],  t[0],  s, o[0]);
    mux2 m01(i[1],  t[1],  s, o[1]);
    mux2 m02(i[2],  t[2],  s, o[2]);
    mux2 m03(i[3],  t[3],  s, o[3]);
    mux2 m04(i[4],  t[4],  s, o[4]);
    mux2 m05(i[5],  t[5],  s, o[5]);
    mux2 m06(i[6],  t[6],  s, o[6]);
    mux2 m07(i[7],  t[7],  s, o[7]);
    mux2 m08(i[8],  t[8],  s, o[8]);
    mux2 m09(i[9],  t[9],  s, o[9]);
    mux2 m10(i[10], t[10], s, o[10]);
    mux2 m11(i[11], t[11], s, o[11]);
    mux2 m12(i[12], t[12], s, o[12]);
    mux2 m13(i[13], t[13], s, o[13]);
    mux2 m14(i[14], t[14], s, o[14]);
    mux2 m15(i[15], t[15], s, o[15]);
    mux2 m16(i[16], t[16], s, o[16]);
    mux2 m17(i[17], t[17], s, o[17]);
    mux2 m18(i[18], t[18], s, o[18]);
    mux2 m19(i[19], t[19], s, o[19]);
    mux2 m20(i[20], t[20], s, o[20]);
    mux2 m21(i[21], t[21], s, o[21]);
    mux2 m22(i[22], t[22], s, o[22]);
    mux2 m23(i[23], t[23], s, o[23]);
    mux2 m24(i[24], t[24], s, o[24]);
    mux2 m25(i[25], t[25], s, o[25]);
    mux2 m26(i[26], t[26], s, o[26]);
    mux2 m27(i[27], t[27], s, o[27]);
    mux2 m28(i[28], t[28], s, o[28]);
    mux2 m29(i[29], t[29], s, o[29]);
    mux2 m30(i[30], t[30], s, o[30]);
    mux2 m31(i[31], t[31], s, o[31]);
endmodule

module bitshift_stage_manual16 (
    input wire [31:0] i, 
    input wire s, 
    input wire [1:0] op, 
    input wire fill, 
    output wire [31:0] o
);
    wire [31:0] t;
    rl16_32 r (i, op, fill, t); 

    // mux to identify if to shift that bit or pass
    // Stage Selection Muxes: if s=0, o=i; if s=1, o=t
    mux2 m00(i[0],  t[0],  s, o[0]);
    mux2 m01(i[1],  t[1],  s, o[1]);
    mux2 m02(i[2],  t[2],  s, o[2]);
    mux2 m03(i[3],  t[3],  s, o[3]);
    mux2 m04(i[4],  t[4],  s, o[4]);
    mux2 m05(i[5],  t[5],  s, o[5]);
    mux2 m06(i[6],  t[6],  s, o[6]);
    mux2 m07(i[7],  t[7],  s, o[7]);
    mux2 m08(i[8],  t[8],  s, o[8]);
    mux2 m09(i[9],  t[9],  s, o[9]);
    mux2 m10(i[10], t[10], s, o[10]);
    mux2 m11(i[11], t[11], s, o[11]);
    mux2 m12(i[12], t[12], s, o[12]);
    mux2 m13(i[13], t[13], s, o[13]);
    mux2 m14(i[14], t[14], s, o[14]);
    mux2 m15(i[15], t[15], s, o[15]);
    mux2 m16(i[16], t[16], s, o[16]);
    mux2 m17(i[17], t[17], s, o[17]);
    mux2 m18(i[18], t[18], s, o[18]);
    mux2 m19(i[19], t[19], s, o[19]);
    mux2 m20(i[20], t[20], s, o[20]);
    mux2 m21(i[21], t[21], s, o[21]);
    mux2 m22(i[22], t[22], s, o[22]);
    mux2 m23(i[23], t[23], s, o[23]);
    mux2 m24(i[24], t[24], s, o[24]);
    mux2 m25(i[25], t[25], s, o[25]);
    mux2 m26(i[26], t[26], s, o[26]);
    mux2 m27(i[27], t[27], s, o[27]);
    mux2 m28(i[28], t[28], s, o[28]);
    mux2 m29(i[29], t[29], s, o[29]);
    mux2 m30(i[30], t[30], s, o[30]);
    mux2 m31(i[31], t[31], s, o[31]);
endmodule

module barrelshifter32(
    input  wire [31:0] i,
    input  wire [31:0] s,      // We use s[4:0]
    input  wire [2:0]  func3,  // Mapping: func3[2] can act as op[0] (direction)
    input  wire        is_sra, 
    output wire [31:0] o
);
    wire [31:0] t16, t8, t4, t2;
    wire [1:0] op = {1'b0, func3[2]}; // Simplistic op mapping for SLL/SRL
    wire fill = is_sra ? i[31] : 1'b0;

    // The stages must be instantiated manually
    // Stage 16 -> 8 -> 4 -> 2 -> 1
    // (Each bitshift_stage_manual would contain the unique rlX module)
    bitshift_stage_manual16 b16 (i,   s[4], op, fill, t16);
    bitshift_stage_manual8 b8  (t16, s[3], op, fill, t8);
    bitshift_stage_manual4 b4  (t8,  s[2], op, fill, t4);
    bitshift_stage_manual2 b2  (t4,  s[1], op, fill, t2);
    bitshift_stage_manual b1  (t2,  s[0], op, fill, o);

endmodule