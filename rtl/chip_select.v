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
    output reg m68k_txt_ram_cs,
    output reg m68k_ram_2_cs,
    output reg m68k_ram_3_cs,
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
localparam pcb_legion          = 2;
localparam pcb_kozure          = 3;

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
            m68k_txt_ram_cs  = m68k_cs( 24'h068000, 24'h069fff ) ; // 4k shared (1k tile attr) low byte
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
            
            m68k_ram_3_cs    = 0; // unused

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
            m68k_ram_2_cs    = m68k_cs( 24'h064000, 24'h065fff ) ; // 8k  

            m68k_bg_ram_cs   = m68k_cs( 24'h066000, 24'h066fff ) ; // 4k
            m68k_fg_ram_cs   = m68k_cs( 24'h067000, 24'h067fff ) ; // 4k

            m68k_txt_ram_cs  = m68k_cs( 24'h068000, 24'h069fff ) ; // 8k shared (1k tile attr) low byte

            m68k_tile_pal_cs = m68k_cs( 24'h06a000, 24'h06afff ) ; // 4k
            
            m68k_spr_pal_cs  = m68k_cs( 24'h06b000, 24'h06bfff ) ; // 4k

            input_p1_cs      = m68k_cs( 24'h06c000, 24'h06c001 ) ; // P1
            input_p2_cs      = m68k_cs( 24'h06c002, 24'h06c003 ) ; // P2
            input_dsw1_cs    = m68k_cs( 24'h06c004, 24'h06c005 ) ; // DSW1
            input_dsw2_cs    = m68k_cs( 24'h06c006, 24'h06c007 ) ; // DSW2
            
            m68k_ram_3_cs    = m68k_cs( 24'h06c008, 24'h06c7ff ) ; // 4k  *** x2

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

        pcb_legion: begin

            m68k_rom_cs      = m68k_cs( 24'h000000, 24'h03ffff ) ;
            m68k_ram_cs      = m68k_cs( 24'h060000, 24'h060fff ) ; // 16k
            m68k_ram_2_cs    = m68k_cs( 24'h061000, 24'h063fff ) ; // 4k  *** x2

            m68k_bg_ram_cs   = m68k_cs( 24'h074000, 24'h074fff ) ; // 4k
            m68k_fg_ram_cs   = m68k_cs( 24'h070000, 24'h070fff ) ; // 4k

            m68k_txt_ram_cs  = m68k_cs( 24'h068000, 24'h069fff ) ; // 4k shared (1k tile attr) low byte
            m68k_tile_pal_cs = m68k_cs( 24'h064000, 24'h064fff ) ; // 4k
            m68k_spr_pal_cs  = m68k_cs( 24'h06c000, 24'h06cfff ) ; // 4k

            input_p1_cs      = m68k_cs( 24'h078000, 24'h078001 ) ; // P1
            input_p2_cs      = m68k_cs( 24'h078002, 24'h078003 ) ; // P2
            input_dsw1_cs    = m68k_cs( 24'h078004, 24'h078005 ) ; // DSW1
            input_dsw2_cs    = m68k_cs( 24'h078006, 24'h078007 ) ; // DSW2

            bg_scroll_x_cs   = m68k_cs( 24'h07c002, 24'h07c003 ) ; // SCROLL X
            bg_scroll_y_cs   = m68k_cs( 24'h07c004, 24'h07c005 ) ; // SCROLL Y

            irq_z80_cs       = m68k_cs( 24'h07c000, 24'h07c001 ) ; // 
            sound_latch_cs   = m68k_cs( 24'h07c00a, 24'h07c00b ) ; // sound latch
            irq_ack_cs       = m68k_cs( 24'h07c00e, 24'h07c00f ) ; // irq ack
            
            m68k_ram_3_cs    = 0; // unused

            z80_rom_cs       = ( MREQ_n == 0 && z80_addr[15:0]  < 16'hf800 );
            z80_ram_cs       = ( MREQ_n == 0 && z80_addr[15:0] >= 16'hf800 );

            z80_sound0_cs    = z80_io_cs(8'h00);
            z80_sound1_cs    = z80_io_cs(8'h01);
            z80_dac1_cs      = z80_io_cs(8'h02);
            z80_dac2_cs      = z80_io_cs(8'h03);
            z80_latch_clr_cs = z80_io_cs(8'h04);
            z80_latch_r_cs   = z80_io_cs(8'h06);
        end

        pcb_kozure: begin

            m68k_rom_cs      = m68k_cs( 24'h000000, 24'h05ffff ) ;
            m68k_ram_cs      = m68k_cs( 24'h060000, 24'h060fff ) ; // 16k
            m68k_ram_2_cs    = m68k_cs( 24'h061000, 24'h063fff ) ; // 4k  *** x2

            m68k_bg_ram_cs   = m68k_cs( 24'h074000, 24'h074fff ) ; // 4k
            m68k_fg_ram_cs   = m68k_cs( 24'h070000, 24'h070fff ) ; // 4k

            m68k_txt_ram_cs  = m68k_cs( 24'h068000, 24'h069fff ) ; // 4k shared (1k tile attr) low byte
            m68k_tile_pal_cs = m68k_cs( 24'h064000, 24'h064fff ) ; // 4k
            m68k_spr_pal_cs  = m68k_cs( 24'h06c000, 24'h06cfff ) ; // 4k

            input_p1_cs      = m68k_cs( 24'h078000, 24'h078001 ) ; // P1
            input_p2_cs      = m68k_cs( 24'h078002, 24'h078003 ) ; // P2
            input_dsw1_cs    = m68k_cs( 24'h078004, 24'h078005 ) ; // DSW1
            input_dsw2_cs    = m68k_cs( 24'h078006, 24'h078007 ) ; // DSW2

            bg_scroll_x_cs   = m68k_cs( 24'h07c002, 24'h07c003 ) ; // SCROLL X
            bg_scroll_y_cs   = m68k_cs( 24'h07c004, 24'h07c005 ) ; // SCROLL Y

            irq_z80_cs       = m68k_cs( 24'h07c000, 24'h07c001 ) ; // 
            sound_latch_cs   = m68k_cs( 24'h07c00a, 24'h07c00b ) ; // sound latch

            irq_ack_cs       = m68k_cs( 24'h07c00e, 24'h07c00f ) ; // irq ack
            
            m68k_ram_3_cs    = 0; // unused

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
    
endmodule
