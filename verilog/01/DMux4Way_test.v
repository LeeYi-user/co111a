`include "gates.v"

module main;
    reg in = 0;
    reg signed[1:0] sel = 0;
    wire a, b, c, d;

    DMux4Way g(in, sel, a, b, c, d);

    initial begin
        $display("%4s %5s %4s %4s %4s %4s\n", "in", "sel", "a", "b", "c", "d");
        $monitor("%4d %4d%d %4d %4d %4d %4d", in, sel[1], sel[0], a, b, c, d);
    end

    always #50 begin
        sel[0]++;
    end

    always #100 begin
        sel[1]++;
    end

    always #200 begin
        in++;
    end

    initial #350 $finish(0);
endmodule
