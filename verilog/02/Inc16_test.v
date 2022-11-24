`include "gates.v"

module main;
    reg[15:0] in = 0;
    wire[15:0] out;

    Inc16 g(in, out);

    initial begin
        $monitor("%b    %b", in, out);
    end

    initial #0 begin
        in = 16'b0000000000000000;
    end

    initial #50 begin
        in = 16'b1111111111111111;
    end

    initial #100 begin
        in = 16'b0000000000000101;
    end

    initial #150 begin
        in = 16'b1111111111111011;
    end

    initial #200 $finish;
endmodule
