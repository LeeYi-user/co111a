`include "gates.v"

module main;
    reg a = 0, b = 0, sel = 0;
    wire out;

    Mux g(a, b, sel, out);

    initial begin
        $display("%4s %4s %5s %5s\n", "a", "b", "sel", "out");
        $monitor("%4d %4d %4d %5d", a, b, sel, out);
    end

    always #50 begin
        sel++;
    end

    always #100 begin
        b++;
    end

    always #200 begin
        a++;
    end

    initial #350 $finish(0);
endmodule
