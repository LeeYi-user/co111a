`include "gates.v"

module main;
    reg a = 0, b = 0;
    wire sum, carry;

    HalfAdder g1(a, b, sum, carry);

    initial begin
        $display("%4s %4s %5s %5s\n", "a", "b", "sum", "carry");
        $monitor("%4d %4d %4d %4d", a, b, sum, carry);
    end

    always #50 begin
        b++;
    end

    always #100 begin
        a++;
    end

    initial #150 $finish(0);
endmodule
