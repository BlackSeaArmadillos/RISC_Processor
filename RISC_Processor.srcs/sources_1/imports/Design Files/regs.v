`timescale 1ns / 1ps

module regs(
    output regs_op2,
    output regs_op1,
    input sel_op2,
    input sel_op1,
    input dest,
    input result,
    input read,
    input write,
    input clk,
    input rst
);

integer i;
reg [2:0] regFile [0:15];

always@(posedge rst or clk) begin
    if (rst == 1) begin
        for (i = 0; i < 16; i = i + 1) begin
            regFile[i] = 0;
        end
    end
    else if (rst == 0) begin
        case ({read, write})
            2'b00   : ;
            
            2'b01   :   begin
                            regFile[dest] = result;
                        end
            
            2'b10   :   begin 
                            regs_op1 = regFile[sel_op1];
                            regs_op2 = regFile[sel_op2];
                        end
            
            2'b11   : ; //  memory read and write
        endcase
    end
end

endmodule


