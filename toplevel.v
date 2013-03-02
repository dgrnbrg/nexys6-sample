`timescale 1ns / 1ps
module toplevel(
		clock,
		sw,
		led,
		seven_seg_cathode,
		seven_seg_anode,
		vgaRed,
		vgaGreen,
		vgaBlue,
		Hsync,
		Vsync
	       );

//inputs
input wire [7:0] sw;
input wire clock;

//outputs
output  [7:0] led;
output  [7:0] seven_seg_cathode;
output  [3:0] seven_seg_anode;
output  [2:0] vgaRed;
output  [2:0] vgaGreen;
output  [1:0] vgaBlue;
output   Hsync;
output   Vsync;

wire clock_65mhz;

	clk_wiz_v3_6 clkgenerator(
			.CLK_IN1(clock),
			.CLK_OUT1(),
			.CLK_OUT2(clock_65mhz)
			);

	piplin_project piplin_code(
			.clock(clock_65mhz),
			.sw(sw),
			.led(led),
			.seven_seg_cathode(seven_seg_cathode),
			.seven_seg_anode(seven_seg_anode),
			.vgaRed(vgaRed),
			.vgaGreen(vgaGreen),
			.vgaBlue(vgaBlue),
			.Hsync(Hsync),
			.Vsync(Vsync),
			.reset(1'b0)
			);

endmodule
