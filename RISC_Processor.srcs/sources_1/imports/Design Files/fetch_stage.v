`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2021 02:37:59 PM
// Design Name: 
// Module Name: fetch_stage
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// This stage will read from the instruction for the program memory
// Input: instruction
// Output: program counter

// define sizes
`define A_SIZE 10
`define D_SIZE 32

module fetch_stage(
    input [15:0] instruction,
    output [`A_SIZE-1:0] pc
    );
endmodule
