`include "gates.v"

module main;
    reg[15:0] a = 0, b = 0, c = 0, d = 0, e = 0, f = 0, g = 0, h = 0;
    reg[2:0] sel = 0;
    wire[15:0] out;

    Mux8Way16 g1(a, b, c, d, e, f, g, h, sel, out);

    initial begin
        $monitor("%b    %b    %b    %b    %b    %b    %b    %b    %b    %b", a, b, c, d, e, f, g, h, sel, out);
    end

    always #50 begin
        sel++;
    end

    initial #0 begin
        a = 16'b0000000000000000;
        b = 16'b0000000000000000;
        c = 16'b0000000000000000;
        d = 16'b0000000000000000;
        e = 16'b0000000000000000;
        f = 16'b0000000000000000;
        g = 16'b0000000000000000;
        h = 16'b0000000000000000;
    end

    initial #400 begin
        a = 16'b0001001000110100;
        b = 16'b0010001101000101;
        c = 16'b0011010001010110;
        d = 16'b0100010101100111;
        e = 16'b0101011001111000;
        f = 16'b0110011110001001;
        g = 16'b0111100010011010;
        h = 16'b1000100110101011;
    end

    initial #750 $finish;
endmodule
