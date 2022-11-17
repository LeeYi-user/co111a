`include "gates.v"

module main;
    reg[7:0] in = 0;
    wire out;

    Or8Way g(in, out);

    initial begin
        $monitor("%b    %d", in, out);
    end

    initial #0 begin
        in = 8'b00000000;
    end

    initial #50 begin
        in = 8'b11111111;
    end

    initial #100 begin
        in = 8'b00010000;
    end

    initial #150 begin
        in = 8'b00000001;
    end

    initial #200 begin
        in = 8'b00100110;
    end

    initial #200 $finish;
endmodule
