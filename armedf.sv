//============================================================================
//
//  This program is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License as published by the Free
//  Software Foundation; either version 2 of the License, or (at your option)
//  any later version.
//
//  This program is distributed in the hope that it will be useful, but WITHOUT
//  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
//  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
//  more details.
//
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//
//============================================================================

`default_nettype none

module emu
(
    //Master input clock
    input         CLK_50M,

    //Async reset from top-level module.
    //Can be used as initial reset.
    input         RESET,

    //Must be passed to hps_io module
    inout  [48:0] HPS_BUS,

    //Base video clock. Usually equals to CLK_SYS.
    output        CLK_VIDEO,

    //Multiple resolutions are supported using different CE_PIXEL rates.
    //Must be based on CLK_VIDEO
    output        CE_PIXEL,

    //Video aspect ratio for HDMI. Most retro systems have ratio 4:3.
    //if VIDEO_ARX[12] or VIDEO_ARY[12] is set then [11:0] contains scaled size instead of aspect ratio.
    output [12:0] VIDEO_ARX,
    output [12:0] VIDEO_ARY,

    output  [7:0] VGA_R,
    output  [7:0] VGA_G,
    output  [7:0] VGA_B,
    output        VGA_HS,
    output        VGA_VS,
    output        VGA_DE,    // = ~(VBlank | HBlank)
    output        VGA_F1,
    output [1:0]  VGA_SL,
    output        VGA_SCALER, // Force VGA scaler

    input  [11:0] HDMI_WIDTH,
    input  [11:0] HDMI_HEIGHT,
    output        HDMI_FREEZE,

`ifdef MISTER_FB
    // Use framebuffer in DDRAM (USE_FB=1 in qsf)
    // FB_FORMAT:
    //    [2:0] : 011=8bpp(palette) 100=16bpp 101=24bpp 110=32bpp
    //    [3]   : 0=16bits 565 1=16bits 1555
    //    [4]   : 0=RGB  1=BGR (for 16/24/32 modes)
    //
    // FB_STRIDE either 0 (rounded to 256 bytes) or multiple of pixel size (in bytes)
    output        FB_EN,
    output  [4:0] FB_FORMAT,
    output [11:0] FB_WIDTH,
    output [11:0] FB_HEIGHT,
    output [31:0] FB_BASE,
    output [13:0] FB_STRIDE,
    input         FB_VBL,
    input         FB_LL,
    output        FB_FORCE_BLANK,

`ifdef MISTER_FB_PALETTE
    // Palette control for 8bit modes.
    // Ignored for other video modes.
    output        FB_PAL_CLK,
    output  [7:0] FB_PAL_ADDR,
    output [23:0] FB_PAL_DOUT,
    input  [23:0] FB_PAL_DIN,
    output        FB_PAL_WR,
`endif
`endif

    output        LED_USER,  // 1 - ON, 0 - OFF.

    // b[1]: 0 - LED status is system status OR'd with b[0]
    //       1 - LED status is controled solely by b[0]
    // hint: supply 2'b00 to let the system control the LED.
    output  [1:0] LED_POWER,
    output  [1:0] LED_DISK,

    // I/O board button press simulation (active high)
    // b[1]: user button
    // b[0]: osd button
    output  [1:0] BUTTONS,

    input         CLK_AUDIO, // 24.576 MHz
    output [15:0] AUDIO_L,
    output [15:0] AUDIO_R,
    output        AUDIO_S,   // 1 - signed audio samples, 0 - unsigned
    output  [1:0] AUDIO_MIX, // 0 - no mix, 1 - 25%, 2 - 50%, 3 - 100% (mono)

    //ADC
    inout   [3:0] ADC_BUS,

    //SD-SPI
    output        SD_SCK,
    output        SD_MOSI,
    input         SD_MISO,
    output        SD_CS,
    input         SD_CD,

    //High latency DDR3 RAM interface
    //Use for non-critical time purposes
    output        DDRAM_CLK,
    input         DDRAM_BUSY,
    output  [7:0] DDRAM_BURSTCNT,
    output [28:0] DDRAM_ADDR,
    input  [63:0] DDRAM_DOUT,
    input         DDRAM_DOUT_READY,
    output        DDRAM_RD,
    output [63:0] DDRAM_DIN,
    output  [7:0] DDRAM_BE,
    output        DDRAM_WE,

    //SDRAM interface with lower latency
    output        SDRAM_CLK,
    output        SDRAM_CKE,
    output [12:0] SDRAM_A,
    output  [1:0] SDRAM_BA,
    inout  [15:0] SDRAM_DQ,
    output        SDRAM_DQML,
    output        SDRAM_DQMH,
    output        SDRAM_nCS,
    output        SDRAM_nCAS,
    output        SDRAM_nRAS,
    output        SDRAM_nWE,

`ifdef MISTER_DUAL_SDRAM
    //Secondary SDRAM
    //Set all output SDRAM_* signals to Z ASAP if SDRAM2_EN is 0
    input         SDRAM2_EN,
    output        SDRAM2_CLK,
    output [12:0] SDRAM2_A,
    output  [1:0] SDRAM2_BA,
    inout  [15:0] SDRAM2_DQ,
    output        SDRAM2_nCS,
    output        SDRAM2_nCAS,
    output        SDRAM2_nRAS,
    output        SDRAM2_nWE,
`endif

    input         UART_CTS,
    output        UART_RTS,
    input         UART_RXD,
    output        UART_TXD,
    output        UART_DTR,
    input         UART_DSR,

`ifdef MISTER_ENABLE_YC
	output [39:0] CHROMA_PHASE_INC,
	output        YC_EN,
	output        PALFLAG,
