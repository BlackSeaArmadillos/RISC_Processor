`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2021 10:03:12 PM
// Design Name: 
// Module Name: fetch
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

module fetch(
    output [`A_SIZE-1:0] instr_address,
    output reg [`A_SIZE-1:0] pc,
    input [7:0] opcode,
    input rst,
    input clk,
    input halt,
    input [`A_SIZE-1:0] pc_jmp
    );
    
    //reg [`A_SIZE-1:0] pc;
    
    always@(posedge clk) begin
        if (!rst)
            pc <= 0;
        else if (opcode == 8'b11111111)
            pc <= pc;
        else if (pc_jmp > 0) begin
            pc <= pc_jmp;
            $display("pc <= pc_jmp");
        end    
        else
            pc <= pc + 1;
    end
    
    assign instr_address = pc;
    
    
endmodule
