`include "../00/gates.v"

module And(input a, b, output out);
    Nand g1(a, b, aNandb);
    Not g2(aNandb, out);
endmodule

module And16(input[15:0] a, b, output[15:0] out);
    And g1(a[15], b[15], out[15]);
    And g2(a[14], b[14], out[14]);
    And g3(a[13], b[13], out[13]);
    And g4(a[12], b[12], out[12]);
    And g5(a[11], b[11], out[11]);
    And g6(a[10], b[10], out[10]);
    And g7(a[9], b[9], out[9]);
    And g8(a[8], b[8], out[8]);
    And g9(a[7], b[7], out[7]);
    And g10(a[6], b[6], out[6]);
    And g11(a[5], b[5], out[5]);
    And g12(a[4], b[4], out[4]);
    And g13(a[3], b[3], out[3]);
    And g14(a[2], b[2], out[2]);
    And g15(a[1], b[1], out[1]);
    And g16(a[0], b[0], out[0]);
endmodule

module DMux(input in, sel, output a, b);
    Not g1(sel, Notsel);
    And g2(Notsel, in, a);
    And g3(in, sel, b);
endmodule

module DMux4Way(input in, input[1:0] sel, output a, b, c, d);
    DMux g1(in, sel[1], a0, b0);
    DMux g2(a0, sel[0], a, b);
    DMux g3(b0, sel[0], c, d);
endmodule

module DMux8Way(input in, input[2:0] sel, output a, b, c, d, e, f, g, h);
    DMux4Way g1(in, sel[2:1], a0, b0, c0, d0);
    DMux g2(a0, sel[0], a, b);
    DMux g3(b0, sel[0], c, d);
    DMux g4(c0, sel[0], e, f);
    DMux g5(d0, sel[0], g, h);
endmodule

module Mux(input a, b, sel, output out);
    Not g1(sel, Notsel);
    And g2(a, Notsel, aAndNotsel);
    And g3(b, sel, bAndsel);
    Or g4(aAndNotsel, bAndsel, out);
endmodule

module Mux16(input[15:0] a, b, input sel, output[15:0] out);
    Mux g1(a[15], b[15], sel, out[15]);
    Mux g2(a[14], b[14], sel, out[14]);
    Mux g3(a[13], b[13], sel, out[13]);
    Mux g4(a[12], b[12], sel, out[12]);
    Mux g5(a[11], b[11], sel, out[11]);
    Mux g6(a[10], b[10], sel, out[10]);
    Mux g7(a[9], b[9], sel, out[9]);
    Mux g8(a[8], b[8], sel, out[8]);
    Mux g9(a[7], b[7], sel, out[7]);
    Mux g10(a[6], b[6], sel, out[6]);
    Mux g11(a[5], b[5], sel, out[5]);
    Mux g12(a[4], b[4], sel, out[4]);
    Mux g13(a[3], b[3], sel, out[3]);
    Mux g14(a[2], b[2], sel, out[2]);
    Mux g15(a[1], b[1], sel, out[1]);
    Mux g16(a[0], b[0], sel, out[0]);
endmodule

module Mux4Way16(input[15:0] a, b, c, d, input[1:0] sel, output[15:0] out);
    wire[15:0] c1, c2;
    Mux16 g1(a, b, sel[0], c1);
    Mux16 g2(c, d, sel[0], c2);
    Mux16 g3(c1, c2, sel[1], out);
endmodule

module Mux8Way16(input[15:0] a, b, c, d, e, f, g, h, input[2:0] sel, output[15:0] out);
    wire[15:0] o1, o2;
    Mux4Way16 g1(a, b, c, d, sel[1:0], o1);
    Mux4Way16 g2(e, f, g, h, sel[1:0], o2);
    Mux16 g3(o1, o2, sel[2], out);
endmodule

module Not(input in, output out);
    Nand g(in, in, out);
endmodule

module Not16(input[15:0] in, output[15:0] out);
    Not g1(in[15], out[15]);
    Not g2(in[14], out[14]);
    Not g3(in[13], out[13]);
    Not g4(in[12], out[12]);
    Not g5(in[11], out[11]);
    Not g6(in[10], out[10]);
    Not g7(in[9], out[9]);
    Not g8(in[8], out[8]);
    Not g9(in[7], out[7]);
    Not g10(in[6], out[6]);
    Not g11(in[5], out[5]);
    Not g12(in[4], out[4]);
    Not g13(in[3], out[3]);
    Not g14(in[2], out[2]);
    Not g15(in[1], out[1]);
    Not g16(in[0], out[0]);
endmodule

module Or(input a, b, output out);
    Not g1(a, Nota);
    Not g2(b, Notb);
    Nand g3(Nota, Notb, out);
endmodule

module Or8Way(input[7:0] in, output out);
    Or g1(in[7], in[6], c1);
    Or g2(in[5], in[4], c2);
    Or g3(in[3], in[2], c3);
    Or g4(in[1], in[0], c4);

    Or g5(c1, c2, d1);
    Or g6(c3, c4, d2);

    Or g7(d1, d2, out);
endmodule

module Or16(input[15:0] a, b, output[15:0] out);
    Or g1(a[15], b[15], out[15]);
    Or g2(a[14], b[14], out[14]);
    Or g3(a[13], b[13], out[13]);
    Or g4(a[12], b[12], out[12]);
    Or g5(a[11], b[11], out[11]);
    Or g6(a[10], b[10], out[10]);
    Or g7(a[9], b[9], out[9]);
    Or g8(a[8], b[8], out[8]);
    Or g9(a[7], b[7], out[7]);
    Or g10(a[6], b[6], out[6]);
    Or g11(a[5], b[5], out[5]);
    Or g12(a[4], b[4], out[4]);
    Or g13(a[3], b[3], out[3]);
    Or g14(a[2], b[2], out[2]);
    Or g15(a[1], b[1], out[1]);
    Or g16(a[0], b[0], out[0]);
endmodule

module Xor(input a, b, output out);
    Not g1(a, Nota);
    Not g2(b, Notb);
    And g3(a, Notb, aAndNotb);
    And g4(Nota, b, NotaAndb);
    Or g5(aAndNotb, NotaAndb, out);
endmodule
