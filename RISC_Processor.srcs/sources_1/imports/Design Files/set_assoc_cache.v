`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2022 04:16:50 PM
// Design Name: 
// Module Name: set_assoc_cache
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
`include "include_defines.vh"// Cache sizes

module set_assoc_cache(
    output reg [`D_SIZE-1:0] dataOut,
    output [3:0] hit,
    output reg V_cache,
    output [3:0] D_cache,
    output reg [`TAG_SIZE-1:0] C_tag,
    output reg [`WAY_NUM-1:0] write_here_way,
    
    input [`D_SIZE-1: 0] dataIn, 
    input [`A_SIZE-1: 0] address,
    input [`A_SIZE-1: 0] requestAddress,
    input V_update,
    input D_update,
    input [1:0] rw,
    input [`WAY_NUM-1:0] way,
    input [`WAY_NUM-1:0] requestWay,
    input clk,
    input rst
    );
    
    reg [6:0] addr_tag;
    reg addr_idx;
    reg [2:0] addr_offset;
    
    integer i;
    
    reg [`C_SIZE-1:0] sa_cache_mem[0:`SET_NUM-1][0:`WAY_NUM-1]; 
    reg [`D_SIZE-1:0] mid_data;
    reg [`C_SIZE-1:0] new_write_way;   
    reg [`C_SIZE-1:0] new_read_way;   
    reg [`TAG_SIZE-1:0] cache_tag;
    
    reg [164-1:0] new_read_set;
    
    reg [`C_SIZE-1:0] way0;
    reg [`C_SIZE-1:0] way1;
    reg [`C_SIZE-1:0] way2;
    reg [`C_SIZE-1:0] way3;
    
    wire [`TAG_SIZE-1:0] cache_tag0;
    wire [`TAG_SIZE-1:0] cache_tag1;
    wire [`TAG_SIZE-1:0] cache_tag2;
    wire [`TAG_SIZE-1:0] cache_tag3;
    
    reg tag_bit0;
    reg tag_bit1;
    reg tag_bit2;
    reg tag_bit3;
    
    reg dirty_bit0;
    reg dirty_bit1;
    reg dirty_bit2;
    reg dirty_bit3;
    
    wire valid_bit0;
    wire valid_bit1;
    wire valid_bit2;
    wire valid_bit3;
    
    
    wire [`D_SIZE-1:0] mid_data0;
    wire [`D_SIZE-1:0] mid_data1;
    wire [`D_SIZE-1:0] mid_data2;
    wire [`D_SIZE-1:0] mid_data3;
    
    reg [6:0] req_addr_tag;
    reg req_addr_idx;
    reg [2:0] req_addr_offset;
    
    
    
    always@(*) begin
        addr_tag = address[`A_SIZE-1:3];
        addr_idx = address[2];
        addr_offset = address[1:0];
    end
    
    
    
    // Here is the cache memory implementation
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    // =================================================================================
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    
    always@(posedge clk) begin
