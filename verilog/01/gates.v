`include "../00/gates.v"

module And(input a, b, output out);
    Nand g1(a, b, aNandb);
    Not g2(aNandb, out);
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

module Not(input in, output out);
    Nand g(in, in, out);
endmodule

module Or(input a, b, output out);
    Not g1(a, Nota);
    Not g2(b, Notb);
    Nand g3(Nota, Notb, out);
endmodule

module Xor(input a, b, output out);
    Not g1(a, Nota);
    Not g2(b, Notb);
    And g3(a, Notb, aAndNotb);
    And g4(Nota, b, NotaAndb);
    Or g5(aAndNotb, NotaAndb, out);
endmodule
