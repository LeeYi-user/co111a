`include "gates.v"

module main;
    reg a = 0, b = 0, c = 0;
    wire sum, carry;

    FullAdder g1(a, b, c, sum, carry);

    initial begin
        $display("%4s %4s %4s %5s %5s\n", "a", "b", "c", "sum", "carry");
        $monitor("%4d %4d %4d %4d %4d", a, b, c, sum, carry);
    end

    always #50 begin
        c++;
    end

    always #100 begin
        b++;
    end

    always #200 begin
        a++;
    end

    initial #350 $finish(0);
endmodule
