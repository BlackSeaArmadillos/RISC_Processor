`ifndef _include_defines_vh_
`define _include_defines_vh_

// define sizes
`define R_SIZE      8
`define A_SIZE      10
`define D_SIZE      32
//`define DM_DEPTH 128
`define DM_DEPTH    1024

// Cache sizes
`define SET_NUM     2
`define WAY_NUM     4
`define TAG_SIZE    7
`define IDX_SIZE    3
`define OFF_SIZE    2
`define C_SIZE      `D_SIZE+`TAG_SIZE+2     // 1 bit valid, 1 bit dirty
`define SET_SIZE     4*`C_SIZE           // 41 bits


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

`define LOAD        7'b00100xx
`define LOADC       7'b00101xx
`define STORE       7'b00110xx
`define JMP         7'b1000xxx
`define JMPR        7'b1010xxx
`define JMPcond     7'b1100xxx
`define JMPRcond    7'b1110xxx
`define HALT        16'b1111111111111111

// conditions
`define N           3'b000
`define NN          3'b001
`define Z           3'b010
`define NZ          3'b011
`define reserved    3'b1xx

// compare define
`define COMPARE(RESULT, PARAM) \
    if(PARAM < 0)   \
        RESULT = `N;    \
    else if (PARAM >= 0)    \
        RESULT = `NN;   \
    else if (PARAM == 0)    \
        RESULT = `Z;    \
    else if (PARAM != 0)    \
        RESULT = `NZ;   \
    else    \
        ;
        
                
                
// define registers
`define R0      3'b000
`define R1      3'b001
`define R2      3'b010
`define R3      3'b011
`define R4      3'b100
`define R5      3'b101
`define R6      3'b110
`define R7      3'b111                
                
// Read/Write from/to memory
`define READ        2'b00
`define WRITE       2'b01
`define DEFAULT     2'b11

`endif