`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2022 11:26:16 PM
// Design Name: 
// Module Name: dd_control
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
// This module adress the data dependency
`include "include_defines.vh"

module dd_control(
    output reg enMuxEx_1, // enable mux execute 1 = ON, 0 = OFF
    output reg enMuxEx_2,
    output reg enMuxR3_1, // enable mux register3
    output reg enMuxR3_2,
    input [2:0] r2_dest,
    input [2:0] r3_dest,
    
    input [15:0] r1,

    input clk,
    input rst
    );
    
    
    always@(*) begin
        if(rst == 1) begin
            //$display("read: r1[15:0] = %b", r1);
            casex(r1[15:9])
                `NOP:           begin
                                    enMuxEx_1 <= 0;
                                    enMuxEx_2 <= 0;
                                    enMuxR3_1 <= 0;
                                    enMuxR3_2 <= 0;
                                end
                                
                `ADD:           begin
                                    enMuxEx_1 = 0;
                                    enMuxEx_2 = 0;
                                    enMuxR3_1 = 0;
                                    enMuxR3_2 = 0;
                                    if ((r2_dest == r1[5:3]) || (r2_dest == r1[2:0]) || (r3_dest == r1[5:3]) || (r3_dest == r1[2:0])) begin
                                        if (r2_dest == r1[5:3]) begin
                                            // enable multiplexor
                                            enMuxEx_1 = 1;
                                            //$display("DD: enMuxEx_1 <= 1");
                                        end
                                        if (r2_dest == r1[2:0]) begin
                                            enMuxEx_2 = 1;
                                            //$display("DD: enMuxEx_2 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[5:3]) begin
                                            enMuxR3_1 = 1;
                                            //$display("DD: enMuxR3_1 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[2:0]) begin
                                            enMuxR3_2 = 1;
                                            //$display("DD: enMuxR3_2 <= 1");
                                        end
                                    end 
                                    else begin
                                        enMuxEx_1 = 0;
                                        enMuxEx_2 = 0;
                                        enMuxR3_1 = 0;
                                        enMuxR3_2 = 0;
                                        //$display("DD: enMux <= 0");
                                    end        
                                end
                                
                `ADDF:          begin
                                    if ((r2_dest == r1[5:3]) || (r2_dest == r1[2:0]) || (r3_dest == r1[5:3]) || (r3_dest == r1[2:0])) begin
                                        if (r2_dest == r1[5:3]) begin
                                            // enable multiplexor
                                            enMuxEx_1 <= 1;
                                            //$display("DD: enMuxEx_1 <= 1");
                                        end
                                        if (r2_dest == r1[2:0]) begin
                                            enMuxEx_2 <= 1;
                                            //$display("DD: enMuxEx_2 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[5:3]) begin
                                            enMuxR3_1 <= 1;
                                            //$display("DD: enMuxR3_1 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[2:0]) begin
                                            enMuxR3_2 <= 1;
                                            //$display("DD: enMuxR3_2 <= 1");
                                        end
                                    end 
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                        //$display("DD: enMux <= 0");
                                    end 
                                end 
                                   
                `SUB:           begin
                                    if ((r2_dest == r1[5:3]) || (r2_dest == r1[2:0]) || (r3_dest == r1[5:3]) || (r3_dest == r1[2:0])) begin
                                        if (r2_dest == r1[5:3]) begin
                                            // enable multiplexor
                                            enMuxEx_1 <= 1;
                                            //$display("DD: enMuxEx_1 <= 1");
                                        end
                                        if (r2_dest == r1[2:0]) begin
                                            enMuxEx_2 <= 1;
                                            //$display("DD: enMuxEx_2 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[5:3]) begin
                                            enMuxR3_1 <= 1;
                                            //$display("DD: enMuxR3_1 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[2:0]) begin
                                            enMuxR3_2 <= 1;
                                            //$display("DD: enMuxR3_2 <= 1");
                                        end
                                    end 
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                        //$display("DD: enMux <= 0");
                                    end 
                                end  
                                  
                `SUBF:          begin
                                    if ((r2_dest == r1[5:3]) || (r2_dest == r1[2:0]) || (r3_dest == r1[5:3]) || (r3_dest == r1[2:0])) begin
                                        if (r2_dest == r1[5:3]) begin
                                            // enable multiplexor
                                            enMuxEx_1 <= 1;
                                            //$display("DD: enMuxEx_1 <= 1");
                                        end
                                        if (r2_dest == r1[2:0]) begin
                                            enMuxEx_2 <= 1;
                                            //$display("DD: enMuxEx_2 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[5:3]) begin
                                            enMuxR3_1 <= 1;
                                            //$display("DD: enMuxR3_1 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[2:0]) begin
                                            enMuxR3_2 <= 1;
                                            //$display("DD: enMuxR3_2 <= 1");
                                        end
                                    end 
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                        //$display("DD: enMux <= 0");
                                    end 
                                end  
                                  
                `AND:           begin
                                    if ((r2_dest == r1[5:3]) || (r2_dest == r1[2:0]) || (r3_dest == r1[5:3]) || (r3_dest == r1[2:0])) begin
                                        if (r2_dest == r1[5:3]) begin
                                            // enable multiplexor
                                            enMuxEx_1 <= 1;
                                            //$display("DD: enMuxEx_1 <= 1");
                                        end
                                        if (r2_dest == r1[2:0]) begin
                                            enMuxEx_2 <= 1;
                                            //$display("DD: enMuxEx_2 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[5:3]) begin
                                            enMuxR3_1 <= 1;
                                            //$display("DD: enMuxR3_1 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[2:0]) begin
                                            enMuxR3_2 <= 1;
                                            //$display("DD: enMuxR3_2 <= 1");
                                        end
                                    end 
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                        //$display("DD: enMux <= 0");
                                    end 
                                end
                                
                `OR:            begin
                                    if ((r2_dest == r1[5:3]) || (r2_dest == r1[2:0]) || (r3_dest == r1[5:3]) || (r3_dest == r1[2:0])) begin
                                        if (r2_dest == r1[5:3]) begin
                                            // enable multiplexor
                                            enMuxEx_1 <= 1;
                                            //$display("DD: enMuxEx_1 <= 1");
                                        end
                                        if (r2_dest == r1[2:0]) begin
                                            enMuxEx_2 <= 1;
                                            //$display("DD: enMuxEx_2 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[5:3]) begin
                                            enMuxR3_1 <= 1;
                                            //$display("DD: enMuxR3_1 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[2:0]) begin
                                            enMuxR3_2 <= 1;
                                            //$display("DD: enMuxR3_2 <= 1");
                                        end
                                    end 
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                        //$display("DD: enMux <= 0");
                                    end 
                                end   
                                 
                `XOR:           begin
                                    if ((r2_dest == r1[5:3]) || (r2_dest == r1[2:0]) || (r3_dest == r1[5:3]) || (r3_dest == r1[2:0])) begin
                                        if (r2_dest == r1[5:3]) begin
                                            // enable multiplexor
                                            enMuxEx_1 <= 1;
                                            //$display("DD: enMuxEx_1 <= 1");
                                        end
                                        if (r2_dest == r1[2:0]) begin
                                            enMuxEx_2 <= 1;
                                            //$display("DD: enMuxEx_2 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[5:3]) begin
                                            enMuxR3_1 <= 1;
                                            //$display("DD: enMuxR3_1 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[2:0]) begin
                                            enMuxR3_2 <= 1;
                                            //$display("DD: enMuxR3_2 <= 1");
                                        end
                                    end 
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                        //$display("DD: enMux <= 0");
                                    end 
                                end    
                                    
                `NAND:          begin
                                    if ((r2_dest == r1[5:3]) || (r2_dest == r1[2:0]) || (r3_dest == r1[5:3]) || (r3_dest == r1[2:0])) begin
                                        if (r2_dest == r1[5:3]) begin
                                            // enable multiplexor
                                            enMuxEx_1 <= 1;
                                            //$display("DD: enMuxEx_1 <= 1");
                                        end
                                        if (r2_dest == r1[2:0]) begin
                                            enMuxEx_2 <= 1;
                                            //$display("DD: enMuxEx_2 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[5:3]) begin
                                            enMuxR3_1 <= 1;
                                            //$display("DD: enMuxR3_1 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[2:0]) begin
                                            enMuxR3_2 <= 1;
                                            //$display("DD: enMuxR3_2 <= 1");
                                        end
                                    end 
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                        //$display("DD: enMux <= 0");
                                    end 
                                end    
                                
                `NOR:           begin
                                    if ((r2_dest == r1[5:3]) || (r2_dest == r1[2:0]) || (r3_dest == r1[5:3]) || (r3_dest == r1[2:0])) begin
                                        if (r2_dest == r1[5:3]) begin
                                            // enable multiplexor
                                            enMuxEx_1 <= 1;
                                            //$display("DD: enMuxEx_1 <= 1");
                                        end
                                        if (r2_dest == r1[2:0]) begin
                                            enMuxEx_2 <= 1;
                                            //$display("DD: enMuxEx_2 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[5:3]) begin
                                            enMuxR3_1 <= 1;
                                            //$display("DD: enMuxR3_1 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[2:0]) begin
                                            enMuxR3_2 <= 1;
                                            //$display("DD: enMuxR3_2 <= 1");
                                        end
                                    end 
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                        //$display("DD: enMux <= 0");
                                    end 
                                end    
                                
                `NXOR:          begin
                                    if ((r2_dest == r1[5:3]) || (r2_dest == r1[2:0]) || (r3_dest == r1[5:3]) || (r3_dest == r1[2:0])) begin
                                        if (r2_dest == r1[5:3]) begin
                                            // enable multiplexor
                                            enMuxEx_1 <= 1;
                                            //$display("DD: enMuxEx_1 <= 1");
                                        end
                                        if (r2_dest == r1[2:0]) begin
                                            enMuxEx_2 <= 1;
                                            //$display("DD: enMuxEx_2 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[5:3]) begin
                                            enMuxR3_1 <= 1;
                                            //$display("DD: enMuxR3_1 <= 1");
                                            //$display("enMuxR3_1 <= 1, r3_dest = %b, r1[5:3] = %b", r3_dest, r1[5:3]);
                                        end
                                        if (r3_dest == r1[2:0]) begin
                                            enMuxR3_2 <= 1;
                                            //$display("DD: enMuxR3_2 <= 1");
                                        end
                                    end 
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                        //$display("DD: enMux <= 0");
                                    end 
                                end    
                                
                `SHIFTR:        begin
                                    // nothing

                                end    
                                
                `SHIFTRA:       begin
                                    // nothing

                                end    
                                
                `SHIFTL:        begin
                                    // nothing

                                end    
                                
                `LOAD:          begin 
                                    if (r2_dest == r1[2:0]) begin
                                    
                                    end
                                    else if (r3_dest == r1[2:0]) begin
                                    
                                    end
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                    end
                                end
                                
                `LOADC:         begin
                                    // nothing
                                    enMuxEx_1 <= 0;
                                    enMuxEx_2 <= 0;
                                    enMuxR3_1 <= 0;
                                    enMuxR3_2 <= 0;
                                    //$display("LOADC 5 enMuxEx_1 = %b, enMuxEx_2 = %b, enMuxR3_1 = %b, enMuxR3_2 = %b", enMuxEx_1, enMuxEx_2, enMuxR3_1, enMuxR3_2);
                                end
                
                `STORE:         begin
                                    if (r2_dest == r1[2:0]) begin
                                        enMuxEx_2 <= 0;
                                        enMuxEx_1 <= 1;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                    end
                                    else if (r3_dest == r1[2:0]) begin
                                        enMuxR3_2 <= 0;
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 1;
                                    end
                                    else begin
                                        enMuxEx_1 <= 0;
                                        enMuxEx_2 <= 0;
                                        enMuxR3_1 <= 0;
                                        enMuxR3_2 <= 0;
                                    end
                                end
                                
                `JMP:           begin 
                                    // nothing
                                end
                                
                `JMPR:          begin
                                    // nothing
                                end
                                
                `JMPcond:       begin
                                    // to be done
                                end
                                
                `JMPRcond:      begin
                                    if ((r2_dest == r1[8:6])) begin
                                        enMuxEx_2 <= 1;
                                    end
                                    else if ((r3_dest == r1[8:6])) begin
                                        enMuxR3_2 <= 1;
                                    end   
                                end
                                
                `HALT:          begin
                                    enMuxEx_1 <= 0;
                                    enMuxEx_2 <= 0;
                                    enMuxR3_1 <= 0;
                                    enMuxR3_2 <= 0;
                                end    
            endcase
        end
    end
    
endmodule
