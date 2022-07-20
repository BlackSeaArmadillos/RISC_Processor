`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2021 10:05:34 PM
// Design Name: 
// Module Name: register1
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

module register1(
    output reg [15:0] r1_r1,
    input rst,
    input halt, // this has to be deleted
    input clk,
    input [15:0] r1_instruction,
    input [`A_SIZE-1:0] pc
    
    );
    
    
    
    always@(posedge clk) begin
        if (!rst) begin
            r1_r1 <= 0;
            //$display("register1: Reset");
        end
        else if(halt)
            r1_r1 <= r1_r1;
        else begin
            r1_r1 <= r1_instruction;
        end 
    end      
endmodule
