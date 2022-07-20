`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 09:42:02 PM
// Design Name: 
// Module Name: distributed_ram
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


module distributed_ram(
    output reg[31:0] data_out,
    input[31:0] data_in,
    input[9:0] addr,
    input[1:0] rw,
    input clk,
    input rst 
    );
    
    reg [`D_SIZE-1:0] dist_ram [0:`DM_DEPTH-1];
    integer index = 0;
    
    always@(posedge clk) begin
    //$display("SRAM: ", data_in, addr, dist_ram[4], dist_ram[8], dist_ram[12], dist_ram[16], dist_ram[20], dist_ram[24], dist_ram[28]);
//    $display(dist_ram[4], dist_ram[8], dist_ram[12]);
//    $display(dist_ram[16], dist_ram[20], dist_ram[24]);
//    $display(dist_ram[28], dist_ram[32], dist_ram[36]);
    //$display("regs: ", dist_ram[`R1], dist_ram[`R2], dist_ram[`R3], dist_ram[`R4]);
        if (rst == 0) begin
            /*
                       | 4   8   12 |            | 40  44  48 |
                A =    | 16  20  24 |     B =    | 52  56  60 |
                       | 28  32  36 |            | 64  68  72 |
                   
            */
        
//            // A matrix
//            dist_ram[4] <= 1;
//            dist_ram[8] <= 2;
//            dist_ram[12] <= 0;
//            dist_ram[16] <= 3;
//            dist_ram[20] <= 1;
//            dist_ram[24] <= 4;
//            dist_ram[28] <= 1;
//            dist_ram[32] <= 0;
//            dist_ram[36] <= 1;
//            // B matrix
//            dist_ram[40] <= 2;
//            dist_ram[44] <= 0;
//            dist_ram[48] <= 3;
//            dist_ram[52] <= 1;
//            dist_ram[56] <= 4;
//            dist_ram[60] <= 1;
//            dist_ram[64] <= 0;
//            dist_ram[68] <= 2;
//            dist_ram[72] <= 0;

            dist_ram[4] <= 1;
            dist_ram[8] <= 2;
        end
        else begin
            if(rw == `WRITE) begin
                dist_ram[addr] = data_in;
            end
            else begin
                // do nothing
            end
        end
    end
    
    always@(*) begin
        data_out = dist_ram[addr];
    end
endmodule
