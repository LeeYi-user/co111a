`include "gates.v"

module main;
    reg[15:0] a = 0, b = 0, c = 0, d = 0;
    reg[1:0] sel = 0;
    wire[15:0] out;

    Mux4Way16 g(a, b, c, d, sel, out);

    initial begin
        $monitor("%b    %b    %b    %b    %b    %b", a, b, c, d, sel, out);
    end

    always #50 begin
        sel++;
    end

    initial #0 begin
        a = 16'b0000000000000000;
        b = 16'b0000000000000000;
        c = 16'b0000000000000000;
        d = 16'b0000000000000000;
    end

    initial #200 begin
        a = 16'b0001001000110100;
        b = 16'b1001100001110110;
        c = 16'b1010101010101010;
        d = 16'b0101010101010101;
    end

    initial #350 $finish;
endmodule