`endif
    
    // Open-drain User port.
    // 0 - D+/RX
    // 1 - D-/TX
    // 2..6 - USR2..USR6
    // Set USER_OUT to 1 to read from USER_IN.
    input   [6:0] USER_IN,
    output  [6:0] USER_OUT,

    input         OSD_STATUS
);

///////// Default values for ports not used in this core /////////

assign ADC_BUS  = 'Z;
assign USER_OUT = ^ticks;
assign {UART_RTS, UART_TXD, UART_DTR} = 0;
assign {SD_SCK, SD_MOSI, SD_CS} = 'Z;
//assign {SDRAM_DQ, SDRAM_A, SDRAM_BA, SDRAM_CLK, SDRAM_CKE, SDRAM_DQML, SDRAM_DQMH, SDRAM_nWE, SDRAM_nCAS, SDRAM_nRAS, SDRAM_nCS} = 'Z;
//assign {DDRAM_CLK, DDRAM_BURSTCNT, DDRAM_ADDR, DDRAM_DIN, DDRAM_BE, DDRAM_RD, DDRAM_WE} = '0;  

//assign VGA_SL = 0;
assign VGA_F1 = 0;
assign VGA_SCALER = 0;
assign HDMI_FREEZE = 0;

assign AUDIO_MIX = 0;
assign LED_USER = m68k_a[0] & ^m68k_fc & m68k_lds_n & m68k_uds_n ;// & ^status & ^joy0 & ^joy1;
assign LED_DISK = 0;
assign LED_POWER = 0;
assign BUTTONS = 0;

assign m68k_a[0] = reset;

// Status Bit Map:
//              Upper Case                     Lower Case
// 0         1         2         3          4         5         6
// 01234567890123456789012345678901 23456789012345678901234567890123
// 0123456789ABCDEFGHIJKLMNOPQRSTUV 0123456789ABCDEFGHIJKLMNOPQRSTUV


wire [1:0] aspect_ratio = status[9:8];
wire orientation = ~status[3];
wire [2:0] scan_lines = status[6:4];
wire [3:0] hs_offset = status[27:24];
wire [3:0] vs_offset = status[31:28];
wire [1:0] select = status[12:11];
wire [1:0] offset = status[14:13];

wire gfx1_en = ~status[37];
wire gfx2_en = ~status[38];
wire gfx3_en = ~status[39];
wire gfx4_en = ~status[40];

assign VIDEO_ARX = (!aspect_ratio) ? (orientation  ? 8'd4 : 8'd3) : (aspect_ratio - 1'd1);
assign VIDEO_ARY = (!aspect_ratio) ? (orientation  ? 8'd3 : 8'd4) : 12'd0;

`include "build_id.v" 
localparam CONF_STR = {
    "Armed F;;",
    "-;",
    "P1,Video Settings;",
    "P1-;",
    "P1O89,Aspect ratio,Original,Full Screen,[ARC1],[ARC2];",
    "P1O3,Orientation,Horz,Vert;",
    "P1O46,Scandoubler Fx,None,HQ2x,CRT 25%,CRT 50%,CRT 75%;",
    "P1-;",
    "P1O7,Video Mode,NTSC,PAL;",
    "P1OM,Video Signal,RGBS/YPbPr,Y/C;",
    "P1-;",
    "P1OOR,H-sync Adjust,0,1,2,3,4,5,6,7,-8,-7,-6,-5,-4,-3,-2,-1;",
    "P1OSV,V-sync Adjust,0,1,2,3,4,5,6,7,-8,-7,-6,-5,-4,-3,-2,-1;",
    "P1-;",
    "P2,Pause options;",
    "P2-;",
    "P2OP,Pause when OSD is open,Off,On;",
    "P2OQ,Dim video after 10s,Off,On;",
    "P2-;",
    "P3,Debug;",
    "P3-;",
    "P3o3,Service Menu,Off,On;",
    "P3o4,Debug Menu,Off,On;",
    "P3-;",
    "P3o5,Text Layer,On,Off;",
    "P3o6,Background Layer,On,Off;",
    "P3o7,Foreground Layer,On,Off;",
    "P3o8,Sprite Layer,On,Off;",
    "P3-;",
    "DIP;",
    "-;",
    "R0,Reset;",
    "J1,Button 1,Button 2,Button 3,Start,Coin,Pause;",
    "jn,A,B,X,R,L,Start;",           // name mapping
    "V,v",`BUILD_DATE
};

wire forced_scandoubler;
wire  [1:0] buttons;
wire [63:0] status;
wire [10:0] ps2_key;
wire [15:0] joy0, joy1;

hps_io #(.CONF_STR(CONF_STR)) hps_io
(
    .clk_sys(clk_sys),
    .HPS_BUS(HPS_BUS),

    .buttons(buttons),
    .ps2_key(ps2_key),
    .status(status),
    .status_menumask(direct_video),
    .forced_scandoubler(forced_scandoubler),
    .gamma_bus(gamma_bus),
    .direct_video(direct_video),
    .video_rotated(video_rotated),
    
    .ioctl_download(ioctl_download),
    .ioctl_upload(ioctl_upload),
    .ioctl_wr(ioctl_wr),
    .ioctl_addr(ioctl_addr),
    .ioctl_dout(ioctl_dout),
    .ioctl_din(ioctl_din),
    .ioctl_index(ioctl_index),
    .ioctl_wait(ioctl_wait),

    .joystick_0(joy0),
    .joystick_1(joy1)
);

// INPUT

// 8 dip switches of 8 bits
reg [7:0] sw[8];
always @(posedge clk_sys) begin
    if (ioctl_wr && (ioctl_index==254) && !ioctl_addr[24:3]) begin
        sw[ioctl_addr[2:0]] <= ioctl_dout;
    end
end

wire        direct_video;

wire        ioctl_download;
wire        ioctl_upload;
wire        ioctl_upload_req;
wire        ioctl_wait;
wire        ioctl_wr;
wire  [7:0] ioctl_index;
wire [24:0] ioctl_addr;
wire  [7:0] ioctl_dout;
wire  [7:0] ioctl_din;

reg   [3:0] pcb;

always @(posedge clk_sys) begin
    if (ioctl_wr && (ioctl_index==1)) begin
        pcb <= ioctl_dout;
    end
end

wire [21:0] gamma_bus;

//<buttons names="Fire,Jump,Start,Coin,Pause" default="A,B,R,L,Start" />
reg [15:0] p1 ;
reg [15:0] p2 ;
reg [15:0] dsw1 ;
reg [15:0] dsw2 ;
reg [15:0] sys ;

always @ (posedge clk_sys ) begin 
    p1 <= 16'hffff;
    p1[7:0] <= ~{ p1_buttons[3:0], p1_right, p1_left ,p1_down, p1_up};
     
    p2 <= 16'hffff;
    p2[7:0] <= ~{ p2_buttons[3:0], p2_right, p2_left ,p2_down, p2_up};
    
//    sys <= 16'hffff;
    p1[8] <= ~start1  ; 
    p1[9] <= ~start2  ;
    p1[10] <= ~coin_a ;
    p1[11] <= ~coin_b ;
    
    p2[8] <= ~(joy0[12] | key_service); 
    p2[9] <= ~(key_test | status[35]);     
    
    dsw1 <=  { 8'b0, sw[0] };
    dsw2 <=  { 8'b0, sw[1] };
end

wire        p1_right   = joy0[0] | key_p1_right;
wire        p1_left    = joy0[1] | key_p1_left;
wire        p1_down    = joy0[2] | key_p1_down;
wire        p1_up      = joy0[3] | key_p1_up;
wire [3:0]  p1_buttons = joy0[7:4] | {key_p1_d, key_p1_c, key_p1_b, key_p1_a};

wire        p2_right   = joy1[0] | key_p2_right;
wire        p2_left    = joy1[1] | key_p2_left;
wire        p2_down    = joy1[2] | key_p2_down;
wire        p2_up      = joy1[3] | key_p2_up | status[36];
wire [3:0]  p2_buttons = joy1[7:4] | {key_p2_d, key_p2_c, key_p2_b | status[36], key_p2_a | status[36]};

wire        start1  = joy0[8]  | joy1[8]  | key_start_1p;
wire        start2  = joy0[9]  | joy1[9]  | key_start_2p;
wire        coin_a  = joy0[10] | joy1[10] | key_coin_a;
wire        coin_b  = joy0[11] | joy1[11] | key_coin_b;
wire        b_pause = joy0[12] | key_pause ;

// Keyboard handler

wire key_start_1p, key_start_2p, key_coin_a, key_coin_b;
wire key_test, key_reset, key_service, key_pause;
wire key_txt_enable, key_fg_enable, key_bg_enable, key_spr_enable;

wire key_p1_up, key_p1_left, key_p1_down, key_p1_right, key_p1_a, key_p1_b, key_p1_c, key_p1_d;
wire key_p2_up, key_p2_left, key_p2_down, key_p2_right, key_p2_a, key_p2_b, key_p2_c, key_p2_d;

wire pressed = ps2_key[9];

always @(posedge clk_sys) begin 
    reg old_state;

    old_state <= ps2_key[10];
    if(old_state ^ ps2_key[10]) begin
        casex(ps2_key[8:0])
            'h016: key_start_1p   <= pressed; // 1
            'h01e: key_start_2p   <= pressed; // 2
            'h02E: key_coin_a     <= pressed; // 5
            'h036: key_coin_b     <= pressed; // 6
            'h006: key_test       <= key_test ^ pressed; // f2
            'h004: key_reset      <= pressed; // f3
            'h046: key_service    <= pressed; // 9
            'h04D: key_pause      <= pressed; // p

            'hX75: key_p1_up      <= pressed; // up
            'hX72: key_p1_down    <= pressed; // down
            'hX6b: key_p1_left    <= pressed; // left
            'hX74: key_p1_right   <= pressed; // right
            'h014: key_p1_a       <= pressed; // lctrl
            'h011: key_p1_b       <= pressed; // lalt
            'h029: key_p1_c       <= pressed; // spacebar
            'h012: key_p1_d       <= pressed; // lshift

            'h02d: key_p2_up      <= pressed; // r
            'h02b: key_p2_down    <= pressed; // f
            'h023: key_p2_left    <= pressed; // d
            'h034: key_p2_right   <= pressed; // g
            'h01c: key_p2_a       <= pressed; // a
            'h01b: key_p2_b       <= pressed; // s
            'h015: key_p2_c       <= pressed; // q
            'h01d: key_p2_d       <= pressed; // w

            'h083: key_txt_enable <= key_txt_enable ^ pressed; // f7
            'h00A: key_bg_enable  <= key_bg_enable  ^ pressed; // f8
            'h001: key_fg_enable  <= key_fg_enable  ^ pressed; // f9
            'h009: key_spr_enable <= key_spr_enable ^ pressed; // f10
        endcase
    end
end



reg user_flip;

wire pll_locked;

wire clk_sys;
reg  clk_4M,clk_8M,clk_16M,clk_ym; // clk_16M,
reg  clk_6M;

wire clk_72M;

pll pll
(
    .refclk(CLK_50M),
    .rst(0),
    .outclk_0(clk_sys),     // 72
    .outclk_1(clk_72M),
//    .outclk_2(clk_6M),
    .locked(pll_locked)
);

assign    SDRAM_CLK = clk_72M;

localparam  CLKSYS=72;
localparam  CLKDIV8=CLKSYS/8,CLKDIV6=CLKSYS/6,CLKDIV4=CLKSYS/4,CLKDIVYM=(CLKSYS/4)*512 ;

reg [5:0] clk16_count;
reg [5:0] clk8_count;
reg [5:0] clk6_count;
reg [5:0] clk4_count;
reg [15:0] clk_ym_count;

reg prev_pause_cpu;
reg clk_16M_pause;


always @ (posedge clk_sys) begin

    clk_6M <= ( clk6_count == 0 );

    if ( clk6_count == CLKDIV6-1 ) begin
        clk6_count <= 0;
    end else begin
        clk6_count <= clk6_count + 1;
    end
    
    clk_16M <= ( clk16_count == 0 || clk16_count == 4 );

    if ( clk16_count == CLKDIV8-1 ) begin
        clk16_count <= 0;
    end else if ( pause_cpu == 0 ) begin
        clk16_count <= clk16_count + 1;
    end
    
    clk_8M <= ( clk8_count == 0 );

    if ( clk8_count == CLKDIV8-1 ) begin
        clk8_count <= 0;
    end else begin
        clk8_count <= clk8_count + 1;
    end    

    clk_4M <= ( clk4_count == 0 );

    if ( clk4_count == CLKDIV4-1 ) begin
        clk4_count <= 0;
    end else begin
        clk4_count <= clk4_count + 1;
    end
     
    clk_ym <= ( clk_ym_count == 0 );

    if ( clk_ym_count == CLKDIVYM-1 ) begin  // 4MHz / 512 = 7.8KHz
        clk_ym_count <= 0;
    end else begin
        clk_ym_count <= clk_ym_count + 1;
    end
     
end

wire    reset;
assign  reset = RESET | ioctl_download |  status[0] | key_reset;

//////////////////////////////////////////////////////////////////
wire rotate_ccw = 1;
wire no_rotate = orientation | direct_video;
wire video_rotated ;
wire flip = 0;

reg [23:0]     rgb;

wire hbl;
wire vbl;

wire [8:0] hc;
wire [8:0] vc;

wire hsync;
wire vsync;

wire hbl_delay, vbl_delay;

delay delay_hbl( .clk(clk_6M), .i( hbl ), .o(hbl_delay) ) ;
delay delay_vbl( .clk(clk_6M), .i( vbl ), .o(vbl_delay) ) ;

video_timing video_timing (
    .clk(clk_6M),
    .clk_pix(1'b1),
    .pcb(pcb),
    .hc(hc),
    .vc(vc),
    .hs_offset(hs_offset),
    .vs_offset(vs_offset),
    .hbl(hbl),
    .vbl(vbl),
    .hsync(hsync),
    .vsync(vsync)
);

// PAUSE SYSTEM
wire    pause_cpu;
wire    hs_pause;

// 8 bits per colour, 72MHz sys clk
pause #(8,8,8,72) pause 
(
    .clk_sys(clk_sys),
    .reset(reset),
    .user_button(b_pause),
    .pause_request(hs_pause),
    .options(status[26:25]),
    .pause_cpu(pause_cpu),
    .dim_video(dim_video),
    .OSD_STATUS(OSD_STATUS),
    .r(rgb[23:16]),
    .g(rgb[15:8]),
    .b(rgb[7:0]),
    .rgb_out(rgb_pause_out)
);

wire [23:0] rgb_pause_out;
wire dim_video;

arcade_video #(256,24) arcade_video
(
        .*,

        .clk_video(clk_sys),
        .ce_pix(clk_6M),

        .RGB_in(rgb_pause_out),

        .HBlank(hbl_delay),
        .VBlank(vbl_delay),
        .HSync(hsync),
        .VSync(vsync),

        .fx(scan_lines)
);

/*     Phase Accumulator Increments (Fractional Size 32, look up size 8 bit, total 40 bits)
    Increment Calculation - (Output Clock * 2 ^ Word Size) / Reference Clock
    Example
    NTSC = 3.579545
    PAL =  4.43361875
    W = 40 ( 32 bit fraction, 8 bit look up reference)
    Ref CLK = 42.954544 (This could us any clock)
    NTSC_Inc = 3.579545333 * 2 ^ 40 / 96 = 40997413706
    
*/


// SET PAL and NTSC TIMING
`ifdef MISTER_ENABLE_YC
    assign CHROMA_PHASE_INC = PALFLAG ? 40'd67705769163: 40'd54663218274 ;
    assign YC_EN =  status[22];
    assign PALFLAG = status[7];
`endif

screen_rotate screen_rotate (.*);

reg [31:0] ticks /* synthesis keep */;

wire [9:0] tx_x ; 
wire [9:0] tx_y ; 



always @ (*) begin
    if ( pcb == 2 ) begin
        tx_x <= hc + 96 ;
        tx_y <= vc ;
    end else begin
        tx_x <= hc - 32;
        tx_y <= vc ;
    end
end

// layer 1 / gfx3
wire [9:0] bg_x = hc + bg_scroll_x[9:0] + 96 ; //ok
wire [9:0] bg_y = vc + bg_scroll_y[9:0] ;

// layer 2 / gfx2
wire [9:0] fg_x = hc + fg_scroll_x[9:0] + 96 ; //ok
wire [9:0] fg_y = vc + fg_scroll_y[9:0] ;

reg  [9:0] bg_x_latch ;
reg  [9:0] bg_y_latch ;

reg  [9:0] fg_x_latch ;
reg  [9:0] fg_y_latch ;

// layer 3 / gfx1
reg  [9:0] tx_x_latch ;
reg  [9:0] tx_y_latch ;


reg   [7:0] gfx_txt_attr_latch;
reg   [7:0] gfx_txt_attr_latch2;
reg   [7:0] gfx_txt_attr_latch3;

reg  [15:0] gfx_bg_latch;
reg  [15:0] gfx_fg_latch;
reg  [15:0] gfx_bg_latch2;
reg  [15:0] gfx_fg_latch2;

reg [10:0] bg_pal_addr ;
reg [10:0] fg_pal_addr ;
reg [10:0] tx_pal_addr ;

reg [10:0] sprite_pal_ofs = 11'h200;

always @ (posedge clk_6M) begin
    if ( reset == 1 ) begin

    end else begin
        
        sprite_fb_addr_r <= { ~vc[0], hc[8:0] };
        
        // make this a pipline
        fg_x_latch <= fg_x;
        fg_y_latch <= fg_y;

        bg_x_latch <= bg_x;
        bg_y_latch <= bg_y;

        tx_x_latch <= tx_x;
        tx_y_latch <= tx_y;
        
// background            
        
        // tile #
        bg_ram_addr <=  { bg_x[9:4], bg_y[8:4] }; 
        
        gfx_bg_latch <= bg_ram_dout;
        // bitmap 
        gfx3_addr <= { bg_ram_dout[9:0], bg_y[3:0], bg_x_latch[3:1] };
        
        gfx_bg_latch2 <= gfx_bg_latch;
        // palette
        //tile_pal_addr <= 11'h600 + { gfx_bg_latch[15:11] , bg_x[0]  ? gfx3_dout[3:0] : gfx3_dout[7:4] };
        bg_pal_addr <=  11'h600 + { gfx_bg_latch2[15:11] , bg_x[0]  ? gfx3_dout[3:0] : gfx3_dout[7:4] };
        
// foreground            

        fg_ram_addr <=  { fg_x[9:4], fg_y[8:4] };
        
        gfx_fg_latch <= fg_ram_dout;
        gfx2_addr    <= { fg_ram_dout[10:0], fg_y[3:0], fg_x_latch[3:1] };
        
        gfx_fg_latch2 <= gfx_fg_latch;
        
        //tile_pal_addr <= { gfx_fg_latch[15:11] , ( fg_x_latch[0] == 0 ) ? gfx2_dout[3:0] : gfx2_dout[7:4] };
        fg_pal_addr <= 11'h400 + { gfx_fg_latch2[15:11] , ( fg_x_latch[0] == 0 ) ? gfx2_dout[3:0] : gfx2_dout[7:4] };
    
    
// text layer
    
        // read from two addresses at once
        if ( pcb == 0 || pcb == 8 || pcb == 4) begin
            gfx_txt_addr      <= { tx_x[8], 1'b0, ~tx_y[7:3], tx_x[7:3] } ;//{ 1'b0, t1[9:0] };
            gfx_txt_attr_addr <= { tx_x[8], 1'b1, ~tx_y[7:3], tx_x[7:3] } ; //{ 1'b1, t1[9:0] } ;
        end else if ( pcb == 2 ) begin
            gfx_txt_addr      <= { 1'b0, tx_x[8:3], tx_y[7:3] } ; 
            gfx_txt_attr_addr <= { 1'b1, tx_x[8:3], tx_y[7:3] } ;
        end else if ( pcb == 5 || pcb == 6 || pcb == 7  ) begin              
            gfx_txt_addr      <= { tx_x[8], 1'b0, tx_x[7:3], tx_y[7:3] } ;
            gfx_txt_attr_addr <= { tx_x[8], 1'b1, tx_x[7:3], tx_y[7:3] } ;
        end
        
        gfx1_addr     <= { gfx_txt_attr_dout[1:0], gfx_txt_dout[7:0], tx_y[2:0], tx_x_latch[2:1] } ;  //gfx_txt_attr_dout[1:0]
        gfx_txt_attr_latch <= gfx_txt_attr_dout;
        gfx_txt_attr_latch2 <= gfx_txt_attr_latch;
        
        tx_pal_addr <= { gfx_txt_attr_latch2[7:4] , ( tx_x[0] ? gfx1_dout[3:0] : gfx1_dout[7:4] ) };
        gfx_txt_attr_latch3 <= gfx_txt_attr_latch2;
        
        draw_pix <= 0;
        
        
        // 15 == transparent
        // lowest priority
        if ( gfx1_en == 1 && tx_enable == 1 && tx_pal_addr[3:0] != 15 ) begin
            tile_pal_addr <= tx_pal_addr;
            draw_pix <= 1;
        end

        // background
        if ( gfx2_en == 1 && bg_enable == 1 && bg_pal_addr[3:0] != 15 ) begin
            tile_pal_addr <= bg_pal_addr ;
            draw_pix <= 1;
        end
         
        // sprite priority 2
        if ( gfx4_en == 1 && sp_enable == 1 && sprite_fb_out[1:0] == 2 ) begin  
            tile_pal_addr <= ( sprite_pal_ofs + sprite_fb_out[10:2] ) ;
            draw_pix <= 1;
        end
        
        if ( gfx3_en == 1 && fg_enable == 1 && fg_pal_addr[3:0] != 15 ) begin
            tile_pal_addr <= fg_pal_addr ;
            draw_pix <= 1;
        end
        
        // sprite priority 1
        if ( gfx4_en == 1 && sp_enable == 1 && sprite_fb_out[1:0] == 1 ) begin 
            tile_pal_addr <= ( sprite_pal_ofs + sprite_fb_out[10:2] ) ;
            draw_pix <= 1;
        end
        
        // highest priority 
        if ( gfx1_en == 1 && tx_enable == 1 && tx_pal_addr[3:0] != 15 && gfx_txt_attr_latch3[3] == 0) begin
            tile_pal_addr <=  tx_pal_addr;
            draw_pix <= 1;
        end
        
        // sprite priority 0
        if ( gfx4_en == 1 && sp_enable == 1 && sprite_fb_out[1:0] == 0 ) begin 
            tile_pal_addr <= ( sprite_pal_ofs + sprite_fb_out[10:2] ) ;
            draw_pix <= 1;
        end

        rgb <= 0;
                           
        if ( draw_pix == 1 ) begin
            rgb <= { tile_pal_dout[11:8], 4'b0, tile_pal_dout[7:4] , 4'b0, tile_pal_dout[3:0], 4'b0} ;
        end 

    end
end



reg draw_pix ;

/// 68k cpu

always @ (posedge clk_sys) begin

    if ( reset == 1 ) begin
        m68k_dtack_n <= 1;
        
//    end else if ( clk_8M == 1 ) begin
    end else if ( clk_16M == 1 ) begin
        // tell 68k to wait for valid data. 0=ready 1=wait
        // always ack when it's not program rom
        m68k_dtack_n <= m68k_rom_cs ? !m68k_rom_valid : 
                        // m68k_txt_ram_cs ? !txt_ram_valid : // not needed if in bram
                        0; 

        // select cpu data input based on what is active 
        m68k_din <=  m68k_rom_cs  ? m68k_rom_data :
                     m68k_ram_cs  ? ram68k_dout :
                     m68k_spr_cs  ? ram68k_sprite_dout :
                     m68k_txt_ram_cs ? { 8'h00, m68k_txt_attr_ram_dout } :
                     m68k_bg_ram_cs ? m68k_bg_ram_dout :
                     m68k_fg_ram_cs ? m68k_fg_ram_dout :
                     m68k_ram_2_cs ? m68k_ram_2_dout :
                     m68k_ram_3_cs ? m68k_ram_3_dout :
                     m68k_spr_pal_cs ? m68k_spr_pal_dout :
                     input_p1_cs ? p1 :
                     input_p2_cs ? p2 :
//                     input_system_cs ? sys:
                     input_dsw1_cs ? dsw1 :
                     input_dsw2_cs ? dsw2 :
                     16'd0;
                     
    end
end 

// vblank handling 
// process interrupt and sprite buffering
always @ (posedge clk_sys ) begin

end
 
reg  [3:0]  nb1414m4_state;
reg  [3:0]  nb1414m4_cmd_state;
reg         nb1414m4_wr;
reg  [15:0] nb1414m4_cmd;
wire [13:0] nb1414m4_dst = nb1414m4_idx; // might need to change
reg  [13:0] nb1414m4_idx;

reg  [13:0] nb1414m4_src;
reg  [13:0] nb1414m4_address;
wire [7:0]  nb1414m4_data;

//	dst = (m_data[0x330 + ((mcu_cmd & 0xf) * 2)] << 8) | (m_data[0x331 + ((mcu_cmd & 0xf) * 2)] & 0xff);
//	dst &= 0x3fff;

always @ (posedge clk_sys) begin
    if ( nb1414m4_state == 1 ) begin
        // DMA transfer
        if ( nb1414m4_cmd[15:8] == 8'h02 ) begin
            // lookup dst in m4 rom table. index is part of command
            if ( nb1414m4_cmd_state == 0 ) begin
                nb1414m4_cmd_state <= 1;
                // setup read for high byte of destination
                // mcu_cmd & 0x87
                nb1414m4_address[13:0] <= 14'h330 + { nb1414m4_cmd[2:0], 1'b0 } ;
            end else if ( nb1414m4_cmd_state == 1 ) begin
                // latch in high byte of source
                nb1414m4_src[13:8] <= nb1414m4_data[5:0];
                // setup read for low byte of destination
                nb1414m4_address[13:0] <= 14'h331 + { nb1414m4_cmd[2:0], 1'b0 } ;
                nb1414m4_cmd_state <= 2;
            end else if ( nb1414m4_cmd_state == 2 ) begin
                // latch in low byte of source
                nb1414m4_src[7:0] <= nb1414m4_data[7:0];
                // start after command data
                nb1414m4_idx <= 14'h012;
                nb1414m4_cmd_state <= 3;
            end else if ( nb1414m4_cmd_state == 3 ) begin 
                nb1414m4_address <= nb1414m4_src + nb1414m4_idx;
                nb1414m4_wr <= 0;
                nb1414m4_cmd_state <= 4;
            end else if ( nb1414m4_cmd_state == 4 ) begin
                // address is valid.  clock in the read
                nb1414m4_cmd_state <= 5;
                // setup a write.  the data will be valid in the next clock
                nb1414m4_wr <= 1;
            end else if ( nb1414m4_cmd_state == 5 ) begin
                // source data is valid.  write 
                // disable write
                nb1414m4_wr <= 0;
                // first 0x400 is char data, second 0x400 is attributes
                if ( nb1414m4_idx < 14'h7ff ) begin 
                    nb1414m4_idx <= nb1414m4_idx + 1;
                    nb1414m4_cmd_state <= 3;
                end else begin
                    // done
                    nb1414m4_cmd_state <= 6;
                end
            end else if ( nb1414m4_cmd_state == 6 ) begin
                nb1414m4_cmd_state <= 0;
            end
        end
    end
end

dual_port_ram #(.LEN(16384)) nb1414m4_rom (
    .clock_a ( clk_sys ),
    .address_a ( nb1414m4_address ),
    .wren_a ( 0 ),
    .data_a ( ),
    .q_a ( nb1414m4_data ),

    .clock_b ( clk_sys ),
    .address_b ( ioctl_addr[13:0] ),
    .wren_b ( nb1414m4_ioctl_wr ),
    .data_b ( ioctl_dout ),
    .q_b(  )
    );

//IORQ gets together with M1-pin active/low. 
always @ (posedge clk_sys) begin
    
    if ( reset == 1 ) begin
        z80_a_irq_n <= 1;
    end else if ( clk_ym == 1 ) begin
        z80_a_irq_n <= 0;
    end 
    
    // check for interrupt ack and deassert int
    if ( M1_a_n == 0 && z80_a_irq_n == 0 && IORQ_a_n == 0 ) begin
        z80_a_irq_n <= 1;
    end
end

always @ (posedge clk_sys) begin
     if ( clk_4M == 1 ) begin

       
        z80_a_wait_n <= 1;
        
        if ( z80_a_rd_n == 0 && z80_a_rom_valid == 0 && z80_a_rom_cs == 1 ) begin
            // wait if rom is selected and data is not yet available
            z80_a_wait_n <= 0;
        end 
        
        if ( z80_a_rd_n == 0 ) begin 
            if ( z80_a_rom_cs ) begin
                z80_a_din <= z80_a_rom_data;
            end else if ( z80_a_ram_cs ) begin
                z80_a_din <= z80_a_ram_data;
            end else if ( z80_a_latch_clr_cs ) begin
                // todo
                z80_a_din <= 0;
                sound_latch <= 8'h0;
            end else if ( z80_a_latch_r_cs ) begin
                z80_a_din <= sound_latch;
                // todo
            end else begin
                z80_a_din <= 8'h00;
            end                
        end

        sound_wr <= 0 ;
        if ( z80_a_wr_n == 0 ) begin 
            if ( z80_a_sound0_cs == 1 || z80_a_sound1_cs == 1) begin    
                sound_data  <= z80_a_dout;
                sound_addr <= z80_a_sound1_cs ; //   opl2 is single bit address
                sound_wr <= 1;
            end else if (z80_a_dac1_cs == 1 ) begin
                    dac1 <= z80_a_dout;
                end else if (z80_a_dac2_cs == 1 ) begin
                    dac2 <= z80_a_dout;
                end
        end

    end
     
//    if ( reset == 1 ) begin
//        z80_b_wait_n <= 0;
//    end
    z80_b_wait_n <= 1;
    
    if ( z80_b_rd_n == 0 ) begin 
        if ( z80_b_rom_cs ) begin
            z80_b_din <= z80_b_rom_data;
        end else if ( z80_b_ram_txt_cs ) begin
            z80_b_din <= z80_b_ram_txt_dout;
        end else if ( z80_b_ram_1_cs ) begin
            z80_b_din <= z80_b_ram_1_dout;
        end else if ( z80_b_ram_2_cs ) begin
            z80_b_din <= z80_b_ram_2_dout;
        end else begin
            z80_b_din <= 8'h00;
        end
    end

    // both the 68k and the bootleg z80 write to the scroll registers
//    if ( clk_8M == 1 ) begin
    if ( clk_16M == 1 ) begin
        // 68k writes
        if ( !m68k_rw ) begin
            if ( bg_scroll_x_cs == 1) begin
              bg_scroll_x <= m68k_dout[15:0];
            end else if ( bg_scroll_y_cs == 1) begin
              bg_scroll_y <= m68k_dout[15:0];
            end else if ( fg_scroll_y_cs == 1 ) begin 
                if ( pcb == 2 || pcb == 6 || pcb == 7 ) begin
                    fg_scroll_y[9:0] <= m68k_dout[9:0];
                end else if ( pcb == 6 || pcb == 7 ) begin
                    // legion bootlegs
                    if ( m68k_a[1] == 1 ) begin
                        fg_scroll_y[7:0] <= m68k_dout[7:0];
                    end else begin
                        fg_scroll_y[9:8] <= m68k_dout[1:0];
                    end
                end
            end else if ( fg_scroll_x_cs == 1 ) begin  // && m68k_rw == 0
                if ( pcb == 2 || pcb == 6 || pcb == 7 ) begin
                    fg_scroll_x[9:0] <= m68k_dout[9:0];
                end else if ( pcb == 6 || pcb == 7 ) begin
                    // legion bootlegs
                    if ( m68k_a[1] == 1 ) begin
                        fg_scroll_x[7:0] <= m68k_dout[7:0];
                    end else begin
                        fg_scroll_x[9:8] <= m68k_dout[1:0];
                    end
                end
            end else if ( sound_latch_cs == 1) begin
              sound_latch <= {m68k_dout[6:0],1'b1};
            end
        end
    end

    if ( reset == 1 ) begin
    end else begin
        if ( pcb == 8 ) begin
            // bootleg z80 controls foreground scrolling
            if ( z80_b_fg_scroll_x_cs == 1 && z80_b_wr_n == 0 ) begin
                fg_scroll_x[7:0] <= z80_b_dout;
            end else if ( z80_b_fg_scroll_y_cs == 1 && z80_b_wr_n == 0 ) begin
                fg_scroll_y[7:0] <= z80_b_dout;
            end else if ( z80_b_fg_scroll_msb_cs == 1 && z80_b_wr_n == 0 ) begin
                fg_scroll_x[9:8] <= z80_b_dout[3:2];
                fg_scroll_y[9:8] <= z80_b_dout[1:0];
            end
         end 
    end

    if ( reset == 1 ) begin
        m68k_ipl0_n  <= 1 ;
        m68k_ipl1_n  <= 1 ;
        int_ack <= 0;
        z80_b_irq_n <= 1;
    end else if ( clk_16M == 1 ) begin

        vbl_sr <= { vbl_sr[0], vbl };
        
        if ( nb1414m4_cmd_state == 6 ) begin
            nb1414m4_state <= 0;
        end 
        
        // only a write to 0x07c00e clears to interrupt line
        if ( irq_ack_cs == 1 ) begin
            m68k_ipl0_n <= 1 ;
            m68k_ipl1_n <= 1 ;
        end else if ( irq_z80_cs == 1 ) begin
            //if (data & 0x4000 && ((m_vreg & 0x4000) == 0)) //0 -> 1 transition
            //    m_extra->set_input_line(0, HOLD_LINE);
            
           
            if ( has_nb1414m4 == 1 ) begin
                // nb1414m4
                if ( m68k_dout[14] == 1 ) begin 
                    nb1414m4_state <= 1;
//reg [7:0] nb_scroll_x_l;
//reg [7:0] nb_scroll_x_h;
//reg [7:0] nb_scroll_y_l;
//reg [7:0] nb_scroll_y_h;                    
                    fg_scroll_x[9:0] <= { nb_scroll_x_h[1:0], nb_scroll_x_l[7:0] };
                    fg_scroll_y[9:0] <= { nb_scroll_y_h[1:0], nb_scroll_y_l[7:0] };
                end
            end else begin
                if ( m68k_dout[14] == 1 ) begin 
                    z80_b_irq_n <= 0;
                end
            end
            bg_enable <= m68k_dout[11];
            fg_enable <= m68k_dout[10];
            sp_enable <= m68k_dout[9];
            tx_enable <= m68k_dout[8];

        end
        
        if ( pcb == 8 ) begin
            // terraf bootleg.  hack to deassert interrupt
            if ( z80_b_irq_n == 0 && z80_b_addr == 16'h0038 ) begin
                z80_b_irq_n <= 1;
            end
        end 
        
        if ( M1_b_n == 0 && IORQ_b_n == 0 && z80_b_irq_n == 0 ) begin
            // z80 acknowledged so deassert
            z80_b_irq_n <= 1;
        end
        

//        if ( clk_8M == 1 ) begin
//            int_ack <= ( m68k_as_n == 0 ) && ( m68k_fc == 3'b111 ); // cpu acknowledged the interrupt
//        end
        if ( vbl_sr == 2'b01 ) begin // rising edge
            //  68k vbl interrupt
            if ( pcb == 4 || pcb == 5 || pcb == 6 || pcb == 7 ) begin
                m68k_ipl1_n <= 0;
            end else begin
                m68k_ipl0_n <= 0;
            end
        end 
    end
end

wire has_nb1414m4 = ( pcb < 6 ) ;

// shared text ram write arbiter
reg shared_w;
reg [11:0] shared_addr;
reg  [7:0] shared_data;

// the text ram will need to be accessible from the 68k, bootleg z80, and nb1414m4
// need better arbitration

// for now hack in scrolling for nb1414m4

reg [7:0] nb_scroll_x_l;
reg [7:0] nb_scroll_x_h;
reg [7:0] nb_scroll_y_l;
reg [7:0] nb_scroll_y_h;

always @ (posedge clk_sys) begin
//    if ( clk_8M == 1 ) begin
        shared_w <= 0;
//        txt_ram_valid <= 0;
        
        // only 68k can read shared. the z80 is write only
        if ( clk_16M == 1 && m68k_txt_ram_cs & !m68k_lds_n ) begin
            shared_addr <= m68k_a[12:1];
            case ( m68k_a[12:1] )
                13'h00: nb1414m4_cmd[15:8] <= m68k_dout[7:0];
                13'h01: nb1414m4_cmd[7:0]  <= m68k_dout[7:0];
                13'h0d: nb_scroll_x_l      <= m68k_dout[7:0];
                13'h0e: nb_scroll_x_h      <= m68k_dout[7:0];
                13'h0b: nb_scroll_y_l      <= m68k_dout[7:0];
                13'h0c: nb_scroll_y_h      <= m68k_dout[7:0];
            endcase

        end
        
        if ( clk_16M == 1 && !m68k_rw && m68k_txt_ram_cs & !m68k_lds_n ) begin
            shared_data <= m68k_dout[7:0];
            shared_w <= 1;
        end else if ( has_nb1414m4 == 1 && nb1414m4_wr == 1 ) begin
            shared_addr <= nb1414m4_dst;
            shared_data <= nb1414m4_data;
            shared_w    <= 1;
        end else if (clk_4M == 1 && z80_b_ram_txt_cs & ~z80_b_wr_n) begin
            shared_addr <= z80_b_addr[11:0];
            shared_data <= z80_b_dout;
            shared_w <= 1;
        end 
end

wire    m68k_rom_cs;
wire    m68k_ram_cs;
wire    m68k_tile_pal_cs;
wire    m68k_txt_ram_cs;
wire    m68k_spr_cs;
wire    m68k_ram_2_cs;
wire    m68k_ram_3_cs;
wire    m68k_spr_pal_cs;
wire    m68k_fg_ram_cs;
wire    m68k_bg_ram_cs;
wire    input_p1_cs;
wire    input_p2_cs;
wire    input_dsw1_cs;
wire    input_dsw2_cs;
wire    irq_z80_cs;
wire    bg_scroll_x_cs;
wire    irq_i8751_cs;
wire    bg_scroll_y_cs;
wire    fg_scroll_x_cs;
wire    fg_scroll_y_cs;
wire    sound_latch_cs;
wire    irq_ack_cs;

wire z80_a_rom_cs;
wire z80_a_ram_cs;

wire z80_a_sound0_cs;
wire z80_a_sound1_cs;
wire z80_a_dac1_cs;
wire z80_a_dac2_cs;
wire z80_a_latch_clr_cs;
wire z80_a_latch_r_cs;
    
chip_select cs (
    .pcb(pcb),

    // 68k bus
    .m68k_a(m68k_a),
    .m68k_as_n(m68k_as_n),

    // 68k chip selects
    .m68k_rom_cs(m68k_rom_cs),
    .m68k_ram_cs(m68k_ram_cs),
    .m68k_tile_pal_cs(m68k_tile_pal_cs),
    .m68k_txt_ram_cs(m68k_txt_ram_cs),
    .m68k_spr_cs(m68k_spr_cs),
    .m68k_ram_2_cs(m68k_ram_2_cs),
    .m68k_ram_3_cs(m68k_ram_3_cs),
    .m68k_spr_pal_cs(m68k_spr_pal_cs),
    .m68k_fg_ram_cs(m68k_fg_ram_cs),
    .m68k_bg_ram_cs(m68k_bg_ram_cs),
    .input_p1_cs(input_p1_cs),
    .input_p2_cs(input_p2_cs),
    .input_dsw1_cs(input_dsw1_cs),
    .input_dsw2_cs(input_dsw2_cs),
    .irq_z80_cs(irq_z80_cs),
    .bg_scroll_x_cs(bg_scroll_x_cs),
    .bg_scroll_y_cs(bg_scroll_y_cs),
    .fg_scroll_x_cs(fg_scroll_x_cs),
    .fg_scroll_y_cs(fg_scroll_y_cs),
    .sound_latch_cs(sound_latch_cs),
    .irq_ack_cs(irq_ack_cs),
    .irq_i8751_cs(irq_i8751_cs),

    
    // sound z80 bus
    .z80_addr(z80_a_addr),
    .MREQ_n(MREQ_a_n),
    .IORQ_n(IORQ_a_n),
    .M1_n(M1_a_n),

    .z80_rom_cs(z80_a_rom_cs),
    .z80_ram_cs(z80_a_ram_cs),

    .z80_sound0_cs(z80_a_sound0_cs),
    .z80_sound1_cs(z80_a_sound1_cs),
    .z80_dac1_cs(z80_a_dac1_cs),
    .z80_dac2_cs(z80_a_dac2_cs),
    .z80_latch_clr_cs(z80_a_latch_clr_cs),
    .z80_latch_r_cs(z80_a_latch_r_cs)
);
 
reg [15:0] bg_scroll_x;
reg [15:0] bg_scroll_y;

reg [7:0]  sound_latch;

// CPU outputs
wire m68k_rw         ;    // Read = 1, Write = 0
wire m68k_as_n       ;    // Address strobe
wire m68k_lds_n      ;    // Lower byte strobe
wire m68k_uds_n      ;    // Upper byte strobe
wire m68k_E;         
wire [2:0] m68k_fc    ;   // Processor state
wire m68k_reset_n_o  ;    // Reset output signal
wire m68k_halted_n   ;    // Halt output

// CPU busses
wire [15:0] m68k_dout       ;
wire [23:0] m68k_a   /* synthesis keep */       ;
reg  [15:0] m68k_din        ;   
//assign m68k_a[0] = 1'b0;

// CPU inputs
reg  m68k_dtack_n ;         // Data transfer ack (always ready)
reg  m68k_ipl0_n ;
reg  m68k_ipl1_n ;

wire reset_n;
wire m68k_vpa_n = 1'b0;//( m68k_lds_n == 0 && m68k_fc == 3'b111 ); // int ack

reg int_ack ;
reg [1:0] vbl_sr;

reg bg_enable;
reg fg_enable;
reg tx_enable;
reg sp_enable;

wire curr_line;

wire [9:0] sprite_y_adj = ( pcb == 4 || pcb == 5 || pcb == 6 || pcb == 7) ? 0 : 128 ;

// kozure (1), armedf (2), cclimbr2 (4), legion (5,6,7)
// big fighter is 192
wire [9:0] sprite_count = ( pcb == 0 || pcb == 8 || pcb == 9 ) ? 127 : 511;

always @ (posedge clk_sys) begin
    //   copy sprite list to dedicated sprite list ram
    // start state machine for copy
    if ( copy_sprite_state == 0 && vbl_sr == 2'b01 ) begin
        copy_sprite_state <= 1;    
    end else if ( copy_sprite_state == 1 ) begin
        sprite_shared_addr <= 0;
        copy_sprite_state <= 2;
        sprite_buffer_addr <= 0;
    end else if ( copy_sprite_state == 2 ) begin
        // address now 0
        sprite_shared_addr <= sprite_shared_addr + 1 ;
        copy_sprite_state <= 3; 
    end else if ( copy_sprite_state == 3 ) begin        
       // address 0 result
        sprite_y_pos <= (240+sprite_y_adj) - sprite_shared_ram_dout[8:0];
        sprite_pri   <= sprite_shared_ram_dout[13:12];
        sprite_shared_addr <= sprite_shared_addr + 1 ;
        copy_sprite_state <= 4; 
    end else if ( copy_sprite_state == 4 ) begin    
        // address 1 result
        // tile #
        sprite_tile[11:0] <= sprite_shared_ram_dout[11:0];

        // flip y
        sprite_flip_y <= sprite_shared_ram_dout[12];

        // flip x
        sprite_flip_x <= sprite_shared_ram_dout[13];

        sprite_shared_addr <= sprite_shared_addr + 1 ;
        copy_sprite_state <= 5; 
    end else if ( copy_sprite_state == 5 ) begin        
        // colour
        sprite_colour <= sprite_shared_ram_dout[12:8];
        sprite_spr_lut <= sprite_shared_ram_dout[6:0];
        
        sprite_shared_addr <= sprite_shared_addr + 1 ;

        copy_sprite_state <= 6; 
    end else if ( copy_sprite_state == 6 ) begin        
        sprite_x_pos <= sprite_shared_ram_dout[8:0] - 94 ;
        
        copy_sprite_state <= 7; 
    end else if ( copy_sprite_state == 7 ) begin                
        sprite_buffer_w <= 1;
        sprite_buffer_din <= {sprite_tile,sprite_x_pos,sprite_y_pos,sprite_colour,sprite_spr_lut, sprite_flip_x,sprite_flip_y,sprite_pri};
        
        copy_sprite_state <= 8;
    end else if ( copy_sprite_state == 8 ) begin                

        // write is complete
        sprite_buffer_w <= 0;
        // sprite has been buffered.  are we done?
        if ( sprite_buffer_addr < sprite_count ) begin
            // start on next sprite
            sprite_buffer_addr <= sprite_buffer_addr + 1;
            copy_sprite_state <= 2;
        end else begin
            // we are done, go idle.  
            copy_sprite_state <= 0; 
        end
    // don't try to draw sprites while copying the buffer.
    end else if ( draw_sprite_state == 0 && hc >= 320 ) begin // off by one
    
        curr_line <= vc[0];
        // clear sprite buffer
        sprite_x_ofs <= 0;
        draw_sprite_state <= 1;
        sprite_buffer_addr <= 0;
        
        // enable writing
        sprite_fb_w <= 1;
        sprite_fb_addr_w <= { ~vc[0], 9'b0 };
        // set default to transparent value
        sprite_fb_din <= 15;
        
    end else if (draw_sprite_state == 1) begin

        sprite_fb_addr_w <= { ~vc[0], sprite_x_ofs }; 

        if ( sprite_x_ofs < 320 ) begin
            sprite_x_ofs <= sprite_x_ofs + 1;
        end else begin
            // done writing.  wait for start of next line
            sprite_fb_w <= 0;
            if ( curr_line != vc[0] ) begin
                // sprite buffer now blank
                draw_sprite_state <= 2;
            end
        end
    end else if (draw_sprite_state == 2) begin        
        // get current sprite attributes
        {sprite_tile,sprite_x_pos,sprite_y_pos,sprite_colour,sprite_spr_lut,sprite_flip_x,sprite_flip_y,sprite_pri} <= sprite_buffer_dout;
        draw_sprite_state <= 3;
        sprite_x_ofs <= 0;
    end else if (draw_sprite_state == 3) begin  
        sprite_fb_w <= 0;
        if ( sprite_pri != 3 && vc >= sprite_y_pos && vc < ( sprite_y_pos + 16 ) && sprite_x_pos < 320 ) begin
            if ( sprite_x_ofs[2:0] == 0 ) begin  
                // fetch sprite bitmap 
                sprite_rom_addr <= { sprite_tile, flipped_y[3:0], flipped_x[3] };  
                sprite_rom_cs <= 1;
                
                draw_sprite_state <= 4;
            end else begin
                draw_sprite_state <= 5;
            end
        end else begin
            draw_sprite_state <= 7;
        end
    end else if (draw_sprite_state == 4) begin
    
        // wait for bitmap read to complete
        if ( sprite_rom_valid == 1 ) begin
            // bitmap is only valid for one clock.  latch it.
            sprite_data <= sprite_rom_data;
            sprite_rom_cs <= 0;
            
            draw_sprite_state <= 5;
        end
    end else if (draw_sprite_state == 5) begin   
        // need a clock cycle to read the sprite palette lut
        draw_sprite_state <= 6;
    end else if (draw_sprite_state == 6) begin       
        draw_sprite_state <= 3; 
        sprite_fb_w <= 0;

        if ( spr_pal_dout[3:0] != 15 ) begin // spr_pix

            sprite_fb_w <= 1;
            // 0-511 = even line / 512-1023 = odd line
            sprite_fb_addr_w <= { vc[0], sprite_x_pos[8:0] };
            sprite_fb_din    <= { sprite_colour[4:0],spr_pal_dout[3:0],sprite_pri[1:0] }; 

        end
        
        if ( sprite_x_ofs < 15 ) begin
            sprite_x_pos <= sprite_x_pos + 1;
            sprite_x_ofs <= sprite_x_ofs + 1;
        end else begin
            draw_sprite_state <= 7;
        end
    end else if (draw_sprite_state == 7) begin                        
        // done. next sprite
        if ( sprite_buffer_addr < sprite_count ) begin
            sprite_buffer_addr <= sprite_buffer_addr + 1;
            draw_sprite_state <= 2;
        end else begin
            // all sprites done
            draw_sprite_state <= 8;
        end
    end else if (draw_sprite_state == 8) begin                        
        // we are done. wait for end of line
//        if ( hc == 0 ) begin
            draw_sprite_state <= 0;
//        end
    end
end

wire [10:0] spr_pal_addr = { sprite_spr_lut, spr_pix };  // [10:0]

wire [3:0] spr_pix ;
always @ (*) begin
    case ( flipped_x[2:0] ) 
            3'b000: spr_pix <= sprite_data[27:24]  ;
            3'b001: spr_pix <= sprite_data[31:28]  ;
            3'b010: spr_pix <= sprite_data[19:16] ;
            3'b011: spr_pix <= sprite_data[23:20] ;
            3'b100: spr_pix <= sprite_data[11:8]  ;
            3'b101: spr_pix <= sprite_data[15:12] ;
            3'b110: spr_pix <= sprite_data[3:0]   ;
            3'b111: spr_pix <= sprite_data[7:4]   ;
    endcase  
end        
        
reg   [5:0] spr_pal_idx;
reg  [31:0] sprite_data;

wire  [3:0] sprite_y_ofs = vc - sprite_y_pos ;

wire  [3:0] flipped_x = ( sprite_flip_x == 0 ) ? sprite_x_ofs : 15 - sprite_x_ofs;
wire  [3:0] flipped_y = ( sprite_flip_y == 0 ) ? sprite_y_ofs : 15 - sprite_y_ofs;

reg   [9:0] sprite_shared_addr;
wire [15:0] sprite_shared_ram_dout;

reg   [3:0] copy_sprite_state;
reg   [3:0] draw_sprite_state;

reg   [1:0] sprite_pri;
reg   [8:0] sprite_x_ofs;
reg   [9:0] sprite_idx;
reg  [11:0] sprite_tile ;  
reg   [8:0] sprite_y_pos;
reg   [8:0] sprite_x_pos;
reg   [4:0] sprite_colour;
reg   [6:0] sprite_spr_lut;

reg   sprite_x_256;
reg   sprite_flip_x;
reg   sprite_flip_y;

// fx68k clock generation
reg fx68_phi1;

always @(posedge clk_sys) begin
    if ( clk_16M == 1 ) begin
        fx68_phi1 <= ~fx68_phi1;
    end
end

fx68k fx68k (
    // input
    .clk( clk_16M ),
    .enPhi1(fx68_phi1),
    .enPhi2(~fx68_phi1),

    .extReset(reset),
    .pwrUp(reset),

    // output
    .eRWn(m68k_rw),
    .ASn( m68k_as_n),
    .LDSn(m68k_lds_n),
    .UDSn(m68k_uds_n),
    .E(),
    .VMAn(),
    .FC0(m68k_fc[0]),
    .FC1(m68k_fc[1]),
    .FC2(m68k_fc[2]),
    .BGn(),
    .oRESETn(m68k_reset_n_o),
    .oHALTEDn(m68k_halted_n),

    // input
    .VPAn( m68k_vpa_n ),  
    .DTACKn( m68k_dtack_n ),     
    .BERRn(1'b1), 
    .BRn(1'b1),  
    .BGACKn(1'b1),
    
    .IPL0n(m68k_ipl0_n),
    .IPL1n(m68k_ipl1_n),
    .IPL2n(1'b1),

    // busses
    .iEdb(m68k_din),
    .oEdb(m68k_dout),
    .eab(m68k_a[23:1])
);


// z80 audio 
wire    [7:0] z80_a_rom_data;
wire    [7:0] z80_a_ram_data;

wire   [15:0] z80_a_addr;
reg     [7:0] z80_a_din;
wire    [7:0] z80_a_dout;

wire z80_a_wr_n;
wire z80_a_rd_n;
reg  z80_a_wait_n;
reg  z80_a_irq_n;

wire IORQ_a_n;
wire MREQ_a_n;
wire M1_a_n;

T80pa z80_a (
    .RESET_n    ( ~reset ),
    .CLK        ( clk_sys ),
    .CEN_p      ( clk_4M ),
    .CEN_n      ( ~clk_4M ),
    .WAIT_n     ( z80_a_wait_n ), 
    .INT_n      ( z80_a_irq_n ),  
    .NMI_n      ( 1'b1 ),
    .BUSRQ_n    ( 1'b1 ),
    .RD_n       ( z80_a_rd_n ),
    .WR_n       ( z80_a_wr_n ),
    .A          ( z80_a_addr ),
    .DI         ( z80_a_din  ),
    .DO         ( z80_a_dout ),
    // unused
    .DIRSET     ( 1'b0     ),
    .DIR        ( 212'b0   ),
    .OUT0       ( 1'b0     ),
    .RFSH_n     (),
    .IORQ_n     ( IORQ_a_n ),
    .M1_n       ( M1_a_n ), // for interrupt ack
    .BUSAK_n    (),
    .HALT_n     ( 1'b1 ),
    .MREQ_n     ( MREQ_a_n ),
    .Stop       (),
    .REG        ()
);

// z80 bootleg
wire    [7:0] z80_b_rom_data;
wire    [7:0] z80_b_ram_dout;

wire   [15:0] z80_b_addr;
reg     [7:0] z80_b_din;
wire    [7:0] z80_b_dout;

wire z80_b_wr_n;
wire z80_b_rd_n;
reg  z80_b_wait_n;
reg  z80_b_irq_n;

wire IORQ_b_n;
wire MREQ_b_n;
wire M1_b_n;

reg [9:0] fg_scroll_x;
reg [9:0] fg_scroll_y;

T80pa z80_b (
    .RESET_n    ( ~reset & (pcb == 8) ),  // don't run if no bootleg cpu
    .CLK        ( clk_sys ),
    .CEN_p      ( clk_4M ),
    .CEN_n      ( ~clk_4M ),
    .WAIT_n     ( z80_b_wait_n ), // wait?
    .INT_n      ( z80_b_irq_n ),  // from 68k 7c000
    .NMI_n      ( 1'b1 ),
    .BUSRQ_n    ( 1'b1 ),
    .RD_n       ( z80_b_rd_n ),
    .WR_n       ( z80_b_wr_n ),
    .A          ( z80_b_addr ),
    .DI         ( z80_b_din  ),
    .DO         ( z80_b_dout ),
    // unused
    .DIRSET     ( 1'b0     ),
    .DIR        ( 212'b0   ),
    .OUT0       ( 1'b0     ),
    .RFSH_n     (),
    .IORQ_n     ( IORQ_b_n ),
    .M1_n       ( M1_b_n ), // for interrupt ack
    .BUSAK_n    (),
    .HALT_n     ( 1'b1 ),
    .MREQ_n     ( MREQ_b_n ),
    .Stop       (),
    .REG        ()
);


// bootleg protection hack 16k
wire z80_b_rom_cs          = ( MREQ_b_n == 0 && z80_b_addr[15:0]  < 16'h4000 );
// shared ram 4k
wire z80_b_ram_txt_cs      = ( MREQ_b_n == 0 && z80_b_addr[15:0] >= 16'h4000 && z80_b_addr[15:0] < 16'h5000);
// 4k
wire z80_b_ram_1_cs        = ( MREQ_b_n == 0 && z80_b_addr[15:0] >= 16'h5000 && z80_b_addr[15:0] < 16'h6000);
// 2k
wire z80_b_ram_2_cs        = ( MREQ_b_n == 0 && z80_b_addr[15:0] >= 16'h8000 && z80_b_addr[15:0] < 16'h8800);

wire z80_b_fg_scroll_x_cs   = ( IORQ_b_n == 0 && z80_b_addr[7:0] == 8'h00 );
wire z80_b_fg_scroll_y_cs   = ( IORQ_b_n == 0 && z80_b_addr[7:0] == 8'h01 );
wire z80_b_fg_scroll_msb_cs = ( IORQ_b_n == 0 && z80_b_addr[7:0] == 8'h02 );

reg p0_o,p1_o,p2_o,p3_o;

wire [15:0] i8751_addr;
wire        i8751_rd; // read req
wire [15:0] i8751_ram_addr;
wire        i8751_ram_wr;
wire [7:0]  i8751_ram_dout;
wire [7:0]  i8751_rom_data;
wire [7:0]  i8751_shared_ram_data ;

assign i8751_shared_ram_data = i8751_ram_addr[0] ? i8751_shared_ram_data_h : i8751_shared_ram_data_l ;

wire [7:0]  i8751_shared_ram_data_l;
wire [7:0]  i8751_shared_ram_data_h;

wire i8751_int0_n = ~irq_i8751_cs;
/*
jtframe_8751mcu #(.SYNC_INT(1)) i8751 (
    .rst( reset ),
    .clk( clk_sys ),
    .cen( clk_8M ),

    .int0n( i8751_int0_n ),
    .int1n( 1'b1 ),

    .p0_i( 0 ),
    .p0_o( p0_o ),

    .p1_i( 0 ),
    .p1_o( p1_o ),

    .p2_i( 0 ),
    .p2_o( p2_o ),

    .p3_i( 0 ),
    .p3_o( p3_o ),

//    input      [ 7:0] x_din,
//    output reg [ 7:0] x_dout,
//    output reg [15:0] x_addr,
//    output reg        x_wr,
//    output reg        x_acc,

    // shared ram
    .x_din( i8751_shared_ram_data ),
    .x_dout( i8751_ram_dout ),
    .x_addr( i8751_ram_addr ),
    .x_wr( i8751_ram_wr ),
    .x_acc( i8751_rd ),

    // ROM programming
    .clk_rom( clk_sys ),
    .prog_addr( ioctl_addr[13:0] ),
    .prom_din( ioctl_dout ),
    .prom_we( i8751_ioctl_wr )
);
*/
   
reg sound_addr ;
reg  [7:0] sound_data ;

// sound ic write enable
reg sound_wr;

wire [7:0] opl_dout;
wire opl_irq_n;

reg signed [15:0] sample;

assign AUDIO_S = 1'b1 ;

wire opl_sample_clk;

jtopl #(.OPL_TYPE(2)) opl
(
    .rst(reset),
    .clk(clk_4M),
    .cen(1'b1),
    .din(sound_data),
    .addr(sound_addr),
    .cs_n(~( z80_a_sound0_cs | z80_a_sound1_cs )),
    .wr_n(~sound_wr),
    .dout(opl_dout),
    .irq_n(opl_irq_n),
    .snd(sample),
    .sample(opl_sample_clk)
);

always @ * begin
    // mix audio
    AUDIO_L <= sample + ($signed({ ~dac1[7], dac1[6:0], 8'b0 }) >>> 1) + ($signed({ ~dac2[7], dac2[6:0], 8'b0 }) >>> 1) ;
    AUDIO_R <= sample + ($signed({ ~dac1[7], dac1[6:0], 8'b0 }) >>> 1) + ($signed({ ~dac2[7], dac2[6:0], 8'b0 }) >>> 1) ;
end

reg [7:0] dac1;
reg [7:0] dac2;

wire [7:0] z80_b_ram_txt_dout;
wire [7:0] z80_b_ram_1_dout;
wire [7:0] z80_b_ram_2_dout;

reg [16:0] gfx1_addr;
reg [17:0] gfx2_addr;
reg [16:0] gfx3_addr;
reg [16:0] gfx4_addr;

reg [7:0] gfx1_dout;
reg [7:0] gfx2_dout;
reg [7:0] gfx3_dout;
reg [7:0] gfx4_dout;

wire [15:0] ram68k_dout;
wire [15:0] ram68k_sprite_dout;

//wire [15:0] prog_rom_data;

// ioctl download addressing    
wire rom_download = ioctl_download && (ioctl_index==0);

// fg len 0x30000 192k
wire gfx2_ioctl_wr       = rom_download & ioctl_wr & (ioctl_addr >= 24'h080000) & (ioctl_addr < 24'h0b0000) ;

// bg len 0x20000 128k
wire gfx3_ioctl_wr       = rom_download & ioctl_wr & (ioctl_addr >= 24'h0c0000) & (ioctl_addr < 24'h0e0000) ;

// sprites
//wire gfx4_ioctl_wr       = rom_download & ioctl_wr & (ioctl_addr >= 24'h100000) & (ioctl_addr < 24'h140000) ;

// text
wire gfx1_ioctl_wr       = rom_download & ioctl_wr & (ioctl_addr >= 24'h140000) & (ioctl_addr < 24'h148000) ;

//wire z80_a_rom_ioctl_wr  = rom_download & ioctl_wr & (ioctl_addr >= 24'h150000) & (ioctl_addr < 24'h160000) ;
wire z80_b_rom_ioctl_wr  = rom_download & ioctl_wr & (ioctl_addr >= 24'h160000) & (ioctl_addr < 24'h164000) ;

//wire prom_ioctl_wr       = rom_download & ioctl_wr & (ioctl_addr >= 24'h104000) & (ioctl_addr < 24'h0f4100) ;

wire i8751_ioctl_wr      = rom_download & ioctl_wr & (ioctl_addr >= 24'h170000) & (ioctl_addr < 24'h171000) ;
wire nb1414m4_ioctl_wr   = rom_download & ioctl_wr & (ioctl_addr >= 24'h180000) & (ioctl_addr < 24'h184000) ;

// main 68k ram high    
dual_port_ram #(.LEN(16384)) ram8kx8_H (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[13:1] ),
    .wren_a ( !m68k_rw & m68k_ram_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a (  ram68k_dout[15:8] ),
    
    .clock_b ( clk_8M ),
    .address_b ( { i8751_ram_addr[13:1], 1'b1 } ),
    .wren_b ( i8751_ram_wr & i8751_ram_addr[0] ),
    .data_b ( i8751_ram_dout ),
    .q_b ( i8751_shared_ram_data_h )
    );

// main 68k ram low     
dual_port_ram #(.LEN(16384)) ram8kx8_L (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[13:1] ),
    .wren_a ( !m68k_rw & m68k_ram_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( ram68k_dout[7:0] ),
    
    .clock_b ( clk_8M ),
    .address_b ( { i8751_ram_addr[13:1], 1'b0 } ),
    .wren_b ( i8751_ram_wr & ~i8751_ram_addr[0]),
    .data_b ( i8751_ram_dout ),
    .q_b ( i8751_shared_ram_data_l )
    );
    
// main 68k sprite ram high    
dual_port_ram #(.LEN(4096)) sprite_ram_H (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[13:1] ),
    .wren_a ( !m68k_rw & m68k_spr_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a (  ram68k_sprite_dout[15:8] ),

    .clock_b ( clk_sys ),
    .address_b ( sprite_shared_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( sprite_shared_ram_dout[15:8] )
    
    );

// main 68k sprite ram low     
dual_port_ram #(.LEN(4096)) sprite_ram_L (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[13:1] ),
    .wren_a ( !m68k_rw & m68k_spr_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( ram68k_sprite_dout[7:0] ),
     
    .clock_b ( clk_sys ),
    .address_b ( sprite_shared_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( sprite_shared_ram_dout[7:0] )
    );

//    .clock_a ( clk_8M ),
//    .address_a ( i8751_ram_addr[13:0] ),
//    .wren_a ( i8751_ram_wr ),
//    .data_a ( i8751_ram_dout ),
//    .q_a ( i8751_shared_ram_data ),
    
reg  [10:0] fg_ram_addr;
wire [15:0] fg_ram_dout;

reg  [10:0] bg_ram_addr;
wire [15:0] bg_ram_dout;


wire [15:0] m68k_fg_ram_dout;

// foreground high   
dual_port_ram #(.LEN(2048)) ram_fg_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_fg_ram_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a ( m68k_fg_ram_dout[15:8] ),

    .clock_b ( clk_sys ),
    .address_b ( fg_ram_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( fg_ram_dout[15:8] )
    
    );

// foreground low
dual_port_ram #(.LEN(2048)) ram_fg_l (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_fg_ram_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( m68k_fg_ram_dout[7:0] ),
     
    .clock_b ( clk_sys ),
    .address_b ( fg_ram_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( fg_ram_dout[7:0] )
    );
    
wire [15:0] m68k_bg_ram_dout;
    
// background high
dual_port_ram #(.LEN(2048)) ram_bg_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_bg_ram_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a ( m68k_bg_ram_dout[15:8] ),

    .clock_b ( clk_sys ),
    .address_b ( bg_ram_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( bg_ram_dout[15:8] )
    
    );

// background low    
dual_port_ram #(.LEN(2048)) ram_fg_L (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_bg_ram_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( m68k_bg_ram_dout[7:0] ),
     
    .clock_b ( clk_sys ),
    .address_b ( bg_ram_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( bg_ram_dout[7:0] )
    );    
    
reg [15:0] tile_pal_dout;
reg [10:0] tile_pal_addr;
    
// tile palette high   
dual_port_ram #(.LEN(2048)) tile_pal_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_tile_pal_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a (  ),

    .clock_b ( clk_sys ),
    .address_b ( tile_pal_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( tile_pal_dout[15:8] )
    );

//  tile palette low
dual_port_ram #(.LEN(2048)) tile_pal_l (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_tile_pal_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( ),
     
    .clock_b ( clk_sys ),
    .address_b ( tile_pal_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( tile_pal_dout[7:0] )
    );    
    
wire [15:0] spr_pal_dout ;
wire [15:0] m68k_spr_pal_dout ;


// sprite pal lut high
dual_port_ram #(.LEN(2048)) spr_pal_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_spr_pal_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a ( m68k_spr_pal_dout[15:8] ),

    .clock_b ( clk_sys ),
    .address_b ( spr_pal_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( spr_pal_dout[15:8] )
    
    );

// sprite pal lut high
dual_port_ram #(.LEN(2048)) spr_pal_L (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_spr_pal_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a (m68k_spr_pal_dout[7:0]),
     
    .clock_b ( clk_sys ),
    .address_b ( spr_pal_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( spr_pal_dout[7:0] )
    ); 

reg  [8:0]  sprite_buffer_addr;  // 128 sprites
reg  [63:0] sprite_buffer_din;
wire [63:0] sprite_buffer_dout;
reg  sprite_buffer_w;

dual_port_ram #(.LEN(512), .DATA_WIDTH(64)) sprite_buffer (
    .clock_a ( clk_sys ),
    .address_a ( sprite_buffer_addr ),
    .wren_a ( 1'b0 ),
    .data_a ( ),
    .q_a ( sprite_buffer_dout ),
    
    .clock_b ( clk_sys ),
    .address_b ( sprite_buffer_addr ),
    .wren_b ( sprite_buffer_w ),
    .data_b ( sprite_buffer_din  ),
    .q_b( )

    );
    
reg          sprite_fb_w;
reg   [9:0]  sprite_fb_addr_w;
reg  [15:0]  sprite_fb_din;
wire [15:0]  sprite_fb_out;
reg   [9:0]  sprite_fb_addr_r ; 
    
// two line buffer for sprite rendering
dual_port_ram #(.LEN(1024), .DATA_WIDTH(16)) sprite_line_buffer_ram (
    .clock_a ( clk_sys ),
    .address_a ( sprite_fb_addr_w ),
    .wren_a ( sprite_fb_w ),
    .data_a ( sprite_fb_din ),
    .q_a ( ),

    .clock_b ( clk_6M ),
    .address_b ( sprite_fb_addr_r ),  
    .wren_b ( 0 ),
//    .data_b ( ),
    .q_b ( sprite_fb_out )
    );    
    
// m68_ram_2_cs

wire [15:0] m68k_ram_2_dout ;
wire [15:0] m68k_ram_3_dout ;

// 68k ram 2
dual_port_ram #(.LEN(4096)) ram_2_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[12:1] ),
    .wren_a ( !m68k_rw & m68k_ram_2_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a ( m68k_ram_2_dout[15:8] )

    );

// 68k ram 2
dual_port_ram #(.LEN(4096)) ram_2_L (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[12:1] ),
    .wren_a ( !m68k_rw & m68k_ram_2_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( m68k_ram_2_dout[7:0] )
     
    ); 

// 68k ram 3
dual_port_ram #(.LEN(4096)) ram_3_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[12:1] ),
    .wren_a ( !m68k_rw & m68k_ram_3_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a ( m68k_ram_3_dout[15:8] )

    );

// 68k ram 3
dual_port_ram #(.LEN(4096)) ram_3_L (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[12:1] ),
    .wren_a ( !m68k_rw & m68k_ram_3_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0] ),
    .q_a ( m68k_ram_3_dout[7:0] )
     
    );    
   
wire [7:0] txt_ram_dout ;
wire [15:0] m68k_txt_ram_dout ;
reg  [12:0] txt_ram_addr ;

dual_port_ram #(.LEN(2048)) z80_a_ram (
    .clock_a ( clk_4M ),
    .address_a ( z80_a_addr[13:0] ),
    .wren_a ( z80_a_ram_cs & ~z80_a_wr_n ),
    .data_a ( z80_a_dout ),
    .q_a ( z80_a_ram_data ),

    );
    
dual_port_ram #(.LEN(16384)) z80_b_rom (
    .clock_a ( clk_4M ),
    .address_a ( z80_b_addr[13:0] ),
    .wren_a ( z80_b_rom_cs & ~z80_b_wr_n ),
    .data_a ( ),
    .q_a ( z80_b_rom_data ),

    .clock_b ( clk_sys ),
    .address_b ( ioctl_addr[13:0] ),
    .wren_b ( z80_b_rom_ioctl_wr ),
    .data_b ( ioctl_dout ),
    .q_b(  )
    );

reg  [11:0] gfx_txt_addr;
wire  [7:0] gfx_txt_dout;

reg  [11:0] gfx_txt_attr_addr;
wire  [7:0] gfx_txt_attr_dout;

wire [15:0] m68k_txt_attr_ram_dout;


// 4 port ram - should figure out real abritration method
dual_port_ram #(.LEN(4096)) txt_ram_0 (
    // 68k read and write txt ram
    .clock_a ( clk_sys ),
    .address_a ( shared_addr ),
    .wren_a ( shared_w ),
    .data_a ( shared_data ),
    .q_a ( m68k_txt_attr_ram_dout[7:0] ),
    
    // tile render read txt tile #
    .clock_b ( clk_sys ),
    .address_b ( gfx_txt_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( gfx_txt_dout[7:0] )
    );
    
// shadow to allow z80 to read
dual_port_ram #(.LEN(4096)) txt_ram_1 (
    .clock_a ( clk_sys ),
    .address_a ( shared_addr ),
    .wren_a ( shared_w ),
    .data_a ( shared_data ),
    .q_a (  ),
    
    // z80 read and write txt ram
    .clock_b ( clk_sys ),
    .address_b ( z80_b_addr[11:0]  ),
    .wren_b ( 1'b0 ),
    .data_b (  ),
    .q_b( z80_b_ram_txt_dout[7:0]  )
    );
    
// shadow for text attribute    
dual_port_ram #(.LEN(4096)) txt_ram_2 (
    .clock_a ( clk_sys ),
    .address_a ( shared_addr ),
    .wren_a ( shared_w ),
    .data_a ( shared_data ),
    .q_a (),
    
    // tile render read txt tile attr
    .clock_b ( clk_sys ),
    .address_b ( gfx_txt_attr_addr ),  
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( gfx_txt_attr_dout[7:0] )
    );
    
// z80 protection ram 1  
dual_port_ram #(.LEN(4096)) z80_b_ram_1 (
    .clock_b ( clk_4M ), 
    .address_b ( z80_b_addr[11:0] ),
    .wren_b ( z80_b_ram_1_cs & ~z80_b_wr_n ),
    .data_b ( z80_b_dout ),
    .q_b ( z80_b_ram_1_dout )
    );

// z80 protection ram 1  
dual_port_ram #(.LEN(2048)) z80_b_ram_2 (
    .clock_b ( clk_4M ), 
    .address_b ( z80_b_addr[11:0] ),
    .wren_b ( z80_b_ram_2_cs & ~z80_b_wr_n ),
    .data_b ( z80_b_dout ),
    .q_b ( z80_b_ram_2_dout )
    );

    
//  <!-- gfx1       0x020000-0x021fff 8K -->
dual_port_ram #(.LEN(32768)) gfx1 (
    .clock_a ( clk_6M ),
    .address_a ( gfx1_addr[14:0] ),
    .wren_a ( 1'b0 ),
    .data_a ( ),
    .q_a ( gfx1_dout[7:0] ),
    
    .clock_b ( clk_sys ),
    .address_b ( ioctl_addr[14:0] ),
    .wren_b ( gfx1_ioctl_wr ),
    .data_b ( ioctl_dout ),
    .q_b( )
    );

dual_port_ram #(.LEN(196608)) gfx2 (
    .clock_a ( clk_6M ),
    .address_a ( gfx2_addr[17:0] ),
    .wren_a ( 1'b0 ),
    .data_a ( ),
    .q_a ( gfx2_dout[7:0] ),
    
    .clock_b ( clk_sys ),
    .address_b ( ioctl_addr[17:0] ),
    .wren_b ( gfx2_ioctl_wr ),
    .data_b ( ioctl_dout ),
    .q_b( )
    );

dual_port_ram #(.LEN(131072)) gfx3 (
    .clock_a ( clk_6M ),
    .address_a ( gfx3_addr[16:0] ),
    .wren_a ( 1'b0 ),
    .data_a ( ),
    .q_a ( gfx3_dout[7:0] ),
    
    .clock_b ( clk_sys ),
    .address_b ( ioctl_addr[16:0] ),
    .wren_b ( gfx3_ioctl_wr ),
    .data_b ( ioctl_dout ),
    .q_b( )
    );
   
wire [15:0] m68k_rom_data;
wire m68k_rom_valid;

reg  [17:0] sprite_rom_addr;
wire [31:0] sprite_rom_data;
reg sprite_rom_cs;
wire sprite_rom_valid;

wire z80_a_rom_valid;

//wire        prog_cache_rom_cs;
//wire [22:0] prog_cache_addr;
//wire [15:0] prog_cache_data;
//wire        prog_cache_valid;
//
//wire [15:0] prog_rom_data;
//wire        prog_rom_data_valid;

    // is a oe needed?
rom_controller rom_controller 
(
    .reset(reset),

    // clock
    .clk(clk_sys),

    // program ROM interface
    .prog_rom_cs(m68k_rom_cs),
    .prog_rom_oe(1),
    .prog_rom_addr(m68k_a[23:1]),
    .prog_rom_data(m68k_rom_data),
    .prog_rom_data_valid(m68k_rom_valid),
    
    // program ROM interface
//    .prog_rom_cs(prog_cache_rom_cs),
//    .prog_rom_oe(1),
//    .prog_rom_addr(prog_cache_addr),
//    .prog_rom_data(prog_cache_data),
//    .prog_rom_data_valid(prog_cache_valid),

    // sprite ROM interface
    .sprite_rom_cs(sprite_rom_cs),
    .sprite_rom_oe(1),
    .sprite_rom_addr(sprite_rom_addr),
    .sprite_rom_data(sprite_rom_data),
    .sprite_rom_data_valid(sprite_rom_valid),
    
    // sound ROM #1 interface
    .sound_rom_cs(z80_a_rom_cs),
    .sound_rom_oe(1),
    .sound_rom_addr(z80_a_addr),
    .sound_rom_data(z80_a_rom_data),
    .sound_rom_data_valid(z80_a_rom_valid),    

    // IOCTL interface
    .ioctl_addr(ioctl_addr),
    .ioctl_data(ioctl_dout),
    .ioctl_index(ioctl_index),
    .ioctl_wr(ioctl_wr),
    .ioctl_download(ioctl_download),

    // SDRAM interface
    .sdram_addr(sdram_addr),
    .sdram_data(sdram_data),
    .sdram_we(sdram_we),
    .sdram_req(sdram_req),
    .sdram_ack(sdram_ack),
    .sdram_valid(sdram_valid),
    .sdram_q(sdram_q)
  );

//cache prog_cache
//(
//    .reset(reset),
//    .clk(clk_sys),
//
//    // client
//    .cache_req(m68k_rom_cs),
//    .cache_addr(m68k_a[23:1]),
//    .cache_valid(m68k_rom_valid),
//    .cache_data(m68k_rom_data),
//
//    // to rom controller
//    .rom_req(prog_cache_rom_cs),
//    .rom_addr(prog_cache_addr),
//    .rom_valid(prog_cache_valid),
//    .rom_data(prog_cache_data)
//
//); 
    
reg  [22:0] sdram_addr;
reg  [31:0] sdram_data;
reg         sdram_we;
reg         sdram_req;

wire        sdram_ack;
wire        sdram_valid;
wire [31:0] sdram_q;

sdram #(.CLK_FREQ( (CLKSYS+0.0))) sdram
(
  .reset(~pll_locked),
  .clk(clk_sys),

  // controller interface
  .addr(sdram_addr),
  .data(sdram_data),
  .we(sdram_we),
  .req(sdram_req),
  
  .ack(sdram_ack),
  .valid(sdram_valid),
  .q(sdram_q),

  // SDRAM interface
  .sdram_a(SDRAM_A),
  .sdram_ba(SDRAM_BA),
  .sdram_dq(SDRAM_DQ),
  .sdram_cke(SDRAM_CKE),
  .sdram_cs_n(SDRAM_nCS),
  .sdram_ras_n(SDRAM_nRAS),
  .sdram_cas_n(SDRAM_nCAS),
  .sdram_we_n(SDRAM_nWE),
  .sdram_dqml(SDRAM_DQML),
  .sdram_dqmh(SDRAM_DQMH)
);    
    
endmodule


module delay
(
    input clk,  
    input i,
    output o
);

reg [5:0] r;

assign o = r[5]; 

always @(posedge clk) begin
    r <= { r[4:0], i };
end

endmodule
