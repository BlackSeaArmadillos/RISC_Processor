`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2021 12:26:11 PM
// Design Name: 
// Module Name: risc_processor_tb
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
`include "include_defines2.vh"


// define sizes
`define A_SIZE 10
`define D_SIZE 32
//`define DM_DEPTH 128
//`define DM_DEPTH 1000
`define PM_DEPTH 64
`define RESERVED    5'b00000

module risc_processor_tb();

    reg [15:0] instruction_t;
    wire [`A_SIZE-1:0] instr_address_tb;
    reg rst_t;
    reg clk_t;
    
    reg [31:0] send_data_in_t;
    wire [31:0] receive_data_out_t;
    wire [9:0] data_addr_t;
    wire [1:0] rw_t;  
    
    reg [15:0] program_memory[0:`PM_DEPTH-1];

    integer index = 0;
    
    initial begin
        clk_t = 0;
        forever #2 clk_t = ~clk_t;
    end

    initial begin
        for (index = 0; index <= 31; index = index + 1) begin
            program_memory[index] = 0;
        end
    end
    
    
    initial begin
        rst_t <= 1;
        #1;
        rst_t <= 0; // this means reset the processor
        #50;
        rst_t <= 1;
        #1;

        // Test 1: Load from RAM into empty cache = SUCCESS
//        program_memory[0] = `NOP;
//        program_memory[1] = {`LOADC, `R1, 8'd8};
//        program_memory[4] = {`LOAD, `R4, `RESERVED,`R1};

// ========================================================================================================================
// ========================================================================================================================

        // Test 2: Load from RAM into empty cache and overwrite the cache = SUCCESS
//        program_memory[0] = `NOP;
//        program_memory[1] = {`LOADC, `R1, 8'd8};
//        program_memory[4] = {`LOAD, `R4, `RESERVED,`R1};
//        program_memory[5] = {`LOADC, `R3, 8'd3};
        
//        program_memory[7] = {`STORE, `R1, `RESERVED, `R3};
//        program_memory[8] = `NOP;
//        program_memory[9] = `NOP;

// ========================================================================================================================
// ========================================================================================================================

/*
        // Test 3: write twice to the same cache block = SUCCESS
        program_memory[0] = `NOP;
        program_memory[1] = {`LOADC, `R1, 8'd16};              // Load 4 in register R1
        program_memory[2] = {`LOADC, `R2, 8'd8};              // Load 8 in register R2
        program_memory[3] = {`STORE, `R1, `RESERVED, `R2};       // Store the value in R2 (i.e. 8) in the address from R1 (i.e. 4)
        program_memory[4] = `NOP;
        program_memory[5] = `NOP;
        program_memory[6] = {`LOADC, `R3, 8'd5};              // Load 5 in register R3
        program_memory[7] = {`STORE, `R1, `RESERVED, `R3};       // Store the value in R3 (i.e. 5) in the address from R1 (i.e. 4)
        program_memory[8] = `NOP;
        program_memory[9] = `NOP;
        program_memory[10] = {`LOAD, `R4, `RESERVED,`R1};         // Load from memory using the address in R1 (i.e. 2) in R4
        program_memory[11] = `NOP;
        program_memory[12] = {`STORE, `R3, `RESERVED, `R4};       // Store value in R4 at the adrees in R3
        program_memory[13] = `NOP;
*/       

// ========================================================================================================================
// ========================================================================================================================

        // Test 4: PENDING 
/*        
        program_memory[0] = `NOP;
        program_memory[1] = {`LOADC, `R1, 8'd4};    // address
        program_memory[2] = {`LOADC, `R2, 8'd8};    // address
        
        program_memory[4] = {`LOADC, `R3, 8'd2};    // values
        program_memory[5] = {`LOADC, `R4, 8'd5};    // values
        
        program_memory[7] = {`ADD, `R7, `R3, `R4};
        program_memory[8] = `NOP;
        program_memory[9] = `NOP;
        
        program_memory[10] = {`STORE, `R2, `RESERVED, `R7};       // Store the value in R6 in the address from R2
        program_memory[11] = `NOP;
        program_memory[12] = `NOP;
        
        program_memory[13] = {`LOAD, `R5, `RESERVED,`R2};
        program_memory[14] = `NOP;
        program_memory[15] = `NOP;
        
        program_memory[16] = {`ADD, `R7, `R3, `R5};
        program_memory[17] = `NOP;
        program_memory[18] = `NOP;
        
        program_memory[19] = {`STORE, `R2, `RESERVED, `R7};
        program_memory[20] = `NOP;
    */
    
    

        
        #100
        $stop();
    end

    always@(*) begin
        instruction_t <= program_memory[instr_address_tb];
    end
    
    

    risc_processor risc_processor_dut(
        .instr_address(instr_address_tb),
        .addr(data_addr_t),
        .data_out(receive_data_out_t),
        .m_data_in(send_data_in_t),
        //.rw(rw_t),
        
        .clk(clk_t),
        .rst(rst_t),
        .instruction(instruction_t)
        
    );

endmodule





