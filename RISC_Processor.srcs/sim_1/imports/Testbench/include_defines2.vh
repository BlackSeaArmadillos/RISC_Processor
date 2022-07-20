`ifndef _include_defines2_vh_
`define _include_defines2_vh_

// define sizes
`define A_SIZE 10
`define D_SIZE 32

// define instruction
`define NOP         16'b0000000000000000
`define ADD         7'b0000001
`define ADDF        7'b0000010
`define SUB         7'b0000011
`define SUBF        7'b0000100
`define AND         7'b0000101
`define OR          7'b0000110
`define XOR         7'b0000111
`define NAND        7'b0001000
`define NOR         7'b0001001
`define NXOR        7'b0001010
`define SHIFTR      7'b0001011
`define SHIFTRA     7'b0001100
`define SHIFTL      7'b0001101

`define LOAD        5'b00100
`define LOADC       5'b00101
`define STORE       5'b00110
`define JMP         4'b1000
`define JMPR        4'b1010
`define JMPcond     4'b1100
`define JMPRcond    4'b1110
`define HALT        16'b1111111111111111


// conditions
`define N           3'b000
`define NN          3'b001
`define Z           3'b010
`define NZ          3'b011
`define reserved    3'b1xx
                
// define registers
`define R0      3'b000
`define R1      3'b001
`define R2      3'b010
`define R3      3'b011
`define R4      3'b100
`define R5      3'b101
`define R6      3'b110
`define R7      3'b111     

`endif