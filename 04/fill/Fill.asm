// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// int D = 8192;
// int M[];
//
// loop:
//     ;
//
// D = D - 1
// M[16384 + D] = 1
//
// if (D > 0)
// {
//     goto loop;
// }
//
// end:
//    ;

(KEEP_WHITE)

@8192
D = A

(WHITE)

D = D - 1
@SCREEN
A = A + D
M = 0

@WHITE
D;JGT

@KBD
D = M
@KEEP_WHITE
D;JEQ

// ----------

(KEEP_BLACK)

@8192
D = A

(BLACK)

D = D - 1
@SCREEN
A = A + D
M = -1

@BLACK
D;JGT

@KBD
D = M
@KEEP_BLACK
D;JNE

@KEEP_WHITE
0;JMP
