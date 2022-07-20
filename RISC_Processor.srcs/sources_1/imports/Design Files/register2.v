`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2021 10:05:34 PM
// Design Name: 
// Module Name: register2
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


module register2(
    output reg [6:0] r2_opcode, 
    output reg [2:0] r2_dest,
    output reg [31:0] r2_op1,
    output reg [31:0] r2_op2,
    input [6:0] r1_opcode,
    input [2:0] r1_dest,
    input [31:0] r1_op1,
    input [31:0] r1_op2,
    
    input enMuxEx_1, // enable mux execute 1 = ON, 0 = OFF
    input enMuxEx_2,
    input enMuxR3_1, // enable mux register3
    input enMuxR3_2,
    input [31:0] ex_result,
    input [31:0] r3_result,
    //input [31:0] ex_data_out,
    
    input rst,
    input clk,
    input [`A_SIZE-1:0] pc
    );
    
    reg [31:0] r_mux_op1;
    reg [31:0] r_mux_op2;
    
    always@(posedge clk) begin
        if (!rst) begin
            r2_opcode <= 0;
            r2_dest <= 0;
            r2_op1 <= 0;
            r2_op2 <= 0;
        end
        else if (r1_opcode == 7'b1111111) begin // halt
            r2_opcode <= r2_opcode;
            r2_dest <= r2_dest;
            r2_op1 <= r2_op1;
            r2_op2 <= r2_op2;
        end
        else begin
            r2_opcode <= r1_opcode;
            r2_dest <= r1_dest;
            r2_op1 <= r_mux_op1;
            r2_op2 <= r_mux_op2;
            //$display("register2: r1_opcode = %b, r1_dest = %b, r_mux_op1 = %b, r_mux_op2 = %b", r1_opcode, r1_dest, r_mux_op1, r_mux_op2);
        end
    end
  
    
    // Data dependency control
    always@(*) begin 
        if (enMuxEx_1 || enMuxR3_1) begin
            if (enMuxEx_1) begin
                r_mux_op1 = ex_result;
            end
            else begin
                r_mux_op1 = r3_result;
            end
        end
        else begin
            r_mux_op1 = r1_op1;
        end
    end
    
    always@(*) begin
        if (enMuxEx_2 || enMuxR3_2) begin
            if (enMuxEx_2) begin
                r_mux_op2 = ex_result;
            end
            else begin
                r_mux_op2 = r3_result;
            end
        end
        else begin
            r_mux_op2 = r1_op2;
        end
    end
    
endmodule
