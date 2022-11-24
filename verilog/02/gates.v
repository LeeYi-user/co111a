`include "../01/gates.v"

module Add16(input[15:0] a, b, output[15:0] out);
    HalfAdder g1(a[0], b[0], out[0], c0);
    FullAdder g2(a[1], b[1], c0, out[1], c1);
    FullAdder g3(a[2], b[2], c1, out[2], c2);
    FullAdder g4(a[3], b[3], c2, out[3], c3);
    FullAdder g5(a[4], b[4], c3, out[4], c4);
    FullAdder g6(a[5], b[5], c4, out[5], c5);
    FullAdder g7(a[6], b[6], c5, out[6], c6);
    FullAdder g8(a[7], b[7], c6, out[7], c7);
    FullAdder g9(a[8], b[8], c7, out[8], c8);
    FullAdder g10(a[9], b[9], c8, out[9], c9);
    FullAdder g11(a[10], b[10], c9, out[10], c10);    
    FullAdder g12(a[11], b[11], c10, out[11], c11);   
    FullAdder g13(a[12], b[12], c11, out[12], c12);   
    FullAdder g14(a[13], b[13], c12, out[13], c13);   
    FullAdder g15(a[14], b[14], c13, out[14], c14);   
    FullAdder g16(a[15], b[15], c14, out[15], c15);
endmodule

module ALU(input[15:0] x, y, input zx, nx, zy, ny, f, no, output[15:0] out, output zr, ng);
    wire[15:0] x1, notx, x2, y1, noty, y2, xaddy, xandy, out1, notout, out2;

    Mux16 g1(x, 16'b0, zx, x1);

    Not16 g2(x1, notx);
    Mux16 g3(x1, notx, nx, x2);

    Mux16 g4(y, 16'b0, zy, y1);

    Not16 g5(y1, noty);
    Mux16 g6(y1, noty, ny, y2);

    Add16 g7(y2, x2, xaddy);
    And16 g8(y2, x2, xandy);
    Mux16 g9(xandy, xaddy, f, out1);

    Not16 g10(out1, notout);
    Mux16 g11(out1, notout, no, out2);

    And16 g12(out2, out2, out);

    Or8Way g13(out[7:0], orLow);
    Or8Way g14(out[15:8], orHigh);
    Or g15(orLow, orHigh, orAll);
    Mux g16(1'b1, 1'b0, orAll, zr);

    Mux g17(1'b0, 1'b1, out[15], ng);
endmodule

module FullAdder(input a, b, c, output sum, carry);
    Xor g1(a, b, c0);
    Xor g2(c0, c, sum);

    And g3(a, b, ab);
    And g4(a, c, ac);
    And g5(b, c, bc);
    Or g6(ab, ac, o1);
    Or g7(o1, bc, carry);
endmodule

module HalfAdder(input a, b, output sum, carry);
    Xor g1(a, b, sum);
    And g2(a, b, carry);
endmodule

module Inc16(input[15:0] in, output[15:0] out);
    wire[15:0] b = 16'b0000000000000001;
    Add16 g1(in, b, out);
endmodule
