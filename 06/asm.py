d_map = {
    "": "000", "M": "001", "D": "010", "MD": "011",
    "A": "100", "AM": "101", "AD": "110", "AMD": "111"
}

c_map = {
    "0": "0101010", "1": "0111111", "-1": "0111010",
    "D": "0001100", "A": "0110000", "!D": "0001101",
    "!A": "0110001", "-D": "0001111", "-A": "0110011",
    "D+1": "0011111", "A+1": "0110111", "D-1": "0001110",
    "A-1": "0110010", "D+A": "0000010", "D-A": "0010011",
    "A-D": "0000111", "D&A": "0000000", "D|A": "0010101",
    "M": "1110000", "!M": "1110001", "-M": "1110011",
    "M+1": "1110111", "M-1": "1110010", "D+M": "1000010",
    "D-M": "1010011", "M-D": "1000111", "D&M": "1000000",
    "D|M": "1010101"
}

j_map = {
    "": "000", "JGT": "001", "JEQ": "010", "JGE": "011",
    "JLT": "100", "JNE": "101", "JLE": "110", "JMP": "111"
}

var_top = 16

sym_map = {
    "R0": 0, "R1": 1, "R2": 2, "R3": 3, "R4": 4, "R5": 5, "R6": 6, "R7": 7,
    "R8": 8, "R9": 9, "R10": 10, "R11": 11, "R12": 12, "R13": 13, "R14": 14, "R15": 15,
    "SCREEN": 16384, "KBD": 24576, "SP": 0, "LCL": 0, "ARG": 2, "THIS": 3, "THAT": 4
}


def pass1(in_file):
    print("============= PASS1 ================")
    with open(in_file, "r") as fp:
        address = 0
        for line in fp:
            code = line.split("//")[0].strip()
            if len(code) == 0:
                continue
            print("%02d:%s" % (address, code))
            if code[0] == "(":
                label = code[1:-1]
                if label not in sym_map:
                    sym_map[label] = address
                else:
                    print("error: %s already defined before !" % label, end='')

                print("symbol:%s address=%d" % (label, address))
            else:
                address += 1


def int2bin(a, size):
    bin = ["0"] * size
    for i in range(size - 1, -1, -1):
        bin[i] = str(a & 1)
        a >>= 1
    return "".join(bin)


def bin2int(bin):
    return int(bin, 2)


def code2binary(code):
    global sym_map
    global var_top

    if code[0] == "@":  # A指令：@number || @symbol
        address = 0
        try:
            address = int(code[1:])
        except:
            symbol = code[1:]
            if symbol in sym_map:
                address = sym_map[symbol]
            else:
                sym_map[symbol] = var_top
                address = var_top
                var_top += 1

        return int2bin(address, 16)
    else:  # C指令
        if "=" in code:  # d=comp
            d, comp = code.split("=")
            dcode = d_map[d]
            ccode = c_map[comp]
            return f"111{ccode}{dcode}000"
        else:  # comp;j
            comp, j = code.split(";")
            ccode = c_map[comp]
            jcode = j_map[j]
            return f"111{ccode}000{jcode}"


def pass2(in_file, hack_file):
    print("============= PASS2 ================")
    with open(in_file, "r") as fp, open(hack_file, "w") as hfp:
        address = 0
        for line in fp:
            code = line.split("//")[0].strip()
            if len(code) == 0:
                continue
            if code[0] == "(":  # 這行是符號 ex: (LOOP)
                print(code)  # 印出該符號
            else:
                binary = code2binary(code)
                b = bin2int(binary)
                print("%02X: %-20s %s %04x" % (address, code, binary, b))
                hfp.write(f"{binary}\n")  # 輸出 .hack 的二進位字串檔
                address += 1


def main():
    pass1("input.asm")
    pass2("input.asm", "output.hack")


if __name__ == "__main__":
    main()
