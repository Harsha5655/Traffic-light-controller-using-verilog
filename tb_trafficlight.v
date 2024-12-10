`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2024 19:45:29
// Design Name: 
// Module Name: tb_trafficlight
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


module tb_trafficlight();

  reg clk;  
  reg rst;  
  
  wire [11:0] light;  
  
  
  traffic_light_design DUT (
    .clk(clk),
    .rst(rst),
    .light(light)
  );


always #5 clk=~clk;

  
  initial begin
    
    clk = 0;
    rst = 1;
   #10 rst = 0;  
   $monitor("Time = %0t, Light = %b", $time, light);
    #200;// Simulate 20 ns (20 seconds for Green Light on 1st road)
    #50;// Simulate 5 ns (5 seconds for Yellow Light on 1st road)
    #200;// Simulate 20 ns (20 seconds for Green Light on 2nd road)
    #50;// Simulate 5 ns (5 seconds for Yellow Light on 2nd road)
    #200; // Simulate 20 ns (20 seconds for Green Light on 3rd road)
    #50;// Simulate 5 ns (5 seconds for Yellow Light on 3rd road)
    #200; // Simulate 20 ns (20 seconds for Green Light on 4th road)
    #50;// Simulate 5 ns (5 seconds for Yellow Light on 4th road)
    #200; // Simulate 20 ns (Cycle completes, back to 1st road green)
    #1200 $finish;
    
   
end
endmodule
