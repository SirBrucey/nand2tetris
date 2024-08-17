// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

// Pseudocode
// cur = 0  start with the screen cleared
// transition = 0 start with no transition
// loop:
//     if (keyboard is pressed) {
//         transition = -1
//     } else {
//         transition = 0
//     }
//     if (transition = cur) {
//         goto loop
//     }
//     goto draw
// draw:
//     if (transition = -1) {
//         blacken the screen
//     } else {
//         clear the screen
//     }
//     cur = transition
//     goto loop

    @cur
    M=0  // cur = 0

    @transition
    M=0  // transition = 0

(LOOP)
    // if keyboard is pressed, transition = -1 else transition = 0
    @KBD
    D=M
    @SET_BLACK
    D;JNE
    @SET_WHITE
    0;JMP

(SET_BLACK)
    @transition
    M=-1
    @CMP
    0;JMP

(SET_WHITE)
    @transition
    M=0
    @CMP
    0;JMP

(CMP)
    // Jump to loop if transition = cur
    @cur
    D=M
    @transition
    D=D-M
    @LOOP
    D;JEQ

    // Jump to DRAW
    @DRAW
    0;JMP

(DRAW)
    @SCREEN
    D=A
    @addr
    M=D // addr = SCREEN (base address of the screen)

    @i
    M=0 // i = 0

(DRAW_LOOP)
    // If we reach KBD Memory location, jump to LOOP
    @i
    D=M
    @KBD
    D=D-A
    @LOOP
    D;JEQ

    // Draw
    @transition
    D=M
    @addr
    A=M
    M=D

    // Next pixel
    @16
    D=A
    @addr
    M=D+M   // addr = addr + 16
    @DRAW_LOOP
    0;JMP
