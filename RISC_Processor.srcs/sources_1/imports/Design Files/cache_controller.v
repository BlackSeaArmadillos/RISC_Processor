`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2022 04:15:40 PM
// Design Name: 
// Module Name: cache_controller
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

module cache_controller(
    // data transfer to/from CPU
    output reg [`D_SIZE-1:0] dataOutToCPU,
    input [`D_SIZE-1:0] dataInFromCPU,
    input [`A_SIZE-1:0] addressFromCPU,
    input [1:0] rw,
    input clk,
    input rst,
    
    // data transfer to/from Cache Memory
    output reg [`D_SIZE-1:0] dataOutToCache,
    output reg [`A_SIZE-1:0] addressToCache,
    output reg [`A_SIZE-1:0] requestAddressToCache,
    output reg V_update,
    output reg D_update,
    output reg [1:0] rw_Cache,
    output reg [`WAY_NUM-1:0] way,
    output reg [`WAY_NUM-1:0] requestWay,
    input [`D_SIZE-1:0] dataInFromCache,
    input [3:0] hit,
    input V_cache,
    input [3:0] D_cache,
    input [`WAY_NUM-1:0] write_here_way,
    //input [`TAG_SIZE-1:0] cache_tag,
    
    // data transfer to/from Main Memory
    output reg [`D_SIZE-1:0] dataOutToMainMem,
    output reg [`A_SIZE-1:0] address_MainMem,
    output reg [1:0] rw_MainMem,
    input [`D_SIZE-1:0] dataInFromMainMem
    );
    
    always@(*) begin
        requestAddressToCache = addressFromCPU;
        requestWay = dataInFromCPU % 4;
        mid_way = dataInFromCPU % 4;
    end
    
    reg [`WAY_NUM-1:0] mid_way;
    
    
  
    
    always@(*) begin
        if (rw == `WRITE) begin
            //$display("hit = %b, D-cache = %b", hit, D_cache);
            case (hit)
                4'bXXXX:        begin
                                    case (D_cache)
                                        4'bXXXX:   begin
                                                        // 1. Read data from main memory to cache - omis momentan
                                                        // 2. Write data to cache
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = dataInFromCPU % 4;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU; 
                                                   end
                                        4'b0000:   begin
                                                        // 1. Read data from main memory to cache - omis momentan
                                                        // 2. Write data to cache
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = dataInFromCPU % 4;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU; 
                                                   end
                                        4'b0001:   begin
                                                        if (mid_way == 0) begin
                                                            // 1. Send already existing data from cache to main memory
                                                            rw_MainMem = rw;
                                                            address_MainMem = addressFromCPU;
                                                            dataOutToMainMem = dataInFromCache;
                                                            D_update = 0;
                                                            // 2. Read data from main memory to cache - omis momentan                   
                                                            // 3. Write data to cache
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end 
                                                        else begin
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end
                                                   end
                                        4'b0010:   begin
                                                        if (mid_way == 1) begin
                                                            // 1. Send already existing data from cache to main memory
                                                            rw_MainMem = rw;
                                                            address_MainMem = addressFromCPU;
                                                            dataOutToMainMem = dataInFromCache;
                                                            D_update = 0;
                                                            // 2. Read data from main memory to cache - omis momentan                   
                                                            // 3. Write data to cache
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end 
                                                        else begin
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end
                                                   end
                                        4'b0100:   begin
                                                        if (mid_way == 2) begin
                                                            // 1. Send already existing data from cache to main memory
                                                            rw_MainMem = rw;
                                                            address_MainMem = addressFromCPU;
                                                            dataOutToMainMem = dataInFromCache;
                                                            D_update = 0;
                                                            // 2. Read data from main memory to cache - omis momentan                   
                                                            // 3. Write data to cache
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end 
                                                        else begin
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end
                                                   end
                                        4'b1000:   begin
                                                        if (mid_way == 3) begin
                                                            // 1. Send already existing data from cache to main memory
                                                            rw_MainMem = rw;
                                                            address_MainMem = addressFromCPU;
                                                            dataOutToMainMem = dataInFromCache;
                                                            D_update = 0;
                                                            // 2. Read data from main memory to cache - omis momentan                   
                                                            // 3. Write data to cache
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end 
                                                        else begin
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end
                                                   end 
                                    endcase
                                end
                4'b0000:        begin
                                    case (D_cache)
                                        4'bXXXX:   begin
                                                        // 1. Read data from main memory to cache - omis momentan
                                                        // 2. Write data to cache
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = dataInFromCPU % 4;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU;
                                                   end
                                        4'b0000:   begin
                                                        // 1. Read data from main memory to cache - omis momentan
                                                        // 2. Write data to cache
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = dataInFromCPU % 4;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU; 
                                                   end
                                        4'b0001:   begin
                                                        if (mid_way == 0) begin
                                                            // 1. Send already existing data from cache to main memory
                                                            rw_MainMem = rw;
                                                            address_MainMem = addressFromCPU;
                                                            dataOutToMainMem = dataInFromCache;
                                                            D_update = 0;
                                                            // 2. Read data from main memory to cache - omis momentan                   
                                                            // 3. Write data to cache
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end 
                                                        else begin
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end
                                                   end
                                        4'b0010:   begin
                                                        if (mid_way == 1) begin
                                                            // 1. Send already existing data from cache to main memory
                                                            rw_MainMem = rw;
                                                            address_MainMem = addressFromCPU;
                                                            dataOutToMainMem = dataInFromCache;
                                                            D_update = 0;
                                                            // 2. Read data from main memory to cache - omis momentan                   
                                                            // 3. Write data to cache
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end 
                                                        else begin
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end
                                                   end
                                        4'b0100:   begin
                                                        if (mid_way == 2) begin
                                                            // 1. Send already existing data from cache to main memory
                                                            rw_MainMem = rw;
                                                            address_MainMem = addressFromCPU;
                                                            dataOutToMainMem = dataInFromCache;
                                                            D_update = 0;
                                                            // 2. Read data from main memory to cache - omis momentan                   
                                                            // 3. Write data to cache
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end 
                                                        else begin
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end
                                                   end
                                        4'b1000:   begin
                                                        if (mid_way == 3) begin
                                                            // 1. Send already existing data from cache to main memory
                                                            rw_MainMem = rw;
                                                            address_MainMem = addressFromCPU;
                                                            dataOutToMainMem = dataInFromCache;
                                                            D_update = 0;
                                                            // 2. Read data from main memory to cache - omis momentan                   
                                                            // 3. Write data to cache
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end 
                                                        else begin
                                                            rw_Cache = 1;
                                                            V_update = 1;
                                                            D_update = 1;
                                                            way = dataInFromCPU % 4;
                                                            dataOutToCache = dataInFromCPU;
                                                            addressToCache = addressFromCPU;
                                                        end
                                                   end 
                                    endcase
                                end
                4'b0001:        begin
                                    case (D_cache[0])
                                        1'b0:       begin
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = 0;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU;
                                                    end
                                        1'b1:       begin
                                                        // 1. Send already existing data from cache to main memory
                                                        rw_MainMem = rw;
                                                        address_MainMem = addressFromCPU;
                                                        dataOutToMainMem = dataInFromCache;
                                                        D_update = 0;                   
                                                        // 2. Read data from main memory to cache - omis momentan
                                                        // 3. Write data to cache
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = 0;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU;
                                                    end
                                    endcase
                                end
                4'b0010:       begin
                                    case (D_cache[1])
                                        1'b0:       begin
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = 1;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU;
                                                    end
                                        1'b1:       begin
                                                        // 1. Send already existing data from cache to main memory
                                                        rw_MainMem = rw;
                                                        address_MainMem = addressFromCPU;
                                                        dataOutToMainMem = dataInFromCache;
                                                        D_update = 0;                   
                                                        // 2. Read data from main memory to cache - omis momentan
                                                        // 3. Write data to cache
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = 1;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU;
                                                    end
                                    endcase
                                end
                4'b0100:        begin
                                    case (D_cache[2])
                                        1'b0:       begin
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = 2;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU;
                                                    end
                                        1'b1:       begin
                                                        // 1. Send already existing data from cache to main memory
                                                        rw_MainMem = rw;
                                                        address_MainMem = addressFromCPU;
                                                        dataOutToMainMem = dataInFromCache;
                                                        D_update = 0;                   
                                                        // 2. Read data from main memory to cache - omis momentan
                                                        // 3. Write data to cache
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = 2;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU;
                                                    end
                                    endcase
                                end
                4'b1000:        begin
                                    case (D_cache[3])
                                        1'b0:       begin
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = 3;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU;
                                                    end
                                        1'b1:       begin
                                                        // 1. Send already existing data from cache to main memory
                                                        rw_MainMem = rw;
                                                        address_MainMem = addressFromCPU;
                                                        dataOutToMainMem = dataInFromCache;
                                                        D_update = 0;                   
                                                        // 2. Read data from main memory to cache - omis momentan
                                                        // 3. Write data to cache
                                                        
                                                        // A delay is needed here between the writing to main memory from cache
                                                        //  and sending to cache the updated data
                                                        
                                                        rw_Cache = 1;
                                                        V_update = 1;
                                                        D_update = 1;
                                                        way = 3;
                                                        dataOutToCache = dataInFromCPU;
                                                        addressToCache = addressFromCPU;
                                                    end
                                    endcase
                                end
            endcase
        end
        else if (rw == `READ) begin
            case (hit)
                4'bXXXX:    begin
                                case (D_cache)
                                    4'bXXXX:    begin
                                                    // 1. Read data from main memory
                                                    address_MainMem = addressFromCPU;
                                                    
                                                    // 2. Send data to cache
                                                    rw_Cache = 1;
                                                    V_update = 1;
                                                    D_update = 0;
                                                    way = dataInFromMainMem % 4;
                                                    addressToCache = addressFromCPU;
                                                    dataOutToCache = dataInFromMainMem;
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromMainMem;
                                                end
                                    4'b0000:    begin
                                                    // 1. Read data from main memory
                                                    address_MainMem = addressFromCPU;
                                                    
                                                    // 2. Send data to cache
                                                    rw_Cache = 1;
                                                    V_update = 1;
                                                    D_update = 0;
                                                    way = dataInFromMainMem % 4;
                                                    addressToCache = addressFromCPU;
                                                    dataOutToCache = dataInFromMainMem;
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromMainMem;
                                                end
                                    4'b0001:    begin
                                                    // 1. Send already existing data from cache to main memory
                                                    rw_MainMem = rw;
                                                    addressToCache = addressFromCPU;
                                                    address_MainMem = addressFromCPU;
                                                    dataOutToMainMem = dataInFromCache;
                                                
                                                    // 2. Read data from main memory to cache
                                                    way = 0;
                                                    dataOutToCache = dataInFromMainMem;
                                                    D_update = 0;
                                                    
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromCache;
                                                end
                                    4'b0010:    begin
                                                    // 1. Send already existing data from cache to main memory
                                                    rw_MainMem = rw;
                                                    addressToCache = addressFromCPU;
                                                    address_MainMem = addressFromCPU;
                                                    dataOutToMainMem = dataInFromCache;
                                                
                                                    // 2. Read data from main memory to cache
                                                    way = 1;
                                                    dataOutToCache = dataInFromMainMem;
                                                    D_update = 0;
                                                    
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromCache;
                                                end
                                    4'b0100:    begin
                                                    // 1. Send already existing data from cache to main memory
                                                    rw_MainMem = rw;
                                                    addressToCache = addressFromCPU;
                                                    address_MainMem = addressFromCPU;
                                                    dataOutToMainMem = dataInFromCache;
                                                
                                                    // 2. Read data from main memory to cache
                                                    way = 2;
                                                    dataOutToCache = dataInFromMainMem;
                                                    D_update = 0;
                                                    
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromCache;
                                                end
                                    4'b1000:    begin
                                                    // 1. Send already existing data from cache to main memory
                                                    rw_MainMem = rw;
                                                    addressToCache = addressFromCPU;
                                                    address_MainMem = addressFromCPU;
                                                    dataOutToMainMem = dataInFromCache;
                                                
                                                    // 2. Read data from main memory to cache
                                                    way = 3;
                                                    dataOutToCache = dataInFromMainMem;
                                                    D_update = 0;
                                                    
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromCache;
                                                end
                                endcase
                            end
                4'b0000:    begin
                                case (D_cache)
                                    4'bXXXX:    begin
                                                    // 1. Read data from main memory
                                                    address_MainMem = addressFromCPU;
                                                    
                                                    // 2. Send data to cache
                                                    rw_Cache = 1;
                                                    V_update = 1;
                                                    D_update = 0;
                                                    way = dataInFromMainMem % 4;
                                                    addressToCache = addressFromCPU;
                                                    dataOutToCache = dataInFromMainMem;
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromMainMem;
                                                end
                                    4'b0000:    begin
                                                    // 1. Read data from main memory
                                                    address_MainMem = addressFromCPU;
                                                    
                                                    // 2. Send data to cache
                                                    rw_Cache = 1;
                                                    V_update = 1;
                                                    D_update = 0;
                                                    way = dataInFromMainMem % 4;
                                                    addressToCache = addressFromCPU;
                                                    dataOutToCache = dataInFromMainMem;
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromMainMem;
                                                end
                                    4'b0001:    begin
                                                    // 1. Send already existing data from cache to main memory
                                                    rw_MainMem = rw;
                                                    addressToCache = addressFromCPU;
                                                    address_MainMem = addressFromCPU;
                                                    dataOutToMainMem = dataInFromCache;
                                                
                                                    // 2. Read data from main memory to cache
                                                    way = 0;
                                                    dataOutToCache = dataInFromMainMem;
                                                    D_update = 0;
                                                    
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromCache;
                                                end
                                    4'b0010:    begin
                                                    // 1. Send already existing data from cache to main memory
                                                    rw_MainMem = rw;
                                                    addressToCache = addressFromCPU;
                                                    address_MainMem = addressFromCPU;
                                                    dataOutToMainMem = dataInFromCache;
                                                
                                                    // 2. Read data from main memory to cache
                                                    way = 1;
                                                    dataOutToCache = dataInFromMainMem;
                                                    D_update = 0;
                                                    
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromCache;
                                                end
                                    4'b0100:    begin
                                                    // 1. Send already existing data from cache to main memory
                                                    rw_MainMem = rw;
                                                    addressToCache = addressFromCPU;
                                                    address_MainMem = addressFromCPU;
                                                    dataOutToMainMem = dataInFromCache;
                                                
                                                    // 2. Read data from main memory to cache
                                                    way = 2;
                                                    dataOutToCache = dataInFromMainMem;
                                                    D_update = 0;
                                                    
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromCache;
                                                end
                                    4'b1000:    begin
                                                    // 1. Send already existing data from cache to main memory
                                                    rw_MainMem = rw;
                                                    addressToCache = addressFromCPU;
                                                    address_MainMem = addressFromCPU;
                                                    dataOutToMainMem = dataInFromCache;
                                                
                                                    // 2. Read data from main memory to cache
                                                    way = 3;
                                                    dataOutToCache = dataInFromMainMem;
                                                    D_update = 0;
                                                    
                                                    // 3. Read data from cache to CPU
                                                    dataOutToCPU = dataInFromCache;
                                                end
                                endcase
                            end
                4'b0001:    begin
                                dataOutToCPU = dataInFromCache;
                            end
                4'b0010:    begin
                                dataOutToCPU = dataInFromCache;
                            end
                4'b0100:    begin
                                dataOutToCPU = dataInFromCache;
                            end
                4'b1000:    begin
                                dataOutToCPU = dataInFromCache;
                            end
            endcase
        end
        else begin
            // default
        end
    end

