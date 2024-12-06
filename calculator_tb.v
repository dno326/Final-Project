`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 02:44:16 PM
// Design Name: 
// Module Name: calculator_tb
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


module tb_calculator;

    reg [3:0] A;             // First operand
    reg [3:0] B;             // Second operand
    reg [2:0] op;            // Operation selector
    reg clk;                 // Clock for multiplexing
    reg reset;

    wire [6:0] seg;          // 7-segment display output
    wire digit_select;       // Control signal for which digit to enable

    calculator uut (
        .A(A),
        .B(B),
        .op(op),
        .clk(clk),
        .seg(seg),
        .reset(reset),
        .digit_select(digit_select)
    );

    always begin
        #5 clk = ~clk; // Clock period 10ns
    end
    
    

    initial begin
        reset = 1;
        clk = 0;  // Start with clock at 0
        A = 4'b0000;  // A = 0
        B = 4'b0000;  // B = 0
        op = 3'b000;  // Operation = ADDITION (A + B)

        @(negedge clk);
        @(negedge clk);
        
        reset = 0;
        
        #1000 A = 4'b0001; B = 4'b0010; op = 3'b000;  // A = 1, B = 2, ADDITION (1 + 2)
        #1000 A = 4'b0101; B = 4'b0011; op = 3'b001;  // A = 5, B = 3, SUBTRACTION (5 - 3)
        #1000 A = 4'b0011; B = 4'b0011; op = 3'b010;  // A = 3, B = 3, MULTIPLICATION (3 * 3)
        #1000 A = 4'b0100; B = 4'b0010; op = 3'b011;  // A = 4, B = 2, DIVISION (4 / 2)
        #1000 A = 4'b1100; B = 4'b0011; op = 3'b100;  // A = 12, B = 3, AND (A & B)
        #1000 A = 4'b1010; B = 4'b1100; op = 3'b101;  // A = 10, B = 12, OR (A | B)
        #1000 A = 4'b1101; B = 4'b1011; op = 3'b110;  // A = 13, B = 11, XOR (A ^ B)
        #1000 A = 4'b1010; B = 4'b0000; op = 3'b111;  // A = 10, B = 0, NOT (~A)
        #1000 $finish;
    end
    initial begin
        $monitor("At time %t, A = %d, B = %d, op = %b, seg = %b, digit_select = %b",
                 $time, A, B, op, seg, digit_select);
    end
endmodule

