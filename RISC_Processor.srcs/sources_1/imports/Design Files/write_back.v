`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2021 10:38:38 PM
// Design Name: 
// Module Name: write_back
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


module write_back(
    output reg [31:0] wresult,
    output reg [2:0] wdest,
    output reg wen,
    input [6:0] r3_opcode,    
    input [2:0] r3_dest,
    input [31:0] r3_result,
    input [31:0] m_data_in,
    input rst,
    input clk,
    input [`A_SIZE-1:0] pc
    
    // only for testing purpose
    //output reg [31:0] wresult_test
    );
    
    always@(*) begin
        //$display("r3_dest = %b", r3_dest);
        if (rst) begin
            casex(r3_opcode)
                `NOP:           ;
                                
                `ADD:           begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                    //$display("write_back: r3_result = %b, r3_dest = %b", r3_result, r3_dest);
                                end
                                
                `ADDF:          begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end 
                                   
                `SUB:           begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end  
                                  
                `SUBF:          begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end  
                                  
                `AND:           begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end
                                
                `OR:            begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end   
                                 
                `XOR:           begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end    
                                
                `NAND:          begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end    
                                
                `NOR:           begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end    
                                
                `NXOR:          begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end    
                                
                `SHIFTR:        begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end    
                                
                `SHIFTRA:       begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end    
                                
                `SHIFTL:        begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                end    
                                
                `LOAD:          begin 
                                    wen = 1'b1;
                                    wresult = m_data_in;
                                    wdest = r3_dest;
                                    //$display("m_data_in = %d", m_data_in);
                                end
                                
                `LOADC:         begin
                                    wen = 1'b1;
                                    wresult = r3_result;
                                    wdest = r3_dest;
                                    //$display("write_back: r3_result = %b, r3_dest = %b", r3_result, r3_dest);
                                    //$display("write_back: r3_dest = %b", r3_dest);
                                end
                
                `STORE:         ;
                                
                `JMP:           ;
                                
                `JMPR:          ;
                                
                `JMPcond:       ;
                                
                `JMPRcond:      ;
                                
                `HALT:          ;
            endcase
        end
    end
    
    //assign wresult_test = wresult;
    
endmodule
