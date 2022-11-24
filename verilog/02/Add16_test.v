`include "gates.v"

module main;
    reg[15:0] a = 0, b = 0;
    wire[15:0] out;

    Add16 g(a, b, out);

    initial begin
        $monitor("%b    %b    %b", a, b, out);
    end

    initial #0 begin
        a = 16'b0000000000000000;
        b = 16'b0000000000000000;
    end

    initial #50 begin
        a = 16'b0000000000000000;
        b = 16'b1111111111111111;
    end

    initial #100 begin
        a = 16'b1111111111111111;
        b = 16'b1111111111111111;
    end

    initial #150 begin
        a = 16'b1010101010101010;
        b = 16'b0101010101010101;
    end

    initial #200 begin
        a = 16'b0011110011000011;
        b = 16'b0000111111110000;
    end

    initial #250 begin
        a = 16'b0001001000110100;
        b = 16'b1001100001110110;
    end

    initial #300 $finish;
endmodule
