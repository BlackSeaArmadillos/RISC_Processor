`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2021 08:20:38 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    // data to Write_Back
    output reg send_data_in,
    // data from Execution (ALU)
    input receive_data_out,
    input addr,
    input rw,
    input clk,
    input rst
    );
    
    reg [2:0] data_mem [0:63];
    integer i;
    
    always@(posedge clk) begin
        if (rst == 1) begin
            for (i = 0; i < 63; i = i + 1) begin
                data_mem[i] = 0;
            end
        end
        else if (rst == 0) begin
            case (rw)
                2'b00   :   ; // do nothing
                
                2'b01   :   begin
                                data_mem[addr] = receive_data_out;
                            end
                
                2'b10   :   begin 
                                send_data_in = data_mem[addr];
                            end
                
                2'b11   :   ; // do nothing
            endcase
        end
    end
    
endmodule
