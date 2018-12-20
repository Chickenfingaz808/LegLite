`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2018 07:58:14 PM
// Design Name: 
// Module Name: IM2
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


// Program or Instuction Memory (IM2.V)
// Program 2 which tests memory and I/O
//   I/O ports:
//      * 0xfff0 = input port from switches
//                  sw1 = bit 1, sw0 = bit 0
//      * 0xfffa = output port to the 7 segment display
//
// Program 2:
//
// L0:  ADDI  X3,XZR,0xfff0    # X3 = 0xfff, I/0 ports
//      LD    X5,[X3,#0]       # X5 = input switch value
//      ANDI  X5,X5,#1         # Mask all bits except 0 (sw0)
//      CBZ   X5,Disp0         # if bit = 0 then 
//                             #   X4 = pattern "0"
//                             # else X4 = pattern "2"
//      ADDI  X4,XZR,#1101101  # X4 = bit pattern "2"
//      CBZ   XZR,Skip       
// Disp0:
//      ADDI  X4,XZR,#1111110  # X4 = bit pattern "0"
// Skip:
//      ST    X4,[X3,#10]      # 7-segment display = bit pattern
//      CBZ   XZR,L0           # repeat loop
//

module IM2(
     output logic [15:0] idata,
     input logic [15:0] iaddr
     );

always_comb
  case(iaddr[5:1])

// L0:
	0: idata={4'd8,6'b110000,3'd7,3'd3}; //ADDI X3,XZR,#0xfff0 
	1: idata={4'd5,6'd0,3'd3,3'd5};      //LD   X5,[X3,#0] 
	2: idata={4'd9,6'd1,3'd5,3'd5};      //ANDI X5,X5,#1   
	3: idata={4'd7,6'd3,3'd5,3'd0};      //CBZ  X5,Disp0
	4: idata={4'd8,6'b101101,3'd7,3'd4}; //ADDI X4,XZR,#1101101
	5: idata={4'd7,6'd2,3'd7,3'd0};      //CBZ  XZR,Skip
// Disp0:
	6: idata={4'd8,6'b111110,3'd7,3'd4}; //ADDI X4,XZR,#1111110 
// Skip:
	7: idata={4'd6,6'd10,3'd3,3'd4};     //ST  X4,[X3,#10]
	8: idata={4'd7,6'b111000,3'd7,3'd0}; //CBZ XZR,L0
    default: idata=0;
  endcase
  
endmodule