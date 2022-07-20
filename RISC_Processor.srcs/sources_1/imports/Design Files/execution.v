`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2021 10:05:34 PM
// Design Name: 
// Module Name: execution
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

// define sizes
`define A_SIZE 10
`define D_SIZE 32


module execution(
    output reg [9:0] addr, // waddr
    output reg [31:0] data_out,
    output reg [31:0] result, // wdata
    output reg [`A_SIZE-1:0] pc_jmp,
    output reg [1:0] rw,    // 10 - read, 01 - write
    input [6:0] r2_opcode,
    input [2:0] r2_dest,
    input [31:0] r2_op1,
    input [31:0] r2_op2,
    input rst,
    input clk,
    input [`A_SIZE-1:0] pc
    
    // only for test
    //output reg [31:0] exresult_test
    );
    
    reg [31:0] offset;
    reg compare_result;
    
    //assign opcode = r2_opcode;
    
    always@(*) begin
        if (rst) begin
            //$display("r2_opcodeFromCasex: %b", r2_opcode);
            casex(r2_opcode)
                `NOP:           begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    //$display("execution: NOP");
                                end
                                
                `ADD:           begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = r2_op1 + r2_op2;
                                    //$display("executionADD: r2_op1 = %b, r2_op2 = %b", r2_op1, r2_op2);
                                end
                                
                `ADDF:          begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = r2_op1 + r2_op2; // not enough here
                                end 
                                   
                `SUB:           begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = r2_op1 - r2_op2;
                                end  
                                  
                `SUBF:          begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = r2_op1 - r2_op2; // not enough here
                                end  
                                  
                `AND:           begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    //result = r2_op1 & r2_op2;
                                    result = r2_op1 * r2_op2;   // this is not multiplication by its name but was modified temporarly due to simplicity
                                end
                                
                `OR:            begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = r2_op1 | r2_op2;
                                end   
                                 
                `XOR:           begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = r2_op1 ^ r2_op2;
                                end    
                                
                `NAND:          begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = ~(r2_op1 & r2_op2);
                                end    
                                
                `NOR:           begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = ~(r2_op1 | r2_op2);
                                end    
                                
                `NXOR:          begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = ~(r2_op1 ^ r2_op2);
                                end    
                                
                `SHIFTR:        begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = r2_op1 >> r2_op2;
                                end    
                                
                `SHIFTRA:       begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = r2_op1 >>> r2_op2;
                                end    
                                
                `SHIFTL:        begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    result = r2_op1 << r2_op2;
                                end    
                                
                `LOAD:          begin 
                                    pc_jmp = 0;
                                    rw = `READ; // read
                                    addr = r2_op1[9:0];
                                    //$display("executionLOAD addr = %b", r2_op1);
                                end
                                
                `LOADC:         begin
                                    pc_jmp = 0;
                                    rw = `DEFAULT;
                                    //addr = r2_dest; // asta trebe stearsa
                                    result = r2_op1;
                                    //$display("executionLOADC: r2_dest = %b, r2_op1 = %b", r2_dest, r2_op1);
                                end
                
                `STORE:         begin
                                    pc_jmp = 0;
                                    rw = `WRITE; // write
                                    addr = r2_op2[9:0];
                                    data_out = r2_op1;
                                    //$display("executionSTORE: r2_op2 = %b, r2_op1 = %b", r2_op2, r2_op1);
                                end
                                
                `JMP:           begin 
                                    rw = `DEFAULT;
                                    pc_jmp = r2_op1;
                                    //$display("executionJMP: r2_op1 = %b", r2_op1);
                                end
                                
                `JMPR:          begin
                                    rw <= `DEFAULT;
                                    pc_jmp = pc + r2_op1 - 2'b11;
                                    //$display("executionJMPR: r2_op1 = %b, pc = %b", r2_op1, pc);
                                end
                                
                `JMPcond:       begin
                                    rw <= `DEFAULT;
                                    //$display("executionJMPRcond");
                                    case(r2_op2)
                                        `N:     if (r2_dest <= 0) begin
                                                    pc_jmp = r2_op1;
                                                    //$display("JMPcond: N");
                                                end
                                                
                                        `NN:    if (r2_dest >= 0) begin
                                                    pc_jmp = r2_op1;
                                                    //$display("JMPcond: NN");
                                                end
                                        
                                        `Z:     if (r2_dest == 0) begin
                                                    pc_jmp = r2_op1;
                                                    //$display("JMPcond: Z");
                                                end
                                        
                                        `NZ:    if (r2_dest != 0) begin
                                                    pc_jmp = r2_op1;
                                                    //$display("JMPcond: NZ");
                                                end
                                    endcase    
                                end
                                
                `JMPRcond:      begin
                                    rw <= `DEFAULT;
                                    //$display("executionJMPRcond");
                                    case(r2_dest)
                                        `N:     if (r2_op2 < 0) begin
                                                    pc_jmp = pc + r2_op1;
                                                    //$display("JMPRcond: N");
                                                end
                                                
                                        `NN:    if (r2_op2 >= 0) begin
                                                    pc_jmp = pc + r2_op1;
                                                    //$display("JMPRcond: NN, r2_op1 = %b", r2_op1);
                                                end
                                        
                                        `Z:     if (r2_op2 == 0) begin
                                                    pc_jmp = pc + r2_op1;
                                                    //$display("JMPRcond: Z");
                                                end
                                        
                                        `NZ:    if (r2_op2 != 0) begin
                                                    pc_jmp = pc + r2_op1;
                                                    //$display("JMPRcond: NZ");
                                                end
                                    endcase 
                                    
                                end
                                
                `HALT:          ;         
                
            endcase
        end
    end
    
endmodule
