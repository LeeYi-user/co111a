`include "gates.v"

module main;
    reg a = 0, b = 0;
    wire out;

    Or g(a, b, out);

    initial begin
        $display("%4s %4s %5s\n", "a", "b", "out");
        $monitor("%4d %4d %4d", a, b, out);
    end

    always #50 begin
        b++;
    end

    always #100 begin
        a++;
    end

    initial #150 $finish(0);
endmodule
