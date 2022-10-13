
module video_timing
(
    input       clk,
    input       clk_pix,
    input       reset,

    input  [2:0] pcb,
    input  signed [3:0] hs_offset,
    input  signed [3:0] vs_offset,

    input  signed [3:0] hs_width,
    input  signed [3:0] vs_width,

    output [8:0] hc,
    output [8:0] vc,

    output reg  hsync,
    output reg  vsync,

    output reg  hbl,
    output reg  vbl 
);

wire h288 = ( pcb == 4 || pcb == 5 || pcb == 6 || pcb == 7 );
// 6MHz
wire [8:0] h_ofs = 0;
wire [8:0] HBL_START  = h288 ? 288+32 : 320 + 16;
wire [8:0] HBL_END    = h288 ? 32 : 16;
wire [8:0] HS_START   = HBL_START + 8;
wire [8:0] HS_END     = HBL_START + 40;
wire [8:0] HTOTAL     = 387 -1;

wire [8:0] v_ofs = 0;
wire [8:0] VBL_START  = h288 ? 240 : 256;
wire [8:0] VBL_END    = h288 ? 16 : 16;
wire [8:0] VS_START   = h288 ? 244 : 0;
wire [8:0] VS_END     = h288 ? 248 : 8;
wire [8:0] VTOTAL     = 262 ;

reg [8:0] v;
reg [8:0] h;

assign vc = v - v_ofs;
assign hc = h - h_ofs;

always @ (posedge clk) begin
    if (reset) begin
        h <= 0;
        v <= 0;

        hbl <= 0;
        vbl <= 0;

        hsync <= 0;
        vsync <= 0;
    end else if ( clk_pix == 1 ) begin 
        // counter
        if (h == HTOTAL) begin
            h <= 0;
            v <= v + 1'd1;

            if ( v == VTOTAL ) begin
                v <= 0;
            end
        end else begin
            h <= h + 1'd1;
        end

        // h signals
        if ( h == HBL_START ) begin
            hbl <= 1;
        end else if ( h == HBL_END ) begin
            hbl <= 0;
        end

        // v signals
        if ( v == VBL_START ) begin
            vbl <= 1;
        end else if ( v == VBL_END ) begin
            vbl <= 0;
        end
   
        if ( v == (VS_START + $signed(vs_offset) ) ) begin
            vsync <= 1;
        end else if ( v == (VS_END + $signed(vs_offset) + $signed(vs_width) ) ) begin
            vsync <= 0;
        end

        if ( h == (HS_START + $signed(hs_offset) ) ) begin
            hsync <= 1;
        end else if ( h == (HS_END + $signed(hs_offset) + $signed(hs_width) ) ) begin
            hsync <= 0;
        end
    end

end

endmodule


