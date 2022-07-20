`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2021 12:25:48 PM
// Design Name: 
// Module Name: risc_processor
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



// ============================================================================================================================
// RISC processor (top module)
// ============================================================================================================================
module risc_processor (
    output [`A_SIZE-1:0] instr_address,
    output [`D_SIZE-1:0] data_out,
    output [`A_SIZE-1:0] addr,
    output [1:0] rw,
    input [31:0] m_data_in,
    input rst,
    input clk,
    input halt,
    input [15:0] instruction
   /* 
    // optional, only for testing
    output [31:0] result_test,
    output [31:0] exresult_test,
    output [15:0] r1_test,
    output [15:0] r1_instruction_test
    */
);
    
    // register1 => read
    wire [`A_SIZE-1:0] sub_pc;  
    wire [15:0] sub_r1; 
    
    // read => register 2
    wire [6:0] sub_r1_opcode;
    wire [2:0] sub_r1_dest;
    wire [31:0] sub_r1_op1;
    wire [31:0] sub_r1_op2;
    
    // register 2 => execute
    wire [6:0] sub_r2_opcode;
    wire [2:0] sub_r2_dest;
    wire [31:0] sub_r2_op1;
    wire [31:0] sub_r2_op2;
    
    // execute => register 3
    wire [31:0] sub_e_result;
    
    
    // execute => pc
    wire [7:0] sub_opcode;
    
    // execute => program_counter
    wire [`A_SIZE-1:0] sub_pc_jmp;
    
    // register 3 => write_back
    wire [6:0] sub_r3_opcode;
    wire [2:0] sub_r3_dest;
    wire [31:0] sub_r3_result;
    
    // write back => read (internal register)
    wire [31:0] sub_wresult;
    wire [2:0] sub_wdest;
    wire sub_wen; 
    
    // data memory => write back
    wire [31:0] sub_data_in;
    
    // data dependency
    wire sub_enMuxEx_1;
    wire sub_enMuxEx_2;
    wire sub_enMuxR3_1;
    wire sub_enMuxR3_2;
    
    // dist_ram
    wire [31:0] sub_data_in;    
    wire [31:0] sub_data_out;
    wire [`A_SIZE-1:0] sub_addr;   
    wire [1:0] sub_rw;
    
    
    
    
    
    
     // ==========================================================================================
    // ==========================================================================================
    // Cache controller and Cache memory
    // CPU interaction
    wire [`D_SIZE-1:0] sub_dataOutToCPU;
    wire [`D_SIZE-1:0] sub_dataInFromCPU;
    wire [`A_SIZE-1:0] sub_addressFromCPU;
    
    // Cache interaction
    wire [`D_SIZE-1:0] sub_dataOutToCache;
    wire [`A_SIZE-1:0] sub_addressToCache;
    wire [`A_SIZE-1:0] sub_requestAddressToCache;
    wire sub_V_update;
    wire sub_D_update;
    wire [1:0] sub_rw_Cache;
    
    wire [`D_SIZE-1:0] sub_dataInFromCache;
    wire [3:0] sub_hit;
    wire sub_dirty;
    wire sub_V_cache;
    wire [3:0] sub_D_cache;
    wire [`TAG_SIZE-1:0] sub_cache_tag;
    wire [`WAY_NUM-1:0] sub_way;
    wire [`WAY_NUM-1:0] sub_requestWay;
    
    // Main Memory interaction
    wire [`D_SIZE-1:0] sub_dataOutToMainMem;
    wire [`A_SIZE-1:0] sub_address_MainMem;
    wire [1:0] sub_rw_MainMem;
    wire [`D_SIZE-1:0] sub_dataFromMainMem;
    
    
    
    
    // To the ram in testbench
    assign addr = sub_addr;
    assign data_out = sub_data_out;
    assign rw = sub_rw;
    
    fetch fetch_dut(
        .instr_address(instr_address),    // output
        .pc(sub_pc),
        // inputs
        .opcode(sub_opcode),
        .rst(rst),
        .clk(clk),
        .halt(halt),
        .pc_jmp(sub_pc_jmp)
    );
    
    register1 register1_dut(
        // outputs
        .r1_r1(sub_r1),
        
        // inputs 
        .clk(clk),               
        .rst(rst),                          
        .halt(halt),                        
        .r1_instruction(instruction),       
        .pc(sub_pc)
        
        // test
        //.r1_instruction_test(r1_instruction_test)
    );
    
    read read_dut(
        // outputs
        .r1_opcode(sub_r1_opcode),
        .r1_dest(sub_r1_dest),
        .r1_op1(sub_r1_op1),
        .r1_op2(sub_r1_op2),
        
        
        // inputs from write_back block
        .result(sub_wresult),
        .dest(sub_wdest),
        .en(sub_wen),
        
        .r1(sub_r1),
        .clk(clk),
        .rst(rst),
        .pc(sub_pc)
        
        // test
        //.r1_test(r1_test)
    );
    
    register2 register2_dut(
        // outputs
        .r2_opcode(sub_r2_opcode),
        .r2_dest(sub_r2_dest),
        .r2_op1(sub_r2_op1),
        .r2_op2(sub_r2_op2),
        
        // inputs
        .r1_opcode(sub_r1_opcode),
        .r1_dest(sub_r1_dest),
        .r1_op1(sub_r1_op1),
        .r1_op2(sub_r1_op2),
        
        // dependency module
        // inputs
        .enMuxEx_1(sub_enMuxEx_1),
        .enMuxEx_2(sub_enMuxEx_2),
        .enMuxR3_1(sub_enMuxR3_1), 
        .enMuxR3_2(sub_enMuxR3_2),
        .ex_result(sub_e_result),
        .r3_result(sub_r3_result),
        //.ex_data_out(data_out),
        
        .clk(clk),
        .rst(rst),
        .pc(sub_pc)
    );
    
    
    execution execution_dut(
        // outputs
        .addr(sub_addressFromCPU),
        .data_out(sub_dataInFromCPU),
        .result(sub_e_result),
        .pc_jmp(sub_pc_jmp),
        .rw(sub_rw),
        // inputs
        .r2_opcode(sub_r2_opcode),
        .r2_dest(sub_r2_dest),
        .r2_op1(sub_r2_op1),
        .r2_op2(sub_r2_op2),
        
        .clk(clk),
        .rst(rst),
        .pc(sub_pc)
        
        // test
        //.exresult_test(exresult_test)
    );
    
    register3 register3_dut(
        .r3_opcode(sub_r3_opcode),
        .r3_dest(sub_r3_dest),
        .r3_result(sub_r3_result),
        
        // inputs
        .r2_opcode(sub_r2_opcode),
        .r2_dest(sub_r2_dest),
        .result(sub_e_result),
        .r2_op1(sub_r2_op1),
        .r2_op2(sub_r2_op2),
        .clk(clk),
        .rst(rst),
        .pc(sub_pc)
    );
    
    write_back write_back_dut(
        // outputs
        .wresult(sub_wresult),
        .wdest(sub_wdest),
        .wen(sub_wen),
        
        // inputs
        .r3_opcode(sub_r3_opcode),
        .r3_dest(sub_r3_dest),
        .r3_result(sub_r3_result),
        .clk(clk),
        .rst(rst),
        .pc(sub_pc),
        
        // inputs from data memory via cache controller
        .m_data_in(sub_dataOutToCPU)
        
        // optional, only for testing purpose
        //.wresult_test(result_test)
    );
    
    
    
    dd_control dd_control_dut(
        // outputs
        .enMuxEx_1(sub_enMuxEx_1),
        .enMuxEx_2(sub_enMuxEx_2),
        .enMuxR3_1(sub_enMuxR3_1),
        .enMuxR3_2(sub_enMuxR3_2),
        
        // inputs
        .r2_dest(sub_r2_dest),
        .r3_dest(sub_r3_dest),
        .r1(sub_r1),
        
        .clk(clk),
        .rst(rst)
    );
    
    distributed_ram distributed_ram_dut(
        // outputs
        // .<other module> (<current module specific>)
        .data_out(sub_dataFromMainMem),
        
        // inputs
        .addr(sub_address_MainMem),
        .data_in(sub_dataOutToMainMem),
        .rw(sub_rw_MainMem),
        .clk(clk),
        .rst(rst)
    );
    
    
   wire [`WAY_NUM-1:0] sub_write_here_way;
    
    
    cache_controller cache_controller_dut(
        // data transfer to/from CPU
        // output
        .dataOutToCPU(sub_dataOutToCPU),
        
        // input
        .dataInFromCPU(sub_dataInFromCPU),
        .addressFromCPU(sub_addressFromCPU),
        .rw(sub_rw),
        .clk(clk),
        .rst(rst),
        
        
        // data transfer to/from Cache memory 
        // output
        .dataOutToCache(sub_dataOutToCache),
        .addressToCache(sub_addressToCache),
        .requestAddressToCache(sub_requestAddressToCache),
        .V_update(sub_V_update),
        .D_update(sub_D_update),
        .rw_Cache(sub_rw_Cache),
        .way(sub_way),
        .requestWay(sub_requestWay),
        
        // input
        .dataInFromCache(sub_dataInFromCache),
        .hit(sub_hit),
        .V_cache(sub_V_cache),
        .D_cache(sub_D_cache),
        .write_here_way(sub_write_here_way),
        //.cache_tag(sub_cache_tag),
        
        // data transfer to/from Main memory
        // output
        .dataOutToMainMem(sub_dataOutToMainMem),
        .address_MainMem(sub_address_MainMem),
        .rw_MainMem(sub_rw_MainMem),
        // input
        .dataInFromMainMem(sub_dataFromMainMem)
        
    );
    
    
    
    set_assoc_cache set_assoc_cache_dut(
        // output
        .dataOut(sub_dataInFromCache),
        .hit(sub_hit),
        .V_cache(sub_V_cache),
        .D_cache(sub_D_cache),
        .write_here_way(sub_write_here_way),
        //.C_tag(sub_cache_tag),
        
        // input
        .dataIn(sub_dataOutToCache),
        .address(sub_addressToCache),
        .requestAddress(sub_requestAddressToCache),
        .V_update(sub_V_update),
        .D_update(sub_D_update),
        .rw(sub_rw_Cache),
        .way(sub_way),
        .requestWay(sub_requestWay),
        .clk(clk),
        .rst(rst)
    );
    
    
    
endmodule



