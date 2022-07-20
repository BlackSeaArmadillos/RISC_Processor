`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2021 10:38:20 PM
// Design Name: 
// Module Name: register3
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


module register3(
    output reg [6:0] r3_opcode,
    output reg [2:0] r3_dest,
    output reg [31:0] r3_result,
    output [31:0] r3_op1,
    output [31:0] r3_op2,
    input [6:0] r2_opcode,
    input [2:0] r2_dest,
    input [31:0] result,   
    input [31:0] r2_op1,
    input [31:0] r2_op2,
    input rst,
    input clk,
    input [`A_SIZE-1:0] pc
    );
    
    reg halt;
    
    always@(posedge clk) begin
        if (!rst) begin
            r3_opcode <= 0;
            r3_dest <= 0;
            r3_result <= 0;
        end
        else if (r2_opcode == 4'b1111) begin // halt
            r3_opcode <= r3_opcode;
            r3_dest <= r3_dest;
            r3_result <= r3_result;
        end
        else begin
            r3_opcode <= r2_opcode;
            r3_dest <= r2_dest;
            r3_result <= result;
            //$display("register3: r2_opcode = %b, r2_dest = %b, result = %b", r2_opcode, r2_dest, result);
        end
    end
    

    
endmodule
