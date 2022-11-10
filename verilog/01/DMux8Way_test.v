`include "gates.v"

module main;
    reg in = 0;
    reg signed[2:0] sel = 0;
    wire a, b, c, d, e, f, g, h;

    DMux8Way g1(in, sel, a, b, c, d, e, f, g, h);

    initial begin
        $display("%4s %5s %4s %4s %4s %4s %4s %4s %4s %4s\n", "in", "sel", "a", "b", "c", "d", "e", "f", "g", "h");
        $monitor("%4d %3d%d%d %4d %4d %4d %4d %4d %4d %4d %4d", in, sel[2], sel[1], sel[0], a, b, c, d, e, f, g, h);
    end

    always #50 begin
        sel[0]++;
    end

    always #100 begin
        sel[1]++;
    end

    always #200 begin
        sel[2]++;
    end

    always #400 begin
        in++;
    end

    initial #750 $finish(0);
endmodule
