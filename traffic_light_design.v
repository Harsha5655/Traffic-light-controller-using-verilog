`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2024 19:38:09
// Design Name: 
// Module Name: traffic_light_design
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


module traffic_light_design(
    input clk,          
    input rst,          
    output reg [11:0] light );

    
    typedef enum reg [2:0] {
        S0 = 3'b000,   
        S1 = 3'b001,   
        S2 = 3'b010,   
        S3 = 3'b011,   
        S4 = 3'b100,   
        S5 = 3'b101,   
        S6 = 3'b110,   
        S7 = 3'b111    
    } state_t;

    
    state_t current_state, next_state;

    
    reg [6:0] timer; 

    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= S0;    
            timer <= 7'b0;           
        end else begin
            current_state <= next_state;
            if (timer < 100) timer <= timer + 1;
            else timer <= 7'b0;     
        end
    end

    
    always @(*) begin
        case (current_state)
            S0: next_state = (timer == 20) ? S1 : S0;
            S1: next_state = (timer == 25) ? S2 : S1;
            S2: next_state = (timer == 45) ? S3 : S2;
            S3: next_state = (timer == 50) ? S4 : S3;
            S4: next_state = (timer == 70) ? S5 : S4;
            S5: next_state = (timer == 75) ? S6 : S5;
            S6: next_state = (timer == 95) ? S7 : S6;
            S7: next_state = (timer == 100) ? S0 : S7;
            default: next_state = S0;
        endcase
    end

    
    always @(*) begin
        
        light = 12'b000_000_000_001;

        case (current_state)
            S0: light = {3'b100, 3'b001, 3'b001, 3'b001}; 
            S1: light = {3'b100, 3'b001, 3'b001, 3'b001}; 
            S2: light = {3'b010, 3'b001, 3'b001, 3'b001}; 
            S3: light = {3'b001, 3'b100, 3'b001, 3'b001}; 
            S4: light = {3'b001, 3'b010, 3'b001, 3'b001}; 
            S5: light = {3'b001, 3'b001, 3'b100, 3'b001}; 
            S6: light = {3'b001, 3'b001, 3'b010, 3'b001}; 
            S7: light = {3'b001, 3'b001, 3'b001, 3'b100}; 
            default: light = 12'b000_000_000_001; 
        endcase
    end
endmodule