//        $display("cache memory: %x, %x, %x, %x", sa_cache_mem[0][0], sa_cache_mem[0][1], sa_cache_mem[0][2], sa_cache_mem[0][3]);
//        $display("cache memory: %x, %x, %x, %x", sa_cache_mem[1][0], sa_cache_mem[1][1], sa_cache_mem[1][2], sa_cache_mem[1][3]);
//        $display("end");

        if(rst == 0) begin
            for(i = 0; i < `SET_NUM; i = i+1) begin
                sa_cache_mem[i][0] <= 0;
                sa_cache_mem[i][1] <= 0;
                sa_cache_mem[i][2] <= 0;
                sa_cache_mem[i][3] <= 0;
            end
        end
        else begin 
            if(rw == `WRITE) begin
                new_write_way[`D_SIZE-1:0] <= dataIn;
                new_write_way[38:32] <= addr_tag;
                new_write_way[`C_SIZE-2] <= D_update;
                new_write_way[`C_SIZE-1] <= V_update;
            end
            else begin
                // nothing to happen
            end     
        end
    end  
    
    always@(*) begin
//        new_read_set[4*`C_SIZE-1:3*`C_SIZE] = sa_cache_mem[addr_idx][0];
//        new_read_set[3*`C_SIZE-1:2*`C_SIZE] = sa_cache_mem[addr_idx][1];
//        new_read_set[2*`C_SIZE-1:`C_SIZE] = sa_cache_mem[addr_idx][2];
//        new_read_set[`C_SIZE-1:0] = sa_cache_mem[addr_idx][3];
        
        new_read_set[164-1:123] = sa_cache_mem[addr_idx][0];
        new_read_set[123-1:82] = sa_cache_mem[addr_idx][1];
        new_read_set[82-1:41] = sa_cache_mem[addr_idx][2];
        new_read_set[`C_SIZE-1:0] = sa_cache_mem[addr_idx][3];
        
//        $display("new_read_set = %b", new_read_set);
//        $display("sa_cache_mem[0] = %b", sa_cache_mem[addr_idx][0]);
//        $display("sa_cache_mem[1] = %b", sa_cache_mem[addr_idx][1]);
//        $display("sa_cache_mem[2] = %b", sa_cache_mem[addr_idx][2]);
//        $display("sa_cache_mem[3] = %b", sa_cache_mem[addr_idx][3]);
    end  
    
    
    
    // Write to cache memory (The write operation is based on the way)
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    // =================================================================================
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    

    always@(*) begin
        sa_cache_mem[addr_idx][way] <= new_write_way;
    end
   
    
    
    // Read from cache memory (The read operation is based on the matching tags)
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    // =================================================================================
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
      
    always@(*) begin
        way0 = new_read_set[164-1:123];
        way1 = new_read_set[123-1:82];
        way2 = new_read_set[82-1:41];
        way3 = new_read_set[`C_SIZE-1:0];
        $display("new_read_set[`C_SIZE-1:0] = %b", new_read_set[`C_SIZE-1:0]);
    end  
    
    
    // Parse data

    assign valid_bit0 = way0[40];
    assign valid_bit1 = way1[40];
    assign valid_bit2 = way2[40];
    assign valid_bit3 = way3[40];

    
    assign D_cache[0] = way0[39];
    assign D_cache[1] = way1[39];
    assign D_cache[2] = way2[39];
    assign D_cache[3] = way3[39];

  
    assign cache_tag0 = way0[38:`D_SIZE];
    assign cache_tag1 = way1[38:`D_SIZE];
    assign cache_tag2 = way2[38:`D_SIZE];
    assign cache_tag3 = way3[38:`D_SIZE];

    assign mid_data0 = way0[`D_SIZE-1:0];
    assign mid_data1 = way1[`D_SIZE-1:0];
    assign mid_data2 = way2[`D_SIZE-1:0];
    assign mid_data3 = way3[`D_SIZE-1:0];
    
    
    
    //assign D_cache = dirty_bit0 | dirty_bit1 | dirty_bit2 | dirty_bit3;
    
    // Enable which data will go out based on the tag_bit
    always@(*) begin
        if (tag_bit0) begin
            dataOut = mid_data0;
        end
        else if (tag_bit1) begin
            dataOut = mid_data1;
        end
        else if (tag_bit2) begin
            dataOut = mid_data2;
        end
        else if (tag_bit3) begin
            dataOut = mid_data3;
            //dirty = dirty_bit3;
        end
        else begin
            // miss
        end
    end
    


    // Valid check
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    // =================================================================================
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    
    //assign hit = tag_bit * V_cache;
    wire [3:0] mid_hit;
    
    assign hit[0] = tag_bit0 * valid_bit0;
    assign hit[1] = tag_bit1 * valid_bit1;
    assign hit[2] = tag_bit2 * valid_bit2;
    assign hit[3] = tag_bit3 * valid_bit3;
    
    //assign hit = mid_hit[0] | mid_hit[1] | mid_hit[2] | mid_hit[3];
    
    
    
    
    // Request cache check
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    // =================================================================================
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    always@(*) begin
        req_addr_tag = requestAddress[`A_SIZE-1:3];
        req_addr_idx = requestAddress[2];
        req_addr_offset = requestAddress[1:0];
    end
    
       
    
    // Tag check
    // |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    // =================================================================================
    // ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 

    always@(*) begin
        if(req_addr_tag == cache_tag0) begin
            tag_bit0 = 1;
            tag_bit1 = 0;
            tag_bit2 = 0;
            tag_bit3 = 0;
            write_here_way = 0;
        end
        else if(req_addr_tag == cache_tag1) begin
            tag_bit0 = 0;
            tag_bit1 = 1;
            tag_bit2 = 0;
            tag_bit3 = 0;
            write_here_way = 1;
        end
        else if(req_addr_tag == cache_tag2) begin
            tag_bit0 = 0;
            tag_bit1 = 0;
            tag_bit2 = 1;
            tag_bit3 = 0;
            write_here_way = 2;
        end
        else if(req_addr_tag == cache_tag3) begin
            tag_bit0 = 0;
            tag_bit1 = 0;
            tag_bit2 = 0;
            tag_bit3 = 1;
            write_here_way = 3;
        end
        else begin
            tag_bit0 = 0;
            tag_bit1 = 0;
            tag_bit2 = 0;
            tag_bit3 = 0;
        end
    end
endmodule
