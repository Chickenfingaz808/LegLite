`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 11:09:42 AM
// Design Name: 
// Module Name: LegLiteSingle
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
// LEGLite Single Cycle
// 
// Obviously, it's incomplete.  Just the ports are defined.
//

module LEGLiteSingle(
	iaddr,		// Program memory address.                   //Result of PC logic
	daddr,		// Data memory address                       //input 1 of dmemory
	dwrite,		// Data memory write enable                  //input 2 of dmemory
	dread,		// Data memory read enable                   //input 3 of dmemory
	dwdata,		// Data memory write output                  //input 4 of dmemory
	alu_out,	// Output of alu for debugging purposes      //output of ALU
	clock,
	idata,		// Program memory output, which is the current instruction    
	ddata,		// Data memory output                        //output 1 of dmemory
	reset
	);

output [15:0] iaddr;
output [15:0] daddr;	
output dwrite;
output dread;
output [15:0] dwdata;
output [15:0] alu_out;
input clock;
input [15:0] idata; // Instructions 
input [15:0] ddata;	
input reset;

//Control Wires
wire reg2loc, uncondbranch, branch, memread, memtoreg, memwrite, alusrc, regwrite;
wire [2:0] aluSelect;

//Zero result for ALU, required for branch condition
wire alu_zero;

wire [15:0] signExtend; 
assign signExtend = {{10{idata[11]}}, idata[11:6]};	
	 
//Result from the ALU
wire [15:0] aluresult;

//Needed for Reg File
wire [15:0] rdata1, rdata2, wdata;

//Results from each Mux
wire [15:0] dmemMuxresult, aluMuxresult;
wire [2:0] regMuxresult;

PCLogic pc(iaddr, clock, signExtend, uncondbranch, branch, alu_zero, reset);

MUX3 regMux(regMuxresult,idata[11:9], idata[2:0], reg2loc);

Control cUnit(reg2loc, uncondbranch, branch,memread, memtoreg, aluSelect[2:0], memwrite, alusrc, regwrite, idata[15:12]);

RegFile reg1(rdata1[15:0], rdata2[15:0], clock, dmemMuxresult, idata[2:0], idata[5:3], regMuxresult, regwrite);

MUX2 aluMux(aluMuxresult, rdata2, signExtend, alusrc);

ALU alu1(aluresult, alu_zero, aluMuxresult, rdata1, aluSelect);

MUX2 dmem(dmemMuxresult, aluresult, ddata, memtoreg);

//Uses result from alu, daddr is data memory address
assign daddr = aluresult;     

//alu_out is just for debugging
assign alu_out = aluresult;  

//Must be updated to be in use for Dmemory_IO module
assign dwrite = memwrite; 
assign dread = memread;
assign dwdata = rdata2;
assign wdata = dmemMuxresult;

endmodule

