`include "gates.v"

module main;
    reg in = 0;
    wire out;

    Not g(in, out);

    initial begin
        $display("%4s %5s\n", "in", "out");
        $monitor("%4d %4d", in, out);
    end

    always #50 begin
        in++;
    end

    initial #50 $finish(0);
endmodule
