`include "../02/gates.v"

module DFF(input in, clock, output out);
    reg q;
    assign out = q;

    always @(posedge clock) begin
        q = in;
    end
endmodule

module Bit(input in, clock, load, output out);
    Mux g1(out, in, load, c);
    DFF g2(c, clock, out);
endmodule

module Register(input[15:0] in, input clock, load, output[15:0] out);
    Bit g1(in[0], clock, load, out[0]);
    Bit g2(in[1], clock, load, out[1]);
    Bit g3(in[2], clock, load, out[2]);
    Bit g4(in[3], clock, load, out[3]);
    Bit g5(in[4], clock, load, out[4]);
    Bit g6(in[5], clock, load, out[5]);
    Bit g7(in[6], clock, load, out[6]);
    Bit g8(in[7], clock, load, out[7]);
    Bit g9(in[8], clock, load, out[8]);
    Bit g10(in[9], clock, load, out[9]);
    Bit g11(in[10], clock, load, out[10]);
    Bit g12(in[11], clock, load, out[11]);
    Bit g13(in[12], clock, load, out[12]);
    Bit g14(in[13], clock, load, out[13]);
    Bit g15(in[14], clock, load, out[14]);
    Bit g16(in[15], clock, load, out[15]);
endmodule

module RAM8(input[15:0] in, input clock, load, input[2:0] address, output[15:0] out);
    wire[15:0] R1, R2, R3, R4, R5, R6, R7, R8;

    DMux8Way g1(load, address, L1, L2, L3, L4, L5, L6, L7, L8);

    Register g2(in, clock, L1, R1);
    Register g3(in, clock, L2, R2);
    Register g4(in, clock, L3, R3);
    Register g5(in, clock, L4, R4);
    Register g6(in, clock, L5, R5);
    Register g7(in, clock, L6, R6);
    Register g8(in, clock, L7, R7);
    Register g9(in, clock, L8, R8);

    Mux8Way16 g10(R1, R2, R3, R4, R5, R6, R7, R8, address, out);
endmodule

module RAM64(input[15:0] in, input clock, load, input[5:0] address, output[15:0] out);
    wire[15:0] R1, R2, R3, R4, R5, R6, R7, R8;

    DMux8Way g1(load, address[5:3], L1, L2, L3, L4, L5, L6, L7, L8);

    RAM8 g2(in, clock, L1, address[2:0], R1);
    RAM8 g3(in, clock, L2, address[2:0], R2);
    RAM8 g4(in, clock, L3, address[2:0], R3);
    RAM8 g5(in, clock, L4, address[2:0], R4);
    RAM8 g6(in, clock, L5, address[2:0], R5);
    RAM8 g7(in, clock, L6, address[2:0], R6);
    RAM8 g8(in, clock, L7, address[2:0], R7);
    RAM8 g9(in, clock, L8, address[2:0], R8);

    Mux8Way16 g10(R1, R2, R3, R4, R5, R6, R7, R8, address[5:3], out);
endmodule
/*
module RAM512(input[15:0] in, input clock, load, input[8:0] address, output[15:0] out);
    wire[15:0] R1, R2, R3, R4, R5, R6, R7, R8;

    DMux8Way g1(load, address[8:6], L1, L2, L3, L4, L5, L6, L7, L8);

    RAM64 g2(in, clock, L1, address[5:0], R1);
    RAM64 g3(in, clock, L2, address[5:0], R2);
    RAM64 g4(in, clock, L3, address[5:0], R3);
    RAM64 g5(in, clock, L4, address[5:0], R4);
    RAM64 g6(in, clock, L5, address[5:0], R5);
    RAM64 g7(in, clock, L6, address[5:0], R6);
    RAM64 g8(in, clock, L7, address[5:0], R7);
    RAM64 g9(in, clock, L8, address[5:0], R8);

    Mux8Way16 g10(R1, R2, R3, R4, R5, R6, R7, R8, address[8:6], out);
endmodule

module RAM4K(input[15:0] in, input clock, load, input[11:0] address, output[15:0] out);
    wire[15:0] R1, R2, R3, R4, R5, R6, R7, R8;

    DMux8Way g1(load, address[11:9], L1, L2, L3, L4, L5, L6, L7, L8);

    RAM512 g2(in, clock, L1, address[8:0], R1);
    RAM512 g3(in, clock, L2, address[8:0], R2);
    RAM512 g4(in, clock, L3, address[8:0], R3);
    RAM512 g5(in, clock, L4, address[8:0], R4);
    RAM512 g6(in, clock, L5, address[8:0], R5);
    RAM512 g7(in, clock, L6, address[8:0], R6);
    RAM512 g8(in, clock, L7, address[8:0], R7);
    RAM512 g9(in, clock, L8, address[8:0], R8);

    Mux8Way16 g10(R1, R2, R3, R4, R5, R6, R7, R8, address[11:9], out);
endmodule
*/
module RAM8K(input[15:0] in, input clock, load, input[12:0] address, output[15:0] out);
    reg[15:0] m[0:2**13 - 1];

    assign out = m[address];

    always @(posedge clock) begin
        if (load) m[address] = in;
    end
endmodule

module RAM16K(input[15:0] in, input clock, load, input[13:0] address, output[15:0] out);
    reg[15:0] m[0:2**14 - 1];

    assign out = m[address];

    always @(posedge clock) begin
        if (load) m[address] = in;
    end
endmodule

module ROM32K(input[14:0] address, output[15:0] out);
    reg[15:0] m[0:2**15 - 1];

    assign out = m[address];
endmodule

module PC(input[15:0] in, input clock, load, inc, reset, output[15:0] out);
    wire[15:0] out1, out2, out3, out4, out5;

    Register g1(out5, clock, 1'b1, out1);
    Inc16 g2(out1, out2);
    And16 g3(out1, out1, out);

    Mux16 g4(out1, out2, inc, out3);
    Mux16 g5(out3, in, load, out4);
    Mux16 g6(out4, 16'b0, reset, out5);
endmodule
