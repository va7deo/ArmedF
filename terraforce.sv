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
wire orientation = ~status[10];
wire [2:0] scan_lines = status[6:4];
wire [3:0] hs_offset = status[27:24];
wire [3:0] vs_offset = status[31:28];
wire [1:0] select = status[12:11];
wire [1:0] offset = status[14:13];

assign VIDEO_ARX = (!aspect_ratio) ? (orientation  ? 8'd176 : 8'd135) : (aspect_ratio - 1'd1);
assign VIDEO_ARY = (!aspect_ratio) ? (orientation  ? 8'd135 : 8'd176) : 12'd0;

`include "build_id.v" 
localparam CONF_STR = {
    "Terra Force;;",
    "-;",
    "P1,Video Settings;",
    "P1-;",
    "P1O89,Aspect ratio,Original,Full Screen,[ARC1],[ARC2];",
    "P1OA,Orientation,Horz,Vert;",
    "P1OBC,Page   0-3,0,1,2,3;",    
    "P1ODE,Offset 0-3,0,1,2,3;",   
    "P1-;",
    "P1O46,Scandoubler Fx,None,HQ2x,CRT 25%,CRT 50%,CRT 75%;",
    "P1OOR,H-sync Adjust,0,1,2,3,4,5,6,7,-8,-7,-6,-5,-4,-3,-2,-1;",
    "P1OSV,V-sync Adjust,0,1,2,3,4,5,6,7,-8,-7,-6,-5,-4,-3,-2,-1;",
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

wire [21:0] gamma_bus;

//<buttons names="Fire,Jump,Start,Coin,Pause" default="A,B,R,L,Start" />
reg [15:0] p1 ;
reg [15:0] p2;
reg [15:0] dsw1 ;
reg [15:0] dsw2 ;
reg [15:0] sys ;

always @ (posedge clk_sys) begin
    p1 <= 16'hffff;
//    p1[5:0] <= ~{ p1_buttons[1:0], p1_right, p1_left ,p1_down, p1_up};
     
    p2 <= 16'hffff;
//    p2[5:0] <= ~{ p2_buttons[1:0], p2_right, p2_left ,p2_down, p2_up};
    
//    sys <= 16'hffff;
//    sys[8] <= ~p1_start ; // coin [5]
//    sys[9] <= ~p2_start ;
//    sys[10] <= ~p1_coin ; 
//    sys[11] <= ~p2_coin ; 
//    sys[13] <= ~sw[3][5] ;

    dsw1 <=  16'hffcf;
    dsw2 <=  16'hff3f;
//    dsw1 <= { sw[1], sw[0] };
end

wire       p1_up      = joy0[3] | key_p1_up;
wire       p1_down    = joy0[2] | key_p1_down;
wire       p1_left    = joy0[1] | key_p1_left;
wire       p1_right   = joy0[0] | key_p1_right;
wire [2:0] p1_buttons = joy0[6:4] | {key_p1_c, key_p1_b, key_p1_a};

wire       p2_up      = joy1[3] | key_p2_up;
wire       p2_down    = joy1[2] | key_p2_down;
wire       p2_left    = joy1[1] | key_p2_left;
wire       p2_right   = joy1[0] | key_p2_right;
wire [2:0] p2_buttons = joy1[6:4] | {key_p2_c, key_p2_b, key_p2_a};

wire p1_start = joy0[6] | key_p1_start;
wire p2_start = joy1[6] | key_p2_start;
wire p1_coin  = joy0[7] | key_p1_coin;
wire p2_coin  = joy1[7] | key_p2_coin;
wire b_pause  = joy0[9] | joy1[9];

// Keyboard handler

wire key_p1_start, key_p2_start, key_p1_coin, key_p2_coin;
wire key_test, key_reset, key_service;

wire key_p1_up, key_p1_left, key_p1_down, key_p1_right, key_p1_a, key_p1_b, key_p1_c;
wire key_p2_up, key_p2_left, key_p2_down, key_p2_right, key_p2_a, key_p2_b, key_p2_c;

wire pressed = ps2_key[9];

// PAUSE SYSTEM
wire    pause_cpu;
wire    hs_pause;

reg user_flip;

wire pll_locked;

wire clk_sys;
reg  clk_4M,clk_8M,clk_16M,clk_ym;

wire clk_80M;

pll pll
(
    .refclk(CLK_50M),
    .rst(0),
    .outclk_0(clk_sys),     // 80
    .outclk_1(clk_80M),
    .locked(pll_locked)
);

assign    SDRAM_CLK = clk_80M;

reg [5:0] clk16_count;
reg [5:0] clk8_count;
reg [5:0] clk4_count;
reg [15:0] clk_ym_count;

always @ (posedge clk_sys) begin
   
    clk_16M <= ( clk16_count == 0 );

    if ( clk16_count == 4 ) begin
        clk16_count <= 0;
    end else begin
        clk16_count <= clk16_count + 1;
    end

    clk_8M <= ( clk8_count == 0 );

    if ( clk8_count == 9 ) begin
        clk8_count <= 0;
    end else begin
        clk8_count <= clk8_count + 1;
    end

    clk_4M <= ( clk4_count == 0 );

    if ( clk4_count == 19 ) begin
        clk4_count <= 0;
    end else begin
        clk4_count <= clk4_count + 1;
    end
     
    clk_ym <= ( clk_ym_count == 0 );

    if ( clk_ym_count == 10239 ) begin  // 4MHz / 512 = 7.8KHz
        clk_ym_count <= 0;
    end else begin
        clk_ym_count <= clk_ym_count + 1;
    end
     
end

wire    reset;
assign  reset = RESET | status[0] | ioctl_download | buttons[1];

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

delay delay_hbl( .clk(clk_8M), .i( hbl ), .o(hbl_delay) ) ;
delay delay_vbl( .clk(clk_8M), .i( vbl ), .o(vbl_delay) ) ;

video_timing video_timing (
    .clk(clk_8M),
    .clk_pix(1'b1),
    .hc(hc),
    .vc(vc),
    .hs_offset(hs_offset),
    .vs_offset(vs_offset),
    .hbl(hbl),
    .vbl(vbl),
    .hsync(hsync),
    .vsync(vsync)
);

arcade_video #(256,24) arcade_video
(
        .*,

        .clk_video(clk_sys),
        .ce_pix(clk_8M),

        .RGB_in(rgb[23:0]),

        .HBlank(hbl_delay),
        .VBlank(vbl_delay),
        .HSync(hsync),
        .VSync(vsync),

        .fx(scan_lines)
);

screen_rotate screen_rotate (.*);

reg [31:0] ticks /* synthesis keep */;

wire [9:0] tx_x = hc - 32;
wire [9:0] tx_y = vc + 8;

// layer 1 / gfx3
wire [9:0] bg_x = hc + bg_scroll_x[9:0] + 96 ; //ok
wire [9:0] bg_y = vc + bg_scroll_y[9:0] + 8;

// layer 2 / gfx2
wire [9:0] fg_x = hc + fg_scroll_x[9:0] + 96 ; //ok
wire [9:0] fg_y = vc + fg_scroll_y[9:0] + 8;

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

reg [10:0] bg_pal_addr ;//= 10'h600 + { gfx_bg_latch[15:11] , bg_x[0]  ? gfx3_dout[3:0] : gfx3_dout[7:4] };
reg [10:0] fg_pal_addr ;//= { gfx_fg_latch[15:11] , ( fg_x_latch[0] == 0 ) ? gfx2_dout[3:0] : gfx2_dout[7:4] };
reg [10:0] tx_pal_addr ;//= { 4'b0 , ( tx_x[0] ? gfx1_dout[3:0] : gfx1_dout[7:4] ) };

always @ (posedge clk_8M) begin
    if ( reset == 1 ) begin
        ticks <= 0;
    end else begin
        ticks <= ticks + 1;
        
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
            gfx2_addr    <= { fg_ram_dout[9:0], fg_y[3:0], fg_x_latch[3:1] };
            
            gfx_fg_latch2 <= gfx_fg_latch;
            
            //tile_pal_addr <= { gfx_fg_latch[15:11] , ( fg_x_latch[0] == 0 ) ? gfx2_dout[3:0] : gfx2_dout[7:4] };
            fg_pal_addr <= 11'h400 + { gfx_fg_latch2[15:11] , ( fg_x_latch[0] == 0 ) ? gfx2_dout[3:0] : gfx2_dout[7:4] };
        
        
// text layer
        
            // read from two addresses at once
            gfx_txt_addr      <= { tx_x[8], 1'b0, ~tx_y[7:3], tx_x[7:3] } ;//{ 1'b0, t1[9:0] };
            gfx_txt_attr_addr <= { tx_x[8], 1'b1, ~tx_y[7:3], tx_x[7:3] } ; //{ 1'b1, t1[9:0] } ;
            
            gfx1_addr     <= { gfx_txt_attr_dout[1:0], gfx_txt_dout[7:0], tx_y[2:0], tx_x_latch[2:1] } ;  //gfx_txt_attr_dout[1:0]
            gfx_txt_attr_latch <= gfx_txt_attr_dout;
            gfx_txt_attr_latch2 <= gfx_txt_attr_latch;
            
            tx_pal_addr <= { gfx_txt_attr_latch2[7:4] , ( tx_x[0] ? gfx1_dout[3:0] : gfx1_dout[7:4] ) };
            gfx_txt_attr_latch3 <= gfx_txt_attr_latch2;
            
            tile_pal_addr <= ( sprite_line_buffer[hc] > 0 ) ? 1 :
                             ( tx_pal_addr[3:0] < 15 && tx_enable == 1 && gfx_txt_attr_latch3[3] == 0) ? tx_pal_addr :
                             ( fg_pal_addr[3:0] < 15 && fg_enable == 1 ) ? fg_pal_addr :
                             ( bg_pal_addr[3:0] < 15 && bg_enable == 1 ) ? bg_pal_addr : 
                             tx_pal_addr ;
            rgb <= 0;
                               
            if ( {fg_pal_addr,fg_pal_addr,tx_enable} > 0 ) begin
                rgb <= { tile_pal_dout[11:8], 4'b0, tile_pal_dout[7:4] , 4'b0, tile_pal_dout[3:0], 4'b0} ;
            end 
// sprites            
//        end else begin
//            sprite_rom_addr <= { t2, vc[3:0], hc[3] };
//            sprite_rom_cs <= 1;
//
//            case ( prev_hc[2:0] ) 
//                3'b000: rgb <= dac[ sprite_rom_data[27:24] ];
//                3'b001: rgb <= dac[ sprite_rom_data[31:28] ];
//                3'b010: rgb <= dac[ sprite_rom_data[19:16] ];
//                3'b011: rgb <= dac[ sprite_rom_data[23:20] ];
//                3'b100: rgb <= dac[ sprite_rom_data[11:8]  ];
//                3'b101: rgb <= dac[ sprite_rom_data[15:12] ];
//                3'b110: rgb <= dac[ sprite_rom_data[3:0]   ];
//                3'b111: rgb <= dac[ sprite_rom_data[7:4]   ];
//            endcase
//        end
    end
end


/// 68k cpu

always @ (posedge clk_sys) begin

    if ( reset == 1 ) begin
        m68k_dtack_n <= 1;
    end else if ( clk_16M == 1 ) begin
        // tell 68k to wait for valid data. 0=ready 1=wait
        // always ack when it's not program rom
        m68k_dtack_n <= m68k_rom_cs ? !m68k_rom_valid : 
//                        txt_ram_cs ? !txt_ram_valid :
                        0; 

        // select cpu data input based on what is active 
        m68k_din <=  m68k_rom_cs  ? m68k_rom_data :
                     m68k_ram_cs  ? ram68k_dout :
                     txt_ram_cs ? { 8'h00, m68k_txt_attr_ram_dout } :
                     m68k_ram_2_cs ? m68k_ram_2_dout :
                     m68k_spr_pal_cs ? m68k_spr_pal_dout :
                     input_p1_cs ? p1 :
                     input_p2_cs ? p2 :
//                     input_system_cs ? sys:
                     input_dsw1_cs ? dsw1 :
                     input_dsw2_cs ? dsw2 :
                     16'd0;
    end
end 

//    m68k_cs = ( cpu_a >> width == base_address >> width ) & !m68k_as_n;

//*!	map(0x000000, 0x05ffff).rom();
wire m68k_rom_cs      = ( m68k_a[23:0]  < 24'h060000 ) & !m68k_as_n ;

//*!	map(0x060000, 0x0603ff).ram().share("spriteram");
//*!	map(0x060400, 0x063fff).ram();
wire m68k_ram_cs      = ( m68k_a[23:0] >= 24'h060000 && m68k_a[23:0] < 24'h064000) & !m68k_as_n ; // 16k

//*!	map(0x064000, 0x064fff).ram().w(m_palette, FUNC(palette_device::write16)).share("palette");
wire m68k_tile_pal_cs = ( m68k_a[23:0] >= 24'h064000 && m68k_a[23:0] < 24'h065000) & !m68k_as_n ; // 4k

//*!	map(0x068000, 0x069fff).rw(FUNC(armedf_state::text_videoram_r), FUNC(armedf_state::text_videoram_w)).umask16(0x00ff);
wire txt_ram_cs  = ( m68k_a[23:0] >= 24'h068000 && m68k_a[23:0] < 24'h06a000) & !m68k_as_n ; // 4k shared (1k tile attr) low byte

//*!	map(0x06a000, 0x06a9ff).ram();
wire m68k_ram_2_cs    = ( m68k_a[23:0] >= 24'h06a000 && m68k_a[23:0] < 24'h06b000) & !m68k_as_n ; // 4k
//*!	map(0x06c000, 0x06cfff).ram().share("spr_pal_clut");
wire m68k_spr_pal_cs  = ( m68k_a[23:0] >= 24'h06c000 && m68k_a[23:0] < 24'h06d000) & !m68k_as_n ; // 4k

//*	map(0x070000, 0x070fff).ram().w(FUNC(armedf_state::fg_videoram_w)).share("fg_videoram");
wire m68k_fg_ram_cs   = ( m68k_a[23:0] >= 24'h070000 && m68k_a[23:0] < 24'h071000) & !m68k_as_n ; // 4k
//*	map(0x074000, 0x074fff).ram().w(FUNC(armedf_state::bg_videoram_w)).share("bg_videoram");
wire m68k_bg_ram_cs   = ( m68k_a[23:0] >= 24'h074000 && m68k_a[23:0] < 24'h075000) & !m68k_as_n ; // 4k

//*	map(0x078000, 0x078001).portr("P1");
wire input_p1_cs      = ( m68k_a[23:0] >= 24'h078000 && m68k_a[23:0] < 24'h078002) & !m68k_as_n ; // P1
//*	map(0x078002, 0x078003).portr("P2");
wire input_p2_cs      = ( m68k_a[23:0] >= 24'h078002 && m68k_a[23:0] < 24'h078004) & !m68k_as_n ; // P2
//*	map(0x078004, 0x078005).portr("DSW1");
wire input_dsw1_cs    = ( m68k_a[23:0] >= 24'h078004 && m68k_a[23:0] < 24'h078006) & !m68k_as_n ; // DSW1
//*	map(0x078006, 0x078007).portr("DSW2");
wire input_dsw2_cs    = ( m68k_a[23:0] >= 24'h078006 && m68k_a[23:0] < 24'h078008) & !m68k_as_n ; // DSW2

// map(0x07c000, 0x07c001).w(FUNC(armedf_state::terrafjb_io_w));
wire irq_z80_cs       = ( m68k_a[23:0] >= 24'h07c000 && m68k_a[23:0] < 24'h07c001) & !m68k_as_n ; // 

//*	map(0x07c002, 0x07c003).w(FUNC(armedf_state::bg_scrollx_w));
wire bg_scroll_x_cs   = ( m68k_a[23:0] >= 24'h07c002 && m68k_a[23:0] < 24'h07c004) & !m68k_as_n ; // SCROLL X
//*	map(0x07c004, 0x07c005).w(FUNC(armedf_state::bg_scrolly_w));
wire bg_scroll_y_cs   = ( m68k_a[23:0] >= 24'h07c004 && m68k_a[23:0] < 24'h07c006) & !m68k_as_n ; // SCROLL Y
//*	map(0x07c00b, 0x07c00b).w(FUNC(armedf_state::sound_command_w));
wire sound_latch_cs   = ( m68k_a[23:0] >= 24'h07c00a && m68k_a[23:0] < 24'h07c00c) & !m68k_as_n ; // sound latch
//*	map(0x07c00e, 0x07c00f).w(FUNC(armedf_state::irq_lv1_ack_w));
wire irq_ack_cs       = ( m68k_a[23:0] >= 24'h07c00e && m68k_a[23:0] < 24'h07c010) & !m68k_as_n ; // irq ack

//*	map(0x07c00c, 0x07c00d).nopw();                    /* Watchdog ? cycle 0000 -> 0100 -> 0200 back to 0000 */
  


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

wire reset_n;
wire m68k_vpa_n = 1'b0;//( m68k_lds_n == 0 && m68k_fc == 3'b111 ); // int ack

reg int_ack ;
reg [1:0] vbl_sr;

reg bg_enable;
reg fg_enable;
reg tx_enable;

// vblank handling 
// process interrupt and sprite buffering
always @ (posedge clk_8M ) begin
    if ( reset == 1 ) begin
        m68k_ipl0_n <= 1 ;
        int_ack <= 0;
        z80_b_irq_n <= 1;
    end else begin
        vbl_sr <= { vbl_sr[0], vbl };
        
        // only a write to 0x07c00e clears to interrupt line
        if ( irq_ack_cs == 1 ) begin
            m68k_ipl0_n <= 1 ;
        end else if ( irq_z80_cs == 1 ) begin
            //if (data & 0x4000 && ((m_vreg & 0x4000) == 0)) //0 -> 1 transition
            //    m_extra->set_input_line(0, HOLD_LINE);
            
            //if ( m68k_dout[14] == 1 ) begin 
            if ( m68k_dout == 16'hcf90 || m68k_dout == 16'hc010 ) begin 
                z80_b_irq_n <= 0;
            end
            bg_enable <= m68k_dout[11];
            fg_enable <= m68k_dout[10];
            tx_enable <= m68k_dout[8];
	//m_bg_tilemap->enable(m_vreg & 0x800);
	//m_fg_tilemap->enable(m_vreg & 0x400);
	//m_tx_tilemap->enable(m_vreg & 0x100);            
        end
        
        if ( M1_b_n == 0 && IORQ_b_n == 0 && z80_b_irq_n == 0 ) begin
        //if ( z80_b_irq_n == 0 && z80_b_addr == 16'h0038 ) begin
            // z80 acknowledged so deassert
            z80_b_irq_n <= 1;
        end

//        if ( clk_16M == 1 ) begin
//            int_ack <= ( m68k_as_n == 0 ) && ( m68k_fc == 3'b111 ); // cpu acknowledged the interrupt
//        end
        if ( vbl_sr == 2'b01 ) begin // rising edge
            //  68k vbl interrupt
            m68k_ipl0_n <= 0;
        end 
    end
end

        // demux - pick where we write
//wire sprite_0_we = ( copy_sprite_state == 2 && sprite_idx[1:0] == 0 );
//wire sprite_1_we = ( copy_sprite_state == 2 && sprite_idx[1:0] == 1 );
//wire sprite_2_we = ( copy_sprite_state == 2 && sprite_idx[1:0] == 2 );
//wire sprite_3_we = ( copy_sprite_state == 2 && sprite_idx[1:0] == 3 );

// buffer sprite ram @ vblank
// each sprite uses four 16 bit words.  
// each offset (0-3) is buffered in separate ram bank
//always @ (posedge clk_sys) begin
//    if ( copy_sprite_state == 0 && vbl_sr == 2'b01 ) begin
//        copy_sprite_state <= 1;
//    end else if ( copy_sprite_state == 1 ) begin
//        sprite_shared_addr <= 0;
//        copy_sprite_state <= 2;
//
//    end else if (copy_sprite_state == 2) begin
//    
//        sprite_ram_data <= sprite_shared_ram_dout;
//
//        sprite_0_we <= ( sprite_shared_addr[1:0] == 0 );
//        sprite_1_we <= ( sprite_shared_addr[1:0] == 1 );
//        sprite_2_we <= ( sprite_shared_addr[1:0] == 2 );
//        sprite_3_we <= ( sprite_shared_addr[1:0] == 3 );
//
//        if ( sprite_shared_addr < 511 ) begin
//            sprite_shared_addr <= sprite_shared_addr + 1;
//        end else begin
//            // done
//            copy_sprite_state <= 0;
//        end
//    end
//    
//    if ( draw_sprite_state == 0 && hc == 320 ) begin // fix - need one line early
//        // clear sprite buffer
//        sprite_x_ofs <= 0;
//        draw_sprite_state <= 1;
//        sprite_idx <= 0; // [9:2]
//    end else if (draw_sprite_state == 1) begin
//        sprite_line_buffer[sprite_x_ofs] <= 0;
//        if ( sprite_x_ofs < 255 ) begin
//            sprite_x_ofs <= sprite_x_ofs + 1;
//        end else begin
//            // sprite buffer now blank
//            draw_sprite_state <= 2;
//        end
//    end else if (draw_sprite_state == 2) begin        
//        // get current sprite attributes
//        //{sprite_tile,sprite_x_pos,sprite_y_pos,sprite_colour,sprite_flip_x,sprite_flip_y} <= sprite_buffer_dout[33:0];
//        sprite_y_pos  <= 240 - sprite_ram_0_dout[8:0];
//        sprite_pri    <= sprite_ram_0_dout[13:12];
//        sprite_flip_y <= sprite_ram_1_dout[12];
//        sprite_flip_x <= sprite_ram_1_dout[13];
//        sprite_tile   <= sprite_ram_1_dout[10:0];
//        sprite_colour <= sprite_ram_2_dout[12:8];
//        sprite_x_pos  <= sprite_ram_3_dout[8:0];
//        
//        draw_sprite_state <= 3;
//        sprite_x_ofs <= 0;
//    end else if (draw_sprite_state == 3) begin    
//        draw_sprite_state <= 4;
//    end else if (draw_sprite_state == 4) begin                
//        draw_sprite_state <= 3; 
//        if ( vc >= sprite_y_pos && vc < ( sprite_y_pos + 16 ) && sprite_x_pos < 320 ) begin
//            // fetch bitmap 
//            //sprite_line_buffer[sprite_x_pos] <= p;
//            sprite_line_buffer[sprite_x_pos] <= 1; // draw a block: test
//            
//            if ( sprite_x_ofs < 15 ) begin
//                sprite_x_pos <= sprite_x_pos + 1;
//                sprite_x_ofs <= sprite_x_ofs + 1;
//            end else begin
//                draw_sprite_state <= 6;
//            end
//        end else begin
//            draw_sprite_state <= 6;
//        end
//    end else if (draw_sprite_state == 6) begin                        
//        // done. next sprite
//        if ( sprite_idx[9:2] < 127 ) begin
//            sprite_idx <= sprite_idx + 3'b100;
//            draw_sprite_state <= 2;
//        end else begin
//            // all sprites done
//            draw_sprite_state <= 7;
//        end
//    end else if (draw_sprite_state == 7) begin                        
//        // we are done. wait for end of line
//        if ( hc == 0 ) begin
//            draw_sprite_state <= 0;
//        end
//    end
//    
//end

wire    [3:0] sprite_y_ofs = vc - sprite_y_pos ;

wire    [3:0] flipped_x = ( sprite_flip_x == 0 ) ? sprite_x_ofs : 15 - sprite_x_ofs;
wire    [3:0] flipped_y = ( sprite_flip_y == 0 ) ? sprite_y_ofs : 15 - sprite_y_ofs;

//wire   [16:0] gfx4_addr = { flipped_x[1], sprite_tile[10:0], flipped_y[3:0], flipped_x[3:2] };

//wire    [3:0] gfx3_pix = (sprite_x_ofs[0] == 1 ) ? gfx3_dout[7:4] : gfx3_dout[3:0];

reg sprite_0_we;
reg sprite_1_we;
reg sprite_2_we;
reg sprite_3_we;
//
//reg  [15:0] sprite_ram_data;
//wire [15:0] sprite_ram_0_dout;
//wire [15:0] sprite_ram_1_dout;
//wire [15:0] sprite_ram_2_dout;
//wire [15:0] sprite_ram_3_dout;

reg    [11:0] sprite_line_buffer [255:0];

reg   [9:0] sprite_shared_addr;
wire [15:0] sprite_shared_ram_dout;

reg   [3:0] copy_sprite_state;
reg   [3:0] draw_sprite_state;

reg   [1:0] sprite_pri;
reg   [8:0] sprite_x_ofs;
reg   [9:0] sprite_idx;
reg   [9:0] sprite_tile ;  
reg   [7:0] sprite_y_pos;
reg   [8:0] sprite_x_pos;
reg   [3:0] sprite_colour;

reg   sprite_x_256;
reg   sprite_flip_x;
reg   sprite_flip_y;

// clock generation
reg  fx68_phi1 = 0; 

// phases for 68k clock
always @(posedge clk_sys) begin
    if ( clk_16M == 1 ) begin
        fx68_phi1 <= ~fx68_phi1; 
    end
end

fx68k fx68k (
    // input
    .clk( clk_16M ),
    .enPhi1(fx68_phi1),
    .enPhi2(!fx68_phi1),
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
    .DTACKn( m68k_dtack_n),     
    .BERRn(1'b1), 
    .BRn(1'b1),  
    .BGACKn(1'b1),
    
    .IPL0n(m68k_ipl0_n),
    .IPL1n(1'b1),
    .IPL2n(1'b1),

    // busses
    .iEdb(m68k_din),
    .oEdb(m68k_dout),
    .eab(m68k_a[23:1])
);


// z80 audio 
wire    [7:0] z80_a_rom_data;
wire    [7:0] z80_a_ram_dout;

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

//IORQ gets together with M1-pin active/low. 
always @ (posedge clk_8M) begin
    
    if ( reset == 1 ) begin
    end else begin
        // bootleg z80 controls foreground scrolling
        if ( z80_b_fg_scroll_x_cs == 1 ) begin
            fg_scroll_x[7:0] <= z80_b_dout;
        end else if ( z80_b_fg_scroll_y_cs == 1 ) begin
            fg_scroll_y[7:0] <= z80_b_dout;
        end else if ( z80_b_fg_scroll_msb_cs == 1 ) begin
            fg_scroll_x[9:8] <= z80_b_dout[3:2];
            fg_scroll_y[9:8] <= z80_b_dout[1:0];
        end
    end
    
//   	if (data & 0x4000 && ((m_vreg & 0x4000) == 0)) //0 -> 1 transition
//		m_extra->set_input_line(0, HOLD_LINE);

end

reg [9:0] fg_scroll_x;
reg [9:0] fg_scroll_y;

T80pa u_cpu_bl(
    .RESET_n    ( ~reset ),
    .CLK        ( clk_8M ),
    .CEN_p      ( 1'b1 ),
    .CEN_n      ( 1'b1 ),
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

wire z80_a_rom_cs          = ( MREQ_a_n == 0 && z80_a_addr[15:0]  < 16'hf800 );
wire z80_a_ram_cs          = ( MREQ_a_n == 0 && z80_a_addr[15:0] >= 16'hf800 );

//wire z80_a_sound0_cs       = ( IORQ_a_n == 0 && z80_a_addr[7:0] == 8'h00 );

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

//void armedf_state::sound_map(address_map &map)
//{
//	map(0x0000, 0xf7ff).rom();
//	map(0xf800, 0xffff).ram();
//}

//void armedf_state::blitter_txram_w(offs_t offset, u8 data)
//{
//	m_text_videoram[offset] = data;
//	if (offset < 0x1000)
//		m_tx_tilemap->mark_tile_dirty(offset & 0x7ff);
//}

//void armedf_state::terrafjb_extraz80_map(address_map &map)
//{
//	map(0x0000, 0x3fff).rom();
//	map(0x4000, 0x4fff).ram().w(FUNC(armedf_state::blitter_txram_w)).share("text_videoram");
//	map(0x5000, 0x5fff).ram();
//	map(0x8000, 0x87ff).ram();
//}
//
//void armedf_state::terrafjb_extraz80_portmap(address_map &map)
//{
//	map.global_mask(0xff);
//	map(0x00, 0x00).w(FUNC(armedf_state::terrafjb_fg_scrollx_w));
//	map(0x01, 0x01).w(FUNC(armedf_state::terrafjb_fg_scrolly_w));
//	map(0x02, 0x02).w(FUNC(armedf_state::terrafjb_fg_scroll_msb_w));
//}

//reg sound_addr ;
//reg  [7:0] sound_data ;
//
//// sound ic write enable
//reg sound_wr;
//
//wire [7:0] opl_dout;
//wire opl_irq_n;
//
//reg signed [15:0] sample;
//
//assign AUDIO_S = 1'b1 ;
//
//wire opl_sample_clk;
//
//jtopl #(.OPL_TYPE(1)) opl
//(
//    .rst(reset),
//    .clk(clk_4M),
//    .cen(1'b1),
//    .din(sound_data),
//    .addr(sound_addr),
//    .cs_n(~( z80_a_sound0_cs | z80_a_sound1_cs )),
//    .wr_n(~sound_wr),
//    .dout(opl_dout),
//    .irq_n(opl_irq_n),
//    .snd(sample),
//    .sample(opl_sample_clk)
//);
//
//always @ * begin
//    // mix audio
//    AUDIO_L <= sample + ($signed({ ~dac1[7], dac1[6:0], 8'b0 }) >>> 1) + ($signed({ ~dac2[7], dac2[6:0], 8'b0 }) >>> 1) ;
//    AUDIO_R <= sample + ($signed({ ~dac1[7], dac1[6:0], 8'b0 }) >>> 1) + ($signed({ ~dac2[7], dac2[6:0], 8'b0 }) >>> 1) ;
//end
//
//reg [7:0] dac1;
//reg [7:0] dac2;

wire [7:0] z80_b_ram_txt_dout;
wire [7:0] z80_b_ram_1_dout;
wire [7:0] z80_b_ram_2_dout;

always @ (posedge clk_sys) begin
     if ( clk_4M == 1 ) begin

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
        
        if ( z80_b_wr_n == 0 ) begin 
            // todo?
        end

    end 
     
     if ( clk_16M == 1 ) begin

         if (!m68k_rw & bg_scroll_x_cs ) begin
              bg_scroll_x <= m68k_dout[15:0];
         end

         if (!m68k_rw & bg_scroll_y_cs ) begin
              bg_scroll_y <= m68k_dout[15:0];
         end

         if (!m68k_rw & sound_latch_cs ) begin
              sound_latch <= {m68k_dout[6:0],1'b1};
         end
    end
    
   if ( reset == 1 ) begin
        z80_b_wait_n <= 0;
   end

end

reg [16:0] gfx1_addr;
reg [16:0] gfx2_addr;
reg [16:0] gfx3_addr;
reg [16:0] gfx4_addr;

reg [7:0] gfx1_dout;
reg [7:0] gfx2_dout;
reg [7:0] gfx3_dout;
reg [7:0] gfx4_dout;

wire [15:0] ram68k_dout;
//wire [15:0] prog_rom_data;

// ioctl download addressing    
wire rom_download = ioctl_download && (ioctl_index==0);

wire m68k_rom_h_ioctl_wr = rom_download & ioctl_wr & (ioctl_addr  < 24'h060000) & (ioctl_addr[0] == 1);
wire m68k_rom_l_ioctl_wr = rom_download & ioctl_wr & (ioctl_addr  < 24'h060000) & (ioctl_addr[0] == 0);

// fg
wire gfx2_ioctl_wr       = rom_download & ioctl_wr & (ioctl_addr >= 24'h060000) & (ioctl_addr < 24'h080000) ;

// bg
wire gfx3_ioctl_wr       = rom_download & ioctl_wr & (ioctl_addr >= 24'h080000) & (ioctl_addr < 24'h0a0000) ;

// sprites
wire gfx4_ioctl_wr       = rom_download & ioctl_wr & (ioctl_addr >= 24'h0a0000) & (ioctl_addr < 24'h0c0000) ;

// text
wire gfx1_ioctl_wr       = rom_download & ioctl_wr & (ioctl_addr >= 24'h0c0000) & (ioctl_addr < 24'h0c8000) ;

wire z80_b_rom_ioctl_wr  = rom_download & ioctl_wr & (ioctl_addr >= 24'h0c8000) & (ioctl_addr < 24'h0cc000) ;

wire z80_a_rom_ioctl_wr  = rom_download & ioctl_wr & (ioctl_addr >= 24'h0d0000) & (ioctl_addr < 24'h0e0000) ;

wire nb1414m4_ioctl_wr   = rom_download & ioctl_wr & (ioctl_addr >= 24'h0f0000) & (ioctl_addr < 24'h0f4000) ;

wire prom_ioctl_wr       = rom_download & ioctl_wr & (ioctl_addr >= 24'h0f4000) & (ioctl_addr < 24'h0f4100) ;

// main 68k ram high    
ram8kx8dp ram8kx8_H (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[13:1] ),
    .wren_a ( !m68k_rw & m68k_ram_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a (  ram68k_dout[15:8] ),

    .clock_b ( clk_sys ),
    .address_b ( sprite_shared_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( sprite_shared_ram_dout[15:8] )
    
    );

// main 68k ram low     
ram8kx8dp ram8kx8_L (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[13:1] ),
    .wren_a ( !m68k_rw & m68k_ram_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( ram68k_dout[7:0] ),
     
    .clock_b ( clk_sys ),
    .address_b ( sprite_shared_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( sprite_shared_ram_dout[7:0] )
    );
    
reg  [10:0] fg_ram_addr;
wire [15:0] fg_ram_dout;

reg  [10:0] bg_ram_addr;
wire [15:0] bg_ram_dout;

// foreground high   
ram2kx8dp ram_fg_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_fg_ram_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a (  ),

    .clock_b ( clk_sys ),
    .address_b ( fg_ram_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( fg_ram_dout[15:8] )
    
    );

// foreground low
ram2kx8dp ram_fg_l (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_fg_ram_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( ),
     
    .clock_b ( clk_sys ),
    .address_b ( fg_ram_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( fg_ram_dout[7:0] )
    );
    
// background high
ram2kx8dp ram_bg_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_bg_ram_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a (  ),

    .clock_b ( clk_sys ),
    .address_b ( bg_ram_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( bg_ram_dout[15:8] )
    
    );

// background low    
ram2kx8dp ram_fg_L (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_bg_ram_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( ),
     
    .clock_b ( clk_sys ),
    .address_b ( bg_ram_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( bg_ram_dout[7:0] )
    );    
    
reg [15:0] tile_pal_dout;
reg [10:0] tile_pal_addr;
    
// tile palette high   
ram2kx8dp tile_pal_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_tile_pal_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a (  ),

    .clock_b ( clk_sys ),
    .address_b ( tile_pal_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( tile_pal_dout[15:8] )
    
    );

//  tile palette low
ram2kx8dp tile_pal_l (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_tile_pal_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( ),
     
    .clock_b ( clk_sys ),
    .address_b ( tile_pal_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( tile_pal_dout[7:0] )
    );    
    
wire [15:0] spr_pal_dout ;
wire [15:0] m68k_spr_pal_dout ;
reg  [11:0] spr_pal_addr ;

// sprite pal lut high
ram2kx8dp spr_pal_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_spr_pal_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a ( m68k_spr_pal_dout[15:8] ),

    .clock_b ( clk_sys ),
    .address_b ( spr_pal_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( spr_pal_dout[15:8] )
    
    );

// sprite pal lut high
ram2kx8dp spr_pal_L (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_spr_pal_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a (m68k_spr_pal_dout[7:0]),
     
    .clock_b ( clk_sys ),
    .address_b ( spr_pal_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( spr_pal_dout[7:0] )
    ); 

// m68_ram_2_cs

wire [15:0] m68k_ram_2_dout ;
wire [15:0] ram_2_dout;
reg  [11:0] m68k_ram_2_addr ;

// 68k ram 2
ram2kx8dp ram_2_h (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_ram_2_cs & !m68k_uds_n ),
    .data_a ( m68k_dout[15:8]  ),
    .q_a ( m68k_ram_2_dout[15:8] ),

    .clock_b ( clk_sys ),
    .address_b ( m68k_ram_2_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( ram_2_dout[15:8] )
    
    );

// 68k ram 2
ram2kx8dp ram_2_L (
    .clock_a ( clk_16M ),
    .address_a ( m68k_a[11:1] ),
    .wren_a ( !m68k_rw & m68k_ram_2_cs & !m68k_lds_n ),
    .data_a ( m68k_dout[7:0]  ),
    .q_a ( m68k_ram_2_dout[7:0] ),
     
    .clock_b ( clk_sys ),
    .address_b ( m68k_ram_2_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( ram_2_dout[7:0] )
    ); 

//reg sprite_0_we;
//reg sprite_1_we;
//reg sprite_2_we;
//reg sprite_3_we;

reg  [15:0] sprite_ram_data;
wire [15:0] sprite_ram_0_dout;
wire [15:0] sprite_ram_1_dout;
wire [15:0] sprite_ram_2_dout;
wire [15:0] sprite_ram_3_dout;

// sprite buffer
ram256bx16dp ram_sprite_0 (
    .clock_a ( clk_sys ),
    .address_a ( sprite_idx[9:2] ),
    .wren_a ( sprite_0_we ),
    .data_a ( sprite_ram_data  ),
    .q_a ( sprite_ram_0_dout[15:0] ),
    );

ram256bx16dp ram_sprite_1 (
    .clock_a ( clk_sys ),
    .address_a ( sprite_idx[9:2] ),
    .wren_a ( sprite_1_we ),
    .data_a ( sprite_ram_data  ),
    .q_a ( sprite_ram_1_dout[15:0] ),
    );

ram256bx16dp ram_sprite_2 (
    .clock_a ( clk_sys ),
    .address_a ( sprite_idx[9:2] ),
    .wren_a ( sprite_2_we ),
    .data_a ( sprite_ram_data ),
    .q_a ( sprite_ram_2_dout[15:0] ),
    );

ram256bx16dp ram_sprite_3 (
    .clock_a ( clk_sys ),
    .address_a ( sprite_idx[9:2] ),
    .wren_a ( sprite_3_we ),
    .data_a ( sprite_ram_data ),
    .q_a ( sprite_ram_3_dout[15:0] ),
    );
    
    
wire [7:0] txt_ram_dout ;
wire [15:0] m68k_txt_ram_dout ;
reg  [12:0] txt_ram_addr ;


ram16kx8dp z80_b_rom (
    .clock_a ( clk_8M ),
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

// shared text ram write arbiter
reg shared_w;
reg [11:0] shared_addr;
reg  [7:0] shared_data;

always @ (posedge clk_sys) begin
    if ( clk_8M == 1 ) begin
        shared_w <= 0;
//        txt_ram_valid <= 0;
        
        // only 68k can read shared. the z80 is write only
        if ( txt_ram_cs & !m68k_lds_n ) begin
            shared_addr <= m68k_a[12:1];
        end
        
        if ( !m68k_rw && txt_ram_cs & !m68k_lds_n ) begin
            shared_data <= m68k_dout[7:0];
            shared_w <= 1;
        end else if (z80_b_ram_txt_cs & ~z80_b_wr_n) begin
            shared_addr <= z80_b_addr[11:0];
            shared_data <= z80_b_dout;
            shared_w <= 1;
        end 
    end
end

// 4 port ram - should figure out real abritration method
ram4kx8dp txt_ram_0 (
    // 68k read and write txt ram
    .clock_a ( clk_sys ),
    .address_a ( shared_addr ),
    .wren_a ( shared_w ),
    .data_a ( shared_data ),
    .q_a ( m68k_txt_attr_ram_dout[7:0] ),
    
    // tile render read txt tile #
    .clock_b ( clk_sys ),
    .address_b ( gfx_txt_addr ),  // 64 sprites * 4 bytes for each == 256
    .wren_b ( 1'b0 ),
    .data_b ( ),
    .q_b( gfx_txt_dout[7:0] )
    );
    
// shadow to allow z80 to read
ram4kx8dp txt_ram_1 (
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
ram4kx8dp txt_ram_2 (
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
ram4kx8dp z80_b_ram_1 (
    .clock_b ( clk_8M ), 
    .address_b ( z80_b_addr[11:0] ),
    .wren_b ( z80_b_ram_1_cs & ~z80_b_wr_n ),
    .data_b ( z80_b_dout ),
    .q_b ( z80_b_ram_1_dout )
    );

// z80 protection ram 1  
ram2kx8dp z80_b_ram_2 (
    .clock_b ( clk_8M ), 
    .address_b ( z80_b_addr[11:0] ),
    .wren_b ( z80_b_ram_2_cs & ~z80_b_wr_n ),
    .data_b ( z80_b_dout ),
    .q_b ( z80_b_ram_2_dout )
    );

    
//  <!-- gfx1       0x020000-0x021fff 8K -->
ram32kx8dp gfx1 (
    .clock_a ( clk_8M ),
    .address_a ( gfx1_addr[16:0] ),
    .wren_a ( 1'b0 ),
    .data_a ( ),
    .q_a ( gfx1_dout[7:0] ),
    
    .clock_b ( clk_sys ),
    .address_b ( ioctl_addr[16:0] ),
    .wren_b ( gfx1_ioctl_wr ),
    .data_b ( ioctl_dout  ),
    .q_b( )
    );

ram128kx8dp gfx2 (
    .clock_a ( clk_8M ),
    .address_a ( gfx2_addr[16:0] ),
    .wren_a ( 1'b0 ),
    .data_a ( ),
    .q_a ( gfx2_dout[7:0] ),
    
    .clock_b ( clk_sys ),
    .address_b ( ioctl_addr[16:0] ),
    .wren_b ( gfx2_ioctl_wr ),
    .data_b ( ioctl_dout  ),
    .q_b( )
    );

ram128kx8dp gfx3 (
    .clock_a ( clk_8M ),
    .address_a ( gfx3_addr[16:0] ),
    .wren_a ( 1'b0 ),
    .data_a ( ),
    .q_a ( gfx3_dout[7:0] ),
    
    .clock_b ( clk_sys ),
    .address_b ( ioctl_addr[16:0] ),
    .wren_b ( gfx3_ioctl_wr ),
    .data_b ( ioctl_dout  ),
    .q_b( )
    );
   
wire [15:0] m68k_rom_data;
wire m68k_rom_valid;

reg  [16:0] sprite_rom_addr;
wire [31:0] sprite_rom_data;
reg sprite_rom_cs;
wire sprite_rom_valid;

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

sdram #(.CLK_FREQ(80.0)) sdram
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
