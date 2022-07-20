`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2021 10:05:34 PM
// Design Name: 
// Module Name: read
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


module read(
    output reg [6:0] r1_opcode, // variabila care determina dimensiunea in functie de lungimea instructiunii
    output reg [2:0] r1_dest,
    output reg [31:0] r1_op1,
    output reg [31:0] r1_op2,
    input [15:0] r1,
        
    // inputs from write_back block
    input [31:0] result,
    input [2:0] dest,
    input en,
    
    input rst,
    input clk,
    input [`A_SIZE-1:0] pc
    
    // test
    //output [15:0] r1_test
    );
    
    integer i;
    reg [31:0] regFile[0:`R_SIZE-1];
    reg [6:0] rd_opcode;
    reg [2:0] rd_dest;
    reg [2:0] rd_op1;
    reg [2:0] rd_op2;
    reg enable;
    
    
    always@(*) begin
        if(rst == 1) begin
            //$display("read: r1[15:0] = %b", r1);
            casex(r1[15:9])
                `NOP:           begin
                                    r1_opcode = r1[15:9];      
                                end
                                
                `ADD:           begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = regFile[r1[5:3]];
                                    r1_op2 = regFile[r1[2:0]];
                                    enable = 1;
                                    //$display("readADD: r1[15:9] = %b, r1[8:6] = %b, r1[5:3] = %b, r1[2:0] = %b", r1[15:9], r1[8:6], r1[5:3], r1[2:0]);                                    
                                end
                                
                `ADDF:          begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = regFile[r1[5:3]];
                                    r1_op2 = regFile[r1[2:0]];
                                    //$display("read: ADDF");
                                end 
                                   
                `SUB:           begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = regFile[r1[5:3]];
                                    r1_op2 = regFile[r1[2:0]];
                                    //$display("read: SUB");
                                end  
                                  
                `SUBF:          begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = regFile[r1[5:3]];
                                    r1_op2 = regFile[r1[2:0]];
                                    //$display("read: SUBF");
                                end  
                                  
                `AND:           begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = regFile[r1[5:3]];
                                    r1_op2 = regFile[r1[2:0]];
                                    $display("read: AND");
                                end
                                
                `OR:            begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = regFile[r1[5:3]];
                                    r1_op2 = regFile[r1[2:0]];
                                    //$display("read: OR");
                                end   
                                 
                `XOR:           begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = regFile[r1[5:3]];
                                    r1_op2 = regFile[r1[2:0]];
                                    //$display("read: XOR");
                                end    
                                
                `NAND:          begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = regFile[r1[5:3]];
                                    r1_op2 = regFile[r1[2:0]];
                                    //$display("read: NAND");
                                end    
                                
                `NOR:           begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = regFile[r1[5:3]];
                                    r1_op2 = regFile[r1[2:0]];
                                    //$display("read: NOR");
                                end    
                                
                `NXOR:          begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = regFile[r1[5:3]];
                                    r1_op2 = regFile[r1[2:0]];
                                    //$display("read: NXOR");
                                end    
                               
                `SHIFTR:        begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = r1[5:0];
                                    r1_op2 = 0;
                                    //$display("read: SHIFTR");
                                end    
                                
                `SHIFTRA:       begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = r1[5:0];
                                    r1_op2 = 0;
                                    //$display("read: SHIFTRA");
                                end    
                                
                `SHIFTL:        begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = r1[5:0];
                                    r1_op2 = 0;
                                    //$display("read: SHIFTL");
                                end    
                                
                `LOAD:          begin 
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[10:8];
                                    r1_op1 = regFile[r1[2:0]];
                                    r1_op2 = 0;
                                    //$display("read: LOAD: r1[15:9] = %b, r1[10:8] = %b, r1[2:0] = %b", r1[15:9], r1[10:8], r1[2:0]);
                                end
                                
                `LOADC:         begin
                                    //r1_opcode <= {r1[15:11], 2'bxx};
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[10:8];
                                    r1_op1 = r1[7:0];
                                    r1_op2 = 0;
                                    //$display("readLOADC: r1[15:9] = %b, r1[10:8] = %b, r1[7:0] = %b", r1[15:9], r1[10:8], r1[7:0]);
                                end
                
                `STORE:         begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[10:8];                                  
                                    r1_op1 = regFile[r1[2:0]];
                                    r1_op2 = regFile[r1[10:8]];
                                    enable = 1;
                                    //$display("readSTORE: r1[15:9] = %b, r1[10:8] = %b, r1[2:0] = %b", r1[15:9], r1[10:8], r1[2:0]);
                                end
                                
                `JMP:           begin 
                                    r1_opcode = r1[15:9];
                                    r1_op1 = regFile[r1[2:0]];
                                    r1_op2 = 0;
                                    //$display("readJMP: r1[15:9] = %b, r1[2:0] = %b", r1[15:9], r1[2:0]);
                                end
                                
                `JMPR:          begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = 0;
                                    r1_op1 = r1[5:0];
                                    r1_op2 = 0;
                                    rd_op1 = 0;
                                    rd_op2 = 0;
                                    //$display("readJMPR: r1[15:9] = %b, r1[5:0] = %b", r1[15:9], r1[5:0]);
                                end
                                
                `JMPcond:       begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[8:6];
                                    r1_op1 = r1[2:0];
                                    r1_op2 = r1[11:9];
                                    //$display("read: JMPcond");
                                end
                                
                `JMPRcond:      begin
                                    r1_opcode = r1[15:9];
                                    r1_dest = r1[11:9];
                                    r1_op1 = r1[5:0];
                                    r1_op2 = r1[8:6];
                                    //$display("readJMPRcond: r1[15:12] = %b, r1[11:9] = %b, r1[8:6] = %b, r1[5:0] = %b", r1[15:12], r1[11:9], r1[8:6], r1[5:0]);
                                end
                                
                `HALT:          begin
                                    r1_opcode = r1[15:9];
                                    //$display("read: HALT");
                                end    
            endcase
        end
    end    
    
                       
    // Internal registers                                    
    always@(posedge clk) begin
    //$display("read: rd_opcode = %b", rd_opcode);
        if (rst == 0) begin
            for (i = 0; i < `R_SIZE-1; i = i + 1) begin
                regFile[i] <= 0;
            end
        end
        else if ((rst == 1) && (en == 1)) begin
            regFile[dest] <= result;
            //$display("regs: result = %b, regFile[dest] = %b, regFile[`R2] = %b, regFile[`R3] = %b", result, regFile[dest], regFile[`R2], regFile[`R3]);
            //$display("regs: regFile[dest] = %b", regFile[dest]);
//            $display("regFile[`R0] = %d", regFile[`R0]);
//            $display("regFile[`R1] = %d", regFile[`R1]);
//            $display("regFile[`R2] = %d", regFile[`R2]);
//            $display("regFile[`R3] = %d", regFile[`R3]);
//            $display("regFile[`R4] = %d", regFile[`R4]);
//            $display("regFile[`R5] = %d", regFile[`R5]);
//            $display("regFile[`R6] = %d", regFile[`R6]);
//            $display("regFile[`R7] = %d", regFile[`R7]);
            
        end
    end
     
endmodule
