`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 23:10:30
// Design Name: 
// Module Name: Baudrate_gen
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


module Baudrate_gen(
    input clk,
    input rst,
    output tx_enb,
    output rx_enb
);

reg [12:0] tx_counter;
reg [9:0] rx_counter;

always @(posedge clk) begin
    if (rst) begin
        tx_counter <= 13'd0;
    end else begin
        if (tx_counter == 13'd5207) begin 
            tx_counter <= 13'd0;
        end else begin
            tx_counter <= tx_counter + 1'b1; // Fixed to non-blocking
        end
    end
end
    
// Receiver Counter Channel
always @(posedge clk) begin
    if (rst) begin
        rx_counter <= 10'd0;
    end else begin
        if (rx_counter == 10'd324) 
        begin 
            rx_counter <= 10'd0;
        end else begin
            rx_counter <= rx_counter + 1'b1; 
        end
    end
end
    
// Continuous assignments for your single-cycle enable pulses
assign rx_enb = (rx_counter == 10'd0) ? 1'b1 : 1'b0;
assign tx_enb = (tx_counter == 13'd0) ? 1'b1 : 1'b0;

endmodule

