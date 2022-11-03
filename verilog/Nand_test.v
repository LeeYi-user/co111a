// iverilog -o Nand.out Nand_test.v
// vvp Nand.out

`include "Nand.v"

module main;
    reg a = 0, b = 0;
    wire out;

    Nand g(a, b, out);

    initial begin
        $display("%4s %4s %5s\n", "a", "b", "out");
        $monitor("%4d %4d %4d", a, b, out);
    end

    always #50 begin    // 50 * 2^idx
        b++;
    end

    always #100 begin   // 50 * 2^idx
        a++;
    end

    initial #150 $finish(0);    // 50 * 2^len - 50
endmodule
