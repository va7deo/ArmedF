//

module chip_select
(
    input  [2:0] pcb,

    input [23:0] m68k_a,
    input        m68k_as_n,

    input [15:0] z80_addr,
    input        MREQ_n,
    input        IORQ_n,
    input        M1_n,

    // M68K selects
    output reg m68k_rom_cs,
    output reg m68k_ram_cs,
    output reg m68k_tile_pal_cs,
    output reg txt_ram_cs,
    output reg m68k_ram_2_cs,
    output reg m68k_spr_pal_cs,
    output reg m68k_fg_ram_cs,
    output reg m68k_bg_ram_cs,
    output reg input_p1_cs,
    output reg input_p2_cs,
    output reg input_dsw1_cs,
    output reg input_dsw2_cs,
    output reg irq_z80_cs,
    output reg bg_scroll_x_cs,
    output reg bg_scroll_y_cs,
    output reg fg_scroll_x_cs,
    output reg fg_scroll_y_cs,
    output reg sound_latch_cs,
    output reg irq_ack_cs,

    // Z80 selects
    output reg   z80_rom_cs,
    output reg   z80_ram_cs,

    output reg   z80_sound0_cs,
    output reg   z80_sound1_cs,
    output reg   z80_dac1_cs,
    output reg   z80_dac2_cs,
    output reg   z80_latch_clr_cs,
    output reg   z80_latch_r_cs

);

localparam pcb_terra_force     = 0;
localparam pcb_armedf          = 1;

function m68k_cs;
        input [23:0] start_address;
        input [23:0] end_address;
begin
    m68k_cs = ( m68k_a[23:0] >= start_address && m68k_a[23:0] <= end_address) & !m68k_as_n;
end
endfunction

function z80_mem_cs;
        input [15:0] base_address;
        input  [7:0] width;
begin
    z80_mem_cs = ( z80_addr >> width == base_address >> width ) & !MREQ_n;
end
endfunction

function z80_io_cs;
        input [7:0] address_lo;
begin
    z80_io_cs = ( IORQ_n == 0 && z80_addr[7:0] == address_lo );
end
endfunction