/*    
    always@(posedge clk) begin
        if (rw == `WRITE) begin           
            if (hit[0]) begin
                if (D_cache[0]) begin
                    // 1. Send already existing data from cache to main memory
                    rw_MainMem = rw;
                    address_MainMem = addressFromCPU;
                    dataOutToMainMem = dataInFromCache;
                    D_update = 0;                   
                    // 2. Read data from main memory to cache - omis momentan
                    // 3. Write data to cache
                    rw_Cache = 1;
                    V_update = 1;
                    D_update = 1;
                    way = 0;
                    dataOutToCache = dataInFromCPU;
                    addressToCache = addressFromCPU;
                end
                else begin
                    // IF NOT DIRTY 0
                    rw_Cache = 1;
                    V_update = 1;
                    D_update = 1;
                    way = 0;
                    dataOutToCache = dataInFromCPU;
                    addressToCache = addressFromCPU;
                end
            end
            else begin
                // IF NOT HIT 0
                // Allocate a cache block to use
                if (D_cache) begin
                    // 1. Send already existing data from cache to main memory
                    rw_MainMem = rw;
                    address_MainMem = addressFromCPU;
                    dataOutToMainMem = dataInFromCache;
                    D_update = 0;
                    // 2. Read data from main memory to cache - omis momentan                   
                    // 3. Write data to cache
                    rw_Cache = 1;
                    V_update = 1;
                    D_update = 1;
                    way = dataInFromCPU % 4;
                    dataOutToCache = dataInFromCPU;
                    addressToCache = addressFromCPU;
                    
                end
                else begin
                    // IF NOT HIT 0 AND NOT DIRTY 0
                    // 1. Read data from main memory to cache - omis momentan
                    // 2. Write data to cache
                    rw_Cache = 1;
                    V_update = 1;
                    D_update = 1;
                    way = dataInFromCPU % 4;
                    dataOutToCache = dataInFromCPU;
                    addressToCache = addressFromCPU;
                end
            end
            if (hit[1]) begin
                if (D_cache[1]) begin
                    // 1. Send already existing data from cache to main memory
                    rw_MainMem = rw;
                    address_MainMem = addressFromCPU;
                    dataOutToMainMem = dataInFromCache;
                    D_update = 0;                   
                    // 2. Read data from main memory to cache - omis momentan
                    // 3. Write data to cache
                    rw_Cache = 1;
                    V_update = 1;
                    D_update = 1;
                    way = 1;
                    dataOutToCache = dataInFromCPU;
                    addressToCache = addressFromCPU;
                end
                else begin
                    // IF NOT DIRTY 1
                    rw_Cache = 1;
                    V_update = 1;
                    D_update = 1;
                    way = 0;
                    dataOutToCache = dataInFromCPU;
                    addressToCache = addressFromCPU;
                end
            end
            else begin
                // IF NOT HIT 1
                if (D_cache[1]) begin
                    // 1. Send already existing data from cache to main memory
                    rw_MainMem = rw;
                    address_MainMem = addressFromCPU;
                    dataOutToMainMem = dataInFromCache;
                    D_update = 0;
                    // 2. Read data from main memory to cache - omis momentan                   
                    // 3. Write data to cache
                    rw_Cache = 1;
                    V_update = 1;
                    D_update = 1;
                    way = dataInFromCPU % 4;
                    dataOutToCache = dataInFromCPU;
                    addressToCache = addressFromCPU;
                end
                else begin
                    // IF NOT HIT 1 AND NOT DIRTY 1
                end
            end
            if (hit[2]) begin
                if (D_cache[2]) begin
                
                end
                else begin
                    // IF NOT DIRTY 2
                end
            end
            else begin
                // IF NOT HIT 2
                if (D_cache[2]) begin
                    
                end
                else begin
                    // IF NOT HIT 2 AND NOT DIRY 2
                end
            end
            if (hit[3]) begin
                if (D_cache[3]) begin
                
                end
                else begin
                    // IF NOT DIRY 3
                end
            end
            else begin
                // IF NOT HIT 3
                if (D_cache[3]) begin
                
                end
                else begin
                    // IF NOT HIT 3 AND DIRY 3
                end
            end
        end
        else if (rw == `READ) begin
            //addressToCache = addressFromCPU;
            if (hit) begin
                dataOutToCPU = dataInFromCache;
            end
            else begin
                // if not hit
                // Allocate cache block to use
                if (D_cache) begin
                    // 1. Send already existing data from cache to main memory
                    rw_MainMem = rw;
                    address_MainMem = addressFromCPU;
                    dataOutToMainMem = dataInFromCache;
                
                    // 2. Read data from main memory to cache
                    dataOutToCache = dataInFromMainMem;
                    D_update = 0;
                    
                    // 3. Read data from cache to CPU
                    dataOutToCPU = dataInFromCache;
                end
                else begin
                    // if not dirty
                    // 1. Read data from main memory to cache
                    dataOutToCache = dataInFromMainMem;
                    D_update = 0;
                    
                    // 2. Read data from cache to CPU
                    dataOutToCPU = dataInFromCache;
                end
            end
        end
    end
    
*/    
endmodule
