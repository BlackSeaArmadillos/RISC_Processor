`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2021 03:00:51 PM
// Design Name: 
// Module Name: program_counter
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
`include "include_defines.vh"

module program_counter(
    output reg [`A_SIZE-1:0] pc,
    input [7:0] opcode,
    input rst,
    input clk,
    input halt,
    input [2:0] pc_jmp
    );
    
    //reg [`A_SIZE-1:0] pc;
   
    always@(posedge clk) begin
        if (!rst)
            pc <= 0;
        else if (opcode == 8'b11111111)
            pc <= pc;
        else if (pc_jmp > 0)
            pc <= pc_jmp;
        else
            pc <= pc + 1;
    end
    
    //assign pc_pc = pc_pc + 1;        
endmodule
