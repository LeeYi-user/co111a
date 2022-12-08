`include "../03/gates.v"

module CPU(input[15:0] inM, I, input clock, reset, output[15:0] outM, output writeM, output[14:0] addressM, pc);
    wire[15:0] outALU, out1Mux16, outARegister, outDRegister, out2Mux16, pcout;

    // first Mux16
    Mux16 g1(I, outALU, I[15], out1Mux16);

    // ARegister
    Not g2(I[15], isA);
    And g3(I[15], I[5], isCAndd1);
    Or g4(isA, isCAndd1, loadARegister);
    Register A(out1Mux16, clock, loadARegister, outARegister);
    assign addressM = outARegister[14:0];

    // DRegister
    And g5(I[15], I[4], loadDRegister);
    Register D(outALU, clock, loadDRegister, outDRegister);

    // second Mux16
    Mux16 g6(outARegister, inM, I[12], out2Mux16);

    // ALU
    ALU g7(outDRegister, out2Mux16, I[11], I[10], I[9], I[8], I[7], I[6], outALU, czr, cng);
    And16 g8(outALU, outALU, outM);

    // writeM
    And g9(I[15], I[3], writeM);

    // PC
    Not g10(I[2], Notj1);
    Not g11(I[1], Notj2);
    Not g12(I[0], Notj3);
    Not g13(czr, Notczr);
    Not g14(cng, Notcng);

    // JGT
    And g15(Notj1, Notj2, Notj1AndNotj2);
    And g16(Notj1AndNotj2, I[0], Notj1AndNotj2Andj3);
    And g17(Notczr, Notcng, NotczrAndNotcng);
    And g18(Notj1AndNotj2Andj3, NotczrAndNotcng, jgt);

    // JEQ
    And g19(Notj1, Notj3, Notj1AndNotj3);
    And g20(Notj1AndNotj3, I[1], Notj1Andj2AndNotj3);
    And g21(Notj1Andj2AndNotj3, czr, jeq);

    // JGE
    And g22(I[1], I[0], j2Andj3);
    And g23(Notj1, j2Andj3, Notj1Andj2Andj3);
    And g24(Notj1Andj2Andj3, Notcng, jge);

    // JLT
    And g25(Notj2, Notj3, Notj2AndNotj3);
    And g26(I[2], Notj2AndNotj3, j1AndNotj2AndNotj3);
    And g27(j1AndNotj2AndNotj3, cng, jlt);

    // JNE
    And g28(I[2], I[0], j1Andj3);
    And g29(j1Andj3, Notj2, j1AndNotj2Andj3);
    And g30(j1AndNotj2Andj3, Notczr, jne);

    // JLE
    And g31(I[2], I[1], j1Andj2);
    And g32(j1Andj2, Notj3, j1Andj2AndNotj3);
    Or g33(czr, cng, czrOrcng);
    And g34(j1Andj2AndNotj3, czrOrcng, jle);

    // JMP
    And g35(j1Andj2, I[0], jmp);

    // PC
    Or g36(1'b0, jgt, jout1);
    Or g37(jeq, jge, jout2);
    Or g38(jlt, jne, jout3);
    Or g39(jle, jmp, jout4);
    Or g40(jout1, jout2, jout5);
    Or g41(jout3, jout4, jout6);
    Or g42(jout5, jout6, jump);
    And g43(I[15], jump, loadPC);
    Not g44(loadPC, NotloadPC);
    PC g45(outARegister, clock, loadPC, NotloadPC, reset, pcout);
    assign pc = pcout[14:0];
endmodule

module Memory(input[15:0] in, input clock, load, input[14:0] address, output[15:0] out);
    wire[15:0] outM, outS, outK, outSK;

    Not g1(address[14], Not14);
    And g2(Not14, load, loadM);
    And g3(address[14], load, loadS);

    RAM16K g4(in, clock, loadM, address[13:0], outM);
    RAM8K screen(in, clock, loadS, address[12:0], outS);
    Register keyboard(16'h0F0F, clock, 1'b0, outK);

    Mux16 g5(outS, outK, address[13], outSK);
    Mux16 g6(outM, outSK, address[14], out);
endmodule

module Computer(input clock, reset);
    wire[15:0] I, out, outM;
    wire[14:0] addressM, pc;

    ROM32K g1(pc, I);
    CPU g2(out, I, clock, reset, outM, writeM, addressM, pc);
    Memory g3(outM, !clock, writeM, addressM, out);
endmodule
