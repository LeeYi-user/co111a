`include "../Nand.v"

module Not(input in, output out);
    Nand g(in, in, out);
endmodule
