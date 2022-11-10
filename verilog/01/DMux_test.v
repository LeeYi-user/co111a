`include "gates.v"

module main;
    reg in = 0, sel = 0;
    wire a, b;

    DMux g(in, sel, a, b);

    initial begin
        $display("%4s %5s %4s %4s\n", "in", "sel", "a", "b");
        $monitor("%4d %4d %5d %4d", in, sel, a, b);
    end

    always #50 begin
        sel++;
    end

    always #100 begin
        in++;
    end

    initial #150 $finish(0);
endmodule
