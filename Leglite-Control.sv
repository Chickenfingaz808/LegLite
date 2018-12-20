`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2018 01:01:02 AM
// Design Name: 
// Module Name: Leglite-Control
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


// EE 361
// LEGLite 
// 
// The control module for LEGLite
//   The control will input the opcode value (3 bits)
//   then determine what the control signals should be
//   in the datapath
// 
//---------------------------------------------------------------
module Control(
     output logic reg2loc,
     output logic uncondbranch,
     output logic branch,
     output logic memread,
     output logic memtoreg,
     output logic [2:0] alu_select,
     output logic memwrite,
     output logic alusrc,
     output logic regwrite,
     input logic [3:0] opcode
     );


always_comb
	case(opcode)
	0:	// ADD
		begin
		reg2loc = 0;
		uncondbranch = 0;
		branch = 0;   
		memread = 0;  
		memtoreg = 0;
		alu_select = 0; // Have ALU do an ADD
		memwrite = 0; 
		alusrc = 0; 
		regwrite = 1;
		end
	5:    //Load
	    begin
	    reg2loc = 0;
        uncondbranch = 0;
        branch = 0;   
        memread = 1;  
        memtoreg = 1;
        alu_select = 0; 
        memwrite = 0; 
        alusrc = 1; 
        regwrite = 1;
        end
     6:    //Store
        begin
        reg2loc = 1;
        uncondbranch = 0;
        branch = 0;   
        memread = 0;  
        memtoreg = 1;
        alu_select = 0; 
        memwrite = 1; 
        alusrc = 1; 
        regwrite = 0;
        end
    7:    //CBZ
        begin
        reg2loc = 1;
        uncondbranch = 0;
        branch = 1;   
        memread = 0;  
        memtoreg = 0;
        alu_select = 2; 
        memwrite = 0; 
        alusrc = 0; 
        regwrite = 0;
        end
    8:    //ADDI
        begin
        reg2loc = 0;
        uncondbranch = 0;
        branch = 0;   
        memread = 0;  
        memtoreg = 0;
        alu_select = 0; 
        memwrite = 0; 
        alusrc = 1; 
        regwrite = 1;
        end
    9:    //ANDI
        begin
        reg2loc = 0;
        uncondbranch = 0;
        branch = 0;   
        memread = 0;  
        memtoreg = 0;
        alu_select = 4; 
        memwrite = 0; 
        alusrc = 1; 
        regwrite = 1;
        end          
	default:
		begin
		reg2loc = 0;
		uncondbranch = 0;
		branch = 0;   
		memread = 0;   
		memtoreg = 0;  
		alu_select = 0; 
		memwrite = 0; 
		alusrc = 0;    
		regwrite = 0;
		end
	endcase

endmodule





