`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2018 01:22:40 AM
// Design Name: 
// Module Name: IM1V
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

// Program or Instuction Memory -- IM1.V
// Multiplies 3 by 5 and the product is in X4
//
// L0:    X2 = 3,   this serves as a counter
//        X4 = 0,   this stores the partial product
// L1:    if X2 == 0 then goto L0
//        X4 = X4 + 5
//        X2 = X2 - 1
//        goto L1
//
module IM(
     output logic [15:0] idata,
     input logic [15:0] iaddr
     );

always_comb
  case(iaddr[3:1])
     0: idata={4'd8, 6'd3, 3'd7, 3'd2};      //L0: ADDI  X2,XZR,#3  //address is at 63
     1: idata={4'd0, 3'd7,3'd0,3'd7,3'd4};   //    ADD   X4,XZR,XZR //address is at 62
     2: idata={4'd7, 6'b111110,3'd2,3'd0};   //L1: CBZ   X2,L0      //address is at 61
     3: idata={4'd8, 6'd5, 3'd4,3'd4};       //    ADDI  X4,X4,#5   //address is at 60
     4: idata={4'd8, 6'b111111,3'd2,3'd2};   //    ADDI  X2,X2,#-1  //address is at 59
     5: idata={4'd7, 6'b111101,3'd7,3'd0};   //    CBZ   XZR,L1     //address is at 58
     default: idata=0;
  endcase

endmodule
