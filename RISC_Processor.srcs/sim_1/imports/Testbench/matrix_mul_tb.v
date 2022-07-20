`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2022 09:58:06 AM
// Design Name: 
// Module Name: matrix_mul_tb
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
`define A_SIZE      10
`define D_SIZE      32
//`define DM_DEPTH 128
//`define DM_DEPTH 1000
`define PM_DEPTH    512
`define RESERVED    5'b00000

module matrix_mul_tb();

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
        for (index = 0; index < `PM_DEPTH; index = index + 1) begin
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

        // Matrix multiplication
        // Compute first element
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // =================================================================================
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        program_memory[1] = {`LOADC, `R1, 8'd4};    // address
        program_memory[2] = {`LOADC, `R2, 8'd40};    // address
        program_memory[5] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[7] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[9] = {`AND, `R5, `R3, `R4};
        
        program_memory[10] = {`LOADC, `R1, 8'd8};    // address
        program_memory[11] = {`LOADC, `R2, 8'd52};    // address
        program_memory[14] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[16] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[18] = {`AND, `R6, `R3, `R4};
        
        program_memory[19] = {`LOADC, `R1, 8'd12};    // address
        program_memory[20] = {`LOADC, `R2, 8'd64};    // address
        program_memory[23] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[25] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[27] = {`AND, `R7, `R3, `R4};

        program_memory[28] = {`ADD, `R5, `R5, `R6};
        program_memory[29] = {`ADD, `R5, `R5, `R7};
        
        program_memory[30] = {`LOADC, `R1, 8'd4};    // address
        program_memory[33] = {`STORE, `R1, 5'b00000, `R7}; 
        
        
        // Compute second element
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // =================================================================================
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        program_memory[35] = {`LOADC, `R1, 8'd4};    // address
        program_memory[36] = {`LOADC, `R2, 8'd44};    // address
        program_memory[39] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[41] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[43] = {`AND, `R5, `R3, `R4};
        
        program_memory[44] = {`LOADC, `R1, 8'd8};    // address
        program_memory[45] = {`LOADC, `R2, 8'd56};    // address
        program_memory[48] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[50] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[52] = {`AND, `R6, `R3, `R4};
        
        program_memory[53] = {`LOADC, `R1, 8'd12};    // address
        program_memory[54] = {`LOADC, `R2, 8'd68};    // address
        program_memory[57] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[59] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[61] = {`AND, `R7, `R3, `R4};

        program_memory[62] = {`ADD, `R5, `R5, `R6};
        program_memory[63] = {`ADD, `R5, `R5, `R7};
        
        program_memory[64] = {`LOADC, `R1, 8'd4};    // address
        program_memory[67] = {`STORE, `R1, `RESERVED, `R7}; 
        
        // Compute third element
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // =================================================================================
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        program_memory[69] = {`LOADC, `R1, 8'd4};    // address
        program_memory[70] = {`LOADC, `R2, 8'd48};    // address
        program_memory[73] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[75] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[77] = {`AND, `R5, `R3, `R4};
        
        program_memory[78] = {`LOADC, `R1, 8'd8};    // address
        program_memory[79] = {`LOADC, `R2, 8'd60};    // address
        program_memory[82] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[84] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[86] = {`AND, `R6, `R3, `R4};
        
        program_memory[87] = {`LOADC, `R1, 8'd12};    // address
        program_memory[88] = {`LOADC, `R2, 8'd72};    // address
        program_memory[91] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[93] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[95] = {`AND, `R7, `R3, `R4};

        program_memory[96] = {`ADD, `R5, `R5, `R6};
        program_memory[97] = {`ADD, `R5, `R5, `R7};
        
        program_memory[98] = {`LOADC, `R1, 8'd4};    // address
        program_memory[101] = {`STORE, `R1, `RESERVED, `R7}; 
        
        // Compute 4th element
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // =================================================================================
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        program_memory[103] = {`LOADC, `R1, 8'd16};    // address
        program_memory[104] = {`LOADC, `R2, 8'd40};    // address
        program_memory[107] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[109] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[111] = {`AND, `R5, `R3, `R4};
        
        program_memory[112] = {`LOADC, `R1, 8'd20};    // address
        program_memory[113] = {`LOADC, `R2, 8'd52};    // address
        program_memory[116] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[118] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[120] = {`AND, `R6, `R3, `R4};
        
        program_memory[121] = {`LOADC, `R1, 8'd24};    // address
        program_memory[122] = {`LOADC, `R2, 8'd64};    // address
        program_memory[125] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[127] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[129] = {`AND, `R7, `R3, `R4};

        program_memory[130] = {`ADD, `R5, `R5, `R6};
        program_memory[131] = {`ADD, `R5, `R5, `R7};
        
        program_memory[132] = {`LOADC, `R1, 8'd4};    // address
        program_memory[135] = {`STORE, `R1, `RESERVED, `R7}; 
        
        // Compute 5th element
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // =================================================================================
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        program_memory[137] = {`LOADC, `R1, 8'd16};    // address
        program_memory[138] = {`LOADC, `R2, 8'd44};    // address
        program_memory[141] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[143] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[145] = {`AND, `R5, `R3, `R4};
        
        program_memory[146] = {`LOADC, `R1, 8'd20};    // address
        program_memory[147] = {`LOADC, `R2, 8'd56};    // address
        program_memory[150] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[152] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[154] = {`AND, `R6, `R3, `R4};
        
        program_memory[155] = {`LOADC, `R1, 8'd24};    // address
        program_memory[156] = {`LOADC, `R2, 8'd68};    // address
        program_memory[159] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[161] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[163] = {`AND, `R7, `R3, `R4};

        program_memory[164] = {`ADD, `R5, `R5, `R6};
        program_memory[165] = {`ADD, `R5, `R5, `R7};
        
        program_memory[166] = {`LOADC, `R1, 8'd4};    // address
        program_memory[169] = {`STORE, `R1, `RESERVED, `R7}; 
        
        // Compute 6th element
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // =================================================================================
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        program_memory[171] = {`LOADC, `R1, 8'd16};    // address
        program_memory[172] = {`LOADC, `R2, 8'd48};    // address
        program_memory[175] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[177] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[179] = {`AND, `R5, `R3, `R4};
        
        program_memory[180] = {`LOADC, `R1, 8'd20};    // address
        program_memory[181] = {`LOADC, `R2, 8'd60};    // address
        program_memory[184] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[186] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[188] = {`AND, `R6, `R3, `R4};
        
        program_memory[189] = {`LOADC, `R1, 8'd24};    // address
        program_memory[190] = {`LOADC, `R2, 8'd72};    // address
        program_memory[193] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[195] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[197] = {`AND, `R7, `R3, `R4};

        program_memory[198] = {`ADD, `R5, `R5, `R6};
        program_memory[199] = {`ADD, `R5, `R5, `R7};
        
        program_memory[200] = {`LOADC, `R1, 8'd4};    // address
        program_memory[203] = {`STORE, `R1, `RESERVED, `R7}; 
        
        // Compute 7th element
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // =================================================================================
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        program_memory[205] = {`LOADC, `R1, 8'd28};    // address
        program_memory[206] = {`LOADC, `R2, 8'd40};    // address
        program_memory[209] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[211] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[213] = {`AND, `R5, `R3, `R4};
        
        program_memory[214] = {`LOADC, `R1, 8'd32};    // address
        program_memory[215] = {`LOADC, `R2, 8'd52};    // address
        program_memory[218] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[220] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[222] = {`AND, `R6, `R3, `R4};
        
        program_memory[223] = {`LOADC, `R1, 8'd36};    // address
        program_memory[224] = {`LOADC, `R2, 8'd64};    // address
        program_memory[227] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[229] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[231] = {`AND, `R7, `R3, `R4};

        program_memory[232] = {`ADD, `R5, `R5, `R6};
        program_memory[233] = {`ADD, `R5, `R5, `R7};
        
        program_memory[234] = {`LOADC, `R1, 8'd4};    // address
        program_memory[237] = {`STORE, `R1, `RESERVED, `R7}; 
        
        // Compute 8th element
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // =================================================================================
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        program_memory[239] = {`LOADC, `R1, 8'd28};    // address
        program_memory[240] = {`LOADC, `R2, 8'd44};    // address
        program_memory[243] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[245] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[247] = {`AND, `R5, `R3, `R4};
        
        program_memory[248] = {`LOADC, `R1, 8'd32};    // address
        program_memory[249] = {`LOADC, `R2, 8'd56};    // address
        program_memory[252] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[254] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[256] = {`AND, `R6, `R3, `R4};
        
        program_memory[257] = {`LOADC, `R1, 8'd36};    // address
        program_memory[258] = {`LOADC, `R2, 8'd68};    // address
        program_memory[261] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[263] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[265] = {`AND, `R7, `R3, `R4};

        program_memory[266] = {`ADD, `R5, `R5, `R6};
        program_memory[267] = {`ADD, `R5, `R5, `R7};
        
        program_memory[268] = {`LOADC, `R1, 8'd4};    // address
        program_memory[271] = {`STORE, `R1, `RESERVED, `R7}; 
        
        // Compute 9th element
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // =================================================================================
        // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        program_memory[273] = {`LOADC, `R1, 8'd28};    // address
        program_memory[274] = {`LOADC, `R2, 8'd48};    // address
        program_memory[277] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[279] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[281] = {`AND, `R5, `R3, `R4};
        
        program_memory[282] = {`LOADC, `R1, 8'd32};    // address
        program_memory[283] = {`LOADC, `R2, 8'd60};    // address
        program_memory[286] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[288] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[290] = {`AND, `R6, `R3, `R4};
        
        program_memory[291] = {`LOADC, `R1, 8'd36};    // address
        program_memory[292] = {`LOADC, `R2, 8'd72};    // address
        program_memory[295] = {`LOAD, `R3, `RESERVED,`R1};
        program_memory[297] = {`LOAD, `R4, `RESERVED,`R2};
        program_memory[299] = {`AND, `R7, `R3, `R4};

        program_memory[300] = {`ADD, `R5, `R5, `R6};
        program_memory[301] = {`ADD, `R5, `R5, `R7};
        
        program_memory[302] = {`LOADC, `R1, 8'd4};    // address
        program_memory[305] = {`STORE, `R1, `RESERVED, `R7}; 
        
        #1350
        $stop();
    end

    always@(*) begin
        instruction_t <= program_memory[instr_address_tb];
    end
    

    
//    risc_processor risc_processor_dut(
//        .instr_address(instr_address_tb),
//        .addr(data_addr_t),
//        .data_out(receive_data_out_t),
//        .m_data_in(send_data_in_t),
//        //.rw(rw_t),
        
//        .clk(clk_t),
//        .rst(rst_t),
//        .instruction(instruction_t)
        
//    );
endmodule