always @ (*) begin
    // Memory mapping based on PCB type
    case (pcb)
        pcb_terra_force: begin

            m68k_rom_cs      = m68k_cs( 24'h000000, 24'h05ffff ) ;
            m68k_ram_cs      = m68k_cs( 24'h060000, 24'h063fff ) ; // 16k

            m68k_tile_pal_cs = m68k_cs( 24'h064000, 24'h064fff ) ; // 4k
            txt_ram_cs       = m68k_cs( 24'h068000, 24'h069fff ) ; // 4k shared (1k tile attr) low byte
            m68k_ram_2_cs    = m68k_cs( 24'h06a000, 24'h06afff ) ; // 4k
            m68k_spr_pal_cs  = m68k_cs( 24'h06c000, 24'h06cfff ) ; // 4k
            m68k_fg_ram_cs   = m68k_cs( 24'h070000, 24'h070fff ) ; // 4k
            m68k_bg_ram_cs   = m68k_cs( 24'h074000, 24'h074fff ) ; // 4k

            input_p1_cs      = m68k_cs( 24'h078000, 24'h078001 ) ; // P1
            input_p2_cs      = m68k_cs( 24'h078002, 24'h078003 ) ; // P2
            input_dsw1_cs    = m68k_cs( 24'h078004, 24'h078005 ) ; // DSW1
            input_dsw2_cs    = m68k_cs( 24'h078006, 24'h078007 ) ; // DSW2

            irq_z80_cs       = m68k_cs( 24'h07c000, 24'h07c001 ) ; //
            bg_scroll_x_cs   = m68k_cs( 24'h07c002, 24'h07c003 ) ; // SCROLL X
            bg_scroll_y_cs   = m68k_cs( 24'h07c004, 24'h07c005 ) ; // SCROLL Y
            sound_latch_cs   = m68k_cs( 24'h07c00a, 24'h07c00b ) ; // sound latch
            irq_ack_cs       = m68k_cs( 24'h07c00e, 24'h07c00f ) ; // irq ack

            z80_rom_cs       = ( MREQ_n == 0 && z80_addr[15:0]  < 16'hf800 );
            z80_ram_cs       = ( MREQ_n == 0 && z80_addr[15:0] >= 16'hf800 );

            z80_sound0_cs    = z80_io_cs(8'h00);
            z80_sound1_cs    = z80_io_cs(8'h01);
            z80_dac1_cs      = z80_io_cs(8'h02);
            z80_dac2_cs      = z80_io_cs(8'h03);
            z80_latch_clr_cs = z80_io_cs(8'h04);
            z80_latch_r_cs   = z80_io_cs(8'h06);
        end

        pcb_armedf: begin

            m68k_rom_cs      = m68k_cs( 24'h000000, 24'h05ffff ) ;
            m68k_ram_cs      = m68k_cs( 24'h060000, 24'h063fff ) ; // 16k
            m68k_ram_2_cs    = m68k_cs( 24'h064000, 24'h065fff ) ; // 4k  *** x2

            m68k_bg_ram_cs   = m68k_cs( 24'h066000, 24'h066fff ) ; // 4k
            m68k_fg_ram_cs   = m68k_cs( 24'h067000, 24'h067fff ) ; // 4k

            txt_ram_cs       = m68k_cs( 24'h068000, 24'h069fff ) ; // 4k shared (1k tile attr) low byte
            m68k_tile_pal_cs = m68k_cs( 24'h06a000, 24'h06afff ) ; // 4k
            m68k_spr_pal_cs  = m68k_cs( 24'h06b000, 24'h06bfff ) ; // 4k

            input_p1_cs      = m68k_cs( 24'h06c000, 24'h06c001 ) ; // P1
            input_p2_cs      = m68k_cs( 24'h06c002, 24'h06c003 ) ; // P2
            input_dsw1_cs    = m68k_cs( 24'h06c004, 24'h06c005 ) ; // DSW1
            input_dsw2_cs    = m68k_cs( 24'h06c006, 24'h06c007 ) ; // DSW2

            bg_scroll_x_cs   = m68k_cs( 24'h06d002, 24'h06d003 ) ; // SCROLL X
            bg_scroll_y_cs   = m68k_cs( 24'h06d004, 24'h06d005 ) ; // SCROLL Y

            fg_scroll_x_cs   = m68k_cs( 24'h06d006, 24'h06d007 ) ; // SCROLL X
            fg_scroll_y_cs   = m68k_cs( 24'h06d008, 24'h06d009 ) ; // SCROLL Y
            
            irq_z80_cs       = m68k_cs( 24'h06d000, 24'h06d001 ) ; // 
            sound_latch_cs   = m68k_cs( 24'h06d00a, 24'h06d00b ) ; // sound latch
            irq_ack_cs       = m68k_cs( 24'h06d00e, 24'h06d00f ) ; // irq ack

            z80_rom_cs       = ( MREQ_n == 0 && z80_addr[15:0]  < 16'hf800 );
            z80_ram_cs       = ( MREQ_n == 0 && z80_addr[15:0] >= 16'hf800 );

            z80_sound0_cs    = z80_io_cs(8'h00);
            z80_sound1_cs    = z80_io_cs(8'h01);
            z80_dac1_cs      = z80_io_cs(8'h02);
            z80_dac2_cs      = z80_io_cs(8'h03);
            z80_latch_clr_cs = z80_io_cs(8'h04);
            z80_latch_r_cs   = z80_io_cs(8'h06);
        end

        default:;
    endcase
end

//	map(0x000000, 0x05ffff).rom();
//	map(0x060000, 0x060fff).ram().share("spriteram");
//	map(0x061000, 0x065fff).ram();
//	map(0x066000, 0x066fff).ram().w(FUNC(armedf_state::bg_videoram_w)).share("bg_videoram");
//	map(0x067000, 0x067fff).ram().w(FUNC(armedf_state::fg_videoram_w)).share("fg_videoram");
//	map(0x068000, 0x069fff).rw(FUNC(armedf_state::text_videoram_r), FUNC(armedf_state::text_videoram_w)).umask16(0x00ff);
//	map(0x06a000, 0x06afff).ram().w(m_palette, FUNC(palette_device::write16)).share("palette");
//	map(0x06b000, 0x06bfff).ram().share("spr_pal_clut");
//	map(0x06c000, 0x06c7ff).ram();
//	map(0x06c000, 0x06c001).portr("P1");
//	map(0x06c002, 0x06c003).portr("P2");
//	map(0x06c004, 0x06c005).portr("DSW1");
//	map(0x06c006, 0x06c007).portr("DSW2");
//	map(0x06d000, 0x06d001).w(FUNC(armedf_state::armedf_io_w));
//	map(0x06d002, 0x06d003).w(FUNC(armedf_state::bg_scrollx_w));
//	map(0x06d004, 0x06d005).w(FUNC(armedf_state::bg_scrolly_w));
//	map(0x06d006, 0x06d007).w(FUNC(armedf_state::fg_scrollx_w));
//	map(0x06d008, 0x06d009).w(FUNC(armedf_state::fg_scrolly_w));
//	map(0x06d00b, 0x06d00b).w(FUNC(armedf_state::sound_command_w));
//	map(0x06d00c, 0x06d00d).nopw(); //watchdog?
//	map(0x06d00e, 0x06d00f).w(FUNC(armedf_state::irq_lv1_ack_w));
    
endmodule
