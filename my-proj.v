/////////////////////////////////////////
//
//
// NOTE: This file will be overwritten with the generated verilog from your Piplin project!
//
//
/////////////////////////////////////////

module piplin_project(
  clock,
  reset,
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
  input wire clock;
  input wire reset;
  wire [15:0] deco_in;
  wire [27:0] deco_out;
  module49 deco(
    .clock(clock), .reset(reset),
    .in(deco_in),
    .out(deco_out)
  );

  wire [10:0] vga_hcount;
  wire [9:0] vga_vcount;
  wire  vga_hsync;
  wire  vga_vsync;
  wire  vga_blank;
  xvga__ vga(
    .clock(clock), .reset(reset),
    .hcount(vga_hcount),
    .vcount(vga_vcount),
    .hsync(vga_hsync),
    .vsync(vga_vsync),
    .blank(vga_blank)
  );

  wire [13:0] cpu_memaddr;
  wire  cpu_memdata;
  wire [7:0] cpu_pc;
  wire [15:0] cpu_fp_accum;
  simplecpu__ cpu(
    .clock(clock), .reset(reset),
    .memaddr(cpu_memaddr),
    .memdata(cpu_memdata),
    .pc(cpu_pc),
    .fp_accum(cpu_fp_accum)
  );

  //inputs
  input wire [7:0] sw;

  //outputs
  output reg [7:0] led;
  output reg [7:0] seven_seg_cathode;
  output reg [3:0] seven_seg_anode;
  output reg [2:0] vgaRed;
  output reg [2:0] vgaGreen;
  output reg [1:0] vgaBlue;
  output reg  Hsync;
  output reg  Vsync;

  //feedback
  reg [23:0] timer;
  reg [15:0] counter;
  reg [13:0] faster_counter;
  reg [13:0] buffer_index;
  reg  video_buffer [16383:0];


  wire [15:0] G__39281 = {2'b00, cpu_memaddr};
  wire [10:0] G__39282 = vga_hcount;
  wire [6:0] G__39283 = G__39282[7:1];
  wire [9:0] G__39284 = vga_vcount;
  wire [6:0] G__39285 = G__39284[7:1];
  wire [13:0] G__39286 = {G__39285, G__39283};
  wire [13:0] G__39287 = {G__39285, G__39283};
  wire  G__39288 = video_buffer[G__39287];
  wire  G__39289 = vga_vcount == 10'd767;
  wire  G__39290 = vga_vcount == 10'd0;
  wire  G__39291 = vga_hcount == 11'd1023;
  wire  G__39292 = vga_hcount == 11'd0;
  wire  G__39293 = G__39292 | G__39291;
  wire  G__39294 = G__39293 | G__39290;
  wire  G__39295 = G__39294 | G__39289;
  wire  G__39296 = G__39295 ? 1'b1 : 1'b0;
  wire [1:0] G__39297 = sw[1:0];
  wire  G__39298 = 2'b01 == G__39297;
  wire  G__39299 = G__39298 ? G__39296 : G__39288;
  wire  G__39300 = G__39282[8:8];
  wire  G__39301 = 2'b00 == G__39297;
  wire  G__39302 = G__39301 ? G__39300 : G__39299;
  wire [1:0] G__39303 = {G__39302, G__39302};
  wire [2:0] G__39304 = {G__39303, G__39302};
  wire  G__39305 = G__39282[7:7];
  wire  G__39306 = G__39301 ? G__39305 : G__39299;
  wire [1:0] G__39307 = {G__39306, G__39306};
  wire [2:0] G__39308 = {G__39307, G__39306};
  wire  G__39309 = G__39282[6:6];
  wire  G__39310 = G__39301 ? G__39309 : G__39299;
  wire [1:0] G__39311 = {G__39310, G__39310};
  wire [23:0] G__39312 = timer + 24'd1;
  wire [15:0] G__39313 = counter + 16'd1;
  wire  G__39314 = 24'd0 == timer;
  wire [15:0] G__39315 = G__39314 ? G__39313 : counter;
  wire [13:0] G__39316 = faster_counter + 14'd1;
  wire [23:0] G__39317 = timer;
  wire [1:0] G__39318 = G__39317[11:10];
  wire  G__39319 = 2'b10 == G__39318;
  wire [3:0] G__39320 = G__39319 ? 4'b1011 : 4'b0111;
  wire  G__39321 = 2'b01 == G__39318;
  wire [3:0] G__39322 = G__39321 ? 4'b1101 : G__39320;
  wire  G__39323 = 2'b00 == G__39318;
  wire [3:0] G__39324 = G__39323 ? 4'b1110 : G__39322;
  wire [6:0] G__39325 = deco_out[27:21];
  wire [6:0] G__39326 = deco_out[20:14];
  wire [6:0] G__39327 = G__39319 ? G__39326 : G__39325;
  wire [6:0] G__39328 = deco_out[13:7];
  wire [6:0] G__39329 = G__39321 ? G__39328 : G__39327;
  wire [6:0] G__39330 = deco_out[6:0];
  wire [6:0] G__39331 = G__39323 ? G__39330 : G__39329;
  wire [6:0] G__39332 = ~G__39331;
  wire [7:0] G__39333 = {1'b1, G__39332};


  always @(posedge clock)
    if (reset) begin
      seven_seg_anode <= 4'b0000;
      vgaGreen <= 3'b000;
      timer <= 24'd1;
      led <= 8'b00000000;
      Hsync <= 1'b0;
      seven_seg_cathode <= 8'b00000000;
      faster_counter <= 14'd0;
      buffer_index <= 14'd0;
      vgaRed <= 3'b000;
      vgaBlue <= 2'b00;
      counter <= 16'd0;
      Vsync <= 1'b0;
    end else begin
      Hsync <= vga_hsync;
      Vsync <= vga_vsync;
      video_buffer[cpu_memaddr] <= 1'b1;
      vgaRed <= G__39304;
      vgaGreen <= G__39308;
      vgaBlue <= G__39311;
      led <= sw;
      timer <= G__39312;
      counter <= G__39315;
      faster_counter <= G__39316;
      seven_seg_anode <= G__39324;
      seven_seg_cathode <= G__39333;
    end

  assign deco_in = G__39281;
endmodule

module module49(
  clock,
  reset,
  in,
  out
);
  input wire clock;
  input wire reset;

  //inputs
  input wire [15:0] in;

  //outputs
  output reg [27:0] out;


  wire [15:0] G__39334 = in;
  wire [3:0] G__39335 = G__39334[3:0];
  wire  G__39336 = 4'b1110 == G__39335;
  wire [6:0] G__39337 = G__39336 ? 7'b1111001 : 7'b1110001;
  wire  G__39338 = 4'b1101 == G__39335;
  wire [6:0] G__39339 = G__39338 ? 7'b1011110 : G__39337;
  wire  G__39340 = 4'b1100 == G__39335;
  wire [6:0] G__39341 = G__39340 ? 7'b0111001 : G__39339;
  wire  G__39342 = 4'b1011 == G__39335;
  wire [6:0] G__39343 = G__39342 ? 7'b1111100 : G__39341;
  wire  G__39344 = 4'b1010 == G__39335;
  wire [6:0] G__39345 = G__39344 ? 7'b1110111 : G__39343;
  wire  G__39346 = 4'b1001 == G__39335;
  wire [6:0] G__39347 = G__39346 ? 7'b1100111 : G__39345;
  wire  G__39348 = 4'b1000 == G__39335;
  wire [6:0] G__39349 = G__39348 ? 7'b1111111 : G__39347;
  wire  G__39350 = 4'b0111 == G__39335;
  wire [6:0] G__39351 = G__39350 ? 7'b0000111 : G__39349;
  wire  G__39352 = 4'b0110 == G__39335;
  wire [6:0] G__39353 = G__39352 ? 7'b1111101 : G__39351;
  wire  G__39354 = 4'b0101 == G__39335;
  wire [6:0] G__39355 = G__39354 ? 7'b1101101 : G__39353;
  wire  G__39356 = 4'b0100 == G__39335;
  wire [6:0] G__39357 = G__39356 ? 7'b1100110 : G__39355;
  wire  G__39358 = 4'b0011 == G__39335;
  wire [6:0] G__39359 = G__39358 ? 7'b1001111 : G__39357;
  wire  G__39360 = 4'b0010 == G__39335;
  wire [6:0] G__39361 = G__39360 ? 7'b1011011 : G__39359;
  wire  G__39362 = 4'b0001 == G__39335;
  wire [6:0] G__39363 = G__39362 ? 7'b0000110 : G__39361;
  wire  G__39364 = 4'b0000 == G__39335;
  wire [6:0] G__39365 = G__39364 ? 7'b0111111 : G__39363;
  wire [3:0] G__39366 = G__39334[7:4];
  wire  G__39367 = 4'b1110 == G__39366;
  wire [6:0] G__39368 = G__39367 ? 7'b1111001 : 7'b1110001;
  wire  G__39369 = 4'b1101 == G__39366;
  wire [6:0] G__39370 = G__39369 ? 7'b1011110 : G__39368;
  wire  G__39371 = 4'b1100 == G__39366;
  wire [6:0] G__39372 = G__39371 ? 7'b0111001 : G__39370;
  wire  G__39373 = 4'b1011 == G__39366;
  wire [6:0] G__39374 = G__39373 ? 7'b1111100 : G__39372;
  wire  G__39375 = 4'b1010 == G__39366;
  wire [6:0] G__39376 = G__39375 ? 7'b1110111 : G__39374;
  wire  G__39377 = 4'b1001 == G__39366;
  wire [6:0] G__39378 = G__39377 ? 7'b1100111 : G__39376;
  wire  G__39379 = 4'b1000 == G__39366;
  wire [6:0] G__39380 = G__39379 ? 7'b1111111 : G__39378;
  wire  G__39381 = 4'b0111 == G__39366;
  wire [6:0] G__39382 = G__39381 ? 7'b0000111 : G__39380;
  wire  G__39383 = 4'b0110 == G__39366;
  wire [6:0] G__39384 = G__39383 ? 7'b1111101 : G__39382;
  wire  G__39385 = 4'b0101 == G__39366;
  wire [6:0] G__39386 = G__39385 ? 7'b1101101 : G__39384;
  wire  G__39387 = 4'b0100 == G__39366;
  wire [6:0] G__39388 = G__39387 ? 7'b1100110 : G__39386;
  wire  G__39389 = 4'b0011 == G__39366;
  wire [6:0] G__39390 = G__39389 ? 7'b1001111 : G__39388;
  wire  G__39391 = 4'b0010 == G__39366;
  wire [6:0] G__39392 = G__39391 ? 7'b1011011 : G__39390;
  wire  G__39393 = 4'b0001 == G__39366;
  wire [6:0] G__39394 = G__39393 ? 7'b0000110 : G__39392;
  wire  G__39395 = 4'b0000 == G__39366;
  wire [6:0] G__39396 = G__39395 ? 7'b0111111 : G__39394;
  wire [3:0] G__39397 = G__39334[11:8];
  wire  G__39398 = 4'b1110 == G__39397;
  wire [6:0] G__39399 = G__39398 ? 7'b1111001 : 7'b1110001;
  wire  G__39400 = 4'b1101 == G__39397;
  wire [6:0] G__39401 = G__39400 ? 7'b1011110 : G__39399;
  wire  G__39402 = 4'b1100 == G__39397;
  wire [6:0] G__39403 = G__39402 ? 7'b0111001 : G__39401;
  wire  G__39404 = 4'b1011 == G__39397;
  wire [6:0] G__39405 = G__39404 ? 7'b1111100 : G__39403;
  wire  G__39406 = 4'b1010 == G__39397;
  wire [6:0] G__39407 = G__39406 ? 7'b1110111 : G__39405;
  wire  G__39408 = 4'b1001 == G__39397;
  wire [6:0] G__39409 = G__39408 ? 7'b1100111 : G__39407;
  wire  G__39410 = 4'b1000 == G__39397;
  wire [6:0] G__39411 = G__39410 ? 7'b1111111 : G__39409;
  wire  G__39412 = 4'b0111 == G__39397;
  wire [6:0] G__39413 = G__39412 ? 7'b0000111 : G__39411;
  wire  G__39414 = 4'b0110 == G__39397;
  wire [6:0] G__39415 = G__39414 ? 7'b1111101 : G__39413;
  wire  G__39416 = 4'b0101 == G__39397;
  wire [6:0] G__39417 = G__39416 ? 7'b1101101 : G__39415;
  wire  G__39418 = 4'b0100 == G__39397;
  wire [6:0] G__39419 = G__39418 ? 7'b1100110 : G__39417;
  wire  G__39420 = 4'b0011 == G__39397;
  wire [6:0] G__39421 = G__39420 ? 7'b1001111 : G__39419;
  wire  G__39422 = 4'b0010 == G__39397;
  wire [6:0] G__39423 = G__39422 ? 7'b1011011 : G__39421;
  wire  G__39424 = 4'b0001 == G__39397;
  wire [6:0] G__39425 = G__39424 ? 7'b0000110 : G__39423;
  wire  G__39426 = 4'b0000 == G__39397;
  wire [6:0] G__39427 = G__39426 ? 7'b0111111 : G__39425;
  wire [3:0] G__39428 = G__39334[15:12];
  wire  G__39429 = 4'b1110 == G__39428;
  wire [6:0] G__39430 = G__39429 ? 7'b1111001 : 7'b1110001;
  wire  G__39431 = 4'b1101 == G__39428;
  wire [6:0] G__39432 = G__39431 ? 7'b1011110 : G__39430;
  wire  G__39433 = 4'b1100 == G__39428;
  wire [6:0] G__39434 = G__39433 ? 7'b0111001 : G__39432;
  wire  G__39435 = 4'b1011 == G__39428;
  wire [6:0] G__39436 = G__39435 ? 7'b1111100 : G__39434;
  wire  G__39437 = 4'b1010 == G__39428;
  wire [6:0] G__39438 = G__39437 ? 7'b1110111 : G__39436;
  wire  G__39439 = 4'b1001 == G__39428;
  wire [6:0] G__39440 = G__39439 ? 7'b1100111 : G__39438;
  wire  G__39441 = 4'b1000 == G__39428;
  wire [6:0] G__39442 = G__39441 ? 7'b1111111 : G__39440;
  wire  G__39443 = 4'b0111 == G__39428;
  wire [6:0] G__39444 = G__39443 ? 7'b0000111 : G__39442;
  wire  G__39445 = 4'b0110 == G__39428;
  wire [6:0] G__39446 = G__39445 ? 7'b1111101 : G__39444;
  wire  G__39447 = 4'b0101 == G__39428;
  wire [6:0] G__39448 = G__39447 ? 7'b1101101 : G__39446;
  wire  G__39449 = 4'b0100 == G__39428;
  wire [6:0] G__39450 = G__39449 ? 7'b1100110 : G__39448;
  wire  G__39451 = 4'b0011 == G__39428;
  wire [6:0] G__39452 = G__39451 ? 7'b1001111 : G__39450;
  wire  G__39453 = 4'b0010 == G__39428;
  wire [6:0] G__39454 = G__39453 ? 7'b1011011 : G__39452;
  wire  G__39455 = 4'b0001 == G__39428;
  wire [6:0] G__39456 = G__39455 ? 7'b0000110 : G__39454;
  wire  G__39457 = 4'b0000 == G__39428;
  wire [6:0] G__39458 = G__39457 ? 7'b0111111 : G__39456;
  wire [13:0] G__39459 = {G__39458, G__39427};
  wire [20:0] G__39460 = {G__39459, G__39396};
  wire [27:0] G__39461 = {G__39460, G__39365};


  always @(posedge clock)
    if (reset) begin
      out <= 28'b0000000000000000000000000000;
    end else begin
      out <= G__39461;
    end

endmodule

module xvga__(
  clock,
  reset,
  hcount,
  vcount,
  hsync,
  vsync,
  blank
);
  input wire clock;
  input wire reset;

  //outputs
  output reg [10:0] hcount;
  output reg [9:0] vcount;
  output reg  hsync;
  output reg  vsync;
  output reg  blank;

  //feedback
  reg  hblank;
  reg  vblank;


  wire [10:0] G__39462 = hcount + 11'd1;
  wire  G__39463 = hcount == 11'd1343;
  wire [10:0] G__39464 = G__39463 ? 11'd0 : G__39462;
  wire  G__39465 = hcount == 11'd1023;
  wire  G__39466 = G__39465 ? 1'b1 : hblank;
  wire  G__39467 = G__39463 ? 1'b0 : G__39466;
  wire  G__39468 = hcount == 11'd1183;
  wire  G__39469 = G__39468 ? 1'b1 : hsync;
  wire  G__39470 = hcount == 11'd1047;
  wire  G__39471 = G__39470 ? 1'b0 : G__39469;
  wire [9:0] G__39472 = vcount + 10'd1;
  wire  G__39473 = vcount == 10'd805;
  wire  G__39474 = G__39463 & G__39473;
  wire [9:0] G__39475 = G__39474 ? 10'd0 : G__39472;
  wire  G__39476 = ~G__39463;
  wire [9:0] G__39477 = G__39476 ? vcount : G__39475;
  wire  G__39478 = vcount == 10'd767;
  wire  G__39479 = G__39463 & G__39478;
  wire  G__39480 = G__39479 ? 1'b1 : vblank;
  wire  G__39481 = G__39474 ? 1'b0 : G__39480;
  wire  G__39482 = vcount == 10'd782;
  wire  G__39483 = G__39463 & G__39482;
  wire  G__39484 = G__39483 ? 1'b1 : vsync;
  wire  G__39485 = vcount == 10'd776;
  wire  G__39486 = G__39463 & G__39485;
  wire  G__39487 = G__39486 ? 1'b0 : G__39484;
  wire  G__39488 = G__39467 & G__39476;
  wire  G__39489 = G__39481 | G__39488;


  always @(posedge clock)
    if (reset) begin
      vblank <= 1'b0;
      hblank <= 1'b0;
      hcount <= 11'd0;
      vcount <= 10'd0;
      hsync <= 1'b0;
      vsync <= 1'b0;
      blank <= 1'b0;
    end else begin
      hcount <= G__39464;
      hblank <= G__39467;
      hsync <= G__39471;
      vcount <= G__39477;
      vblank <= G__39481;
      vsync <= G__39487;
      blank <= G__39489;
    end

endmodule

module simplecpu__(
  clock,
  reset,
  memaddr,
  memdata,
  pc,
  fp_accum
);
  input wire clock;
  input wire reset;

  //outputs
  output reg [13:0] memaddr;
  output reg  memdata;
  output reg [7:0] pc;
  output reg [15:0] fp_accum;

  //feedback
  reg [15:0] fp_regs [7:0];


  wire [7:0] G__39490 = pc + 8'd1;
  wire  G__39491 = 8'd15 == pc;
  wire [22:0] G__39492 = G__39491 ? {4'b0001, 11'b0, 8'd5} : {4'b0101, 18'b0, 1'b0};
  wire  G__39493 = 8'd14 == pc;
  wire [22:0] G__39494 = G__39493 ? {4'b0110, 16'b0, 3'd4} : G__39492;
  wire  G__39495 = 8'd13 == pc;
  wire [22:0] G__39496 = G__39495 ? {4'b1000, 16'b0, 3'd5} : G__39494;
  wire  G__39497 = 8'd12 == pc;
  wire [22:0] G__39498 = G__39497 ? {4'b0111, 16'b0, 3'd4} : G__39496;
  wire  G__39499 = 8'd11 == pc;
  wire [22:0] G__39500 = G__39499 ? {4'b0110, 16'b0, 3'd2} : G__39498;
  wire  G__39501 = 8'd10 == pc;
  wire [22:0] G__39502 = G__39501 ? {4'b1000, 16'b0, 3'd3} : G__39500;
  wire  G__39503 = 8'd9 == pc;
  wire [22:0] G__39504 = G__39503 ? {4'b0111, 16'b0, 3'd2} : G__39502;
  wire  G__39505 = 8'd8 == pc;
  wire [22:0] G__39506 = G__39505 ? {4'b0110, 16'b0, 3'd1} : G__39504;
  wire  G__39507 = 8'd7 == pc;
  wire [22:0] G__39508 = G__39507 ? {4'b1000, 16'b0, 3'd2} : G__39506;
  wire  G__39509 = 8'd6 == pc;
  wire [22:0] G__39510 = G__39509 ? {4'b0111, 16'b0, 3'd1} : G__39508;
  wire  G__39511 = 8'd5 == pc;
  wire [22:0] G__39512 = G__39511 ? {4'b0100, 13'b0, 6'b001100} : G__39510;
  wire  G__39513 = 8'd4 == pc;
  wire [22:0] G__39514 = G__39513 ? {4'b0010, 19'b0000000001010001101} : G__39512;
  wire  G__39515 = 8'd3 == pc;
  wire [22:0] G__39516 = G__39515 ? {4'b0010, 19'b1010000000000000100} : G__39514;
  wire  G__39517 = 8'd2 == pc;
  wire [22:0] G__39518 = G__39517 ? {4'b0010, 19'b1111111101011101011} : G__39516;
  wire  G__39519 = 8'd1 == pc;
  wire [22:0] G__39520 = G__39519 ? {4'b0010, 19'b0000010011001100010} : G__39518;
  wire  G__39521 = 8'd0 == pc;
  wire [22:0] G__39522 = G__39521 ? {4'b0010, 19'b1010000000000000001} : G__39520;
  wire [7:0] G__39523 = G__39522[7:0];
  wire [3:0] G__39524 = G__39522[22:19];
  wire  G__39525 = 4'b0001 == G__39524;
  wire [7:0] G__39526 = G__39525 ? G__39523 : G__39490;
  wire [2:0] G__39527 = G__39522[2:0];
  wire [15:0] G__39528 = fp_regs[G__39527];
  wire  G__39529 = 4'b0111 == G__39524;
  wire [15:0] G__39530 = G__39529 ? G__39528 : fp_accum;
  wire [15:0] G__39532 = fp_regs[G__39527];
  wire [15:0] G__39533 = fp_regs[G__39527];
  wire [28:0] rhs_sints39534 = { {13{G__39533[15]}}, G__39533};
  wire [15:0] G__39535 = fp_accum;
  wire [15:0] G__39536 = fp_accum;
  wire [28:0] lhs_sints39537 = { {13{G__39536[15]}}, G__39536};
  wire [28:0] lhs39539 = lhs_sints39537;
  wire [28:0] rhs39540 = rhs_sints39534;
  wire  zero39553 = lhs39539 == 29'd0 || rhs39540 == 29'd0;
  wire [28:0] prod39541 = lhs39539 * rhs39540;
  wire  lhs_pos39542 = ~lhs39539[28];
  wire  rhs_pos39543 = ~rhs39540[28];
  wire [4:0] lhs_leading_zeros39544 = ~|lhs39539[28:0] ? 29 : ~|lhs39539[28:1] ? 28 : ~|lhs39539[28:2] ? 27 : ~|lhs39539[28:3] ? 26 : ~|lhs39539[28:4] ? 25 : ~|lhs39539[28:5] ? 24 : ~|lhs39539[28:6] ? 23 : ~|lhs39539[28:7] ? 22 : ~|lhs39539[28:8] ? 21 : ~|lhs39539[28:9] ? 20 : ~|lhs39539[28:10] ? 19 : ~|lhs39539[28:11] ? 18 : ~|lhs39539[28:12] ? 17 : ~|lhs39539[28:13] ? 16 : ~|lhs39539[28:14] ? 15 : ~|lhs39539[28:15] ? 14 : ~|lhs39539[28:16] ? 13 : ~|lhs39539[28:17] ? 12 : ~|lhs39539[28:18] ? 11 : ~|lhs39539[28:19] ? 10 : ~|lhs39539[28:20] ? 9 : ~|lhs39539[28:21] ? 8 : ~|lhs39539[28:22] ? 7 : ~|lhs39539[28:23] ? 6 : ~|lhs39539[28:24] ? 5 : ~|lhs39539[28:25] ? 4 : ~|lhs39539[28:26] ? 3 : ~|lhs39539[28:27] ? 2 : 1;
  wire [4:0] lhs_leading_ones39546 = &lhs39539[28:0] ? 29 : &lhs39539[28:1] ? 28 : &lhs39539[28:2] ? 27 : &lhs39539[28:3] ? 26 : &lhs39539[28:4] ? 25 : &lhs39539[28:5] ? 24 : &lhs39539[28:6] ? 23 : &lhs39539[28:7] ? 22 : &lhs39539[28:8] ? 21 : &lhs39539[28:9] ? 20 : &lhs39539[28:10] ? 19 : &lhs39539[28:11] ? 18 : &lhs39539[28:12] ? 17 : &lhs39539[28:13] ? 16 : &lhs39539[28:14] ? 15 : &lhs39539[28:15] ? 14 : &lhs39539[28:16] ? 13 : &lhs39539[28:17] ? 12 : &lhs39539[28:18] ? 11 : &lhs39539[28:19] ? 10 : &lhs39539[28:20] ? 9 : &lhs39539[28:21] ? 8 : &lhs39539[28:22] ? 7 : &lhs39539[28:23] ? 6 : &lhs39539[28:24] ? 5 : &lhs39539[28:25] ? 4 : &lhs39539[28:26] ? 3 : &lhs39539[28:27] ? 2 : 1;
  wire [4:0] rhs_leading_zeros39545 = ~|rhs39540[28:0] ? 29 : ~|rhs39540[28:1] ? 28 : ~|rhs39540[28:2] ? 27 : ~|rhs39540[28:3] ? 26 : ~|rhs39540[28:4] ? 25 : ~|rhs39540[28:5] ? 24 : ~|rhs39540[28:6] ? 23 : ~|rhs39540[28:7] ? 22 : ~|rhs39540[28:8] ? 21 : ~|rhs39540[28:9] ? 20 : ~|rhs39540[28:10] ? 19 : ~|rhs39540[28:11] ? 18 : ~|rhs39540[28:12] ? 17 : ~|rhs39540[28:13] ? 16 : ~|rhs39540[28:14] ? 15 : ~|rhs39540[28:15] ? 14 : ~|rhs39540[28:16] ? 13 : ~|rhs39540[28:17] ? 12 : ~|rhs39540[28:18] ? 11 : ~|rhs39540[28:19] ? 10 : ~|rhs39540[28:20] ? 9 : ~|rhs39540[28:21] ? 8 : ~|rhs39540[28:22] ? 7 : ~|rhs39540[28:23] ? 6 : ~|rhs39540[28:24] ? 5 : ~|rhs39540[28:25] ? 4 : ~|rhs39540[28:26] ? 3 : ~|rhs39540[28:27] ? 2 : 1;
  wire [4:0] rhs_leading_ones39547 = &rhs39540[28:0] ? 29 : &rhs39540[28:1] ? 28 : &rhs39540[28:2] ? 27 : &rhs39540[28:3] ? 26 : &rhs39540[28:4] ? 25 : &rhs39540[28:5] ? 24 : &rhs39540[28:6] ? 23 : &rhs39540[28:7] ? 22 : &rhs39540[28:8] ? 21 : &rhs39540[28:9] ? 20 : &rhs39540[28:10] ? 19 : &rhs39540[28:11] ? 18 : &rhs39540[28:12] ? 17 : &rhs39540[28:13] ? 16 : &rhs39540[28:14] ? 15 : &rhs39540[28:15] ? 14 : &rhs39540[28:16] ? 13 : &rhs39540[28:17] ? 12 : &rhs39540[28:18] ? 11 : &rhs39540[28:19] ? 10 : &rhs39540[28:20] ? 9 : &rhs39540[28:21] ? 8 : &rhs39540[28:22] ? 7 : &rhs39540[28:23] ? 6 : &rhs39540[28:24] ? 5 : &rhs39540[28:25] ? 4 : &rhs39540[28:26] ? 3 : &rhs39540[28:27] ? 2 : 1;
  wire  pos_pos_ovf39548 = (lhs_leading_zeros39544 + rhs_leading_zeros39545 < 29) | ((lhs_leading_zeros39544 + rhs_leading_zeros39545 == 29) & prod39541[28]);
  wire  neg_neg_ovf39549 = (lhs_leading_ones39546 + rhs_leading_ones39547 < 29) | ((lhs_leading_ones39546 + rhs_leading_ones39547 == 29 || lhs_leading_ones39546 + rhs_leading_ones39547 == 30) & (prod39541[28] || prod39541 == 29'b00000000000000000000000000000));
  wire [4:0] neg_leading39550 = ~lhs_pos39542 ? lhs_leading_ones39546 : rhs_leading_ones39547;
  wire [4:0] pos_leading39551 = ~lhs_pos39542 ? rhs_leading_zeros39545 : lhs_leading_zeros39544;
  wire  neg_pos_ovf39552 = (neg_leading39550 + pos_leading39551 < 29) | ~prod39541[28];
  wire [28:0] sints__STAR_39538 = zero39553 ? 29'd0 : ((lhs_pos39542 & rhs_pos39543 & pos_pos_ovf39548) | (~lhs_pos39542 & ~rhs_pos39543 & neg_neg_ovf39549)) ? 29'd268435455 : ((lhs_pos39542 ^ rhs_pos39543) & neg_pos_ovf39552) ? -29'd268435456 : prod39541;
  wire [28:0] full_result39554 = sints__STAR_39538;
  wire [15:0] G__39531 = full_result39554[28:13];
  wire  G__39555 = 4'b0011 == G__39524;
  wire [15:0] G__39556 = G__39555 ? G__39531 : G__39530;
  wire [15:0] G__39558 = fp_regs[G__39527];
  wire [16:0] G__39559 = { {1{G__39528[15]}}, G__39528};
  wire [16:0] G__39560 = { {1{G__39528[15]}}, G__39528};
  wire [16:0] G__39561 = ~G__39560;
  wire [16:0] G__39562 = ~G__39560;
  wire [16:0] G__39563 = G__39562 + 17'd1;
  wire [16:0] G__39564 = G__39562 + 17'd1;
  wire [16:0] G__39565 = G__39562 + 17'd1;
  wire [15:0] G__39566 = fp_accum;
  wire [16:0] G__39567 = { {1{fp_accum[15]}}, fp_accum};
  wire [16:0] lhs39569 = G__39567;
  wire [16:0] rhs39570 = G__39565;
  wire [17:0] extended_sum39571 = {lhs39569[16],lhs39569} + {rhs39570[16],rhs39570};
  wire [16:0] raw_diff39568 = (extended_sum39571[17] == extended_sum39571[16]) ? extended_sum39571[16:0] : (extended_sum39571[17] == 1'b0) ? 17'd65535 : -17'd65536;
  wire [16:0] lhs39573 = G__39567;
  wire [16:0] rhs39574 = G__39565;
  wire [17:0] extended_sum39575 = {lhs39573[16],lhs39573} + {rhs39574[16],rhs39574};
  wire [16:0] G__39572 = (extended_sum39575[17] == extended_sum39575[16]) ? extended_sum39575[16:0] : (extended_sum39575[17] == 1'b0) ? 17'd65535 : -17'd65536;
  wire [15:0] G__39576 = G__39572[15:0];
  wire [15:0] difference39577 = G__39572[15:0];
  wire  msb039578 = G__39572[16:16];
  wire  G__39579 = 1'b0 == msb039578;
  wire [15:0] G__39580 = G__39579 ? 16'd32767 : -16'd32768;
  wire  msb139581 = G__39572[15:15];
  wire  G__39582 = msb039578 ^ msb139581;
  wire  G__39583 = msb039578 ^ msb139581;
  wire  overflow_QMARK_39584 = msb039578 ^ msb139581;
  wire [15:0] result39585 = overflow_QMARK_39584 ? G__39580 : difference39577;
  wire [15:0] G__39557 = result39585;
  wire  G__39586 = 4'b0000 == G__39524;
  wire [15:0] G__39587 = G__39586 ? G__39557 : G__39556;
  wire [15:0] lhs39589 = fp_accum;
  wire [15:0] rhs39590 = G__39528;
  wire [16:0] extended_sum39591 = {lhs39589[15],lhs39589} + {rhs39590[15],rhs39590};
  wire [15:0] G__39588 = (extended_sum39591[16] == extended_sum39591[15]) ? extended_sum39591[15:0] : (extended_sum39591[16] == 1'b0) ? 16'd32767 : -16'd32768;
  wire  G__39592 = 4'b1000 == G__39524;
  wire [15:0] G__39593 = G__39592 ? G__39588 : G__39587;
  wire  G__39594 = 4'b0110 == G__39524;
  wire [15:0] G__39595 = G__39594 ? fp_accum : 16'b0000000000000000;
  wire [18:0] G__39596 = G__39522[18:0];
  wire [15:0] G__39597 = G__39596[18:3];
  wire  G__39598 = 4'b0010 == G__39524;
  wire [15:0] G__39599 = G__39598 ? G__39597 : G__39595;
  wire [2:0] G__39600 = G__39594 ? G__39527 : 3'd0;
  wire [2:0] G__39601 = G__39596[2:0];
  wire [2:0] G__39602 = G__39598 ? G__39601 : G__39600;
  wire [5:0] G__39603 = G__39522[5:0];
  wire [2:0] G__39604 = G__39603[2:0];
  wire [15:0] G__39605 = fp_regs[G__39604];
  wire [15:0] G__39606 = fp_regs[G__39604];
  wire [6:0] G__39607 = G__39606[15:9];
  wire [6:0] G__39608 = G__39606[15:9];
  wire [6:0] G__39609 = 7'd63 + G__39608;
  wire [6:0] G__39610 = 7'd63 + G__39608;
  wire [2:0] G__39611 = G__39603[5:3];
  wire [15:0] G__39612 = fp_regs[G__39611];
  wire [15:0] G__39613 = fp_regs[G__39611];
  wire [6:0] G__39614 = G__39613[15:9];
  wire [6:0] G__39615 = G__39613[15:9];
  wire [6:0] G__39616 = 7'd63 + G__39615;
  wire [6:0] G__39617 = 7'd63 + G__39615;
  wire [13:0] G__39618 = {G__39617, G__39610};
  wire [13:0] G__39619 = {G__39617, G__39610};
  wire  G__39620 = G__39524 == 4'b0100;
  wire [13:0] G__39621 = G__39620 ? G__39619 : memaddr;


  always @(posedge clock)
    if (reset) begin
      memaddr <= 14'd0;
      memdata <= 1'b1;
      pc <= 8'd0;
      fp_accum <= 16'b0000000000000000;
    end else begin
      pc <= G__39526;
      fp_accum <= G__39593;
      fp_regs[G__39602] <= G__39599;
      memaddr <= G__39621;
    end

endmodule
