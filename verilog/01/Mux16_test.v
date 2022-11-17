`include "gates.v"

module main;
    reg[15:0] a = 0, b = 0;
    reg sel = 0;
    wire[15:0] out;

    Mux16 g(a, b, sel, out);

    initial begin
        $monitor("%b    %b    %d    %b", a, b, sel, out);
    end

    always #50 begin
        sel++;
    end

    initial #0 begin
        a = 16'b0000000000000000;
        b = 16'b0000000000000000;
    end

    initial #100 begin
        a = 16'b0000000000000000;
        b = 16'b0001001000110100;
    end

    initial #200 begin
        a = 16'b1001100001110110;
        b = 16'b0000000000000000;
    end

    initial #300 begin
        a = 16'b1010101010101010;
        b = 16'b0101010101010101;
    end

    initial #350 $finish;
endmodule
