003E02: 007C 0700                ori     #$700, SR				; set interrupt mask, disable interrupts
003E06: 4EBA 00F4                jsr     ($f4,PC) ; ($3efc)		; ?
003E0A: 33F9 0006 0604 0007 C000 move.w  $60604.l, $7c000.l		; ram -> terraf_io_w
003E14: 23F9 0006 0606 0007 C002 move.l  $60606.l, $7c002.l		; bg_scrollx_w
003E1E: 33FC 0000 0007 C00C      move.w  #$0, $7c00c.l
003E26: 33FC 0100 0007 C00C      move.w  #$100, $7c00c.l		; ? nopw
003E2E: 33FC 0200 0007 C00C      move.w  #$200, $7c00c.l		; ? nopw
003E36: 4EB9 0000 7814           jsr     $7814.l
003E3C: 4EB9 0000 75B8           jsr     $75b8.l
003E42: 1039 0006 0630           move.b  $60630.l, D0
003E48: E858                     ror.w   #4, D0
003E4A: 0240 1000                andi.w  #$1000, D0
003E4E: 0279 EFFF 0006 0604      andi.w  #$efff, $60604.l
003E56: 8179 0006 0604           or.w    D0, $60604.l
003E5C: 1039 0006 0600           move.b  $60600.l, D0
003E62: 0C00 0006                cmpi.b  #$6, D0
003E66: 6506                     bcs     $3e6e
003E68: 4EB9 0000 76B0           jsr     $76b0.l
003E6E: 0839 0005 0006 0623      btst    #$5, $60623.l
003E76: 676A                     beq     $3ee2
003E78: 1039 0006 0600           move.b  $60600.l, D0
003E7E: 6762                     beq     $3ee2
003E80: 0C00 0004                cmpi.b  #$4, D0
003E84: 675C                     beq     $3ee2
003E86: 0C00 0002                cmpi.b  #$2, D0
003E8A: 6726                     beq     $3eb2
003E8C: 41FA 0008                lea     ($8,PC) ; ($3e96), A0
003E90: 4EB9 0000 758A           jsr     $758a.l
003E96: 33FC 0200 0006 0600      move.w  #$200, $60600.l
003E9E: 703F                     moveq   #$3f, D0
003EA0: 4EB9 0000 77EA           jsr     $77ea.l
003EA6: 08F9 0005 0006 0622      bset    #$5, $60622.l
003EAE: 6000 C27E                bra     $12e
003EB2: 3439 0006 0622           move.w  $60622.l, D2
003EB8: 41FA 0008                lea     ($8,PC) ; ($3ec2), A0
003EBC: 4EB9 0000 758A           jsr     $758a.l
003EC2: 33C2 0006 0622           move.w  D2, $60622.l
003EC8: 33FC 0600 0006 0600      move.w  #$600, $60600.l
003ED0: 4EB9 0000 7612           jsr     $7612.l
003ED6: 703F                     moveq   #$3f, D0
003ED8: 4EB9 0000 77EA           jsr     $77ea.l
003EDE: 6000 C24E                bra     $12e
003EE2: 5239 0006 0603           addq.b  #1, $60603.l
003EE8: 5239 0006 0602           addq.b  #1, $60602.l
003EEE: 4EB9 0000 4BA8           jsr     $4ba8.l
003EF4: 33C0 0007 C00E           move.w  D0, $7c00e.l
003EFA: 4E73                     rte
003EFC: 41F9 0006 0648           lea     $60648.l, A0
003F02: 3210                     move.w  (A0), D1
003F04: 6714                     beq     $3f1a
003F06: 4258                     clr.w   (A0)+
003F08: 7400                     moveq   #$0, D2
003F0A: 1401                     move.b  D1, D2
003F0C: 343B 2014                move.w  ($14,PC,D2.w), D2
003F10: 2442                     movea.l D2, A2
003F12: 4879 0000 3F02           pea     $3f02.l
003F18: 4ED2                     jmp     (A2)
003F1A: 33C1 0006 066C           move.w  D1, $6066c.l
003F20: 4E75                     rts
003F22: 46BC                     dc.w    $46bc; ILLEGAL
003F24: 46E8 4718                move    ($4718,A0), SR
003F28: 47C0                     dc.w    $47c0; ILLEGAL
003F2A: 47A2                     chk.w   -(A2), D3
003F2C: 467A                     dc.w    $467a; ILLEGAL
003F2E: 447C                     dc.w    $447c; ILLEGAL
003F30: 442C 475C                neg.b   ($475c,A4)
003F34: 4582                     chk.w   D2, D2
003F36: 43FC                     dc.w    $43fc; ILLEGAL
003F38: 45EA 4632                lea     ($4632,A2), A2
003F3C: 45BE                     dc.w    $45be; ILLEGAL
003F3E: 45D4                     lea     (A4), A2
003F40: 4538                     dc.w    $4538; ILLEGAL
003F42: 4168                     dc.w    $4168; ILLEGAL
003F44: 42C2                     dc.w    $42c2; ILLEGAL
003F46: 41A8 4252                chk.w   ($4252,A0), D0
003F4A: 4138                     dc.w    $4138; ILLEGAL
003F4C: 411E                     dc.w    $411e; ILLEGAL
003F4E: 410A                     dc.w    $410a; ILLEGAL
003F50: 4116                     dc.w    $4116; ILLEGAL
003F52: 40DC                     move    SR, (A4)+
003F54: 40C8                     dc.w    $40c8; ILLEGAL
003F56: 013C 405A                btst    D0, #$5a
003F5A: 40AA 4222                negx.l  ($4222,A2)
003F5E: 423A                     dc.w    $423a; ILLEGAL
003F60: 404C                     dc.w    $404c; ILLEGAL
003F62: 3FD0                     dc.w    $3fd0; ILLEGAL
003F64: 3F9A 3F68                move.w  (A2)+, INVALID 37
003F68: 33FC DAA3 0007 033E      move.w  #$daa3, $7033e.l
003F70: 33FC DAA7 0007 037E      move.w  #$daa7, $7037e.l
003F78: 33FC DAAB 0007 03BE      move.w  #$daab, $703be.l
003F80: 33FC DAAB 0007 043E      move.w  #$daab, $7043e.l
003F88: 33FC DAAF 0007 047E      move.w  #$daaf, $7047e.l
003F90: 33FC DAB3 0007 04BE      move.w  #$dab3, $704be.l
003F98: 4E75                     rts
003F9A: 45F9 0000 4A60           lea     $4a60.l, A2
003FA0: 6100 072C                bsr     $46ce
003FA4: 45F9 0000 4A70           lea     $4a70.l, A2
003FAA: 6100 0722                bsr     $46ce
003FAE: 43F9 0006 8364           lea     $68364.l, A1
003FB4: 3039 0006 0898           move.w  $60898.l, D0
003FBA: 0C40 0010                cmpi.w  #$10, D0
003FBE: 6604                     bne     $3fc4
003FC0: 32FC 0011                move.w  #$11, (A1)+			; 
003FC4: 0240 000F                andi.w  #$f, D0
003FC8: 0040 0010                ori.w   #$10, D0
003FCC: 3280                     move.w  D0, (A1)
003FCE: 4E75                     rts
003FD0: 243C 0040 0040           move.l  #$400040, D2
003FD6: 0839 0002 0006 0603      btst    #$2, $60603.l
003FDE: 6706                     beq     $3fe6
003FE0: 243C 0050 0050           move.l  #$500050, D2
003FE6: 3039 0006 0896           move.w  $60896.l, D0
003FEC: 0C40 0005                cmpi.w  #$5, D0
003FF0: 642C                     bcc     $401e
003FF2: EF48                     lsl.w   #7, D0
003FF4: 43F9 0006 8BE4           lea     $68be4.l, A1
003FFA: 3382 0000                move.w  D2, (A1,D0.w)
003FFE: 2382 0006                move.l  D2, ($6,A1,D0.w)
004002: 2382 000A                move.l  D2, ($a,A1,D0.w)
004006: 2382 000E                move.l  D2, ($e,A1,D0.w)
00400A: 2382 0012                move.l  D2, ($12,A1,D0.w)
00400E: 3382 001A                move.w  D2, ($1a,A1,D0.w)
004012: 43F9 0006 9BC0           lea     $69bc0.l, A1
004018: 2382 0000                move.l  D2, (A1,D0.w)
00401C: 4E75                     rts
00401E: 5B40                     subq.w  #5, D0
004020: EF48                     lsl.w   #7, D0
004022: 43F9 0006 9BFC           lea     $69bfc.l, A1
004028: 3382 0000                move.w  D2, (A1,D0.w)
00402C: 43F9 0006 8BC2           lea     $68bc2.l, A1
004032: 2382 0000                move.l  D2, (A1,D0.w)
004036: 2382 0004                move.l  D2, ($4,A1,D0.w)
00403A: 2382 0008                move.l  D2, ($8,A1,D0.w)
00403E: 2382 000C                move.l  D2, ($c,A1,D0.w)
004042: 2382 0014                move.l  D2, ($14,A1,D0.w)
004046: 3382 0018                move.w  D2, ($18,A1,D0.w)
00404A: 4E75                     rts
00404C: 2279 0006 089E           movea.l $6089e.l, A1
004052: 32B9 0006 08A2           move.w  $608a2.l, (A1)
004058: 4E75                     rts
00405A: 45F9 0000 49E6           lea     $49e6.l, A2
004060: 1039 0006 06BE           move.b  $606be.l, D0
004066: 4A39 0006 07D5           tst.b   $607d5.l
00406C: 670C                     beq     $407a
00406E: 45F9 0000 49F8           lea     $49f8.l, A2
004074: 1039 0006 06BF           move.b  $606bf.l, D0
00407A: 6100 0652                bsr     $46ce
00407E: 45F9 0000 4A0A           lea     $4a0a.l, A2
004084: 6100 0648                bsr     $46ce
004088: 43F9 0006 8464           lea     $68464.l, A1
00408E: 3400                     move.w  D0, D2
004090: 0200 000F                andi.b  #$f, D0
004094: 0040 0030                ori.w   #$30, D0
004098: 3300                     move.w  D0, -(A1)
00409A: 0242 00F0                andi.w  #$f0, D2
00409E: 6708                     beq     $40a8
0040A0: E84A                     lsr.w   #4, D2
0040A2: 0042 0030                ori.w   #$30, D2
0040A6: 3282                     move.w  D2, (A1)
0040A8: 4E75                     rts
0040AA: 45F9 0000 49F8           lea     $49f8.l, A2
0040B0: 6100 0648                bsr     $46fa
0040B4: 45F9 0000 4A0A           lea     $4a0a.l, A2
0040BA: 6100 063E                bsr     $46fa
0040BE: 45F9 0000 4A1A           lea     $4a1a.l, A2
0040C4: 6000 0634                bra     $46fa
0040C8: 43F9 0006 2778           lea     $62778.l, A1
0040CE: 2459                     movea.l (A1)+, A2
0040D0: 2659                     movea.l (A1)+, A3
0040D2: 3019                     move.w  (A1)+, D0
0040D4: 34DB                     move.w  (A3)+, (A2)+
0040D6: 51C8 FFFC                dbra    D0, $40d4
0040DA: 4E75                     rts
0040DC: 2279 0006 2778           movea.l $62778.l, A1
0040E2: 2479 0006 277C           movea.l $6277c.l, A2
0040E8: 7006                     moveq   #$6, D0
0040EA: 7208                     moveq   #$8, D1
0040EC: 3499                     move.w  (A1)+, (A2)
0040EE: D5FC 0000 0040           adda.l  #$40, A2
0040F4: 51C9 FFF6                dbra    D1, $40ec
0040F8: D3FC 0000 0016           adda.l  #$16, A1
0040FE: 95FC 0000 0242           suba.l  #$242, A2
004104: 51C8 FFE4                dbra    D0, $40ea
004108: 4E75                     rts
00410A: 23FC EA12 EA12 0007 040A move.l  #$ea12ea12, $7040a.l
004114: 4E75                     rts
004116: 42B9 0007 040A           clr.l   $7040a.l
00411C: 4E75                     rts
00411E: 43F9 0007 0000           lea     $70000.l, A1
004124: 45F9 0007 4000           lea     $74000.l, A2
00412A: 303C 03FF                move.w  #$3ff, D0
00412E: 4299                     clr.l   (A1)+
004130: 429A                     clr.l   (A2)+
004132: 51C8 FFFA                dbra    D0, $412e
004136: 4E75                     rts
004138: 43F9 0006 2778           lea     $62778.l, A1
00413E: 2459                     movea.l (A1)+, A2
004140: 2659                     movea.l (A1)+, A3
004142: 780C                     moveq   #$c, D4
004144: 7607                     moveq   #$7, D3
004146: 2559 0800                move.l  (A1)+, ($800,A2)
00414A: 24D9                     move.l  (A1)+, (A2)+
00414C: 51CB FFF8                dbra    D3, $4146
004150: 95FC 0000 0060           suba.l  #$60, A2
004156: 2759 0800                move.l  (A1)+, ($800,A3)
00415A: 2699                     move.l  (A1)+, (A3)
00415C: 97FC 0000 0040           suba.l  #$40, A3
004162: 51CC FFE0                dbra    D4, $4144
004166: 4E75                     rts
004168: 43F9 0006 86C2           lea     $686c2.l, A1
00416E: 7240                     moveq   #$40, D1
004170: 1039 0006 06D4           move.b  $606d4.l, D0
004176: 4EB9 0000 4698           jsr     $4698.l
00417C: 1039 0006 06D5           move.b  $606d5.l, D0
004182: 4EB9 0000 4698           jsr     $4698.l
004188: 43F9 0006 8682           lea     $68682.l, A1
00418E: 3639 0006 06D4           move.w  $606d4.l, D3
004194: E24B                     lsr.w   #1, D3
004196: 3003                     move.w  D3, D0
004198: E058                     ror.w   #8, D0
00419A: 4EB9 0000 4698           jsr     $4698.l
0041A0: 3003                     move.w  D3, D0
0041A2: 4EF9 0000 4698           jmp     $4698.l
0041A8: 23FC 0021 0022 0006 90FA move.l  #$210022, $690fa.l
0041B2: 23FC 0029 002A 0006 90BA move.l  #$29002a, $690ba.l
0041BC: 33FC 0028 0006 90BE      move.w  #$28, $690be.l
0041C4: 23FC 0020 0020 0006 98FA move.l  #$200020, $698fa.l
0041CE: 23FC 0020 0020 0006 98BA move.l  #$200020, $698ba.l
0041D8: 33FC 0020 0006 98BE      move.w  #$20, $698be.l
0041E0: 43F9 0006 8080           lea     $68080.l, A1
0041E6: 1039 0006 06BE           move.b  $606be.l, D0
0041EC: 4A39 0006 07D5           tst.b   $607d5.l
0041F2: 6706                     beq     $41fa
0041F4: 1039 0006 06BF           move.b  $606bf.l, D0
0041FA: 3400                     move.w  D0, D2
0041FC: E858                     ror.w   #4, D0
0041FE: 0200 000F                andi.b  #$f, D0
004202: 670C                     beq     $4210
004204: 0040 0030                ori.w   #$30, D0
004208: 337C 0020 0800           move.w  #$20, ($800,A1)
00420E: 32C0                     move.w  D0, (A1)+
004210: 0202 000F                andi.b  #$f, D2
004214: 0042 0030                ori.w   #$30, D2
004218: 337C 0020 0800           move.w  #$20, ($800,A1)
00421E: 3282                     move.w  D2, (A1)
004220: 4E75                     rts
004222: 45F9 0000 4A28           lea     $4a28.l, A2
004228: 6100 04A4                bsr     $46ce
00422C: 43F9 0006 8700           lea     $68700.l, A1
004232: 45F9 0006 06B6           lea     $606b6.l, A2
004238: 602E                     bra     $4268
00423A: 45F9 0000 4A34           lea     $4a34.l, A2
004240: 6100 048C                bsr     $46ce
004244: 43F9 0006 8730           lea     $68730.l, A1
00424A: 45F9 0006 06BA           lea     $606ba.l, A2
004250: 6016                     bra     $4268
004252: 45F9 0000 4A7C           lea     $4a7c.l, A2
004258: 6100 0474                bsr     $46ce
00425C: 43F9 0006 8718           lea     $68718.l, A1
004262: 45F9 0006 06B2           lea     $606b2.l, A2
004268: 7210                     moveq   #$10, D1
00426A: 4243                     clr.w   D3
00426C: 101A                     move.b  (A2)+, D0
00426E: 6100 001C                bsr     $428c
004272: 101A                     move.b  (A2)+, D0
004274: 6100 0016                bsr     $428c
004278: 101A                     move.b  (A2)+, D0
00427A: 6100 0010                bsr     $428c
00427E: 1012                     move.b  (A2), D0
004280: 337C 0010 0802           move.w  #$10, ($802,A1)
004286: 337C 0030 0002           move.w  #$30, ($2,A1)
00428C: 3400                     move.w  D0, D2
00428E: E858                     ror.w   #4, D0
004290: 0200 000F                andi.b  #$f, D0
004294: 6604                     bne     $429a
004296: 4A43                     tst.w   D3
004298: 670C                     beq     $42a6
00429A: 5243                     addq.w  #1, D3
00429C: 0040 0030                ori.w   #$30, D0
0042A0: 3341 0800                move.w  D1, ($800,A1)
0042A4: 3280                     move.w  D0, (A1)
0042A6: 5489                     addq.l  #2, A1
0042A8: 0202 000F                andi.b  #$f, D2
0042AC: 6604                     bne     $42b2
0042AE: 4A43                     tst.w   D3
0042B0: 670C                     beq     $42be
0042B2: 5243                     addq.w  #1, D3
0042B4: 0042 0030                ori.w   #$30, D2
0042B8: 3341 0800                move.w  D1, ($800,A1)
0042BC: 3282                     move.w  D2, (A1)
0042BE: 5489                     addq.l  #2, A1
0042C0: 4E75                     rts
0042C2: 4A39 0006 07D5           tst.b   $607d5.l
0042C8: 660E                     bne     $42d8
0042CA: 43F9 0006 876A           lea     $6876a.l, A1
0042D0: 45F9 0006 872A           lea     $6872a.l, A2
0042D6: 600C                     bra     $42e4
0042D8: 43F9 0006 8740           lea     $68740.l, A1
0042DE: 45F9 0006 8700           lea     $68700.l, A2
0042E4: 237C 0070 0070 0800      move.l  #$700070, ($800,A1)
0042EC: 22FC 0008 0009           move.l  #$80009, (A1)+
0042F2: 237C 0070 0010 0800      move.l  #$700010, ($800,A1)
0042FA: 22FC 000A 0000           move.l  #$a0000, (A1)+
004300: 237C 0080 0080 0800      move.l  #$800080, ($800,A1)
004308: 22FC 0078 0079           move.l  #$780079, (A1)+
00430E: 237C 0080 0010 0800      move.l  #$800010, ($800,A1)
004316: 22FC 007A 0000           move.l  #$7a0000, (A1)+
00431C: 237C 0090 0090 0800      move.l  #$900090, ($800,A1)
004324: 22FC 001A 001B           move.l  #$1a001b, (A1)+
00432A: 337C 0090 0800           move.w  #$90, ($800,A1)
004330: 32BC 001C                move.w  #$1c, (A1)
004334: 7000                     moveq   #$0, D0
004336: 1039 0006 06EB           move.b  $606eb.l, D0
00433C: E748                     lsl.w   #3, D0
00433E: 47FA 005C                lea     ($5c,PC) ; ($439c), A3
004342: D7C0                     adda.l  D0, A3
004344: 257C 0070 0070 0800      move.l  #$700070, ($800,A2)
00434C: 24DB                     move.l  (A3)+, (A2)+
00434E: 257C 0070 0010 0800      move.l  #$700010, ($800,A2)
004356: 24D3                     move.l  (A3), (A2)+
004358: 1039 0006 06EC           move.b  $606ec.l, D0
00435E: E748                     lsl.w   #3, D0
004360: 47FA 005A                lea     ($5a,PC) ; ($43bc), A3
004364: D7C0                     adda.l  D0, A3
004366: 257C 0080 0080 0800      move.l  #$800080, ($800,A2)
00436E: 24DB                     move.l  (A3)+, (A2)+
004370: 257C 0080 0010 0800      move.l  #$800010, ($800,A2)
004378: 24D3                     move.l  (A3), (A2)+
00437A: 1039 0006 06EE           move.b  $606ee.l, D0
004380: E748                     lsl.w   #3, D0
004382: 47FA 0058                lea     ($58,PC) ; ($43dc), A3
004386: D7C0                     adda.l  D0, A3
004388: 257C 0090 0090 0800      move.l  #$900090, ($800,A2)
004390: 24DB                     move.l  (A3)+, (A2)+
004392: 357C 0090 0800           move.w  #$90, ($800,A2)
004398: 3493                     move.w  (A3), (A2)
00439A: 4E75                     rts
00439C: 0000 0000                ori.b   #$0, D0
0043A0: 0000 0000                ori.b   #$0, D0
0043A4: 000B                     dc.w    $000b; ILLEGAL
0043A6: 0000 0000                ori.b   #$0, D0
0043AA: 0000 000B                ori.b   #$b, D0
0043AE: 000C                     dc.w    $000c; ILLEGAL
0043B0: 0000 0000                ori.b   #$0, D0
0043B4: 000B                     dc.w    $000b; ILLEGAL
0043B6: 000C                     dc.w    $000c; ILLEGAL
0043B8: 000D                     dc.w    $000d; ILLEGAL
0043BA: 0000 0000                ori.b   #$0, D0
0043BE: 0000 0000                ori.b   #$0, D0
0043C2: 0000 007B                ori.b   #$7b, D0
0043C6: 0000 0000                ori.b   #$0, D0
0043CA: 0000 007B                ori.b   #$7b, D0
0043CE: 007C 0000                ori     #$0, SR
0043D2: 0000 007B                ori.b   #$7b, D0
0043D6: 007C 007D                ori     #$7d, SR
0043DA: 0000 0000                ori.b   #$0, D0
0043DE: 0000 0000                ori.b   #$0, D0
0043E2: 0000 0025                ori.b   #$25, D0
0043E6: 0000 0000                ori.b   #$0, D0
0043EA: 0000 0025                ori.b   #$25, D0
0043EE: 0026 0000                ori.b   #$0, -(A6)
0043F2: 0000 0025                ori.b   #$25, D0
0043F6: 0026 0027                ori.b   #$27, -(A6)
0043FA: 0000 43F9                ori.b   #$f9, D0
0043FE: 0006 86EE                ori.b   #$ee, D6
004402: 7230                     moveq   #$30, D1
004404: 3341 0800                move.w  D1, ($800,A1)
004408: 1039 0006 0613           move.b  $60613.l, D0
00440E: 0040 0030                ori.w   #$30, D0
004412: 3280                     move.w  D0, (A1)
004414: 43F9 0006 86AE           lea     $686ae.l, A1
00441A: 3341 0800                move.w  D1, ($800,A1)
00441E: 1039 0006 0614           move.b  $60614.l, D0
004424: 0040 0030                ori.w   #$30, D0
004428: 3280                     move.w  D0, (A1)
00442A: 4E75                     rts
00442C: 45F9 0006 4000           lea     $64000.l, A2
004432: 43F9 0004 8DF0           lea     $48df0.l, A1
004438: 7007                     moveq   #$7, D0
00443A: 24D9                     move.l  (A1)+, (A2)+
00443C: 51C8 FFFC                dbra    D0, $443a
004440: 43F9 0006 2778           lea     $62778.l, A1
004446: 1039 0006 0603           move.b  $60603.l, D0
00444C: 0200 0007                andi.b  #$7, D0
004450: 6602                     bne     $4454
004452: 5251                     addq.w  #1, (A1)
004454: 3011                     move.w  (A1), D0
004456: 0C40 000E                cmpi.w  #$e, D0
00445A: 6504                     bcs     $4460
00445C: 4251                     clr.w   (A1)
00445E: 4240                     clr.w   D0
004460: E548                     lsl.w   #2, D0
004462: 43F9 0004 8E0E           lea     $48e0e.l, A1
004468: 2271 0000                movea.l (A1,D0.w), A1
00446C: 45F9 0006 4000           lea     $64000.l, A2
004472: 7004                     moveq   #$4, D0
004474: 24D9                     move.l  (A1)+, (A2)+
004476: 51C8 FFFC                dbra    D0, $4474
00447A: 4E75                     rts
00447C: 43F9 0004 8BB0           lea     $48bb0.l, A1
004482: 45F9 0006 8708           lea     $68708.l, A2
004488: 47F9 0006 8F08           lea     $68f08.l, A3
00448E: 700B                     moveq   #$b, D0
004490: 2229 0210                move.l  ($210,A1), D1
004494: 2541 FD40                move.l  D1, (-$2c0,A2)
004498: E089                     lsr.l   #8, D1
00449A: 2741 FD40                move.l  D1, (-$2c0,A3)
00449E: 2229 01E0                move.l  ($1e0,A1), D1
0044A2: 2541 FD80                move.l  D1, (-$280,A2)
0044A6: E089                     lsr.l   #8, D1
0044A8: 2741 FD80                move.l  D1, (-$280,A3)
0044AC: 2229 01B0                move.l  ($1b0,A1), D1
0044B0: 2541 FDC0                move.l  D1, (-$240,A2)
0044B4: E089                     lsr.l   #8, D1
0044B6: 2741 FDC0                move.l  D1, (-$240,A3)
0044BA: 2229 0180                move.l  ($180,A1), D1
0044BE: 2541 FE00                move.l  D1, (-$200,A2)
0044C2: E089                     lsr.l   #8, D1
0044C4: 2741 FE00                move.l  D1, (-$200,A3)
0044C8: 2229 0150                move.l  ($150,A1), D1
0044CC: 2541 FE40                move.l  D1, (-$1c0,A2)
0044D0: E089                     lsr.l   #8, D1
0044D2: 2741 FE40                move.l  D1, (-$1c0,A3)
0044D6: 2229 0120                move.l  ($120,A1), D1
0044DA: 2541 FE80                move.l  D1, (-$180,A2)
0044DE: E089                     lsr.l   #8, D1
0044E0: 2741 FE80                move.l  D1, (-$180,A3)
0044E4: 2229 00F0                move.l  ($f0,A1), D1
0044E8: 2541 FEC0                move.l  D1, (-$140,A2)
0044EC: E089                     lsr.l   #8, D1
0044EE: 2741 FEC0                move.l  D1, (-$140,A3)
0044F2: 2229 00C0                move.l  ($c0,A1), D1
0044F6: 2541 FF00                move.l  D1, (-$100,A2)
0044FA: E089                     lsr.l   #8, D1
0044FC: 2741 FF00                move.l  D1, (-$100,A3)
004500: 2229 0090                move.l  ($90,A1), D1
004504: 2541 FF40                move.l  D1, (-$c0,A2)
004508: E089                     lsr.l   #8, D1
00450A: 2741 FF40                move.l  D1, (-$c0,A3)
00450E: 2229 0060                move.l  ($60,A1), D1
004512: 2541 FF80                move.l  D1, (-$80,A2)
004516: E089                     lsr.l   #8, D1
004518: 2741 FF80                move.l  D1, (-$80,A3)
00451C: 2229 0030                move.l  ($30,A1), D1
004520: 2541 FFC0                move.l  D1, (-$40,A2)
004524: E089                     lsr.l   #8, D1
004526: 2741 FFC0                move.l  D1, (-$40,A3)
00452A: 2219                     move.l  (A1)+, D1
00452C: 24C1                     move.l  D1, (A2)+
00452E: E089                     lsr.l   #8, D1
004530: 26C1                     move.l  D1, (A3)+
004532: 51C8 FF5C                dbra    D0, $4490
004536: 4E75                     rts
004538: 2679 0006 275C           movea.l $6275c.l, A3
00453E: B7FC 0007 403E           cmpa.l  #$7403e, A3
004544: 670E                     beq     $4554
004546: B7FC 0007 403C           cmpa.l  #$7403c, A3
00454C: 670C                     beq     $455a
00454E: 7202                     moveq   #$2, D1
004550: 7402                     moveq   #$2, D2
004552: 600A                     bra     $455e
004554: 72C2                     moveq   #-$3e, D1
004556: 7402                     moveq   #$2, D2
004558: 6004                     bra     $455e
00455A: 7202                     moveq   #$2, D1
00455C: 74C2                     moveq   #-$3e, D2
00455E: 2479 0006 2760           movea.l $62760.l, A2
004564: 7013                     moveq   #$13, D0
004566: 224B                     movea.l A3, A1
004568: 32AA 0050                move.w  ($50,A2), (A1)
00456C: D3C1                     adda.l  D1, A1
00456E: 32AA 0028                move.w  ($28,A2), (A1)
004572: D3C2                     adda.l  D2, A1
004574: 329A                     move.w  (A2)+, (A1)
004576: D7FC 0000 0040           adda.l  #$40, A3
00457C: 51C8 FFE8                dbra    D0, $4566
004580: 4E75                     rts
004582: 45F9 0006 8700           lea     $68700.l, A2
004588: 203C 0020 0020           move.l  #$200020, D0
00458E: 323C 001F                move.w  #$1f, D1
004592: 24C0                     move.l  D0, (A2)+
004594: 51C9 FFFC                dbra    D1, $4592
004598: 43F9 0006 86FA           lea     $686fa.l, A1
00459E: 7240                     moveq   #$40, D1
0045A0: 1039 0006 0680           move.b  $60680.l, D0
0045A6: 4EB9 0000 4698           jsr     $4698.l
0045AC: 43F9 0006 86BA           lea     $686ba.l, A1
0045B2: 1039 0006 0681           move.b  $60681.l, D0
0045B8: 4EF9 0000 4698           jmp     $4698.l
0045BE: 43F9 0006 0786           lea     $60786.l, A1
0045C4: 3019                     move.w  (A1)+, D0
0045C6: 45F9 0006 4800           lea     $64800.l, A2
0045CC: 24D9                     move.l  (A1)+, (A2)+
0045CE: 51C8 FFFC                dbra    D0, $45cc
0045D2: 4E75                     rts
0045D4: 43F9 0006 07A8           lea     $607a8.l, A1
0045DA: 3019                     move.w  (A1)+, D0
0045DC: 45F9 0006 4C00           lea     $64c00.l, A2
0045E2: 24D9                     move.l  (A1)+, (A2)+
0045E4: 51C8 FFFC                dbra    D0, $45e2
0045E8: 4E75                     rts
0045EA: 2F08                     move.l  A0, -(A7)
0045EC: 4EB9 0000 8CF0           jsr     $8cf0.l
0045F2: 205F                     movea.l (A7)+, A0
0045F4: 33F9 0006 06DA 0006 0606 move.w  $606da.l, $60606.l
0045FE: 33F9 0006 06E2 0006 0608 move.w  $606e2.l, $60608.l
004608: 13F9 0006 06DE 0006 0616 move.b  $606de.l, $60616.l
004612: 13F9 0006 06DF 0006 0615 move.b  $606df.l, $60615.l
00461C: 13F9 0006 06D6 0006 0618 move.b  $606d6.l, $60618.l
004626: 13F9 0006 06D7 0006 0617 move.b  $606d7.l, $60617.l
004630: 4E75                     rts
004632: 2F08                     move.l  A0, -(A7)
004634: 4EB9 0000 8F30           jsr     $8f30.l
00463A: 205F                     movea.l (A7)+, A0
00463C: 33F9 0006 06DA 0006 0606 move.w  $606da.l, $60606.l
004646: 33F9 0006 06E2 0006 0608 move.w  $606e2.l, $60608.l
004650: 13F9 0006 06DE 0006 0616 move.b  $606de.l, $60616.l
00465A: 13F9 0006 06DF 0006 0615 move.b  $606df.l, $60615.l
004664: 13F9 0006 06D6 0006 0618 move.b  $606d6.l, $60618.l
00466E: 13F9 0006 06D7 0006 0617 move.b  $606d7.l, $60617.l
004678: 4E75                     rts
00467A: 7805                     moveq   #$5, D4
00467C: 43FA 0258                lea     ($258,PC) ; ($48d6), A1
004680: 7A00                     moveq   #$0, D5
004682: 720A                     moveq   #$a, D1
004684: 3A31 1000                move.w  (A1,D1.w), D5
004688: 2445                     movea.l D5, A2
00468A: 4EB9 0000 46CE           jsr     $46ce.l
004690: 5441                     addq.w  #2, D1
004692: 51CC FFF0                dbra    D4, $4684
004696: 4E75                     rts
004698: 3400                     move.w  D0, D2
00469A: E858                     ror.w   #4, D0
00469C: 0200 000F                andi.b  #$f, D0
0046A0: 6106                     bsr     $46a8
0046A2: 3002                     move.w  D2, D0
0046A4: 0200 000F                andi.b  #$f, D0
0046A8: 0040 0030                ori.w   #$30, D0
0046AC: 0C00 003A                cmpi.b  #$3a, D0
0046B0: 6502                     bcs     $46b4
0046B2: 5E00                     addq.b  #7, D0
0046B4: 3341 0800                move.w  D1, ($800,A1)
0046B8: 32C0                     move.w  D0, (A1)+
0046BA: 4E75                     rts
0046BC: E059                     ror.w   #8, D1
0046BE: 0241 00FE                andi.w  #$fe, D1
0046C2: 45FA 0212                lea     ($212,PC) ; ($48d6), A2
0046C6: 7400                     moveq   #$0, D2
0046C8: 3432 1000                move.w  (A2,D1.w), D2
0046CC: 2442                     movea.l D2, A2
0046CE: 243C 0006 8000           move.l  #$68000, D2
0046D4: D45A                     add.w   (A2)+, D2
0046D6: 2642                     movea.l D2, A3
0046D8: 161A                     move.b  (A2)+, D3
0046DA: 141A                     move.b  (A2)+, D2
0046DC: 6708                     beq     $46e6
0046DE: 3743 0800                move.w  D3, ($800,A3)
0046E2: 36C2                     move.w  D2, (A3)+
0046E4: 60F4                     bra     $46da
0046E6: 4E75                     rts
0046E8: E059                     ror.w   #8, D1
0046EA: 0241 00FE                andi.w  #$fe, D1
0046EE: 45FA 01E6                lea     ($1e6,PC) ; ($48d6), A2
0046F2: 7400                     moveq   #$0, D2
0046F4: 3432 1000                move.w  (A2,D1.w), D2
0046F8: 2442                     movea.l D2, A2
0046FA: 243C 0006 8000           move.l  #$68000, D2
004700: D45A                     add.w   (A2)+, D2
004702: 2642                     movea.l D2, A3
004704: 161A                     move.b  (A2)+, D3
004706: 3438 0020                move.w  $20.w, D2
00470A: 4A1A                     tst.b   (A2)+
00470C: 6708                     beq     $4716
00470E: 3743 0800                move.w  D3, ($800,A3)
004712: 36C2                     move.w  D2, (A3)+
004714: 60F4                     bra     $470a
004716: 4E75                     rts
004718: 43F9 0006 060A           lea     $6060a.l, A1
00471E: 45F9 0006 8000           lea     $68000.l, A2
004724: 7211                     moveq   #$11, D1
004726: 1019                     move.b  (A1)+, D0
004728: 34C0                     move.w  D0, (A2)+
00472A: 51C9 FFFA                dbra    D1, $4726
00472E: 08B9 0006 0006 0604      bclr    #$6, $60604.l
004736: 33F9 0006 0604 0007 C000 move.w  $60604.l, $7c000.l
004740: 08F9 0006 0006 0604      bset    #$6, $60604.l
004748: 33F9 0006 0604 0007 C000 move.w  $60604.l, $7c000.l
004752: 08B9 0006 0006 0604      bclr    #$6, $60604.l
00475A: 4E75                     rts
00475C: 223C 0006 8000           move.l  #$68000, D1
004762: 243C 0006 0700           move.l  #$60700, D2
004768: 1039 0006 0603           move.b  $60603.l, D0
00476E: 0240 0007                andi.w  #$7, D0
004772: D040                     add.w   D0, D0
004774: D27B 001C                add.w   ($1c,PC,D0.w), D1
004778: D47B 0018                add.w   ($18,PC,D0.w), D2
00477C: 2241                     movea.l D1, A1
00477E: 2442                     movea.l D2, A2
004780: 303C 003F                move.w  #$3f, D0
004784: 236A 0800 0800           move.l  ($800,A2), ($800,A1)
00478A: 22DA                     move.l  (A2)+, (A1)+
00478C: 51C8 FFF6                dbra    D0, $4784
004790: 4E75                     rts
004792: 0040 0100                ori.w   #$100, D0
004796: 0200 0300                andi.b  #$0, D0
00479A: 0400 0500                subi.b  #$0, D0
00479E: 0600 0700                addi.b  #$0, D0
0047A2: 43F9 0006 9000           lea     $69000.l, A1
0047A8: 7200                     moveq   #$0, D1
0047AA: 243C 0010 0010           move.l  #$100010, D2
0047B0: 303C 01FF                move.w  #$1ff, D0
0047B4: 2342 0800                move.l  D2, ($800,A1)
0047B8: 22C1                     move.l  D1, (A1)+
0047BA: 51C8 FFF8                dbra    D0, $47b4
0047BE: 4E75                     rts
0047C0: 7202                     moveq   #$2, D1
0047C2: 7E03                     moveq   #$3, D7
0047C4: 4EB9 0000 46C2           jsr     $46c2.l
0047CA: 5441                     addq.w  #2, D1
0047CC: 51CF FFF6                dbra    D7, $47c4
0047D0: 7031                     moveq   #$31, D0
0047D2: 7236                     moveq   #$36, D1
0047D4: 7404                     moveq   #$4, D2
0047D6: 7630                     moveq   #$30, D3
0047D8: 43F9 0006 85E4           lea     $685e4.l, A1
0047DE: 45F9 0006 95FC           lea     $695fc.l, A2
0047E4: 3281                     move.w  D1, (A1)
0047E6: 3480                     move.w  D0, (A2)
0047E8: 3343 0800                move.w  D3, ($800,A1)
0047EC: 3543 0800                move.w  D3, ($800,A2)
0047F0: 5240                     addq.w  #1, D0
0047F2: 5241                     addq.w  #1, D1
0047F4: 93FC 0000 0080           suba.l  #$80, A1
0047FA: 95FC 0000 0080           suba.l  #$80, A2
004800: 51CA FFE2                dbra    D2, $47e4
004804: 45F9 0006 066E           lea     $6066e.l, A2
00480A: 7210                     moveq   #$10, D1
00480C: 43F9 0006 85C2           lea     $685c2.l, A1
004812: 6100 0070                bsr     $4884
004816: 43F9 0006 85EA           lea     $685ea.l, A1
00481C: 6100 0066                bsr     $4884
004820: 7404                     moveq   #$4, D2
004822: 43F9 0006 85D6           lea     $685d6.l, A1
004828: 102A 000F                move.b  ($f,A2), D0
00482C: 3340 0028                move.w  D0, ($28,A1)
004830: 3341 0828                move.w  D1, ($828,A1)
004834: 101A                     move.b  (A2)+, D0
004836: 3341 0800                move.w  D1, ($800,A1)
00483A: 32C0                     move.w  D0, (A1)+
00483C: 101A                     move.b  (A2)+, D0
00483E: 3341 0800                move.w  D1, ($800,A1)
004842: 32C0                     move.w  D0, (A1)+
004844: 101A                     move.b  (A2)+, D0
004846: 3341 0800                move.w  D1, ($800,A1)
00484A: 32C0                     move.w  D0, (A1)+
00484C: 93FC 0000 0086           suba.l  #$86, A1
004852: 51CA FFD4                dbra    D2, $4828
004856: 7404                     moveq   #$4, D2
004858: 43F9 0006 95C0           lea     $695c0.l, A1
00485E: 102A 0001                move.b  ($1,A2), D0
004862: 3341 0800                move.w  D1, ($800,A1)
004866: 32C0                     move.w  D0, (A1)+
004868: 102A 0002                move.b  ($2,A2), D0
00486C: 3341 0800                move.w  D1, ($800,A1)
004870: 32C0                     move.w  D0, (A1)+
004872: D5FC 0000 0003           adda.l  #$3, A2
004878: 93FC 0000 0084           suba.l  #$84, A1
00487E: 51CA FFDE                dbra    D2, $485e
004882: 4E75                     rts
004884: 7804                     moveq   #$4, D4
004886: 4245                     clr.w   D5
004888: 7602                     moveq   #$2, D3
00488A: 101A                     move.b  (A2)+, D0
00488C: 3400                     move.w  D0, D2
00488E: E858                     ror.w   #4, D0
004890: 6100 0026                bsr     $48b8
004894: 3002                     move.w  D2, D0
004896: 6100 0020                bsr     $48b8
00489A: 51CB FFEE                dbra    D3, $488a
00489E: 22BC 3030 3030           move.l  #$30303030, (A1)
0048A4: 3341 0800                move.w  D1, ($800,A1)
0048A8: 3341 0802                move.w  D1, ($802,A1)
0048AC: 93FC 0000 008C           suba.l  #$8c, A1
0048B2: 51CC FFD2                dbra    D4, $4886
0048B6: 4E75                     rts
0048B8: 0200 000F                andi.b  #$f, D0
0048BC: 0000 0030                ori.b   #$30, D0
0048C0: 0C00 0030                cmpi.b  #$30, D0
0048C4: 6608                     bne     $48ce
0048C6: 4A45                     tst.w   D5
0048C8: 6606                     bne     $48d0
0048CA: 7020                     moveq   #$20, D0
0048CC: 6002                     bra     $48d0
0048CE: 7A01                     moveq   #$1, D5
0048D0: 3341 0800                move.w  D1, ($800,A1)
0048D4: 32C0                     move.w  D0, (A1)+
0048D6: 4E75                     rts
0048D8: 4924                     dc.w    $4924; ILLEGAL
0048DA: 4930                     dc.w    $4930; ILLEGAL
0048DC: 4938                     dc.w    $4938; ILLEGAL
0048DE: 495C                     dc.w    $495c; ILLEGAL
0048E0: 4964                     dc.w    $4964; ILLEGAL
0048E2: 4970                     dc.w    $4970; ILLEGAL
0048E4: 498C                     dc.w    $498c; ILLEGAL
0048E6: 49A2                     chk.w   -(A2), D4
0048E8: 49B6 49CC                chk.w   INVALID 36, D4
0048EC: 49E6                     dc.w    $49e6; ILLEGAL
0048EE: 49F8 4A0A                lea     $4a0a.w, A4
0048F2: 4A1A                     tst.b   (A2)+
0048F4: 4A28 4A34                tst.b   ($4a34,A0)
0048F8: 4A40                     tst.w   D0
0048FA: 4A4E                     dc.w    $4a4e; ILLEGAL
0048FC: 4A60                     tst.w   -(A0)
0048FE: 4A70 4A7C                tst.w   INVALID 30
004902: 4A88                     dc.w    $4a88; ILLEGAL
004904: 4A92                     tst.l   (A2)
004906: 4AA2                     tst.l   -(A2)
004908: 4AB6 4AC6                tst.l   INVALID 36
00490C: 4AD0                     tas     (A0)
00490E: 4AE0                     tas     -(A0)
004910: 4AF4 4B08                tas     INVALID 34
004914: 4B18                     dc.w    $4b18; ILLEGAL
004916: 4B28                     dc.w    $4b28; ILLEGAL
004918: 4B3A                     dc.w    $4b3a; ILLEGAL
00491A: 4B4C                     dc.w    $4b4c; ILLEGAL
00491C: 4B5E                     dc.w    $4b5e; ILLEGAL
00491E: 4B70                     dc.w    $4b70; ILLEGAL
004920: 4B84                     chk.w   D4, D5
004922: 4B9A                     chk.w   (A2)+, D5
004924: 06DA                     dc.w    $06da; ILLEGAL
004926: 3002                     move.w  D2, D0
004928: 0304                     btst    D1, D4
00492A: 0520                     btst    D2, -(A0)
00492C: 1110                     move.b  (A0), -(A0)
00492E: 00FF                     dc.w    $00ff; ILLEGAL
004930: 167A                     dc.w    $167a; ILLEGAL
004932: 3052                     movea.w (A2), A0
004934: 414E                     dc.w    $414e; ILLEGAL
004936: 00FF                     dc.w    $00ff; ILLEGAL
004938: 0640 304B                addi.w  #$304b, D0
00493C: 2020                     move.l  -(A0), D0
00493E: 2053                     movea.l (A3), A0
004940: 434F                     dc.w    $434f; ILLEGAL
004942: 5245                     addq.w  #1, D5
004944: 2020                     move.l  -(A0), D0
004946: 4E41                     trap    #$1
004948: 4D45                     dc.w    $4d45; ILLEGAL
00494A: 2020                     move.l  -(A0), D0
00494C: 5241                     addq.w  #1, D1
00494E: 4E4B                     trap    #$b
004950: 2020                     move.l  -(A0), D0
004952: 2053                     movea.l (A3), A0
004954: 434F                     dc.w    $434f; ILLEGAL
004956: 5245                     addq.w  #1, D5
004958: 2020                     move.l  -(A0), D0
00495A: 4E00                     dc.w    $4e00; ILLEGAL
00495C: 1640                     dc.w    $1640; ILLEGAL
00495E: 3041                     movea.w D1, A0
004960: 4D45                     dc.w    $4d45; ILLEGAL
004962: 00FF                     dc.w    $00ff; ILLEGAL
004964: 04D8                     dc.w    $04d8; ILLEGAL
004966: 4057                     negx.w  (A7)
004968: 4152                     dc.w    $4152; ILLEGAL
00496A: 4E49                     trap    #$9
00496C: 4E47                     trap    #$7
00496E: 00FF                     dc.w    $00ff; ILLEGAL
004970: 0448                     dc.w    $0448; ILLEGAL
004972: 1049                     dc.w    $1049; ILLEGAL
004974: 5420                     addq.b  #2, -(A0)
004976: 4953                     dc.w    $4953; ILLEGAL
004978: 2050                     movea.l (A0), A0
00497A: 524F                     addq.w  #1, A7
00497C: 4849                     dc.w    $4849; ILLEGAL
00497E: 4249                     dc.w    $4249; ILLEGAL
004980: 5445                     addq.w  #2, D5
004982: 4420                     neg.b   -(A0)
004984: 544F                     addq.w  #2, A7
004986: 2055                     movea.l (A5), A0
004988: 5345                     subq.w  #1, D5
00498A: 00FF                     dc.w    $00ff; ILLEGAL
00498C: 03CE 1054                movep.l D1, ($1054,A6)
004990: 4849                     dc.w    $4849; ILLEGAL
004992: 5320                     subq.b  #1, -(A0)
004994: 4741                     dc.w    $4741; ILLEGAL
004996: 4D45                     dc.w    $4d45; ILLEGAL
004998: 2053                     movea.l (A3), A0
00499A: 4F46                     dc.w    $4f46; ILLEGAL
00499C: 5457                     addq.w  #2, (A7)
00499E: 4152                     dc.w    $4152; ILLEGAL
0049A0: 4500                     dc.w    $4500; ILLEGAL
0049A2: 0350                     bchg    D1, (A0)
0049A4: 104F                     dc.w    $104f; ILLEGAL
0049A6: 5554                     subq.w  #2, (A4)
0049A8: 5349                     subq.w  #1, A1
0049AA: 4445                     neg.w   D5
0049AC: 204F                     movea.l A7, A0
0049AE: 4620                     not.b   -(A0)
0049B0: 4A41                     tst.w   D1
0049B2: 5041                     addq.w  #8, D1
0049B4: 4E00                     dc.w    $4e00; ILLEGAL
0049B6: 02CE                     dc.w    $02ce; ILLEGAL
0049B8: 1057                     dc.w    $1057; ILLEGAL
0049BA: 4954                     dc.w    $4954; ILLEGAL
0049BC: 484F                     dc.w    $484f; ILLEGAL
0049BE: 5554                     subq.w  #2, (A4)
0049C0: 2050                     movea.l (A0), A0
0049C2: 4552                     dc.w    $4552; ILLEGAL
0049C4: 4D49                     dc.w    $4d49; ILLEGAL
0049C6: 5353                     subq.w  #1, (A3)
0049C8: 494F                     dc.w    $494f; ILLEGAL
0049CA: 4E00                     dc.w    $4e00; ILLEGAL
0049CC: 024A                     dc.w    $024a; ILLEGAL
0049CE: 1046                     dc.w    $1046; ILLEGAL
0049D0: 524F                     addq.w  #1, A7
0049D2: 4D20                     dc.w    $4d20; ILLEGAL
0049D4: 4E49                     trap    #$9
0049D6: 4348                     dc.w    $4348; ILLEGAL
0049D8: 4942                     dc.w    $4942; ILLEGAL
0049DA: 5554                     subq.w  #2, (A4)
0049DC: 5355                     subq.w  #1, (A5)
0049DE: 204A                     movea.l A2, A0
0049E0: 4150                     dc.w    $4150; ILLEGAL
0049E2: 414E                     dc.w    $414e; ILLEGAL
0049E4: 00FF                     dc.w    $00ff; ILLEGAL
0049E6: 04D2                     dc.w    $04d2; ILLEGAL
0049E8: 1031 504C                move.b  ($4c,A1,D5.w), D0
0049EC: 4159                     dc.w    $4159; ILLEGAL
0049EE: 4552                     dc.w    $4552; ILLEGAL
0049F0: 2052                     movea.l (A2), A0
0049F2: 4541                     dc.w    $4541; ILLEGAL
0049F4: 4459                     neg.w   (A1)+
0049F6: 00FF                     dc.w    $00ff; ILLEGAL
0049F8: 04D2                     dc.w    $04d2; ILLEGAL
0049FA: 1032 504C                move.b  ($4c,A2,D5.w), D0
0049FE: 4159                     dc.w    $4159; ILLEGAL
004A00: 4552                     dc.w    $4552; ILLEGAL
004A02: 2052                     movea.l (A2), A0
004A04: 4541                     dc.w    $4541; ILLEGAL
004A06: 4459                     neg.w   (A1)+
004A08: 00FF                     dc.w    $00ff; ILLEGAL
004A0A: 0456 1047                subi.w  #$1047, (A6)
004A0E: 4149                     dc.w    $4149; ILLEGAL
004A10: 4F53                     dc.w    $4f53; ILLEGAL
004A12: 2020                     move.l  -(A0), D0
004A14: 4C45                     dc.w    $4c45; ILLEGAL
004A16: 4654                     not.w   (A4)
004A18: 00FF                     dc.w    $00ff; ILLEGAL
004A1A: 03D8                     bset    D1, (A0)+
004A1C: 1047                     dc.w    $1047; ILLEGAL
004A1E: 414D                     dc.w    $414d; ILLEGAL
004A20: 4520                     dc.w    $4520; ILLEGAL
004A22: 5354                     subq.w  #1, (A4)
004A24: 4152                     dc.w    $4152; ILLEGAL
004A26: 5400                     addq.b  #2, D0
004A28: 0740                     bchg    D3, D0
004A2A: 2031 502D                move.l  ($2d,A1,D5.w), D0
004A2E: 5343                     subq.w  #1, D3
004A30: 4F52                     dc.w    $4f52; ILLEGAL
004A32: 4500                     dc.w    $4500; ILLEGAL
004A34: 0770 2032                bchg    D3, ($32,A0,D2.w)
004A38: 502D 5343                addq.b  #8, ($5343,A5)
004A3C: 4F52                     dc.w    $4f52; ILLEGAL
004A3E: 4500                     dc.w    $4500; ILLEGAL
004A40: 0458 1047                subi.w  #$1047, (A0)+
004A44: 414D                     dc.w    $414d; ILLEGAL
004A46: 4520                     dc.w    $4520; ILLEGAL
004A48: 4F56                     dc.w    $4f56; ILLEGAL
004A4A: 4552                     dc.w    $4552; ILLEGAL
004A4C: 00FF                     dc.w    $00ff; ILLEGAL
004A4E: 0312                     btst    D1, (A2)
004A50: 1050                     dc.w    $1050; ILLEGAL
004A52: 5554                     subq.w  #2, (A4)
004A54: 2059                     movea.l (A1)+, A0
004A56: 4F55                     dc.w    $4f55; ILLEGAL
004A58: 5220                     addq.b  #1, -(A0)
004A5A: 4E41                     trap    #$1
004A5C: 4D45                     dc.w    $4d45; ILLEGAL
004A5E: 3E00                     move.w  D0, D7
004A60: 03D4                     bset    D1, (A4)
004A62: 3054                     movea.w (A4), A0
004A64: 4F20                     dc.w    $4f20; ILLEGAL
004A66: 434F                     dc.w    $434f; ILLEGAL
004A68: 4E54 494E                link    A4, #$494e
004A6C: 5545                     subq.w  #2, D5
004A6E: 00FF                     dc.w    $00ff; ILLEGAL
004A70: 035A                     bchg    D1, (A2)+
004A72: 3054                     movea.w (A4), A0
004A74: 494D                     dc.w    $494d; ILLEGAL
004A76: 4520                     dc.w    $4520; ILLEGAL
004A78: 2020                     move.l  -(A0), D0
004A7A: 00FF                     dc.w    $00ff; ILLEGAL
004A7C: 0758                     bchg    D3, (A0)+
004A7E: 2048                     movea.l A0, A0
004A80: 492D                     dc.w    $492d; ILLEGAL
004A82: 5343                     subq.w  #1, D3
004A84: 4F52                     dc.w    $4f52; ILLEGAL
004A86: 4500                     dc.w    $4500; ILLEGAL
004A88: 03D8                     bset    D1, (A0)+
004A8A: 1053                     dc.w    $1053; ILLEGAL
004A8C: 5441                     addq.w  #2, D1
004A8E: 4646                     not.w   D6
004A90: 00FF                     dc.w    $00ff; ILLEGAL
004A92: 0306                     btst    D1, D6
004A94: 1047                     dc.w    $1047; ILLEGAL
004A96: 414D                     dc.w    $414d; ILLEGAL
004A98: 4520                     dc.w    $4520; ILLEGAL
004A9A: 4445                     neg.w   D5
004A9C: 5349                     subq.w  #1, A1
004A9E: 474E                     dc.w    $474e; ILLEGAL
004AA0: 00FF                     dc.w    $00ff; ILLEGAL
004AA2: 0294 1053 4849           andi.l  #$10534849, (A4)
004AA8: 4745                     dc.w    $4745; ILLEGAL
004AAA: 4B49                     dc.w    $4b49; ILLEGAL
004AAC: 2046                     movea.l D6, A0
004AAE: 554A                     subq.w  #2, A2
004AB0: 4957                     dc.w    $4957; ILLEGAL
004AB2: 4152                     dc.w    $4152; ILLEGAL
004AB4: 4100                     dc.w    $4100; ILLEGAL
004AB6: 01C6                     bset    D0, D6
004AB8: 1047                     dc.w    $1047; ILLEGAL
004ABA: 414D                     dc.w    $414d; ILLEGAL
004ABC: 4520                     dc.w    $4520; ILLEGAL
004ABE: 5052                     addq.w  #8, (A2)
004AC0: 4F47                     dc.w    $4f47; ILLEGAL
004AC2: 5241                     addq.w  #1, D1
004AC4: 4D00                     dc.w    $4d00; ILLEGAL
004AC6: 016A 104B                bchg    D0, ($104b,A2)
004ACA: 414B                     dc.w    $414b; ILLEGAL
004ACC: 4546                     dc.w    $4546; ILLEGAL
004ACE: 5500                     subq.b  #2, D0
004AD0: 00DE                     dc.w    $00de; ILLEGAL
004AD2: 1053                     dc.w    $1053; ILLEGAL
004AD4: 4849                     dc.w    $4849; ILLEGAL
004AD6: 4E59                     unlk    A1
004AD8: 4120                     dc.w    $4120; ILLEGAL
004ADA: 4F4B                     dc.w    $4f4b; ILLEGAL
004ADC: 5544                     subq.w  #2, D4
004ADE: 4100                     dc.w    $4100; ILLEGAL
004AE0: 03C6                     bset    D1, D6
004AE2: 1043                     dc.w    $1043; ILLEGAL
004AE4: 4841                     swap    D1
004AE6: 5241                     addq.w  #1, D1
004AE8: 4354                     dc.w    $4354; ILLEGAL
004AEA: 4552                     dc.w    $4552; ILLEGAL
004AEC: 2044                     movea.l D4, A0
004AEE: 4553                     dc.w    $4553; ILLEGAL
004AF0: 4947                     dc.w    $4947; ILLEGAL
004AF2: 4E00                     dc.w    $4e00; ILLEGAL
004AF4: 0358                     bchg    D1, (A0)+
004AF6: 1054                     dc.w    $1054; ILLEGAL
004AF8: 414B                     dc.w    $414b; ILLEGAL
004AFA: 414E                     dc.w    $414e; ILLEGAL
004AFC: 4F52                     dc.w    $4f52; ILLEGAL
004AFE: 4920                     dc.w    $4920; ILLEGAL
004B00: 5441                     addq.w  #2, D1
004B02: 4E41                     trap    #$1
004B04: 4B41                     dc.w    $4b41; ILLEGAL
004B06: 00FF                     dc.w    $00ff; ILLEGAL
004B08: 02E0                     dc.w    $02e0; ILLEGAL
004B0A: 1059                     dc.w    $1059; ILLEGAL
004B0C: 554B                     subq.w  #2, A3
004B0E: 4920                     dc.w    $4920; ILLEGAL
004B10: 5941                     subq.w  #4, D1
004B12: 5355                     subq.w  #1, (A5)
004B14: 4441                     neg.w   D1
004B16: 00FF                     dc.w    $00ff; ILLEGAL
004B18: 0206 1054                andi.b  #$54, D6
004B1C: 4954                     dc.w    $4954; ILLEGAL
004B1E: 4C45                     dc.w    $4c45; ILLEGAL
004B20: 2044                     movea.l D4, A0
004B22: 4553                     dc.w    $4553; ILLEGAL
004B24: 4947                     dc.w    $4947; ILLEGAL
004B26: 4E00                     dc.w    $4e00; ILLEGAL
004B28: 019C                     bclr    D0, (A4)+
004B2A: 1053                     dc.w    $1053; ILLEGAL
004B2C: 4849                     dc.w    $4849; ILLEGAL
004B2E: 4E4A                     trap    #$a
004B30: 4920                     dc.w    $4920; ILLEGAL
004B32: 4B55                     dc.w    $4b55; ILLEGAL
004B34: 424F                     dc.w    $424f; ILLEGAL
004B36: 5441                     addq.w  #2, D1
004B38: 00FF                     dc.w    $00ff; ILLEGAL
004B3A: 03C6                     bset    D1, D6
004B3C: 1053                     dc.w    $1053; ILLEGAL
004B3E: 4F55                     dc.w    $4f55; ILLEGAL
004B40: 4E44                     trap    #$4
004B42: 2043                     movea.l D3, A0
004B44: 4F4D                     dc.w    $4f4d; ILLEGAL
004B46: 504F                     addq.w  #8, A7
004B48: 5345                     subq.w  #1, D5
004B4A: 5200                     addq.b  #1, D0
004B4C: 035A                     bchg    D1, (A2)+
004B4E: 104E                     dc.w    $104e; ILLEGAL
004B50: 4F42                     dc.w    $4f42; ILLEGAL
004B52: 4F52                     dc.w    $4f52; ILLEGAL
004B54: 5520                     subq.b  #2, -(A0)
004B56: 594F                     subq.w  #4, A7
004B58: 5348                     subq.w  #1, A0
004B5A: 4944                     dc.w    $4944; ILLEGAL
004B5C: 4100                     dc.w    $4100; ILLEGAL
004B5E: 0286 1053 4F55           andi.l  #$10534f55, D6
004B64: 4E44                     trap    #$4
004B66: 2050                     movea.l (A0), A0
004B68: 524F                     addq.w  #1, A7
004B6A: 4752                     dc.w    $4752; ILLEGAL
004B6C: 414D                     dc.w    $414d; ILLEGAL
004B6E: 00FF                     dc.w    $00ff; ILLEGAL
004B70: 0218 1059                andi.b  #$59, (A0)+
004B74: 4F53                     dc.w    $4f53; ILLEGAL
004B76: 4849                     dc.w    $4849; ILLEGAL
004B78: 4E4F                     trap    #$f
004B7A: 5249                     addq.w  #1, A1
004B7C: 204D                     movea.l A5, A0
004B7E: 4954                     dc.w    $4954; ILLEGAL
004B80: 5441                     addq.w  #2, D1
004B82: 00FF                     dc.w    $00ff; ILLEGAL
004B84: 0146                     bchg    D0, D6
004B86: 1048                     dc.w    $1048; ILLEGAL
004B88: 4152                     dc.w    $4152; ILLEGAL
004B8A: 4420                     neg.b   -(A0)
004B8C: 5741                     subq.w  #3, D1
004B8E: 5245                     addq.w  #1, D5
004B90: 2045                     movea.l D5, A0
004B92: 4E47                     trap    #$7
004B94: 494E                     dc.w    $494e; ILLEGAL
004B96: 4545                     dc.w    $4545; ILLEGAL
004B98: 5200                     addq.b  #1, D0
004B9A: 00E2                     dc.w    $00e2; ILLEGAL
004B9C: 1049                     dc.w    $1049; ILLEGAL
004B9E: 5341                     subq.w  #1, D1
004BA0: 4F20                     dc.w    $4f20; ILLEGAL
004BA2: 5348                     subq.w  #1, A0
004BA4: 494B                     dc.w    $494b; ILLEGAL
004BA6: 4900                     dc.w    $4900; ILLEGAL
004BA8: 7000                     moveq   #$0, D0
004BAA: 1039 0006 0600           move.b  $60600.l, D0
004BB0: 303B 0006                move.w  ($6,PC,D0.w), D0
004BB4: 2040                     movea.l D0, A0
004BB6: 4ED0                     jmp     (A0)
004BB8: 4BCE                     dc.w    $4bce; ILLEGAL
004BBA: 7360                     dc.w    $7360; ILLEGAL
004BBC: 6E20                     bgt     $4bde
004BBE: 4BC2                     dc.w    $4bc2; ILLEGAL
004BC0: 4BC8                     dc.w    $4bc8; ILLEGAL
004BC2: 4EF9 0004 1C46           jmp     $41c46.l
004BC8: 4EF9 0004 24AA           jmp     $424aa.l
004BCE: 0839 0001 0006 0601      btst    #$1, $60601.l
004BD6: 6620                     bne     $4bf8
004BD8: 0079 0180 0006 0604      ori.w   #$180, $60604.l
004BE0: 13FC FFE0 0006 0602      move.b  #$e0, $60602.l
004BE8: 13FC 0002 0006 0601      move.b  #$2, $60601.l
004BF0: 703F                     moveq   #$3f, D0
004BF2: 4EF9 0000 77EA           jmp     $77ea.l
004BF8: 4A39 0006 0602           tst.b   $60602.l
004BFE: 6616                     bne     $4c16
004C00: 0279 F07F 0006 0604      andi.w  #$f07f, $60604.l
004C08: 33FC 0600 0006 0600      move.w  #$600, $60600.l
004C10: 4EB9 0000 7612           jsr     $7612.l
004C16: 4E75                     rts
004C18: 41F9 0006 10AC           lea     $610ac.l, A0
004C1E: 30BC 0208                move.w  #$208, (A0)
004C22: 317C 0100 0002           move.w  #$100, ($2,A0)
004C28: 317C 0100 0006           move.w  #$100, ($6,A0)
004C2E: 42A8 0010                clr.l   ($10,A0)
004C32: 42A8 0014                clr.l   ($14,A0)
004C36: 42A8 0018                clr.l   ($18,A0)
004C3A: 42A8 001C                clr.l   ($1c,A0)
004C3E: 6000 0112                bra     $4d52
004C42: 41F9 0006 10AC           lea     $610ac.l, A0
004C48: 30BC FF14                move.w  #$ff14, (A0)
004C4C: 317C 015A 0002           move.w  #$15a, ($2,A0)
004C52: 317C 0188 0006           move.w  #$188, ($6,A0)
004C58: 42A8 0010                clr.l   ($10,A0)
004C5C: 42A8 0014                clr.l   ($14,A0)
004C60: 42A8 0018                clr.l   ($18,A0)
004C64: 42A8 001C                clr.l   ($1c,A0)
004C68: 6000 00E8                bra     $4d52
004C6C: 41F9 0006 10AC           lea     $610ac.l, A0
004C72: 317C 0100 0002           move.w  #$100, ($2,A0)
004C78: 317C 0100 0006           move.w  #$100, ($6,A0)
004C7E: 30BC FF1C                move.w  #$ff1c, (A0)
004C82: 217C 000E 0008 0014      move.l  #$e0008, ($14,A0)
004C8A: 42A8 001C                clr.l   ($1c,A0)
004C8E: 42A8 0010                clr.l   ($10,A0)
004C92: 42A8 0018                clr.l   ($18,A0)
004C96: 700C                     moveq   #$c, D0
004C98: 4EB9 0000 77EA           jsr     $77ea.l
004C9E: 6000 00B2                bra     $4d52
004CA2: 41F9 0006 10AC           lea     $610ac.l, A0
004CA8: 30BC 0222                move.w  #$222, (A0)
004CAC: 317C 0100 0002           move.w  #$100, ($2,A0)
004CB2: 317C 0058 0006           move.w  #$58, ($6,A0)
004CB8: 42A8 0010                clr.l   ($10,A0)
004CBC: 42A8 0014                clr.l   ($14,A0)
004CC0: 42A8 0018                clr.l   ($18,A0)
004CC4: 42A8 001C                clr.l   ($1c,A0)
004CC8: 6100 0088                bsr     $4d52
004CCC: 41F9 0006 252C           lea     $6252c.l, A0
004CD2: 317C 0200 0040           move.w  #$200, ($40,A0)
004CD8: 317C 0100 0042           move.w  #$100, ($42,A0)
004CDE: 317C 0068 0046           move.w  #$68, ($46,A0)
004CE4: 317C 0400 0020           move.w  #$400, ($20,A0)
004CEA: 317C 0100 0022           move.w  #$100, ($22,A0)
004CF0: 317C 0058 0026           move.w  #$58, ($26,A0)
004CF6: 317C 0600 0000           move.w  #$600, ($0,A0)
004CFC: 317C 0100 0002           move.w  #$100, ($2,A0)
004D02: 317C 0058 0006           move.w  #$58, ($6,A0)
004D08: 13FC 0003 0006 26C2      move.b  #$3, $626c2.l
004D10: 4E75                     rts
004D12: 41F9 0006 10AC           lea     $610ac.l, A0
004D18: 30BC 0224                move.w  #$224, (A0)
004D1C: 42A8 0010                clr.l   ($10,A0)
004D20: 42A8 0014                clr.l   ($14,A0)
004D24: 42A8 0018                clr.l   ($18,A0)
004D28: 42A8 001C                clr.l   ($1c,A0)
004D2C: 317C 0100 0002           move.w  #$100, ($2,A0)
004D32: 317C 0078 0006           move.w  #$78, ($6,A0)
004D38: 4A39 0006 06E6           tst.b   $606e6.l
004D3E: 6700 0012                beq     $4d52
004D42: 317C 0050 0002           move.w  #$50, ($2,A0)
004D48: 317C 00F0 0006           move.w  #$f0, ($6,A0)
004D4E: 6000 0002                bra     $4d52
004D52: 43F9 0006 06F4           lea     $606f4.l, A1
004D58: 701F                     moveq   #$1f, D0
004D5A: 4299                     clr.l   (A1)+
004D5C: 51C8 FFFC                dbra    D0, $4d5a
004D60: 4E75                     rts
004D62: 4A39 0006 26C2           tst.b   $626c2.l
004D68: 6704                     beq     $4d6e
004D6A: 6100 05B0                bsr     $531c
004D6E: 33F9 0006 061E 0006 06E8 move.w  $6061e.l, $606e8.l
004D78: 4A39 0006 062A           tst.b   $6062a.l
004D7E: 6612                     bne     $4d92
004D80: 4A39 0006 07D5           tst.b   $607d5.l
004D86: 670A                     beq     $4d92
004D88: 33F9 0006 0620 0006 06E8 move.w  $60620.l, $606e8.l
004D92: 41F9 0006 10AC           lea     $610ac.l, A0
004D98: 4228 0011                clr.b   ($11,A0)
004D9C: 7000                     moveq   #$0, D0
004D9E: 1028 0001                move.b  ($1,A0), D0
004DA2: 303B 0006                move.w  ($6,PC,D0.w), D0
004DA6: 2240                     movea.l D0, A1
004DA8: 4ED1                     jmp     (A1)
004DAA: 0000 0000                ori.b   #$0, D0
004DAE: 4E0C                     dc.w    $4e0c; ILLEGAL
004DB0: 4E7E                     dc.w    $4e7e; ILLEGAL
004DB2: 4EB6 0000                jsr     (A6,D0.w)
004DB6: 5018                     addq.b  #8, (A0)+
004DB8: 5076 50FE                addq.w  #8, (-$2,A6,D5.w)
004DBC: 0000 5128                ori.b   #$28, D0
004DC0: 0000 51BE                ori.b   #$be, D0
004DC4: 5260                     addq.w  #1, -(A0)
004DC6: 51A2                     subq.l  #8, -(A2)
004DC8: 51BE                     dc.w    $51be; ILLEGAL
004DCA: 5260                     addq.w  #1, -(A0)
004DCC: 52FE                     dc.w    $52fe; ILLEGAL
004DCE: 54BA                     dc.w    $54ba; ILLEGAL
004DD0: 117C 0004 0001           move.b  #$4, ($1,A0)
004DD6: 4268 001E                clr.w   ($1e,A0)
004DDA: 43F9 0006 0822           lea     $60822.l, A1
004DE0: 4A39 0006 06E6           tst.b   $606e6.l
004DE6: 6706                     beq     $4dee
004DE8: 43F9 0006 082C           lea     $6082c.l, A1
004DEE: 4A51                     tst.w   (A1)
004DF0: 6612                     bne     $4e04
004DF2: 32F9 0006 06D4           move.w  $606d4.l, (A1)+
004DF8: 22F9 0006 26C4           move.l  $626c4.l, (A1)+
004DFE: 22B9 0006 26C8           move.l  $626c8.l, (A1)
004E04: 7022                     moveq   #$22, D0
004E06: 4EB9 0000 77EA           jsr     $77ea.l
004E0C: 3E28 001C                move.w  ($1c,A0), D7
004E10: 0247 007E                andi.w  #$7e, D7
004E14: 43F9 0006 06F4           lea     $606f4.l, A1
004E1A: 4271 7000                clr.w   (A1,D7.w)
004E1E: 5468 001C                addq.w  #2, ($1c,A0)
004E22: 5228 001E                addq.b  #1, ($1e,A0)
004E26: 0228 0007 001E           andi.b  #$7, ($1e,A0)
004E2C: 664A                     bne     $4e78
004E2E: 0628 000C 001F           addi.b  #$c, ($1f,A0)
004E34: 0C28 0048 001F           cmpi.b  #$48, ($1f,A0)
004E3A: 663C                     bne     $4e78
004E3C: 5428 0001                addq.b  #2, ($1,A0)
004E40: 43F9 0006 06BE           lea     $606be.l, A1
004E46: 4A39 0006 07D5           tst.b   $607d5.l
004E4C: 6706                     beq     $4e54
004E4E: 43F9 0006 06BF           lea     $606bf.l, A1
004E54: 4A11                     tst.b   (A1)
004E56: 6708                     beq     $4e60
004E58: 117C 0040 001E           move.b  #$40, ($1e,A0)
004E5E: 4E75                     rts
004E60: 117C 00FF 001E           move.b  #$ff, ($1e,A0)
004E66: 303C 2200                move.w  #$2200, D0
004E6A: 4EB9 0000 77C8           jsr     $77c8.l
004E70: 7036                     moveq   #$36, D0
004E72: 4EF9 0000 77EA           jmp     $77ea.l
004E78: 4EF9 0000 5B5E           jmp     $5b5e.l
004E7E: 3E28 001C                move.w  ($1c,A0), D7
004E82: 0247 007E                andi.w  #$7e, D7
004E86: 43F9 0006 06F4           lea     $606f4.l, A1
004E8C: 4271 7000                clr.w   (A1,D7.w)
004E90: 5468 001C                addq.w  #2, ($1c,A0)
004E94: 5328 001E                subq.b  #1, ($1e,A0)
004E98: 6616                     bne     $4eb0
004E9A: 0279 B07F 0006 0604      andi.w  #$b07f, $60604.l
004EA2: 13FC 0030 0006 0601      move.b  #$30, $60601.l
004EAA: DFFC 0000 0004           adda.l  #$4, A7
004EB0: 4E75                     rts
004EB2: 0709 0B0D                movep.w ($b0d,A1), D3
004EB6: 4EB9 0000 88BE           jsr     $88be.l
004EBC: 4A10                     tst.b   (A0)
004EBE: 6B00 FF10                bmi     $4dd0
004EC2: 43F9 0006 06F4           lea     $606f4.l, A1
004EC8: 3E28 001C                move.w  ($1c,A0), D7
004ECC: 0247 007E                andi.w  #$7e, D7
004ED0: 4271 7000                clr.w   (A1,D7.w)
004ED4: 4240                     clr.w   D0
004ED6: 1039 0006 06EE           move.b  $606ee.l, D0
004EDC: 117B 00D4 0010           move.b  (-$2c,PC,D0.w), ($10,A0)
004EE2: 1039 0006 06E8           move.b  $606e8.l, D0
004EE8: 4A39 0006 06E6           tst.b   $606e6.l
004EEE: 6702                     beq     $4ef2
004EF0: E548                     lsl.w   #2, D0
004EF2: 1228 001F                move.b  ($1f,A0), D1
004EF6: 0200 000C                andi.b  #$c, D0
004EFA: 671A                     beq     $4f16
004EFC: 0200 0004                andi.b  #$4, D0
004F00: 660A                     bne     $4f0c
004F02: 0C01 00E7                cmpi.b  #-$19, D1
004F06: 6F18                     ble     $4f20
004F08: 5301                     subq.b  #1, D1
004F0A: 6014                     bra     $4f20
004F0C: 0C01 0017                cmpi.b  #$17, D1
004F10: 6C0E                     bge     $4f20
004F12: 5201                     addq.b  #1, D1
004F14: 600A                     bra     $4f20
004F16: 70FF                     moveq   #-$1, D0
004F18: 4A01                     tst.b   D1
004F1A: 6A02                     bpl     $4f1e
004F1C: 7001                     moveq   #$1, D0
004F1E: D200                     add.b   D0, D1
004F20: 1141 001F                move.b  D1, ($1f,A0)
004F24: 1039 0006 06E8           move.b  $606e8.l, D0
004F2A: 0240 000F                andi.w  #$f, D0
004F2E: 6728                     beq     $4f58
004F30: 143B 0037                move.b  ($37,PC,D0.w), D2
004F34: 6100 003E                bsr     $4f74
004F38: 0C02 00FF                cmpi.b  #-$1, D2
004F3C: 671A                     beq     $4f58
004F3E: 1142 0012                move.b  D2, ($12,A0)
004F42: 1382 7001                move.b  D2, ($1,A1,D7.w)
004F46: 13A8 0010 7000           move.b  ($10,A0), (A1,D7.w)
004F4C: 4EB9 0000 7FE4           jsr     $7fe4.l
004F52: 117C 0001 0011           move.b  #$1, ($11,A0)
004F58: 5468 001C                addq.w  #2, ($1c,A0)
004F5C: 4EB9 0000 5A92           jsr     $5a92.l
004F62: 4EB9 0000 5F40           jsr     $5f40.l
004F68: 4E75                     rts
004F6A: 40C0                     move    SR, D0
004F6C: 0000 20E0                ori.b   #$e0, D0
004F70: 0080 60A0 4240           ori.l   #$60a04240, D0
004F76: 4A39 0006 06E6           tst.b   $606e6.l
004F7C: 6702                     beq     $4f80
004F7E: 7008                     moveq   #$8, D0
004F80: 45FA 0066                lea     ($66,PC) ; ($4fe8), A2
004F84: 3232 0000                move.w  (A2,D0.w), D1
004F88: B268 0002                cmp.w   ($2,A0), D1
004F8C: 6D1C                     blt     $4faa
004F8E: 3232 0002                move.w  ($2,A2,D0.w), D1
004F92: B268 0002                cmp.w   ($2,A0), D1
004F96: 6F24                     ble     $4fbc
004F98: E84A                     lsr.w   #4, D2
004F9A: 0242 000E                andi.w  #$e, D2
004F9E: 143B 2058                move.b  ($58,PC,D2.w), D2
004FA2: 0C02 00FF                cmpi.b  #-$1, D2
004FA6: 6614                     bne     $4fbc
004FA8: 4E75                     rts
004FAA: E84A                     lsr.w   #4, D2
004FAC: 0242 000E                andi.w  #$e, D2
004FB0: 143B 2047                move.b  ($47,PC,D2.w), D2
004FB4: 0C02 00FF                cmpi.b  #-$1, D2
004FB8: 6602                     bne     $4fbc
004FBA: 4E75                     rts
004FBC: 3232 0004                move.w  ($4,A2,D0.w), D1
004FC0: B268 0006                cmp.w   ($6,A0), D1
004FC4: 6D16                     blt     $4fdc
004FC6: 3232 0006                move.w  ($6,A2,D0.w), D1
004FCA: B268 0006                cmp.w   ($6,A0), D1
004FCE: 6F16                     ble     $4fe6
004FD0: E84A                     lsr.w   #4, D2
004FD2: 0242 000E                andi.w  #$e, D2
004FD6: 143B 2030                move.b  ($30,PC,D2.w), D2
004FDA: 4E75                     rts
004FDC: E84A                     lsr.w   #4, D2
004FDE: 0242 000E                andi.w  #$e, D2
004FE2: 143B 2025                move.b  ($25,PC,D2.w), D2
004FE6: 4E75                     rts
004FE8: 0190                     bclr    D0, (A0)
004FEA: 0070 0150 00A0           ori.w   #$150, (-$60,A0,D0.w)
004FF0: 0180                     bclr    D0, D0
004FF2: 0080 0148 00A0           ori.l   #$14800a0, D0
004FF8: FF00                     dc.w    $ff00; opcode 1111
004FFA: 4020                     negx.b  -(A0)
004FFC: 4040                     negx.w  D0
004FFE: 6040                     bra     $5040
005000: 80FF                     dc.w    $80ff; ILLEGAL
005002: A0C0                     dc.w    $a0c0; opcode 1010
005004: C0C0                     mulu.w  D0, D0
005006: C0E0                     mulu.w  -(A0), D0
005008: 0000 2000                ori.b   #$0, D0
00500C: 40FF                     dc.w    $40ff; ILLEGAL
00500E: 6080                     bra     $4f90
005010: 8080                     or.l    D0, D0
005012: 80A0                     or.l    -(A0), D0
005014: FFC0                     dc.w    $ffc0; opcode 1111
005016: 00E0                     dc.w    $00e0; ILLEGAL
005018: 4EB9 0000 DA5C           jsr     $da5c.l
00501E: 1228 001F                move.b  ($1f,A0), D1
005022: 5328 001F                subq.b  #1, ($1f,A0)
005026: 4A01                     tst.b   D1
005028: 6A04                     bpl     $502e
00502A: 5428 001F                addq.b  #2, ($1f,A0)
00502E: 1228 001F                move.b  ($1f,A0), D1
005032: 5201                     addq.b  #1, D1
005034: 0C01 0002                cmpi.b  #$2, D1
005038: 6204                     bhi     $503e
00503A: 5428 0001                addq.b  #2, ($1,A0)
00503E: 43F9 0006 06F4           lea     $606f4.l, A1
005044: 3E28 001C                move.w  ($1c,A0), D7
005048: 0247 007E                andi.w  #$7e, D7
00504C: 13BC 0001 7000           move.b  #$1, (A1,D7.w)
005052: 13BC 00C0 7001           move.b  #$c0, ($1,A1,D7.w)
005058: 117C 0001 0011           move.b  #$1, ($11,A0)
00505E: 5468 001C                addq.w  #2, ($1c,A0)
005062: 4A39 0006 06C0           tst.b   $606c0.l
005068: 6606                     bne     $5070
00506A: 13BC 00FF 7000           move.b  #$ff, (A1,D7.w)
005070: 4EF9 0000 5A92           jmp     $5a92.l
005076: 2268 0014                movea.l ($14,A0), A1
00507A: 3028 0002                move.w  ($2,A0), D0
00507E: 3228 0006                move.w  ($6,A0), D1
005082: 3429 0002                move.w  ($2,A1), D2
005086: 3629 0006                move.w  ($6,A1), D3
00508A: 0C41 0078                cmpi.w  #$78, D1
00508E: 6308                     bls     $5098
005090: B440                     cmp.w   D0, D2
005092: 662A                     bne     $50be
005094: B641                     cmp.w   D1, D3
005096: 6626                     bne     $50be
005098: 5428 0001                addq.b  #2, ($1,A0)
00509C: 4EB9 0000 DA5C           jsr     $da5c.l
0050A2: 4268 0014                clr.w   ($14,A0)
0050A6: 317C 0008 0016           move.w  #$8, ($16,A0)
0050AC: 7039                     moveq   #$39, D0
0050AE: 4EB9 0000 77EA           jsr     $77ea.l
0050B4: 700B                     moveq   #$b, D0
0050B6: 4EB9 0000 77EA           jsr     $77ea.l
0050BC: 6080                     bra     $503e
0050BE: 4EB9 0000 7D80           jsr     $7d80.l
0050C4: 1140 0012                move.b  D0, ($12,A0)
0050C8: 117C 0003 0010           move.b  #$3, ($10,A0)
0050CE: 4EB9 0000 7FE4           jsr     $7fe4.l
0050D4: 43F9 0006 06F4           lea     $606f4.l, A1
0050DA: 3E28 001C                move.w  ($1c,A0), D7
0050DE: 0247 007E                andi.w  #$7e, D7
0050E2: 13BC 0003 7000           move.b  #$3, (A1,D7.w)
0050E8: 13A8 0012 7001           move.b  ($12,A0), ($1,A1,D7.w)
0050EE: 117C 0001 0011           move.b  #$1, ($11,A0)
0050F4: 5468 001C                addq.w  #2, ($1c,A0)
0050F8: 4EF9 0000 5A92           jmp     $5a92.l
0050FE: 4EB9 0000 DA5C           jsr     $da5c.l
005104: 43F9 0006 06F4           lea     $606f4.l, A1
00510A: 3E28 001C                move.w  ($1c,A0), D7
00510E: 0247 007E                andi.w  #$7e, D7
005112: 33BC FFFF 7000           move.w  #$ffff, (A1,D7.w)
005118: 117C 0001 0011           move.b  #$1, ($11,A0)
00511E: 5468 001C                addq.w  #2, ($1c,A0)
005122: 4EF9 0000 5C2A           jmp     $5c2a.l
005128: 4A39 0006 06C0           tst.b   $606c0.l
00512E: 6704                     beq     $5134
005130: 5368 0002                subq.w  #1, ($2,A0)
005134: 117C 0005 0010           move.b  #$5, ($10,A0)
00513A: 117C 00C0 0012           move.b  #$c0, ($12,A0)
005140: 4EB9 0000 7FE4           jsr     $7fe4.l
005146: 43F9 0006 06F4           lea     $606f4.l, A1
00514C: 3E28 001C                move.w  ($1c,A0), D7
005150: 0247 007E                andi.w  #$7e, D7
005154: 33BC 05C0 7000           move.w  #$5c0, (A1,D7.w)
00515A: 117C 0001 0011           move.b  #$1, ($11,A0)
005160: 5468 001C                addq.w  #2, ($1c,A0)
005164: 0C28 00E7 001F           cmpi.b  #-$19, ($1f,A0)
00516A: 6F04                     ble     $5170
00516C: 5328 001F                subq.b  #1, ($1f,A0)
005170: 0C68 0100 0006           cmpi.w  #$100, ($6,A0)
005176: 6208                     bhi     $5180
005178: 30BC 0208                move.w  #$208, (A0)
00517C: 6100 FBD4                bsr     $4d52
005180: 4EB9 0000 5A92           jsr     $5a92.l
005186: 43F9 0006 0F33           lea     $60f33.l, A1
00518C: 4240                     clr.w   D0
00518E: 1039 0006 108D           move.b  $6108d.l, D0
005194: 5239 0006 108D           addq.b  #1, $6108d.l
00519A: 13BC 0001 0000           move.b  #$1, (A1,D0.w)
0051A0: 4E75                     rts
0051A2: 3E28 001C                move.w  ($1c,A0), D7
0051A6: 0247 007E                andi.w  #$7e, D7
0051AA: 43F9 0006 06F4           lea     $606f4.l, A1
0051B0: 4271 7000                clr.w   (A1,D7.w)
0051B4: 5468 001C                addq.w  #2, ($1c,A0)
0051B8: 4EF9 0000 5CE0           jmp     $5ce0.l
0051BE: 70FF                     moveq   #-$1, D0
0051C0: 4A28 001F                tst.b   ($1f,A0)
0051C4: 6A02                     bpl     $51c8
0051C6: 7001                     moveq   #$1, D0
0051C8: D128 001F                add.b   D0, ($1f,A0)
0051CC: 4A39 0006 06C0           tst.b   $606c0.l
0051D2: 6704                     beq     $51d8
0051D4: 5368 0002                subq.w  #1, ($2,A0)
0051D8: 117C 0007 0010           move.b  #$7, ($10,A0)
0051DE: 2268 0014                movea.l ($14,A0), A1
0051E2: 3429 0002                move.w  ($2,A1), D2
0051E6: 9468 0002                sub.w   ($2,A0), D2
0051EA: 5442                     addq.w  #2, D2
0051EC: 0C42 0005                cmpi.w  #$5, D2
0051F0: 6410                     bcc     $5202
0051F2: 4228 0010                clr.b   ($10,A0)
0051F6: 5428 0001                addq.b  #2, ($1,A0)
0051FA: 7039                     moveq   #$39, D0
0051FC: 4EB9 0000 77EA           jsr     $77ea.l
005202: 4240                     clr.w   D0
005204: 3229 0002                move.w  ($2,A1), D1
005208: B268 0002                cmp.w   ($2,A0), D1
00520C: 6502                     bcs     $5210
00520E: 7080                     moveq   #-$80, D0
005210: 1140 0012                move.b  D0, ($12,A0)
005214: 4EB9 0000 7FE4           jsr     $7fe4.l
00521A: 43F9 0006 06F4           lea     $606f4.l, A1
005220: 3E28 001C                move.w  ($1c,A0), D7
005224: 0247 007E                andi.w  #$7e, D7
005228: 13A8 0010 7000           move.b  ($10,A0), (A1,D7.w)
00522E: 13A8 0012 7001           move.b  ($12,A0), ($1,A1,D7.w)
005234: 117C 0001 0011           move.b  #$1, ($11,A0)
00523A: 5468 001C                addq.w  #2, ($1c,A0)
00523E: 4EB9 0000 5A92           jsr     $5a92.l
005244: 43F9 0006 0F33           lea     $60f33.l, A1
00524A: 4240                     clr.w   D0
00524C: 1039 0006 108D           move.b  $6108d.l, D0
005252: 5239 0006 108D           addq.b  #1, $6108d.l
005258: 13BC 0001 0000           move.b  #$1, (A1,D0.w)
00525E: 4E75                     rts
005260: 0C28 0017 001F           cmpi.b  #$17, ($1f,A0)
005266: 6C04                     bge     $526c
005268: 5228 001F                addq.b  #1, ($1f,A0)
00526C: 117C 0040 0012           move.b  #$40, ($12,A0)
005272: 117C 0007 0010           move.b  #$7, ($10,A0)
005278: 4EB9 0000 7FE4           jsr     $7fe4.l
00527E: 4A39 0006 06C0           tst.b   $606c0.l
005284: 6704                     beq     $528a
005286: 5368 0002                subq.w  #1, ($2,A0)
00528A: 43F9 0006 06F4           lea     $606f4.l, A1
005290: 3E28 001C                move.w  ($1c,A0), D7
005294: 0247 007E                andi.w  #$7e, D7
005298: 13BC 0007 7000           move.b  #$7, (A1,D7.w)
00529E: 13BC 0040 7001           move.b  #$40, ($1,A1,D7.w)
0052A4: 117C 0001 0011           move.b  #$1, ($11,A0)
0052AA: 5468 001C                addq.w  #2, ($1c,A0)
0052AE: 4EB9 0000 5A92           jsr     $5a92.l
0052B4: 43F9 0006 0F33           lea     $60f33.l, A1
0052BA: 4240                     clr.w   D0
0052BC: 1039 0006 108D           move.b  $6108d.l, D0
0052C2: 5239 0006 108D           addq.b  #1, $6108d.l
0052C8: 13BC 0001 0000           move.b  #$1, (A1,D0.w)
0052CE: 0C68 0188 0006           cmpi.w  #$188, ($6,A0)
0052D4: 6526                     bcs     $52fc
0052D6: 0279 B07F 0006 0604      andi.w  #$b07f, $60604.l
0052DE: 13FC 002A 0006 0601      move.b  #$2a, $60601.l
0052E6: 0C28 0020 0001           cmpi.b  #$20, ($1,A0)
0052EC: 6708                     beq     $52f6
0052EE: 13FC 001E 0006 0601      move.b  #$1e, $60601.l
0052F6: DFFC 0000 0004           adda.l  #$4, A7
0052FC: 4E75                     rts
0052FE: 1028 0014                move.b  ($14,A0), D0
005302: 670E                     beq     $5312
005304: 5328 0015                subq.b  #1, ($15,A0)
005308: 660C                     bne     $5316
00530A: 117C 0008 0001           move.b  #$8, ($1,A0)
005310: 6004                     bra     $5316
005312: 5268 0006                addq.w  #1, ($6,A0)
005316: 4EF9 0000 5A92           jmp     $5a92.l
00531C: 4247                     clr.w   D7
00531E: 1E39 0006 26C2           move.b  $626c2.l, D7
005324: 5307                     subq.b  #1, D7
005326: 41F9 0006 250C           lea     $6250c.l, A0
00532C: 13FC 00A4 0006 06E7      move.b  #$a4, $606e7.l
005334: 5239 0006 06E7           addq.b  #1, $606e7.l
00533A: D1FC 0000 0020           adda.l  #$20, A0
005340: 4A10                     tst.b   (A0)
005342: 67F0                     beq     $5334
005344: 1010                     move.b  (A0), D0
005346: 0C00 0002                cmpi.b  #$2, D0
00534A: 6700 00A8                beq     $53f4
00534E: 600E                     bra     $535e
005350: 4250                     clr.w   (A0)
005352: 5339 0006 26C2           subq.b  #1, $626c2.l
005358: 51CF FFDA                dbra    D7, $5334
00535C: 4E75                     rts
00535E: 1028 0001                move.b  ($1,A0), D0
005362: 675E                     beq     $53c2
005364: 0C00 0002                cmpi.b  #$2, D0
005368: 673C                     beq     $53a6
00536A: 0C10 0004                cmpi.b  #$4, (A0)
00536E: 670E                     beq     $537e
005370: 5468 0002                addq.w  #2, ($2,A0)
005374: 0C68 01A8 0002           cmpi.w  #$1a8, ($2,A0)
00537A: 64D4                     bcc     $5350
00537C: 600C                     bra     $538a
00537E: 5568 0002                subq.w  #2, ($2,A0)
005382: 0C68 0058 0002           cmpi.w  #$58, ($2,A0)
005388: 65C6                     bcs     $5350
00538A: 317C 0300 000C           move.w  #$300, ($c,A0)
005390: 0839 0002 0006 0603      btst    #$2, $60603.l
005398: 6700 0100                beq     $549a
00539C: 317C 081E 000C           move.w  #$81e, ($c,A0)
0053A2: 6000 00F6                bra     $549a
0053A6: 5328 000F                subq.b  #1, ($f,A0)
0053AA: 6604                     bne     $53b0
0053AC: 5428 0001                addq.b  #2, ($1,A0)
0053B0: 06A8 FFFF 8000 0006      addi.l  #-$8000, ($6,A0)
0053B8: 33E8 0006 0006 10B2      move.w  ($6,A0), $610b2.l
0053C0: 6016                     bra     $53d8
0053C2: 5268 0006                addq.w  #1, ($6,A0)
0053C6: 317C 3760 000A           move.w  #$3760, ($a,A0)
0053CC: 0C10 0004                cmpi.b  #$4, (A0)
0053D0: 6706                     beq     $53d8
0053D2: 317C 3768 000A           move.w  #$3768, ($a,A0)
0053D8: 317C 083E 000C           move.w  #$83e, ($c,A0)
0053DE: 0839 0002 0006 0603      btst    #$2, $60603.l
0053E6: 6700 00B2                beq     $549a
0053EA: 317C 085E 000C           move.w  #$85e, ($c,A0)
0053F0: 6000 00A8                bra     $549a
0053F4: 1028 0001                move.b  ($1,A0), D0
0053F8: 6742                     beq     $543c
0053FA: 0C00 0002                cmpi.b  #$2, D0
0053FE: 6714                     beq     $5414
005400: 06A8 0001 8000 0006      addi.l  #$18000, ($6,A0)
005408: 0C68 01A8 0006           cmpi.w  #$1a8, ($6,A0)
00540E: 6400 FF40                bcc     $5350
005412: 600A                     bra     $541e
005414: 5328 000F                subq.b  #1, ($f,A0)
005418: 6604                     bne     $541e
00541A: 5428 0001                addq.b  #2, ($1,A0)
00541E: 317C 3720 000A           move.w  #$3720, ($a,A0)
005424: 317C 0300 000C           move.w  #$300, ($c,A0)
00542A: 0839 0002 0006 0603      btst    #$2, $60603.l
005432: 6766                     beq     $549a
005434: 317C 081E 000C           move.w  #$81e, ($c,A0)
00543A: 605E                     bra     $549a
00543C: 0C68 00E8 0006           cmpi.w  #$e8, ($6,A0)
005442: 6636                     bne     $547a
005444: 5428 0001                addq.b  #2, ($1,A0)
005448: 117C 0040 000F           move.b  #$40, ($f,A0)
00544E: 5439 0006 10C0           addq.b  #2, $610c0.l
005454: 13FC 0060 0006 10C1      move.b  #$60, $610c1.l
00545C: 5439 0006 252D           addq.b  #2, $6252d.l
005462: 13FC 0040 0006 253B      move.b  #$40, $6253b.l
00546A: 5439 0006 254D           addq.b  #2, $6254d.l
005470: 13FC 0040 0006 255B      move.b  #$40, $6255b.l
005478: 6004                     bra     $547e
00547A: 5268 0006                addq.w  #1, ($6,A0)
00547E: 317C 36FE 000A           move.w  #$36fe, ($a,A0)
005484: 317C 083E 000C           move.w  #$83e, ($c,A0)
00548A: 0839 0002 0006 0603      btst    #$2, $60603.l
005492: 6706                     beq     $549a
005494: 317C 085E 000C           move.w  #$85e, ($c,A0)
00549A: 4240                     clr.w   D0
00549C: 1039 0006 1090           move.b  $61090.l, D0
0054A2: 43F9 0006 0F4A           lea     $60f4a.l, A1
0054A8: 13B9 0006 06E7 0000      move.b  $606e7.l, (A1,D0.w)
0054B0: 5239 0006 1090           addq.b  #1, $61090.l
0054B6: 6000 FEA0                bra     $5358
0054BA: 7006                     moveq   #$6, D0
0054BC: 323C 00B8                move.w  #$b8, D1
0054C0: 4A39 0006 06E6           tst.b   $606e6.l
0054C6: 6706                     beq     $54ce
0054C8: 7002                     moveq   #$2, D0
0054CA: 323C 00C0                move.w  #$c0, D1
0054CE: 06B0 0001 8000 0000      addi.l  #$18000, (A0,D0.w)
0054D6: 3030 0000                move.w  (A0,D0.w), D0
0054DA: B041                     cmp.w   D1, D0
0054DC: 6506                     bcs     $54e4
0054DE: 117C 0008 0001           move.b  #$8, ($1,A0)
0054E4: 4EF9 0000 5A92           jmp     $5a92.l
0054EA: 4A10                     tst.b   (A0)
0054EC: 671E                     beq     $550c
0054EE: 6B1C                     bmi     $550c
0054F0: 42A8 0010                clr.l   ($10,A0)
0054F4: 42A8 0014                clr.l   ($14,A0)
0054F8: 42A8 0018                clr.l   ($18,A0)
0054FC: 42A8 001C                clr.l   ($1c,A0)
005500: 3083                     move.w  D3, (A0)
005502: 3140 0002                move.w  D0, ($2,A0)
005506: 3141 0006                move.w  D1, ($6,A0)
00550A: 4E75                     rts
00550C: 4290                     clr.l   (A0)
00550E: 42A8 0004                clr.l   ($4,A0)
005512: 42A8 0008                clr.l   ($8,A0)
005516: 42A8 000C                clr.l   ($c,A0)
00551A: 42A8 0010                clr.l   ($10,A0)
00551E: 42A8 0014                clr.l   ($14,A0)
005522: 42A8 0018                clr.l   ($18,A0)
005526: 42A8 001C                clr.l   ($1c,A0)
00552A: 4E75                     rts
00552C: 3039 0006 10AE           move.w  $610ae.l, D0
005532: 3239 0006 10B2           move.w  $610b2.l, D1
005538: 363C 0214                move.w  #$214, D3
00553C: 41F9 0006 10CC           lea     $610cc.l, A0
005542: 61A6                     bsr     $54ea
005544: 363C 0414                move.w  #$414, D3
005548: 41F9 0006 10EC           lea     $610ec.l, A0
00554E: 609A                     bra     $54ea
005550: 3039 0006 10AE           move.w  $610ae.l, D0
005556: 3239 0006 10B2           move.w  $610b2.l, D1
00555C: 363C 021C                move.w  #$21c, D3
005560: 41F9 0006 10CC           lea     $610cc.l, A0
005566: 6182                     bsr     $54ea
005568: 217C 002A 0008 0014      move.l  #$2a0008, ($14,A0)
005570: 363C 041C                move.w  #$41c, D3
005574: 41F9 0006 10EC           lea     $610ec.l, A0
00557A: 6100 FF6E                bsr     $54ea
00557E: 217C 002A 0008 0014      move.l  #$2a0008, ($14,A0)
005586: 4E75                     rts
005588: 3039 0006 10AE           move.w  $610ae.l, D0
00558E: 3239 0006 10B2           move.w  $610b2.l, D1
005594: 363C 0208                move.w  #$208, D3
005598: 41F9 0006 10CC           lea     $610cc.l, A0
00559E: 10BC 0002                move.b  #$2, (A0)
0055A2: 6100 FF46                bsr     $54ea
0055A6: 3439 0006 10C8           move.w  $610c8.l, D2
0055AC: 0442 0020                subi.w  #$20, D2
0055B0: 3142 001C                move.w  D2, ($1c,A0)
0055B4: 363C 0408                move.w  #$408, D3
0055B8: 41F9 0006 10EC           lea     $610ec.l, A0
0055BE: 10BC 0004                move.b  #$4, (A0)
0055C2: 6000 FF26                bra     $54ea
0055C6: 3439 0006 10C8           move.w  $610c8.l, D2
0055CC: 0442 0020                subi.w  #$20, D2
0055D0: 3142 001C                move.w  D2, ($1c,A0)
0055D4: 41F9 0006 10CC           lea     $610cc.l, A0
0055DA: 4A10                     tst.b   (A0)
0055DC: 6716                     beq     $55f4
0055DE: 7000                     moveq   #$0, D0
0055E0: 1028 0001                move.b  ($1,A0), D0
0055E4: 303B 0030                move.w  ($30,PC,D0.w), D0
0055E8: 2240                     movea.l D0, A1
0055EA: 13FC 0002 0006 06E7      move.b  #$2, $606e7.l
0055F2: 4E91                     jsr     (A1)
0055F4: 41F9 0006 10EC           lea     $610ec.l, A0
0055FA: 4A10                     tst.b   (A0)
0055FC: 6716                     beq     $5614
0055FE: 7000                     moveq   #$0, D0
005600: 1028 0001                move.b  ($1,A0), D0
005604: 303B 0010                move.w  ($10,PC,D0.w), D0
005608: 2240                     movea.l D0, A1
00560A: 13FC 0003 0006 06E7      move.b  #$3, $606e7.l
005612: 4ED1                     jmp     (A1)
005614: 4E75                     rts
005616: 0000 0000                ori.b   #$0, D0
00561A: 0000 563A                ori.b   #$3a, D0
00561E: 5672 575A                addq.w  #3, INVALID 32
005622: 57F8 0000                seq     $0.w
005626: 0000 0000                ori.b   #$0, D0
00562A: 584E                     addq.w  #4, A6
00562C: 0000 58D4                ori.b   #$d4, D0
005630: 0000 5986                ori.b   #$86, D0
005634: 0000 599C                ori.b   #$9c, D0
005638: 59DE                     svs     (A6)+
00563A: 3039 0006 10C8           move.w  $610c8.l, D0
005640: 0440 0020                subi.w  #$20, D0
005644: 0240 007E                andi.w  #$7e, D0
005648: B068 001C                cmp.w   ($1c,A0), D0
00564C: 660A                     bne     $5658
00564E: 117C 000A 0001           move.b  #$a, ($1,A0)
005654: 6000 0104                bra     $575a
005658: 70FF                     moveq   #-$1, D0
00565A: 4A28 001F                tst.b   ($1f,A0)
00565E: 6A02                     bpl     $5662
005660: 7001                     moveq   #$1, D0
005662: D128 001F                add.b   D0, ($1f,A0)
005666: 4EB9 0000 5D02           jsr     $5d02.l
00566C: 4EF9 0000 6C4E           jmp     $6c4e.l
005672: 4A39 0006 06E6           tst.b   $606e6.l
005678: 661C                     bne     $5696
00567A: 3639 0006 10B2           move.w  $610b2.l, D3
005680: 3439 0006 10AE           move.w  $610ae.l, D2
005686: 0642 0020                addi.w  #$20, D2
00568A: 0C10 0002                cmpi.b  #$2, (A0)
00568E: 6720                     beq     $56b0
005690: 0442 0040                subi.w  #$40, D2
005694: 601A                     bra     $56b0
005696: 3439 0006 10AE           move.w  $610ae.l, D2
00569C: 3639 0006 10B2           move.w  $610b2.l, D3
0056A2: 0643 0020                addi.w  #$20, D3
0056A6: 0C10 0002                cmpi.b  #$2, (A0)
0056AA: 6704                     beq     $56b0
0056AC: 0443 0040                subi.w  #$40, D3
0056B0: 3028 0002                move.w  ($2,A0), D0
0056B4: 9042                     sub.w   D2, D0
0056B6: 5840                     addq.w  #4, D0
0056B8: 0C40 0009                cmpi.w  #$9, D0
0056BC: 6430                     bcc     $56ee
0056BE: 3028 0006                move.w  ($6,A0), D0
0056C2: 9043                     sub.w   D3, D0
0056C4: 5840                     addq.w  #4, D0
0056C6: 0C40 0009                cmpi.w  #$9, D0
0056CA: 6422                     bcc     $56ee
0056CC: 3142 0002                move.w  D2, ($2,A0)
0056D0: 3143 0006                move.w  D3, ($6,A0)
0056D4: 117C 0006 0001           move.b  #$6, ($1,A0)
0056DA: 3179 0006 10C8 001C      move.w  $610c8.l, ($1c,A0)
0056E2: 0268 007E 001C           andi.w  #$7e, ($1c,A0)
0056E8: 1228 001F                move.b  ($1f,A0), D1
0056EC: 6052                     bra     $5740
0056EE: 3028 0002                move.w  ($2,A0), D0
0056F2: 3228 0006                move.w  ($6,A0), D1
0056F6: 4EB9 0000 7D80           jsr     $7d80.l
0056FC: 1140 0012                move.b  D0, ($12,A0)
005700: 117C 000E 0010           move.b  #$e, ($10,A0)
005706: 4EB9 0000 7FE4           jsr     $7fe4.l
00570C: 1228 001F                move.b  ($1f,A0), D1
005710: 1028 0012                move.b  ($12,A0), D0
005714: 4A39 0006 06E6           tst.b   $606e6.l
00571A: 6604                     bne     $5720
00571C: 0640 0040                addi.w  #$40, D0
005720: 3400                     move.w  D0, D2
005722: 0240 007F                andi.w  #$7f, D0
005726: 6718                     beq     $5740
005728: 4A02                     tst.b   D2
00572A: 6A0A                     bpl     $5736
00572C: 0C01 00E7                cmpi.b  #-$19, D1
005730: 6F18                     ble     $574a
005732: 5301                     subq.b  #1, D1
005734: 6014                     bra     $574a
005736: 0C01 0017                cmpi.b  #$17, D1
00573A: 6C0E                     bge     $574a
00573C: 5201                     addq.b  #1, D1
00573E: 600A                     bra     $574a
005740: 70FF                     moveq   #-$1, D0
005742: 4A01                     tst.b   D1
005744: 6A02                     bpl     $5748
005746: 7001                     moveq   #$1, D0
005748: D200                     add.b   D0, D1
00574A: 1141 001F                move.b  D1, ($1f,A0)
00574E: 4EB9 0000 5D02           jsr     $5d02.l
005754: 4EF9 0000 6C4E           jmp     $6c4e.l
00575A: 3039 0006 10C8           move.w  $610c8.l, D0
005760: 0440 0020                subi.w  #$20, D0
005764: 0240 007E                andi.w  #$7e, D0
005768: 43F9 0006 06F4           lea     $606f4.l, A1
00576E: 0C71 FFFF 0000           cmpi.w  #-$1, (A1,D0.w)
005774: 6700 0072                beq     $57e8
005778: 1171 0000 0010           move.b  (A1,D0.w), ($10,A0)
00577E: 1171 0001 0012           move.b  ($1,A1,D0.w), ($12,A0)
005784: 5468 001C                addq.w  #2, ($1c,A0)
005788: 1228 001F                move.b  ($1f,A0), D1
00578C: 4A28 0010                tst.b   ($10,A0)
005790: 6730                     beq     $57c2
005792: 1028 0012                move.b  ($12,A0), D0
005796: 4A39 0006 06E6           tst.b   $606e6.l
00579C: 6604                     bne     $57a2
00579E: 0640 0040                addi.w  #$40, D0
0057A2: 3400                     move.w  D0, D2
0057A4: 0240 007F                andi.w  #$7f, D0
0057A8: 6718                     beq     $57c2
0057AA: 4A02                     tst.b   D2
0057AC: 6A0A                     bpl     $57b8
0057AE: 0C01 00E7                cmpi.b  #-$19, D1
0057B2: 6F18                     ble     $57cc
0057B4: 5301                     subq.b  #1, D1
0057B6: 6014                     bra     $57cc
0057B8: 0C01 0017                cmpi.b  #$17, D1
0057BC: 6C0E                     bge     $57cc
0057BE: 5201                     addq.b  #1, D1
0057C0: 600A                     bra     $57cc
0057C2: 70FF                     moveq   #-$1, D0
0057C4: 4A01                     tst.b   D1
0057C6: 6A02                     bpl     $57ca
0057C8: 7001                     moveq   #$1, D0
0057CA: D200                     add.b   D0, D1
0057CC: 1141 001F                move.b  D1, ($1f,A0)
0057D0: 4A28 0010                tst.b   ($10,A0)
0057D4: 6706                     beq     $57dc
0057D6: 4EB9 0000 7FE4           jsr     $7fe4.l
0057DC: 4EB9 0000 5D02           jsr     $5d02.l
0057E2: 4EF9 0000 6C4E           jmp     $6c4e.l
0057E8: 117C 000C 0001           move.b  #$c, ($1,A0)
0057EE: 4268 0014                clr.w   ($14,A0)
0057F2: 317C 0008 0016           move.w  #$8, ($16,A0)
0057F8: 3439 0006 10AE           move.w  $610ae.l, D2
0057FE: 3639 0006 10B2           move.w  $610b2.l, D3
005804: 3028 0002                move.w  ($2,A0), D0
005808: 9042                     sub.w   D2, D0
00580A: 5440                     addq.w  #2, D0
00580C: 0C40 0005                cmpi.w  #$5, D0
005810: 6418                     bcc     $582a
005812: 3028 0006                move.w  ($6,A0), D0
005816: 9043                     sub.w   D3, D0
005818: 5440                     addq.w  #2, D0
00581A: 0C40 0005                cmpi.w  #$5, D0
00581E: 640A                     bcc     $582a
005820: 3142 0002                move.w  D2, ($2,A0)
005824: 3143 0006                move.w  D3, ($6,A0)
005828: 601E                     bra     $5848
00582A: 3028 0002                move.w  ($2,A0), D0
00582E: 3228 0006                move.w  ($6,A0), D1
005832: 4EB9 0000 7D80           jsr     $7d80.l
005838: 1140 0012                move.b  D0, ($12,A0)
00583C: 117C 0005 0010           move.b  #$5, ($10,A0)
005842: 4EB9 0000 7FE4           jsr     $7fe4.l
005848: 4EF9 0000 5DA0           jmp     $5da0.l
00584E: 4A39 0006 06C0           tst.b   $606c0.l
005854: 6704                     beq     $585a
005856: 5368 0002                subq.w  #1, ($2,A0)
00585A: 4A39 0006 10AC           tst.b   $610ac.l
005860: 6B0C                     bmi     $586e
005862: 117C 0008 0001           move.b  #$8, ($1,A0)
005868: 4EF9 0000 5D02           jmp     $5d02.l
00586E: 3039 0006 10C8           move.w  $610c8.l, D0
005874: 0440 0020                subi.w  #$20, D0
005878: 0240 007E                andi.w  #$7e, D0
00587C: 43F9 0006 06F4           lea     $606f4.l, A1
005882: 1171 0000 0010           move.b  (A1,D0.w), ($10,A0)
005888: 1171 0001 0012           move.b  ($1,A1,D0.w), ($12,A0)
00588E: 5468 001C                addq.w  #2, ($1c,A0)
005892: 1228 001F                move.b  ($1f,A0), D1
005896: 0C01 00E7                cmpi.b  #-$19, D1
00589A: 6F04                     ble     $58a0
00589C: 5301                     subq.b  #1, D1
00589E: 4E71                     nop
0058A0: 1141 001F                move.b  D1, ($1f,A0)
0058A4: 4A28 0012                tst.b   ($12,A0)
0058A8: 6706                     beq     $58b0
0058AA: 4EB9 0000 7FE4           jsr     $7fe4.l
0058B0: 4EB9 0000 5D02           jsr     $5d02.l
0058B6: 43F9 0006 0F33           lea     $60f33.l, A1
0058BC: 4240                     clr.w   D0
0058BE: 1039 0006 108D           move.b  $6108d.l, D0
0058C4: 5239 0006 108D           addq.b  #1, $6108d.l
0058CA: 13B9 0006 06E7 0000      move.b  $606e7.l, (A1,D0.w)
0058D2: 4E75                     rts
0058D4: 0C68 0188 0006           cmpi.w  #$188, ($6,A0)
0058DA: 6502                     bcs     $58de
0058DC: 4E75                     rts
0058DE: 3039 0006 10C8           move.w  $610c8.l, D0
0058E4: 0440 0020                subi.w  #$20, D0
0058E8: 0240 007E                andi.w  #$7e, D0
0058EC: 43F9 0006 06F4           lea     $606f4.l, A1
0058F2: 1171 0000 0010           move.b  (A1,D0.w), ($10,A0)
0058F8: 1171 0001 0012           move.b  ($1,A1,D0.w), ($12,A0)
0058FE: 5468 001C                addq.w  #2, ($1c,A0)
005902: 1228 001F                move.b  ($1f,A0), D1
005906: 4A28 0010                tst.b   ($10,A0)
00590A: 6730                     beq     $593c
00590C: 1028 0012                move.b  ($12,A0), D0
005910: 4A39 0006 06E6           tst.b   $606e6.l
005916: 6604                     bne     $591c
005918: 0640 0040                addi.w  #$40, D0
00591C: 3400                     move.w  D0, D2
00591E: 0240 007F                andi.w  #$7f, D0
005922: 6718                     beq     $593c
005924: 4A02                     tst.b   D2
005926: 6A0A                     bpl     $5932
005928: 0C01 00E7                cmpi.b  #-$19, D1
00592C: 6F18                     ble     $5946
00592E: 5301                     subq.b  #1, D1
005930: 6014                     bra     $5946
005932: 0C01 0017                cmpi.b  #$17, D1
005936: 6C0E                     bge     $5946
005938: 5201                     addq.b  #1, D1
00593A: 600A                     bra     $5946
00593C: 70FF                     moveq   #-$1, D0
00593E: 4A01                     tst.b   D1
005940: 6A02                     bpl     $5944
005942: 7001                     moveq   #$1, D0
005944: D200                     add.b   D0, D1
005946: 1141 001F                move.b  D1, ($1f,A0)
00594A: 4A28 0010                tst.b   ($10,A0)
00594E: 6706                     beq     $5956
005950: 4EB9 0000 7FE4           jsr     $7fe4.l
005956: 4A39 0006 06C0           tst.b   $606c0.l
00595C: 6704                     beq     $5962
00595E: 5368 0002                subq.w  #1, ($2,A0)
005962: 4EB9 0000 5D02           jsr     $5d02.l
005968: 43F9 0006 0F33           lea     $60f33.l, A1
00596E: 4240                     clr.w   D0
005970: 1039 0006 108D           move.b  $6108d.l, D0
005976: 5239 0006 108D           addq.b  #1, $6108d.l
00597C: 13B9 0006 06E7 0000      move.b  $606e7.l, (A1,D0.w)
005984: 4E75                     rts
005986: 0C39 0008 0006 10AD      cmpi.b  #$8, $610ad.l
00598E: 6606                     bne     $5996
005990: 117C 0008 0001           move.b  #$8, ($1,A0)
005996: 4EF9 0000 5E10           jmp     $5e10.l
00599C: 4A28 0018                tst.b   ($18,A0)
0059A0: 660E                     bne     $59b0
0059A2: 117C 00C0 0019           move.b  #$c0, ($19,A0)
0059A8: 4228 001F                clr.b   ($1f,A0)
0059AC: 5428 0001                addq.b  #2, ($1,A0)
0059B0: 4A39 0006 06E6           tst.b   $606e6.l
0059B6: 6610                     bne     $59c8
0059B8: 5268 0006                addq.w  #1, ($6,A0)
0059BC: 0C68 0188 0006           cmpi.w  #$188, ($6,A0)
0059C2: 6514                     bcs     $59d8
0059C4: 4250                     clr.w   (A0)
0059C6: 4E75                     rts
0059C8: 5268 0002                addq.w  #1, ($2,A0)
0059CC: 0C68 01B0 0002           cmpi.w  #$1b0, ($2,A0)
0059D2: 6504                     bcs     $59d8
0059D4: 4250                     clr.w   (A0)
0059D6: 4E75                     rts
0059D8: 4EF9 0000 5E2E           jmp     $5e2e.l
0059DE: 4A28 0019                tst.b   ($19,A0)
0059E2: 6630                     bne     $5a14
0059E4: 4A39 0006 06E6           tst.b   $606e6.l
0059EA: 6614                     bne     $5a00
0059EC: 06A8 FFFE 8000 0006      addi.l  #-$18000, ($6,A0)
0059F4: 0C68 0080 0006           cmpi.w  #$80, ($6,A0)
0059FA: 641C                     bcc     $5a18
0059FC: 4250                     clr.w   (A0)
0059FE: 4E75                     rts
005A00: 06A8 FFFE 8000 0002      addi.l  #-$18000, ($2,A0)
005A08: 0C68 0058 0002           cmpi.w  #$58, ($2,A0)
005A0E: 6408                     bcc     $5a18
005A10: 4250                     clr.w   (A0)
005A12: 4E75                     rts
005A14: 5328 0019                subq.b  #1, ($19,A0)
005A18: 4A39 0006 10AC           tst.b   $610ac.l
005A1E: 6B6C                     bmi     $5a8c
005A20: 3028 0002                move.w  ($2,A0), D0
005A24: 9079 0006 10AE           sub.w   $610ae.l, D0
005A2A: 0640 000A                addi.w  #$a, D0
005A2E: 0C40 0015                cmpi.w  #$15, D0
005A32: 6458                     bcc     $5a8c
005A34: 3028 0006                move.w  ($6,A0), D0
005A38: 9079 0006 10B2           sub.w   $610b2.l, D0
005A3E: 0640 000A                addi.w  #$a, D0
005A42: 0C40 0015                cmpi.w  #$15, D0
005A46: 6444                     bcc     $5a8c
005A48: 363C 0408                move.w  #$408, D3
005A4C: 0C39 0002 0006 10CC      cmpi.b  #$2, $610cc.l
005A54: 670E                     beq     $5a64
005A56: 0C39 0002 0006 10EC      cmpi.b  #$2, $610ec.l
005A5E: 6704                     beq     $5a64
005A60: 363C 0208                move.w  #$208, D3
005A64: 3083                     move.w  D3, (A0)
005A66: 3439 0006 10C8           move.w  $610c8.l, D2
005A6C: 0442 0020                subi.w  #$20, D2
005A70: 3142 001C                move.w  D2, ($1c,A0)
005A74: 42A8 0010                clr.l   ($10,A0)
005A78: 42A8 0014                clr.l   ($14,A0)
005A7C: 42A8 0018                clr.l   ($18,A0)
005A80: 4268 001E                clr.w   ($1e,A0)
005A84: 700A                     moveq   #$a, D0
005A86: 4EB9 0000 77EA           jsr     $77ea.l
005A8C: 4EF9 0000 5D02           jmp     $5d02.l
005A92: 323C 5AE2                move.w  #$5ae2, D1
005A96: 4A39 0006 06E6           tst.b   $606e6.l
005A9C: 6704                     beq     $5aa2
005A9E: 323C 5B1E                move.w  #$5b1e, D1
005AA2: 1028 001F                move.b  ($1f,A0), D0
005AA6: 0600 0080                addi.b  #-$80, D0
005AAA: 45FA 0030                lea     ($30,PC) ; ($5adc), A2
005AAE: B01A                     cmp.b   (A2)+, D0
005AB0: 6506                     bcs     $5ab8
005AB2: 0641 000C                addi.w  #$c, D1
005AB6: 60F6                     bra     $5aae
005AB8: 3141 000A                move.w  D1, ($a,A0)
005ABC: 317C 0300 000C           move.w  #$300, ($c,A0)
005AC2: 0839 0002 0006 0603      btst    #$2, $60603.l
005ACA: 6706                     beq     $5ad2
005ACC: 317C 0320 000C           move.w  #$320, ($c,A0)
005AD2: 13FC 0001 0006 0F50      move.b  #$1, $60f50.l
005ADA: 4E75                     rts
005ADC: 6F77                     ble     $5b55
005ADE: 8894                     or.l    (A4), D4
005AE0: FF00                     dc.w    $ff00; opcode 1111
005AE2: 1D48                     dc.w    $1d48; ILLEGAL
005AE4: 0003 000A                ori.b   #$a, D3
005AE8: 000B                     dc.w    $000b; ILLEGAL
005AEA: 000C                     dc.w    $000c; ILLEGAL
005AEC: 000D                     dc.w    $000d; ILLEGAL
005AEE: 1D48                     dc.w    $1d48; ILLEGAL
005AF0: 0003 0006                ori.b   #$6, D3
005AF4: 0007 0008                ori.b   #$8, D7
005AF8: 0009                     dc.w    $0009; ILLEGAL
005AFA: 1D48                     dc.w    $1d48; ILLEGAL
005AFC: 0003 0002                ori.b   #$2, D3
005B00: 0003 0004                ori.b   #$4, D3
005B04: 0005 1D48                ori.b   #$48, D5
005B08: 0003 0012                ori.b   #$12, D3
005B0C: 0013 0014                ori.b   #$14, (A3)
005B10: 0015 1D48                ori.b   #$48, (A5)
005B14: 0003 000E                ori.b   #$e, D3
005B18: 000F                     dc.w    $000f; ILLEGAL
005B1A: 0010 0011                ori.b   #$11, (A0)
005B1E: 5B5A                     subq.w  #5, (A2)+
005B20: 0001 001E                ori.b   #$1e, D1
005B24: 001F 0000                ori.b   #$0, (A7)+
005B28: 0000 5B5A                ori.b   #$5a, D0
005B2C: 0001 001C                ori.b   #$1c, D1
005B30: 001D 0000                ori.b   #$0, (A5)+
005B34: 0000 5B5A                ori.b   #$5a, D0
005B38: 0001 0016                ori.b   #$16, D1
005B3C: 0017 0000                ori.b   #$0, (A7)
005B40: 0000 5B5A                ori.b   #$5a, D0
005B44: 0001 0018                ori.b   #$18, D1
005B48: 0019 0000                ori.b   #$0, (A1)+
005B4C: 0000 5B5A                ori.b   #$5a, D0
005B50: 0001 001A                ori.b   #$1a, D1
005B54: 001B 0000                ori.b   #$0, (A3)+
005B58: 0000 F8F0                ori.b   #$f0, D0
005B5C: F800                     dc.w    $f800; opcode 1111
005B5E: 4240                     clr.w   D0
005B60: 1028 001F                move.b  ($1f,A0), D0
005B64: 323C 5B9A                move.w  #$5b9a, D1
005B68: 4A39 0006 06E6           tst.b   $606e6.l
005B6E: 6704                     beq     $5b74
005B70: 323C 5BE2                move.w  #$5be2, D1
005B74: D041                     add.w   D1, D0
005B76: 3140 000A                move.w  D0, ($a,A0)
005B7A: 317C 0300 000C           move.w  #$300, ($c,A0)
005B80: 0839 0002 0006 0603      btst    #$2, $60603.l
005B88: 6706                     beq     $5b90
005B8A: 317C 0320 000C           move.w  #$320, ($c,A0)
005B90: 13FC 0001 0006 0F50      move.b  #$1, $60f50.l
005B98: 4E75                     rts
005B9A: 1D48                     dc.w    $1d48; ILLEGAL
005B9C: 0003 0074                ori.b   #$74, D3
005BA0: 0075 0076 0077           ori.w   #$76, ($77,A5,D0.w)
005BA6: 1D48                     dc.w    $1d48; ILLEGAL
005BA8: 0003 0078                ori.b   #$78, D3
005BAC: 0079 007A 007B 1D48      ori.w   #$7a, $7b1d48.l
005BB4: 0003 007C                ori.b   #$7c, D3
005BB8: 007D                     dc.w    $007d; ILLEGAL
005BBA: 007E                     dc.w    $007e; ILLEGAL
005BBC: 007F                     dc.w    $007f; ILLEGAL
005BBE: 1D48                     dc.w    $1d48; ILLEGAL
005BC0: 0003 0080                ori.b   #$80, D3
005BC4: 0081 0082 0083           ori.l   #$820083, D1
005BCA: 1D48                     dc.w    $1d48; ILLEGAL
005BCC: 0003 0084                ori.b   #$84, D3
005BD0: 0085 0086 0087           ori.l   #$860087, D5
005BD6: 1D48                     dc.w    $1d48; ILLEGAL
005BD8: 0003 0088                ori.b   #$88, D3
005BDC: 0089                     dc.w    $0089; ILLEGAL
005BDE: 008A                     dc.w    $008a; ILLEGAL
005BE0: 008B                     dc.w    $008b; ILLEGAL
005BE2: 1D48                     dc.w    $1d48; ILLEGAL
005BE4: 0003 008C                ori.b   #$8c, D3
005BE8: 008D                     dc.w    $008d; ILLEGAL
005BEA: 008E                     dc.w    $008e; ILLEGAL
005BEC: 008F                     dc.w    $008f; ILLEGAL
005BEE: 1D48                     dc.w    $1d48; ILLEGAL
005BF0: 0003 0090                ori.b   #$90, D3
005BF4: 0091 0092 0093           ori.l   #$920093, (A1)
005BFA: 1D48                     dc.w    $1d48; ILLEGAL
005BFC: 0003 0094                ori.b   #$94, D3
005C00: 0095 0096 0097           ori.l   #$960097, (A5)
005C06: 1D48                     dc.w    $1d48; ILLEGAL
005C08: 0003 0098                ori.b   #$98, D3
005C0C: 0099 009A 009B           ori.l   #$9a009b, (A1)+
005C12: 1D48                     dc.w    $1d48; ILLEGAL
005C14: 0003 009C                ori.b   #$9c, D3
005C18: 009D 009E 009F           ori.l   #$9e009f, (A5)+
005C1E: 1D48                     dc.w    $1d48; ILLEGAL
005C20: 0003 00A0                ori.b   #$a0, D3
005C24: 00A1 00A2 00A3           ori.l   #$a200a3, -(A1)
005C2A: 3028 0014                move.w  ($14,A0), D0
005C2E: 5368 0016                subq.w  #1, ($16,A0)
005C32: 662C                     bne     $5c60
005C34: 317C 0010 0016           move.w  #$10, ($16,A0)
005C3A: 5440                     addq.w  #2, D0
005C3C: 3140 0014                move.w  D0, ($14,A0)
005C40: 0C40 0016                cmpi.w  #$16, D0
005C44: 661A                     bne     $5c60
005C46: 0279 B07F 0006 0604      andi.w  #$b07f, $60604.l
005C4E: 13F9 0006 07FA 0006 0601 move.b  $607fa.l, $60601.l
005C58: DFFC 0000 0004           adda.l  #$4, A7
005C5E: 4E75                     rts
005C60: 0C40 0010                cmpi.w  #$10, D0
005C64: 6502                     bcs     $5c68
005C66: 4E75                     rts
005C68: 317B 0024 000A           move.w  ($24,PC,D0.w), ($a,A0)
005C6E: 317C 0300 000C           move.w  #$300, ($c,A0)
005C74: 0839 0002 0006 0603      btst    #$2, $60603.l
005C7C: 6706                     beq     $5c84
005C7E: 317C 0320 000C           move.w  #$320, ($c,A0)
005C84: 13FC 0001 0006 0F50      move.b  #$1, $60f50.l
005C8C: 4E75                     rts
005C8E: 5C9E                     addq.l  #6, (A6)+
005C90: 5CAA 5CB6                addq.l  #6, ($5cb6,A2)
005C94: 5CBE                     dc.w    $5cbe; ILLEGAL
005C96: 5CC4                     sge     D4
005C98: 5CCA 5CD0                dbge    D2, $b96a
005C9C: 5CD6                     sge     (A6)
005C9E: 1D48                     dc.w    $1d48; ILLEGAL
005CA0: 0003 0002                ori.b   #$2, D3
005CA4: 0003 0004                ori.b   #$4, D3
005CA8: 0005 1D48                ori.b   #$48, D5
005CAC: 0003 00AC                ori.b   #$ac, D3
005CB0: 00AD 00AE 00AF 5CDC      ori.l   #$ae00af, ($5cdc,A5)
005CB8: 0001 00B0                ori.b   #$b0, D1
005CBC: 00B1 1DC0 0000 00B4      ori.l   #$1dc00000, (-$4c,A1,D0.w)
005CC4: 1DC0                     dc.w    $1dc0; ILLEGAL
005CC6: 0000 00B5                ori.b   #$b5, D0
005CCA: 1DC0                     dc.w    $1dc0; ILLEGAL
005CCC: 0000 00B6                ori.b   #$b6, D0
005CD0: 1DC0                     dc.w    $1dc0; ILLEGAL
005CD2: 0000 00B7                ori.b   #$b7, D0
005CD6: 1DC0                     dc.w    $1dc0; ILLEGAL
005CD8: 0000 00B7                ori.b   #$b7, D0
005CDC: 00F8                     dc.w    $00f8; ILLEGAL
005CDE: F0F8 3028 0014           pbws 30285cf4
005CE4: 5368 0016                subq.w  #1, ($16,A0)
005CE8: 6614                     bne     $5cfe
005CEA: 317C 0010 0016           move.w  #$10, ($16,A0)
005CF0: 5540                     subq.w  #2, D0
005CF2: 6A06                     bpl     $5cfa
005CF4: 30BC 0208                move.w  #$208, (A0)
005CF8: 4240                     clr.w   D0
005CFA: 3140 0014                move.w  D0, ($14,A0)
005CFE: 6000 FF68                bra     $5c68
005D02: 323C 5D64                move.w  #$5d64, D1
005D06: 4A39 0006 06E6           tst.b   $606e6.l
005D0C: 6704                     beq     $5d12
005D0E: 323C 5D82                move.w  #$5d82, D1
005D12: 1028 001F                move.b  ($1f,A0), D0
005D16: 0600 0080                addi.b  #-$80, D0
005D1A: 45FA 0042                lea     ($42,PC) ; ($5d5e), A2
005D1E: B01A                     cmp.b   (A2)+, D0
005D20: 6504                     bcs     $5d26
005D22: 5C41                     addq.w  #6, D1
005D24: 60F8                     bra     $5d1e
005D26: 3141 000A                move.w  D1, ($a,A0)
005D2A: 317C 0300 000C           move.w  #$300, ($c,A0)
005D30: 0839 0002 0006 0603      btst    #$2, $60603.l
005D38: 6706                     beq     $5d40
005D3A: 317C 0328 000C           move.w  #$328, ($c,A0)
005D40: 4240                     clr.w   D0
005D42: 1039 0006 1094           move.b  $61094.l, D0
005D48: 43F9 0006 0F5D           lea     $60f5d.l, A1
005D4E: 13B9 0006 06E7 0000      move.b  $606e7.l, (A1,D0.w)
005D56: 5239 0006 1094           addq.b  #1, $61094.l
005D5C: 4E75                     rts
005D5E: 6F77                     ble     $5dd7
005D60: 8894                     or.l    (A4), D4
005D62: FF00                     dc.w    $ff00; opcode 1111
005D64: 1DC0                     dc.w    $1dc0; ILLEGAL
005D66: 0000 006D                ori.b   #$6d, D0
005D6A: 1DC0                     dc.w    $1dc0; ILLEGAL
005D6C: 0000 006E                ori.b   #$6e, D0
005D70: 1DC0                     dc.w    $1dc0; ILLEGAL
005D72: 0000 006F                ori.b   #$6f, D0
005D76: 1DC0                     dc.w    $1dc0; ILLEGAL
005D78: 0000 0070                ori.b   #$70, D0
005D7C: 1DC0                     dc.w    $1dc0; ILLEGAL
005D7E: 0000 0071                ori.b   #$71, D0
005D82: 1DC0                     dc.w    $1dc0; ILLEGAL
005D84: 0000 006C                ori.b   #$6c, D0
005D88: 1DC0                     dc.w    $1dc0; ILLEGAL
005D8A: 0000 006B                ori.b   #$6b, D0
005D8E: 1DC0                     dc.w    $1dc0; ILLEGAL
005D90: 0000 006A                ori.b   #$6a, D0
005D94: 1DC0                     dc.w    $1dc0; ILLEGAL
005D96: 0000 0069                ori.b   #$69, D0
005D9A: 1DC0                     dc.w    $1dc0; ILLEGAL
005D9C: 0000 0068                ori.b   #$68, D0
005DA0: 3028 0014                move.w  ($14,A0), D0
005DA4: 5368 0016                subq.w  #1, ($16,A0)
005DA8: 660C                     bne     $5db6
005DAA: 317C 0010 0016           move.w  #$10, ($16,A0)
005DB0: 5C40                     addq.w  #6, D0
005DB2: 3140 0014                move.w  D0, ($14,A0)
005DB6: 0C40 002B                cmpi.w  #$2b, D0
005DBA: 6502                     bcs     $5dbe
005DBC: 4E75                     rts
005DBE: 0640 5DE0                addi.w  #$5de0, D0
005DC2: 3140 000A                move.w  D0, ($a,A0)
005DC6: 317C 0300 000C           move.w  #$300, ($c,A0)
005DCC: 0839 0002 0006 0603      btst    #$2, $60603.l
005DD4: 6706                     beq     $5ddc
005DD6: 317C 0320 000C           move.w  #$320, ($c,A0)
005DDC: 6000 FF62                bra     $5d40
005DE0: 1DC0                     dc.w    $1dc0; ILLEGAL
005DE2: 0000 006F                ori.b   #$6f, D0
005DE6: 1DC0                     dc.w    $1dc0; ILLEGAL
005DE8: 0000 00B8                ori.b   #$b8, D0
005DEC: 1DC0                     dc.w    $1dc0; ILLEGAL
005DEE: 0000 00B9                ori.b   #$b9, D0
005DF2: 1DC0                     dc.w    $1dc0; ILLEGAL
005DF4: 0000 00BA                ori.b   #$ba, D0
005DF8: 1DC0                     dc.w    $1dc0; ILLEGAL
005DFA: 0000 00BB                ori.b   #$bb, D0
005DFE: 1DC0                     dc.w    $1dc0; ILLEGAL
005E00: 0000 00B6                ori.b   #$b6, D0
005E04: 1DC0                     dc.w    $1dc0; ILLEGAL
005E06: 0000 00B7                ori.b   #$b7, D0
005E0A: 1DC0                     dc.w    $1dc0; ILLEGAL
005E0C: 0000 00B7                ori.b   #$b7, D0
005E10: 3028 0014                move.w  ($14,A0), D0
005E14: 5368 0016                subq.w  #1, ($16,A0)
005E18: 660C                     bne     $5e26
005E1A: 317C 0010 0016           move.w  #$10, ($16,A0)
005E20: 5D40                     subq.w  #6, D0
005E22: 3140 0014                move.w  D0, ($14,A0)
005E26: 4A40                     tst.w   D0
005E28: 6A94                     bpl     $5dbe
005E2A: 4240                     clr.w   D0
005E2C: 6090                     bra     $5dbe
005E2E: 0839 0000 0006 0603      btst    #$0, $60603.l
005E36: 6704                     beq     $5e3c
005E38: 5468 001A                addq.w  #2, ($1a,A0)
005E3C: 0268 FFFE 001A           andi.w  #$fffe, ($1a,A0)
005E42: 0C68 000C 001A           cmpi.w  #$c, ($1a,A0)
005E48: 6504                     bcs     $5e4e
005E4A: 4268 001A                clr.w   ($1a,A0)
005E4E: 3028 001A                move.w  ($1a,A0), D0
005E52: 4A39 0006 06E6           tst.b   $606e6.l
005E58: 6704                     beq     $5e5e
005E5A: 0640 000C                addi.w  #$c, D0
005E5E: 317B 0022 000A           move.w  ($22,PC,D0.w), ($a,A0)
005E64: 1039 0006 0603           move.b  $60603.l, D0
005E6A: 0240 0007                andi.w  #$7, D0
005E6E: D040                     add.w   D0, D0
005E70: 3200                     move.w  D0, D1
005E72: E548                     lsl.w   #2, D0
005E74: D041                     add.w   D1, D0
005E76: 0640 1378                addi.w  #$1378, D0
005E7A: 3140 000C                move.w  D0, ($c,A0)
005E7E: 6000 FEC0                bra     $5d40
005E82: 5EA4                     addq.l  #7, -(A4)
005E84: 5EB2 5EBE                addq.l  #7, INVALID 32
005E88: 5ECC 5ED8                dbgt    D4, $bd62
005E8C: 5EE6                     sgt     -(A6)
005E8E: 5EF2 5F00                sgt     INVALID 32
005E92: 5F0C                     dc.w    $5f0c; ILLEGAL
005E94: 5F1A                     subq.b  #7, (A2)+
005E96: 5F26                     subq.b  #7, -(A6)
005E98: 5F34 00F0                subq.b  #7, (-$10,A4,D0.w)
005E9C: 0000 F0F0                ori.b   #$f0, D0
005EA0: F000 F8F8                pmove [unknown form] D0
005EA4: 5E9A                     addq.l  #7, (A2)+
005EA6: 0004 00C4                ori.b   #$c4, D4
005EAA: 00C5                     dc.w    $00c5; ILLEGAL
005EAC: 00C6                     dc.w    $00c6; ILLEGAL
005EAE: 00C7                     dc.w    $00c7; ILLEGAL
005EB0: 006F 1D48 0003           ori.w   #$1d48, ($3,A7)
005EB6: 00C4                     dc.w    $00c4; ILLEGAL
005EB8: 00C5                     dc.w    $00c5; ILLEGAL
005EBA: 00C6                     dc.w    $00c6; ILLEGAL
005EBC: 00C7                     dc.w    $00c7; ILLEGAL
005EBE: 5E9A                     addq.l  #7, (A2)+
005EC0: 0004 00C8                ori.b   #$c8, D4
005EC4: 00C9                     dc.w    $00c9; ILLEGAL
005EC6: 00CA                     dc.w    $00ca; ILLEGAL
005EC8: 00CB                     dc.w    $00cb; ILLEGAL
005ECA: 006F 1D48 0003           ori.w   #$1d48, ($3,A7)
005ED0: 00C8                     dc.w    $00c8; ILLEGAL
005ED2: 00C9                     dc.w    $00c9; ILLEGAL
005ED4: 00CA                     dc.w    $00ca; ILLEGAL
005ED6: 00CB                     dc.w    $00cb; ILLEGAL
005ED8: 5E9A                     addq.l  #7, (A2)+
005EDA: 0004 00CC                ori.b   #$cc, D4
005EDE: 00CD                     dc.w    $00cd; ILLEGAL
005EE0: 00CE                     dc.w    $00ce; ILLEGAL
005EE2: 00CF                     dc.w    $00cf; ILLEGAL
005EE4: 006F 1D48 0003           ori.w   #$1d48, ($3,A7)
005EEA: 00CC                     dc.w    $00cc; ILLEGAL
005EEC: 00CD                     dc.w    $00cd; ILLEGAL
005EEE: 00CE                     dc.w    $00ce; ILLEGAL
005EF0: 00CF                     dc.w    $00cf; ILLEGAL
005EF2: 5E9A                     addq.l  #7, (A2)+
005EF4: 0004 00C4                ori.b   #$c4, D4
005EF8: 00C5                     dc.w    $00c5; ILLEGAL
005EFA: 00C6                     dc.w    $00c6; ILLEGAL
005EFC: 00C7                     dc.w    $00c7; ILLEGAL
005EFE: 006A 1D48 0003           ori.w   #$1d48, ($3,A2)
005F04: 00C4                     dc.w    $00c4; ILLEGAL
005F06: 00C5                     dc.w    $00c5; ILLEGAL
005F08: 00C6                     dc.w    $00c6; ILLEGAL
005F0A: 00C7                     dc.w    $00c7; ILLEGAL
005F0C: 5E9A                     addq.l  #7, (A2)+
005F0E: 0004 00C8                ori.b   #$c8, D4
005F12: 00C9                     dc.w    $00c9; ILLEGAL
005F14: 00CA                     dc.w    $00ca; ILLEGAL
005F16: 00CB                     dc.w    $00cb; ILLEGAL
005F18: 006A 1D48 0003           ori.w   #$1d48, ($3,A2)
005F1E: 00C8                     dc.w    $00c8; ILLEGAL
005F20: 00C9                     dc.w    $00c9; ILLEGAL
005F22: 00CA                     dc.w    $00ca; ILLEGAL
005F24: 00CB                     dc.w    $00cb; ILLEGAL
005F26: 5E9A                     addq.l  #7, (A2)+
005F28: 0004 00CC                ori.b   #$cc, D4
005F2C: 00CD                     dc.w    $00cd; ILLEGAL
005F2E: 00CE                     dc.w    $00ce; ILLEGAL
005F30: 00CF                     dc.w    $00cf; ILLEGAL
005F32: 006A 1D48 0003           ori.w   #$1d48, ($3,A2)
005F38: 00CC                     dc.w    $00cc; ILLEGAL
005F3A: 00CD                     dc.w    $00cd; ILLEGAL
005F3C: 00CE                     dc.w    $00ce; ILLEGAL
005F3E: 00CF                     dc.w    $00cf; ILLEGAL
005F40: 4A39 0006 06ED           tst.b   $606ed.l
005F46: 6716                     beq     $5f5e
005F48: 13FC 0018 0006 110C      move.b  #$18, $6110c.l
005F50: 13FC 0001 0006 26AF      move.b  #$1, $626af.l
005F58: 4279 0006 112A           clr.w   $6112a.l
005F5E: 0C39 0002 0006 06EB      cmpi.b  #$2, $606eb.l
005F66: 6556                     bcs     $5fbe
005F68: 4A39 0006 122C           tst.b   $6122c.l
005F6E: 664E                     bne     $5fbe
005F70: 5239 0006 26B3           addq.b  #1, $626b3.l
005F76: 43F9 0006 122C           lea     $6122c.l, A1
005F7C: 32BC 1000                move.w  #$1000, (A1)
005F80: 3368 0002 0002           move.w  ($2,A0), ($2,A1)
005F86: 4269 0004                clr.w   ($4,A1)
005F8A: 3368 0006 0006           move.w  ($6,A0), ($6,A1)
005F90: 0669 0018 0006           addi.w  #$18, ($6,A1)
005F96: 4269 0008                clr.w   ($8,A1)
005F9A: 137C 0007 0010           move.b  #$7, ($10,A1)
005FA0: 337C 8000 0012           move.w  #$8000, ($12,A1)
005FA6: 137C 0010 0014           move.b  #$10, ($14,A1)
005FAC: 3368 0002 0016           move.w  ($2,A0), ($16,A1)
005FB2: 3368 0006 0018           move.w  ($6,A0), ($18,A1)
005FB8: 337C 0004 001E           move.w  #$4, ($1e,A1)
005FBE: 4EB9 0000 5FCA           jsr     $5fca.l
005FC4: 4EF9 0000 6150           jmp     $6150.l
005FCA: 4A28 001E                tst.b   ($1e,A0)
005FCE: 6706                     beq     $5fd6
005FD0: 5328 001E                subq.b  #1, ($1e,A0)
005FD4: 4E75                     rts
005FD6: 0839 0004 0006 06E9      btst    #$4, $606e9.l
005FDE: 6754                     beq     $6034
005FE0: 7000                     moveq   #$0, D0
005FE2: 1039 0006 06EB           move.b  $606eb.l, D0
005FE8: D040                     add.w   D0, D0
005FEA: 303B 004A                move.w  ($4a,PC,D0.w), D0
005FEE: 2440                     movea.l D0, A2
005FF0: 47F9 0006 26B1           lea     $626b1.l, A3
005FF6: 49FA 0058                lea     ($58,PC) ; ($6050), A4
005FFA: 4A39 0006 06E6           tst.b   $606e6.l
006000: 6704                     beq     $6006
006002: 49FA 0054                lea     ($54,PC) ; ($6058), A4
006006: 7000                     moveq   #$0, D0
006008: 101A                     move.b  (A2)+, D0
00600A: 6B28                     bmi     $6034
00600C: 3200                     move.w  D0, D1
00600E: 0C41 0006                cmpi.w  #$6, D1
006012: 6602                     bne     $6016
006014: 4241                     clr.w   D1
006016: E249                     lsr.w   #1, D1
006018: 1433 1000                move.b  (A3,D1.w), D2
00601C: B41A                     cmp.b   (A2)+, D2
00601E: 64E6                     bcc     $6006
006020: 5233 1000                addq.b  #1, (A3,D1.w)
006024: 3034 0000                move.w  (A4,D0.w), D0
006028: 2240                     movea.l D0, A1
00602A: 4E91                     jsr     (A1)
00602C: 117C 0004 001E           move.b  #$4, ($1e,A0)
006032: 60D2                     bra     $6006
006034: 4E75                     rts
006036: 603E                     bra     $6076
006038: 6041                     bra     $607b
00603A: 6044                     bra     $6080
00603C: 6049                     bra     $6087
00603E: 0004 FF02                ori.b   #$2, D4
006042: 02FF                     dc.w    $02ff; ILLEGAL
006044: 0202 0404                andi.b  #$4, D2
006048: FF06                     dc.w    $ff06; opcode 1111
00604A: 0302                     btst    D1, D2
00604C: 0204 04FF                andi.b  #$ff, D4
006050: 6078                     bra     $60ca
006052: 60CC                     bra     $6020
006054: 6108                     bsr     $605e
006056: 6060                     bra     $60b8
006058: 6084                     bra     $5fde
00605A: 60D8                     bra     $6034
00605C: 60F4                     bra     $6052
00605E: 606C                     bra     $60cc
006060: 4BFA 0004                lea     ($4,PC) ; ($6066), A5
006064: 602A                     bra     $6090
006066: 0000 FFF8                ori.b   #$f8, D0
00606A: 1400                     move.b  D0, D2
00606C: 4BFA 0004                lea     ($4,PC) ; ($6072), A5
006070: 601E                     bra     $6090
006072: FFFC                     dc.w    $fffc; opcode 1111
006074: 0000 1600                ori.b   #$0, D0
006078: 4BFA 0004                lea     ($4,PC) ; ($607e), A5
00607C: 600A                     bra     $6088
00607E: 0000 0010                ori.b   #$10, D0
006082: 0800 4BFA                btst    #$fa, D0
006086: 0040 7002                ori.w   #$7002, D0
00608A: 4EB9 0000 77EA           jsr     $77ea.l
006090: 43F9 0006 112C           lea     $6112c.l, A1
006096: 7402                     moveq   #$2, D2
006098: D3FC 0000 0020           adda.l  #$20, A1
00609E: 4A11                     tst.b   (A1)
0060A0: 66F6                     bne     $6098
0060A2: 3228 0002                move.w  ($2,A0), D1
0060A6: D25D                     add.w   (A5)+, D1
0060A8: 3341 0002                move.w  D1, ($2,A1)
0060AC: 3228 0006                move.w  ($6,A0), D1
0060B0: D25D                     add.w   (A5)+, D1
0060B2: 3341 0006                move.w  D1, ($6,A1)
0060B6: 329D                     move.w  (A5)+, (A1)
0060B8: 4229 0015                clr.b   ($15,A1)
0060BC: 4269 0016                clr.w   ($16,A1)
0060C0: 3342 001E                move.w  D2, ($1e,A1)
0060C4: 4E75                     rts
0060C6: 0010 0000                ori.b   #$0, (A0)
0060CA: 0A00 4BFA                eori.b  #$fa, D0
0060CE: 0004 600A                ori.b   #$a, D4
0060D2: 0000 0010                ori.b   #$10, D0
0060D6: 0C00 4BFA                cmpi.b  #-$6, D0
0060DA: 0014 7003                ori.b   #$3, (A4)
0060DE: 4EB9 0000 77EA           jsr     $77ea.l
0060E4: 43F9 0006 11AC           lea     $611ac.l, A1
0060EA: 7403                     moveq   #$3, D2
0060EC: 60AA                     bra     $6098
0060EE: 0010 0000                ori.b   #$0, (A0)
0060F2: 0E00                     dc.w    $0e00; ILLEGAL
0060F4: 7240                     moveq   #$40, D1
0060F6: 3439 0006 1232           move.w  $61232.l, D2
0060FC: B479 0006 10B2           cmp.w   $610b2.l, D2
006102: 6416                     bcc     $611a
006104: 72C0                     moveq   #-$40, D1
006106: 6012                     bra     $611a
006108: 4241                     clr.w   D1
00610A: 3439 0006 122E           move.w  $6122e.l, D2
006110: B479 0006 10AE           cmp.w   $610ae.l, D2
006116: 6502                     bcs     $611a
006118: 7280                     moveq   #-$80, D1
00611A: 43F9 0006 122C           lea     $6122c.l, A1
006120: D3FC 0000 0020           adda.l  #$20, A1
006126: 4A11                     tst.b   (A1)
006128: 66F6                     bne     $6120
00612A: 32BC 1200                move.w  #$1200, (A1)
00612E: 3379 0006 122E 0002      move.w  $6122e.l, ($2,A1)
006136: 3379 0006 1232 0006      move.w  $61232.l, ($6,A1)
00613E: 137C 0014 0010           move.b  #$14, ($10,A1)
006144: 1341 0012                move.b  D1, ($12,A1)
006148: 337C 0004 001E           move.w  #$4, ($1e,A1)
00614E: 4E75                     rts
006150: 0839 0005 0006 06E9      btst    #$5, $606e9.l
006158: 677A                     beq     $61d4
00615A: 4A39 0006 26B0           tst.b   $626b0.l
006160: 6672                     bne     $61d4
006162: 7005                     moveq   #$5, D0
006164: 4EB9 0000 77EA           jsr     $77ea.l
00616A: 5239 0006 26B0           addq.b  #1, $626b0.l
006170: 43F9 0006 112C           lea     $6112c.l, A1
006176: 3368 0002 0002           move.w  ($2,A0), ($2,A1)
00617C: 337C 0001 001E           move.w  #$1, ($1e,A1)
006182: 4A39 0006 06E6           tst.b   $606e6.l
006188: 661C                     bne     $61a6
00618A: 3368 0006 0006           move.w  ($6,A0), ($6,A1)
006190: 5569 0006                subq.w  #2, ($6,A1)
006194: 32BC 0200                move.w  #$200, (A1)
006198: 137C 0040 0012           move.b  #$40, ($12,A1)
00619E: 137C 002F 0014           move.b  #$2f, ($14,A1)
0061A4: 4E75                     rts
0061A6: 3368 0006 0006           move.w  ($6,A0), ($6,A1)
0061AC: 5D69 0006                subq.w  #6, ($6,A1)
0061B0: 32BC 0400                move.w  #$400, (A1)
0061B4: 237C 0300 8000 0010      move.l  #$3008000, ($10,A1)
0061BC: 137C 0006 0014           move.b  #$6, ($14,A1)
0061C2: 137C 002F 0015           move.b  #$2f, ($15,A1)
0061C8: 137C 0008 0016           move.b  #$8, ($16,A1)
0061CE: 137C 00A0 0017           move.b  #$a0, ($17,A1)
0061D4: 4E75                     rts
0061D6: DFFC 0000 0004           adda.l  #$4, A7
0061DC: 4250                     clr.w   (A0)
0061DE: 43F9 0006 26AF           lea     $626af.l, A1
0061E4: 3028 001E                move.w  ($1e,A0), D0
0061E8: 5331 0000                subq.b  #1, (A1,D0.w)
0061EC: 4E75                     rts
0061EE: 4240                     clr.w   D0
0061F0: 41F9 0006 26AF           lea     $626af.l, A0
0061F6: D018                     add.b   (A0)+, D0
0061F8: D018                     add.b   (A0)+, D0
0061FA: D018                     add.b   (A0)+, D0
0061FC: D018                     add.b   (A0)+, D0
0061FE: D018                     add.b   (A0)+, D0
006200: 6602                     bne     $6204
006202: 4E75                     rts
006204: 5340                     subq.w  #1, D0
006206: 13FC 0004 0006 06E7      move.b  #$4, $606e7.l
00620E: 41F9 0006 110C           lea     $6110c.l, A0
006214: 47F9 0006 1091           lea     $61091.l, A3
00621A: 49F9 0006 0F4E           lea     $60f4e.l, A4
006220: 4BF9 0006 1093           lea     $61093.l, A5
006226: 4DF9 0006 0F52           lea     $60f52.l, A6
00622C: 3F00                     move.w  D0, -(A7)
00622E: 4A10                     tst.b   (A0)
006230: 660E                     bne     $6240
006232: 5239 0006 06E7           addq.b  #1, $606e7.l
006238: D1FC 0000 0020           adda.l  #$20, A0
00623E: 60EE                     bra     $622e
006240: 7000                     moveq   #$0, D0
006242: 1010                     move.b  (A0), D0
006244: 303B 0018                move.w  ($18,PC,D0.w), D0
006248: 2240                     movea.l D0, A1
00624A: 4E91                     jsr     (A1)
00624C: 5239 0006 06E7           addq.b  #1, $606e7.l
006252: D1FC 0000 0020           adda.l  #$20, A0
006258: 301F                     move.w  (A7)+, D0
00625A: 51C8 FFD0                dbra    D0, $622c
00625E: 4E75                     rts
006260: 62AC                     bhi     $620e
006262: 6382                     bls     $61e6
006264: 645A                     bcc     $62c0
006266: 66DA                     bne     $6242
006268: 66B6                     bne     $6220
00626A: 6794                     beq     $6200
00626C: 6756                     beq     $62c4
00626E: 689C                     bvc     $620c
006270: 6828                     bvc     $629a
006272: 665C                     bne     $62d0
006274: 6682                     bne     $61f8
006276: 6910                     bvs     $6288
006278: 6976                     bvs     $62f0
00627A: 6A9E                     bpl     $621a
00627C: 6A7C                     bpl     $62fa
00627E: 6A5A                     bpl     $62da
006280: 6A38                     bpl     $62ba
006282: 6B3E                     bmi     $62c2
006284: 6B2E                     bmi     $62b4
006286: 6B1E                     bmi     $62a6
006288: 6B0E                     bmi     $6298
00628A: 6B3E                     bmi     $62ca
00628C: 6B2E                     bmi     $62bc
00628E: 6B1E                     bmi     $62ae
006290: 6B0E                     bmi     $62a0
006292: 61DC                     bsr     $6270
006294: FFFF                     dc.w    $ffff; opcode 1111
006296: 0000 0001                ori.b   #$1, D0
00629A: 0102                     btst    D0, D2
00629C: 0405 0708                subi.b  #$8, D5
0062A0: 0909 0A0A                movep.w ($a0a,A1), D4
0062A4: 0B0B 0C0C                movep.w ($c0c,A3), D5
0062A8: 0D0D 0E0E                movep.w ($e0e,A5), D6
0062AC: 1028 0014                move.b  ($14,A0), D0
0062B0: E248                     lsr.w   #1, D0
0062B2: 0240 003F                andi.w  #$3f, D0
0062B6: 117B 00DC 0010           move.b  (-$24,PC,D0.w), ($10,A0)
0062BC: 4EB9 0000 7FE4           jsr     $7fe4.l
0062C2: 5328 0014                subq.b  #1, ($14,A0)
0062C6: 6648                     bne     $6310
0062C8: 30BC 0600                move.w  #$600, (A0)
0062CC: 42A8 0014                clr.l   ($14,A0)
0062D0: 4268 001A                clr.w   ($1a,A0)
0062D4: 4240                     clr.w   D0
0062D6: 0C28 0001 001F           cmpi.b  #$1, ($1f,A0)
0062DC: 661A                     bne     $62f8
0062DE: 701F                     moveq   #$1f, D0
0062E0: 0C39 0002 0006 06EC      cmpi.b  #$2, $606ec.l
0062E8: 6502                     bcs     $62ec
0062EA: 7020                     moveq   #$20, D0
0062EC: 4EB9 0000 77EA           jsr     $77ea.l
0062F2: 1039 0006 06EC           move.b  $606ec.l, D0
0062F8: D040                     add.w   D0, D0
0062FA: 5840                     addq.w  #4, D0
0062FC: 3140 0018                move.w  D0, ($18,A0)
006300: 0C68 0201 0002           cmpi.w  #$201, ($2,A0)
006306: 6506                     bcs     $630e
006308: 317C 0200 0002           move.w  #$200, ($2,A0)
00630E: 4E75                     rts
006310: 317C 0300 000C           move.w  #$300, ($c,A0)
006316: 0839 0002 0006 0603      btst    #$2, $60603.l
00631E: 6706                     beq     $6326
006320: 317C 0320 000C           move.w  #$320, ($c,A0)
006326: 1028 0014                move.b  ($14,A0), D0
00632A: E248                     lsr.w   #1, D0
00632C: 0240 003F                andi.w  #$3f, D0
006330: 103B 001A                move.b  ($1a,PC,D0.w), D0
006334: 0640 6364                addi.w  #$6364, D0
006338: 3140 000A                move.w  D0, ($a,A0)
00633C: 4240                     clr.w   D0
00633E: 1013                     move.b  (A3), D0
006340: 5213                     addq.b  #1, (A3)
006342: 19B9 0006 06E7 0000      move.b  $606e7.l, (A4,D0.w)
00634A: 4E75                     rts
00634C: 1818                     move.b  (A0)+, D4
00634E: 1818                     move.b  (A0)+, D4
006350: 1212                     move.b  (A2), D1
006352: 1212                     move.b  (A2), D1
006354: 1212                     move.b  (A2), D1
006356: 0C0C                     dc.w    $0c0c; ILLEGAL
006358: 0C0C                     dc.w    $0c0c; ILLEGAL
00635A: 0000 0000                ori.b   #$0, D0
00635E: 0000 0606                ori.b   #$6, D0
006362: 0606 1DC0                addi.b  #-$40, D6
006366: 0000 0040                ori.b   #$40, D0
00636A: 1DC0                     dc.w    $1dc0; ILLEGAL
00636C: 0000 003F                ori.b   #$3f, D0
006370: 1DC0                     dc.w    $1dc0; ILLEGAL
006372: 0000 0041                ori.b   #$41, D0
006376: 1DC0                     dc.w    $1dc0; ILLEGAL
006378: 0000 0042                ori.b   #$42, D0
00637C: 1DC0                     dc.w    $1dc0; ILLEGAL
00637E: 0000 0043                ori.b   #$43, D0
006382: 5328 0015                subq.b  #1, ($15,A0)
006386: 6700 FF40                beq     $62c8
00638A: 0668 0080 0010           addi.w  #$80, ($10,A0)
006390: 4A28 0001                tst.b   ($1,A0)
006394: 6618                     bne     $63ae
006396: 4EB9 0000 7FE4           jsr     $7fe4.l
00639C: 6100 0066                bsr     $6404
0063A0: 5328 0016                subq.b  #1, ($16,A0)
0063A4: 6626                     bne     $63cc
0063A6: 117C 0002 0001           move.b  #$2, ($1,A0)
0063AC: 601E                     bra     $63cc
0063AE: 1428 0017                move.b  ($17,A0), D2
0063B2: 4EB9 0000 809E           jsr     $809e.l
0063B8: B428 0012                cmp.b   ($12,A0), D2
0063BC: 660A                     bne     $63c8
0063BE: 4228 0001                clr.b   ($1,A0)
0063C2: 117C 00FF 0016           move.b  #$ff, ($16,A0)
0063C8: 6100 003A                bsr     $6404
0063CC: 317C 0300 000C           move.w  #$300, ($c,A0)
0063D2: 0839 0001 0006 0603      btst    #$1, $60603.l
0063DA: 6706                     beq     $63e2
0063DC: 317C 0320 000C           move.w  #$320, ($c,A0)
0063E2: 1028 0012                move.b  ($12,A0), D0
0063E6: 5000                     addq.b  #8, D0
0063E8: E848                     lsr.w   #4, D0
0063EA: 5D00                     subq.b  #6, D0
0063EC: 0240 0007                andi.w  #$7, D0
0063F0: D040                     add.w   D0, D0
0063F2: 3200                     move.w  D0, D1
0063F4: D040                     add.w   D0, D0
0063F6: D041                     add.w   D1, D0
0063F8: 0640 643C                addi.w  #$643c, D0
0063FC: 3140 000A                move.w  D0, ($a,A0)
006400: 6000 FF3A                bra     $633c
006404: 0C28 0080 0012           cmpi.b  #-$80, ($12,A0)
00640A: 6410                     bcc     $641c
00640C: 0C68 0141 0006           cmpi.w  #$141, ($6,A0)
006412: 6526                     bcs     $643a
006414: 317C 0141 0006           move.w  #$141, ($6,A0)
00641A: 600E                     bra     $642a
00641C: 0C68 00A0 0006           cmpi.w  #$a0, ($6,A0)
006422: 6416                     bcc     $643a
006424: 317C 00A0 0006           move.w  #$a0, ($6,A0)
00642A: 4228 0001                clr.b   ($1,A0)
00642E: 117C 0080 0012           move.b  #$80, ($12,A0)
006434: 117C 00FF 0016           move.b  #$ff, ($16,A0)
00643A: 4E75                     rts
00643C: 1DC0                     dc.w    $1dc0; ILLEGAL
00643E: 0000 0046                ori.b   #$46, D0
006442: 1DC0                     dc.w    $1dc0; ILLEGAL
006444: 0000 0045                ori.b   #$45, D0
006448: 1DC0                     dc.w    $1dc0; ILLEGAL
00644A: 0000 0044                ori.b   #$44, D0
00644E: 1DC0                     dc.w    $1dc0; ILLEGAL
006450: 0000 1045                ori.b   #$45, D0
006454: 1DC0                     dc.w    $1dc0; ILLEGAL
006456: 0000 1046                ori.b   #$46, D0
00645A: 4EB9 0000 DA52           jsr     $da52.l
006460: 4EB9 0000 825A           jsr     $825a.l
006466: 5268 001A                addq.w  #1, ($1a,A0)
00646A: 3228 001A                move.w  ($1a,A0), D1
00646E: 3028 0018                move.w  ($18,A0), D0
006472: B068 0014                cmp.w   ($14,A0), D0
006476: 6600 008E                bne     $6506
00647A: 0241 0007                andi.w  #$7, D1
00647E: 6600 0090                bne     $6510
006482: 4A39 0006 06E6           tst.b   $606e6.l
006488: 666C                     bne     $64f6
00648A: 0C68 0178 0006           cmpi.w  #$178, ($6,A0)
006490: 6464                     bcc     $64f6
006492: 0C68 0004 0018           cmpi.w  #$4, ($18,A0)
006498: 675C                     beq     $64f6
00649A: 4A68 0016                tst.w   ($16,A0)
00649E: 6656                     bne     $64f6
0064A0: 0C79 0010 0006 07E6      cmpi.w  #$10, $607e6.l
0064A8: 644C                     bcc     $64f6
0064AA: 0C39 0006 0006 26BF      cmpi.b  #$6, $626bf.l
0064B2: 6442                     bcc     $64f6
0064B4: 3628 0002                move.w  ($2,A0), D3
0064B8: 3828 0006                move.w  ($6,A0), D4
0064BC: 4EB9 0004 10BE           jsr     $410be.l
0064C2: 6632                     bne     $64f6
0064C4: 5239 0006 26BF           addq.b  #1, $626bf.l
0064CA: 43F9 0006 1C4C           lea     $61c4c.l, A1
0064D0: D3FC 0000 0020           adda.l  #$20, A1
0064D6: 4A11                     tst.b   (A1)
0064D8: 66F6                     bne     $64d0
0064DA: 5211                     addq.b  #1, (A1)
0064DC: 3368 0002 0002           move.w  ($2,A0), ($2,A1)
0064E2: 3368 0006 0006           move.w  ($6,A0), ($6,A1)
0064E8: 3368 0018 0018           move.w  ($18,A0), ($18,A1)
0064EE: 3379 0006 07E6 0016      move.w  $607e6.l, ($16,A1)
0064F6: 5468 0016                addq.w  #2, ($16,A0)
0064FA: 0C68 000C 0016           cmpi.w  #$c, ($16,A0)
006500: 660E                     bne     $6510
006502: 6000 FCD8                bra     $61dc
006506: 0241 0007                andi.w  #$7, D1
00650A: 6604                     bne     $6510
00650C: 5468 0014                addq.w  #2, ($14,A0)
006510: 3028 0014                move.w  ($14,A0), D0
006514: 317B 002C 000A           move.w  ($2c,PC,D0.w), ($a,A0)
00651A: 3028 0016                move.w  ($16,A0), D0
00651E: 317B 002E 000C           move.w  ($2e,PC,D0.w), ($c,A0)
006524: 43F9 0006 1027           lea     $61027.l, A1
00652A: 4240                     clr.w   D0
00652C: 1039 0006 10A1           move.b  $610a1.l, D0
006532: 5239 0006 10A1           addq.b  #1, $610a1.l
006538: 13B9 0006 06E7 0000      move.b  $606e7.l, (A1,D0.w)
006540: 4E75                     rts
006542: 655A                     bcs     $659e
006544: 6560                     bcs     $65a6
006546: 656C                     bcs     $65b4
006548: 6578                     bcs     $65c2
00654A: 659C                     bcs     $64e8
00654C: 65E0                     bcs     $652e
00654E: 032C 03A4                btst    D1, ($3a4,A4)
006552: 041C 0494                subi.b  #-$6c, (A4)+
006556: 050C 0584                movep.w ($584,A4), D2
00655A: 1DC0                     dc.w    $1dc0; ILLEGAL
00655C: 0000 0001                ori.b   #$1, D0
006560: 1D48                     dc.w    $1d48; ILLEGAL
006562: 0003 2047                ori.b   #$47, D3
006566: 0047 3047                ori.w   #$3047, D7
00656A: 1047                     dc.w    $1047; ILLEGAL
00656C: 1D48                     dc.w    $1d48; ILLEGAL
00656E: 0003 2048                ori.b   #$48, D3
006572: 0048                     dc.w    $0048; ILLEGAL
006574: 3048                     movea.w A0, A0
006576: 1048                     dc.w    $1048; ILLEGAL
006578: 1D48                     dc.w    $1d48; ILLEGAL
00657A: 000F                     dc.w    $000f; ILLEGAL
00657C: 204B                     movea.l A3, A0
00657E: 004B                     dc.w    $004b; ILLEGAL
006580: 304B                     movea.w A3, A0
006582: 104B                     dc.w    $104b; ILLEGAL
006584: 2049                     movea.l A1, A0
006586: 0049                     dc.w    $0049; ILLEGAL
006588: 3049                     movea.w A1, A0
00658A: 1049                     dc.w    $1049; ILLEGAL
00658C: 204A                     movea.l A2, A0
00658E: 004A                     dc.w    $004a; ILLEGAL
006590: 204C                     movea.l A4, A0
006592: 004C                     dc.w    $004c; ILLEGAL
006594: 304C                     movea.w A4, A0
006596: 104C                     dc.w    $104c; ILLEGAL
006598: 304A                     movea.w A2, A0
00659A: 104A                     dc.w    $104a; ILLEGAL
00659C: 1D48                     dc.w    $1d48; ILLEGAL
00659E: 001F 2052                ori.b   #$52, (A7)+
0065A2: 0052 3052                ori.w   #$3052, (A2)
0065A6: 1052                     dc.w    $1052; ILLEGAL
0065A8: 204F                     movea.l A7, A0
0065AA: 004F                     dc.w    $004f; ILLEGAL
0065AC: 304F                     movea.w A7, A0
0065AE: 104F                     dc.w    $104f; ILLEGAL
0065B0: 2050                     movea.l (A0), A0
0065B2: 0050 2053                ori.w   #$2053, (A0)
0065B6: 0053 3053                ori.w   #$3053, (A3)
0065BA: 1053                     dc.w    $1053; ILLEGAL
0065BC: 3050                     movea.w (A0), A0
0065BE: 1050                     dc.w    $1050; ILLEGAL
0065C0: 204E                     movea.l A6, A0
0065C2: 204D                     movea.l A5, A0
0065C4: 004D                     dc.w    $004d; ILLEGAL
0065C6: 004E                     dc.w    $004e; ILLEGAL
0065C8: 304E                     movea.w A6, A0
0065CA: 304D                     movea.w A5, A0
0065CC: 104D                     dc.w    $104d; ILLEGAL
0065CE: 104E                     dc.w    $104e; ILLEGAL
0065D0: 2051                     movea.l (A1), A0
0065D2: 0051 2054                ori.w   #$2054, (A1)
0065D6: 0054 3054                ori.w   #$3054, (A4)
0065DA: 1054                     dc.w    $1054; ILLEGAL
0065DC: 3051                     movea.w (A1), A0
0065DE: 1051                     dc.w    $1051; ILLEGAL
0065E0: 1D48                     dc.w    $1d48; ILLEGAL
0065E2: 003B                     dc.w    $003b; ILLEGAL
0065E4: 205C                     movea.l (A4)+, A0
0065E6: 005C 305C                ori.w   #$305c, (A4)+
0065EA: 105C                     dc.w    $105c; ILLEGAL
0065EC: 2059                     movea.l (A1)+, A0
0065EE: 0059 3059                ori.w   #$3059, (A1)+
0065F2: 1059                     dc.w    $1059; ILLEGAL
0065F4: 205A                     movea.l (A2)+, A0
0065F6: 005A 205D                ori.w   #$205d, (A2)+
0065FA: 005D 305D                ori.w   #$305d, (A5)+
0065FE: 105D                     dc.w    $105d; ILLEGAL
006600: 305A                     movea.w (A2)+, A0
006602: 105A                     dc.w    $105a; ILLEGAL
006604: 2057                     movea.l (A7), A0
006606: 2056                     movea.l (A6), A0
006608: 0056 0057                ori.w   #$57, (A6)
00660C: 3057                     movea.w (A7), A0
00660E: 3056                     movea.w (A6), A0
006610: 1056                     dc.w    $1056; ILLEGAL
006612: 1057                     dc.w    $1057; ILLEGAL
006614: 205B                     movea.l (A3)+, A0
006616: 005B 205E                ori.w   #$205e, (A3)+
00661A: 005E 305E                ori.w   #$305e, (A6)+
00661E: 105E                     dc.w    $105e; ILLEGAL
006620: 305B                     movea.w (A3)+, A0
006622: 105B                     dc.w    $105b; ILLEGAL
006624: 20FD                     dc.w    $20fd; ILLEGAL
006626: 20FC 2055 0055           move.l  #$20550055, (A0)+
00662C: 00FC                     dc.w    $00fc; ILLEGAL
00662E: 00FD                     dc.w    $00fd; ILLEGAL
006630: 20FE                     dc.w    $20fe; ILLEGAL
006632: 2058                     movea.l (A0)+, A0
006634: 0058 00FE                ori.w   #$fe, (A0)+
006638: 20FF                     dc.w    $20ff; ILLEGAL
00663A: 00FF                     dc.w    $00ff; ILLEGAL
00663C: 205F                     movea.l (A7)+, A0
00663E: 005F 305F                ori.w   #$305f, (A7)+
006642: 105F                     dc.w    $105f; ILLEGAL
006644: 30FF                     dc.w    $30ff; ILLEGAL
006646: 10FF                     dc.w    $10ff; ILLEGAL
006648: 30FE                     dc.w    $30fe; ILLEGAL
00664A: 3058                     movea.w (A0)+, A0
00664C: 1058                     dc.w    $1058; ILLEGAL
00664E: 10FE                     dc.w    $10fe; ILLEGAL
006650: 30FD                     dc.w    $30fd; ILLEGAL
006652: 30FC 3055                move.w  #$3055, (A0)+
006656: 1055                     dc.w    $1055; ILLEGAL
006658: 10FC 10FD                move.b  #$fd, (A0)+
00665C: 4EB9 0000 825A           jsr     $825a.l
006662: 7406                     moveq   #$6, D2
006664: 363C 0080                move.w  #$80, D3
006668: 383C 6676                move.w  #$6676, D4
00666C: 0C10 001C                cmpi.b  #$1c, (A0)
006670: 6400 008E                bcc     $6700
006674: 6022                     bra     $6698
006676: 1DC0                     dc.w    $1dc0; ILLEGAL
006678: 0000 102A                ori.b   #$2a, D0
00667C: 1DC0                     dc.w    $1dc0; ILLEGAL
00667E: 0000 102B                ori.b   #$2b, D0
006682: 4EB9 0000 825A           jsr     $825a.l
006688: 7402                     moveq   #$2, D2
00668A: 363C 0058                move.w  #$58, D3
00668E: 383C 66AA                move.w  #$66aa, D4
006692: 0C10 001C                cmpi.b  #$1c, (A0)
006696: 6468                     bcc     $6700
006698: 0470 0005 2000           subi.w  #$5, (A0,D2.w)
00669E: B670 2000                cmp.w   (A0,D2.w), D3
0066A2: 6E00 FB38                bgt     $61dc
0066A6: 6000 0058                bra     $6700
0066AA: 1DC0                     dc.w    $1dc0; ILLEGAL
0066AC: 0000 202C                ori.b   #$2c, D0
0066B0: 1DC0                     dc.w    $1dc0; ILLEGAL
0066B2: 0000 202D                ori.b   #$2d, D0
0066B6: 4EB9 0000 825A           jsr     $825a.l
0066BC: 7402                     moveq   #$2, D2
0066BE: 363C 01A8                move.w  #$1a8, D3
0066C2: 383C 66CE                move.w  #$66ce, D4
0066C6: 0C10 001C                cmpi.b  #$1c, (A0)
0066CA: 6434                     bcc     $6700
0066CC: 6022                     bra     $66f0
0066CE: 1DC0                     dc.w    $1dc0; ILLEGAL
0066D0: 0000 002C                ori.b   #$2c, D0
0066D4: 1DC0                     dc.w    $1dc0; ILLEGAL
0066D6: 0000 002D                ori.b   #$2d, D0
0066DA: 4EB9 0000 825A           jsr     $825a.l
0066E0: 7406                     moveq   #$6, D2
0066E2: 363C 0180                move.w  #$180, D3
0066E6: 383C 674A                move.w  #$674a, D4
0066EA: 0C10 001C                cmpi.b  #$1c, (A0)
0066EE: 6410                     bcc     $6700
0066F0: 06B0 0005 8000 2000      addi.l  #$58000, (A0,D2.w)
0066F8: B670 2000                cmp.w   (A0,D2.w), D3
0066FC: 6D00 FADE                blt     $61dc
006700: 5228 0015                addq.b  #1, ($15,A0)
006704: 3028 0016                move.w  ($16,A0), D0
006708: 0C40 0006                cmpi.w  #$6, D0
00670C: 6710                     beq     $671e
00670E: 1228 0015                move.b  ($15,A0), D1
006712: 0201 0003                andi.b  #$3, D1
006716: 6606                     bne     $671e
006718: 5C40                     addq.w  #6, D0
00671A: 3140 0016                move.w  D0, ($16,A0)
00671E: D044                     add.w   D4, D0
006720: 3140 000A                move.w  D0, ($a,A0)
006724: 317C 05FC 000C           move.w  #$5fc, ($c,A0)
00672A: 0839 0001 0006 0603      btst    #$1, $60603.l
006732: 6706                     beq     $673a
006734: 317C 0300 000C           move.w  #$300, ($c,A0)
00673A: 4240                     clr.w   D0
00673C: 1015                     move.b  (A5), D0
00673E: 5215                     addq.b  #1, (A5)
006740: 1DB9 0006 06E7 0000      move.b  $606e7.l, (A6,D0.w)
006748: 4E75                     rts
00674A: 1DC0                     dc.w    $1dc0; ILLEGAL
00674C: 0000 002A                ori.b   #$2a, D0
006750: 1DC0                     dc.w    $1dc0; ILLEGAL
006752: 0000 002B                ori.b   #$2b, D0
006756: 4EB9 0000 825A           jsr     $825a.l
00675C: 7402                     moveq   #$2, D2
00675E: 363C 01E8                move.w  #$1e8, D3
006762: 383C 6770                move.w  #$6770, D4
006766: 7A06                     moveq   #$6, D5
006768: 0C10 001C                cmpi.b  #$1c, (A0)
00676C: 6452                     bcc     $67c0
00676E: 603C                     bra     $67ac
006770: 1DC6                     dc.w    $1dc6; ILLEGAL
006772: 0000 00C0                ori.b   #$c0, D0
006776: 1DC6                     dc.w    $1dc6; ILLEGAL
006778: 0001 00C0                ori.b   #$c0, D1
00677C: 00C2                     dc.w    $00c2; ILLEGAL
00677E: 1DC6                     dc.w    $1dc6; ILLEGAL
006780: 0002 00C0                ori.b   #$c0, D2
006784: 00C1                     dc.w    $00c1; ILLEGAL
006786: 00C2                     dc.w    $00c2; ILLEGAL
006788: 1DC6                     dc.w    $1dc6; ILLEGAL
00678A: 0003 00C0                ori.b   #$c0, D3
00678E: 00C1                     dc.w    $00c1; ILLEGAL
006790: 00C1                     dc.w    $00c1; ILLEGAL
006792: 00C2                     dc.w    $00c2; ILLEGAL
006794: 4EB9 0000 825A           jsr     $825a.l
00679A: 7406                     moveq   #$6, D2
00679C: 363C 01C0                move.w  #$1c0, D3
0067A0: 383C 6804                move.w  #$6804, D4
0067A4: 7A02                     moveq   #$2, D5
0067A6: 0C10 001C                cmpi.b  #$1c, (A0)
0067AA: 6414                     bcc     $67c0
0067AC: 06B0 0005 8000 2000      addi.l  #$58000, (A0,D2.w)
0067B4: B670 2000                cmp.w   (A0,D2.w), D3
0067B8: 6D00 FA22                blt     $61dc
0067BC: 5228 0015                addq.b  #1, ($15,A0)
0067C0: 3028 0016                move.w  ($16,A0), D0
0067C4: 0C40 0006                cmpi.w  #$6, D0
0067C8: 6710                     beq     $67da
0067CA: 1228 0015                move.b  ($15,A0), D1
0067CE: 0201 0003                andi.b  #$3, D1
0067D2: 6606                     bne     $67da
0067D4: 5440                     addq.w  #2, D0
0067D6: 3140 0016                move.w  D0, ($16,A0)
0067DA: D87B 0018                add.w   ($18,PC,D0.w), D4
0067DE: 3144 000A                move.w  D4, ($a,A0)
0067E2: 1228 0015                move.b  ($15,A0), D1
0067E6: 0241 0006                andi.w  #$6, D1
0067EA: 317B 1010 000C           move.w  ($10,PC,D1.w), ($c,A0)
0067F0: 6000 FF48                bra     $673a
0067F4: 0000 0006                ori.b   #$6, D0
0067F8: 000E                     dc.w    $000e; ILLEGAL
0067FA: 0018 05FC                ori.b   #$fc, (A0)+
0067FE: 0624 0636                addi.b  #$36, -(A4)
006802: 0648                     dc.w    $0648; ILLEGAL
006804: 1DCE                     dc.w    $1dce; ILLEGAL
006806: 0000 003C                ori.b   #$3c, D0
00680A: 1DCE                     dc.w    $1dce; ILLEGAL
00680C: 0001 003C                ori.b   #$3c, D1
006810: 003E                     dc.w    $003e; ILLEGAL
006812: 1DCE                     dc.w    $1dce; ILLEGAL
006814: 0002 003C                ori.b   #$3c, D2
006818: 003D                     dc.w    $003d; ILLEGAL
00681A: 003E                     dc.w    $003e; ILLEGAL
00681C: 1DCE                     dc.w    $1dce; ILLEGAL
00681E: 0003 003C                ori.b   #$3c, D3
006822: 003D                     dc.w    $003d; ILLEGAL
006824: 003D                     dc.w    $003d; ILLEGAL
006826: 003E                     dc.w    $003e; ILLEGAL
006828: 4EB9 0000 825A           jsr     $825a.l
00682E: 0C10 001C                cmpi.b  #$1c, (A0)
006832: 642E                     bcc     $6862
006834: 4EB9 0000 7FE4           jsr     $7fe4.l
00683A: 0C68 0058 0002           cmpi.w  #$58, ($2,A0)
006840: 6500 F99A                bcs     $61dc
006844: 0C68 01A8 0002           cmpi.w  #$1a8, ($2,A0)
00684A: 6400 F990                bcc     $61dc
00684E: 0C68 0080 0006           cmpi.w  #$80, ($6,A0)
006854: 6500 F986                bcs     $61dc
006858: 0C68 0180 0006           cmpi.w  #$180, ($6,A0)
00685E: 6400 F97C                bcc     $61dc
006862: 317C 05FC 000C           move.w  #$5fc, ($c,A0)
006868: 0839 0002 0006 0603      btst    #$2, $60603.l
006870: 6706                     beq     $6878
006872: 317C 065A 000C           move.w  #$65a, ($c,A0)
006878: 317C 6890 000A           move.w  #$6890, ($a,A0)
00687E: 4A39 0006 06E6           tst.b   $606e6.l
006884: 6606                     bne     $688c
006886: 317C 6896 000A           move.w  #$6896, ($a,A0)
00688C: 6000 FEAC                bra     $673a
006890: 1DC0                     dc.w    $1dc0; ILLEGAL
006892: 0000 00EE                ori.b   #$ee, D0
006896: 1DC0                     dc.w    $1dc0; ILLEGAL
006898: 0000 00F3                ori.b   #$f3, D0
00689C: 4A39 0006 10AC           tst.b   $610ac.l
0068A2: 6B00 F938                bmi     $61dc
0068A6: 4EB9 0000 8104           jsr     $8104.l
0068AC: 3028 0016                move.w  ($16,A0), D0
0068B0: 3239 0006 10AE           move.w  $610ae.l, D1
0068B6: 3141 0016                move.w  D1, ($16,A0)
0068BA: 9041                     sub.w   D1, D0
0068BC: 9168 0002                sub.w   D0, ($2,A0)
0068C0: 3028 0018                move.w  ($18,A0), D0
0068C4: 3239 0006 10B2           move.w  $610b2.l, D1
0068CA: 3141 0018                move.w  D1, ($18,A0)
0068CE: 9041                     sub.w   D1, D0
0068D0: 9168 0006                sub.w   D0, ($6,A0)
0068D4: 5228 001A                addq.b  #1, ($1a,A0)
0068D8: 317C 0300 000C           move.w  #$300, ($c,A0)
0068DE: 0828 0002 001A           btst    #$2, ($1a,A0)
0068E4: 6706                     beq     $68ec
0068E6: 317C 066A 000C           move.w  #$66a, ($c,A0)
0068EC: 317C 6904 000A           move.w  #$6904, ($a,A0)
0068F2: 0828 0003 001A           btst    #$3, ($1a,A0)
0068F8: 6706                     beq     $6900
0068FA: 317C 690A 000A           move.w  #$690a, ($a,A0)
006900: 6000 FE38                bra     $673a
006904: 1DC0                     dc.w    $1dc0; ILLEGAL
006906: 0000 0072                ori.b   #$72, D0
00690A: 1DC0                     dc.w    $1dc0; ILLEGAL
00690C: 0000 0073                ori.b   #$73, D0
006910: 4A39 0006 06E6           tst.b   $606e6.l
006916: 6666                     bne     $697e
006918: 10BC 0018                move.b  #$18, (A0)
00691C: 323C 6936                move.w  #$6936, D1
006920: 3179 0006 10AE 0002      move.w  $610ae.l, ($2,A0)
006928: 3179 0006 10B2 0006      move.w  $610b2.l, ($6,A0)
006930: 5868 0006                addq.w  #4, ($6,A0)
006934: 6064                     bra     $699a
006936: 1D48                     dc.w    $1d48; ILLEGAL
006938: 0003 00A4                ori.b   #$a4, D3
00693C: 00A5 0026 0027           ori.l   #$260027, -(A5)
006942: 0000 0000                ori.b   #$0, D0
006946: 1D48                     dc.w    $1d48; ILLEGAL
006948: 0003 00A6                ori.b   #$a6, D3
00694C: 00A7 0026 2025           ori.l   #$262025, -(A7)
006952: 0000 0000                ori.b   #$0, D0
006956: 1D48                     dc.w    $1d48; ILLEGAL
006958: 0003 00A8                ori.b   #$a8, D3
00695C: 00A9 0025 0027 0000      ori.l   #$250027, ($0,A1)
006964: 0000 1D48                ori.b   #$48, D0
006968: 0003 00AA                ori.b   #$aa, D3
00696C: 00AB 0026 0027 0000      ori.l   #$260027, ($0,A3)
006974: 0000 4A39                ori.b   #$39, D0
006978: 0006 06E6                ori.b   #$e6, D6
00697C: 679A                     beq     $6918
00697E: 10BC 001A                move.b  #$1a, (A0)
006982: 323C 69F0                move.w  #$69f0, D1
006986: 3179 0006 10AE 0002      move.w  $610ae.l, ($2,A0)
00698E: 3179 0006 10B2 0006      move.w  $610b2.l, ($6,A0)
006996: 5868 0002                addq.w  #4, ($2,A0)
00699A: 4A39 0006 10AC           tst.b   $610ac.l
0069A0: 6B00 F83A                bmi     $61dc
0069A4: 4A39 0006 06ED           tst.b   $606ed.l
0069AA: 6700 F830                beq     $61dc
0069AE: 5228 0001                addq.b  #1, ($1,A0)
0069B2: 1028 0001                move.b  ($1,A0), D0
0069B6: 3400                     move.w  D0, D2
0069B8: E348                     lsl.w   #1, D0
0069BA: 0240 0030                andi.w  #$30, D0
0069BE: D041                     add.w   D1, D0
0069C0: 3140 000A                move.w  D0, ($a,A0)
0069C4: E24A                     lsr.w   #1, D2
0069C6: 0242 0006                andi.w  #$6, D2
0069CA: 0C39 0001 0006 06ED      cmpi.b  #$1, $606ed.l
0069D2: 6602                     bne     $69d6
0069D4: 5042                     addq.w  #8, D2
0069D6: 317B 2008 000C           move.w  ($8,PC,D2.w), ($c,A0)
0069DC: 6000 FD5C                bra     $673a
0069E0: 05FC                     dc.w    $05fc; ILLEGAL
0069E2: 065A 05FC                addi.w  #$5fc, (A2)+
0069E6: 0662 066E                addi.w  #$66e, -(A2)
0069EA: 0662 0676                addi.w  #$676, -(A2)
0069EE: 0662 6A30                addi.w  #$6a30, -(A2)
0069F2: 0003 0023                ori.b   #$23, D3
0069F6: 0030 0024 0031           ori.b   #$24, ($31,A0,D0.w)
0069FC: 0000 0000                ori.b   #$0, D0
006A00: 6A30                     bpl     $6a32
006A02: 0003 0023                ori.b   #$23, D3
006A06: 0032 1022 0033           ori.b   #$22, ($33,A2,D0.w)
006A0C: 0000 0000                ori.b   #$0, D0
006A10: 6A30                     bpl     $6a42
006A12: 0003 0022                ori.b   #$22, D3
006A16: 0034 0024 0035           ori.b   #$24, ($35,A4,D0.w)
006A1C: 0000 0000                ori.b   #$0, D0
006A20: 6A30                     bpl     $6a52
006A22: 0003 0023                ori.b   #$23, D3
006A26: 0036 0024 0037           ori.b   #$24, ($37,A6,D0.w)
006A2C: 0000 0000                ori.b   #$0, D0
006A30: 01F0 0100                bset    D0, INVALID 30
006A34: F1F0                     dc.w    $f1f0; opcode 1111
006A36: F100                     dc.w    $f100; opcode 1111
006A38: 6100 0086                bsr     $6ac0
006A3C: 43F9 0006 0F00           lea     $60f00.l, A1
006A42: 4240                     clr.w   D0
006A44: 1039 0006 108C           move.b  $6108c.l, D0
006A4A: 5239 0006 108C           addq.b  #1, $6108c.l
006A50: 13B9 0006 06E7 0000      move.b  $606e7.l, (A1,D0.w)
006A58: 4E75                     rts
006A5A: 6100 0064                bsr     $6ac0
006A5E: 43F9 0006 0FAC           lea     $60fac.l, A1
006A64: 4240                     clr.w   D0
006A66: 1039 0006 109A           move.b  $6109a.l, D0
006A6C: 5239 0006 109A           addq.b  #1, $6109a.l
006A72: 13B9 0006 06E7 0000      move.b  $606e7.l, (A1,D0.w)
006A7A: 4E75                     rts
006A7C: 6100 0042                bsr     $6ac0
006A80: 43F9 0006 0FD9           lea     $60fd9.l, A1
006A86: 4240                     clr.w   D0
006A88: 1039 0006 109D           move.b  $6109d.l, D0
006A8E: 5239 0006 109D           addq.b  #1, $6109d.l
006A94: 13B9 0006 06E7 0000      move.b  $606e7.l, (A1,D0.w)
006A9C: 4E75                     rts
006A9E: 6100 0020                bsr     $6ac0
006AA2: 43F9 0006 1032           lea     $61032.l, A1
006AA8: 4240                     clr.w   D0
006AAA: 1039 0006 10A3           move.b  $610a3.l, D0
006AB0: 5239 0006 10A3           addq.b  #1, $610a3.l
006AB6: 13B9 0006 06E7 0000      move.b  $606e7.l, (A1,D0.w)
006ABE: 4E75                     rts
006AC0: 4EB9 0000 DA52           jsr     $da52.l
006AC6: 5228 000E                addq.b  #1, ($e,A0)
006ACA: 0228 0003 000E           andi.b  #$3, ($e,A0)
006AD0: 660E                     bne     $6ae0
006AD2: 5C28 000F                addq.b  #6, ($f,A0)
006AD6: 0C28 0018 000F           cmpi.b  #$18, ($f,A0)
006ADC: 6700 F6F8                beq     $61d6
006AE0: 4240                     clr.w   D0
006AE2: 1028 000F                move.b  ($f,A0), D0
006AE6: 0640 6AF6                addi.w  #$6af6, D0
006AEA: 3140 000A                move.w  D0, ($a,A0)
006AEE: 317C 05FC 000C           move.w  #$5fc, ($c,A0)
006AF4: 4E75                     rts
006AF6: 1DC0                     dc.w    $1dc0; ILLEGAL
006AF8: 0000 0038                ori.b   #$38, D0
006AFC: 1DC0                     dc.w    $1dc0; ILLEGAL
006AFE: 0000 0039                ori.b   #$39, D0
006B02: 1DC0                     dc.w    $1dc0; ILLEGAL
006B04: 0000 003A                ori.b   #$3a, D0
006B08: 1DC0                     dc.w    $1dc0; ILLEGAL
006B0A: 0000 003B                ori.b   #$3b, D0
006B0E: 6100 003E                bsr     $6b4e
006B12: 4EB9 0000 825A           jsr     $825a.l
006B18: 4EF9 0000 6A3C           jmp     $6a3c.l
006B1E: 6100 002E                bsr     $6b4e
006B22: 4EB9 0000 825A           jsr     $825a.l
006B28: 4EF9 0000 6A5E           jmp     $6a5e.l
006B2E: 6100 001E                bsr     $6b4e
006B32: 4EB9 0000 825A           jsr     $825a.l
006B38: 4EF9 0000 6A80           jmp     $6a80.l
006B3E: 6100 000E                bsr     $6b4e
006B42: 4EB9 0000 825A           jsr     $825a.l
006B48: 4EF9 0000 6AA2           jmp     $6aa2.l
006B4E: 4EB9 0000 DA52           jsr     $da52.l
006B54: 5228 0015                addq.b  #1, ($15,A0)
006B58: 0C28 0003 0015           cmpi.b  #$3, ($15,A0)
006B5E: 660C                     bne     $6b6c
006B60: 4228 0015                clr.b   ($15,A0)
006B64: 5568 0016                subq.w  #2, ($16,A0)
006B68: 6500 F66C                bcs     $61d6
006B6C: 3028 0016                move.w  ($16,A0), D0
006B70: 317B 001C 000C           move.w  ($1c,PC,D0.w), ($c,A0)
006B76: 4A39 0006 06E6           tst.b   $606e6.l
006B7C: 6702                     beq     $6b80
006B7E: 5040                     addq.w  #8, D0
006B80: 303B 0014                move.w  ($14,PC,D0.w), D0
006B84: 0640 6BA6                addi.w  #$6ba6, D0
006B88: 3140 000A                move.w  D0, ($a,A0)
006B8C: 4E75                     rts
006B8E: 6C4A                     bge     $6bda
006B90: 6C44                     bge     $6bd6
006B92: 6C3C                     bge     $6bd0
006B94: 6C32                     bge     $6bc8
006B96: 0000 0008                ori.b   #$8, D0
006B9A: 0012 001E                ori.b   #$1e, (A2)
006B9E: 002C 0034 003E           ori.b   #$34, ($3e,A4)
006BA4: 004A                     dc.w    $004a; ILLEGAL
006BA6: 6BFE                     bmi     $6ba6
006BA8: 0001 003C                ori.b   #$3c, D1
006BAC: 003B                     dc.w    $003b; ILLEGAL
006BAE: 6C02                     bge     $6bb2
006BB0: 0002 003C                ori.b   #$3c, D2
006BB4: 003E                     dc.w    $003e; ILLEGAL
006BB6: 003A                     dc.w    $003a; ILLEGAL
006BB8: 6C08                     bge     $6bc2
006BBA: 0003 003C                ori.b   #$3c, D3
006BBE: 003D                     dc.w    $003d; ILLEGAL
006BC0: 003E                     dc.w    $003e; ILLEGAL
006BC2: 0039 6C10 0004 003C      ori.b   #$10, $4003c.l
006BCA: 003D                     dc.w    $003d; ILLEGAL
006BCC: 003D                     dc.w    $003d; ILLEGAL
006BCE: 003E                     dc.w    $003e; ILLEGAL
006BD0: 0038 6BFE 0001           ori.b   #$fe, $1.w
006BD6: 00C0                     dc.w    $00c0; ILLEGAL
006BD8: 00C2                     dc.w    $00c2; ILLEGAL
006BDA: 6C1A                     bge     $6bf6
006BDC: 0002 00C0                ori.b   #$c0, D2
006BE0: 00C2                     dc.w    $00c2; ILLEGAL
006BE2: 003A                     dc.w    $003a; ILLEGAL
006BE4: 6C20                     bge     $6c06
006BE6: 0003 00C0                ori.b   #$c0, D3
006BEA: 00C1                     dc.w    $00c1; ILLEGAL
006BEC: 00C2                     dc.w    $00c2; ILLEGAL
006BEE: 0039 6C28 0004 00C0      ori.b   #$28, $400c0.l
006BF6: 00C1                     dc.w    $00c1; ILLEGAL
006BF8: 00C1                     dc.w    $00c1; ILLEGAL
006BFA: 00C2                     dc.w    $00c2; ILLEGAL
006BFC: 0038 F8F8 F8F8           ori.b   #$f8, $f8f8.w
006C02: F8F8                     dc.w    $f8f8; opcode 1111
006C04: E8F8                     dc.w    $e8f8; ILLEGAL
006C06: F8F8                     dc.w    $f8f8; opcode 1111
006C08: F8F8                     dc.w    $f8f8; opcode 1111
006C0A: E8F8                     dc.w    $e8f8; ILLEGAL
006C0C: D8F8 F8F8                adda.w  $f8f8.w, A4
006C10: F8F8                     dc.w    $f8f8; opcode 1111
006C12: E8F8                     dc.w    $e8f8; ILLEGAL
006C14: D8F8 C8F8                adda.w  $c8f8.w, A4
006C18: F8F8                     dc.w    $f8f8; opcode 1111
006C1A: F8F8                     dc.w    $f8f8; opcode 1111
006C1C: F8E8                     dc.w    $f8e8; opcode 1111
006C1E: F8F8                     dc.w    $f8f8; opcode 1111
006C20: F8F8                     dc.w    $f8f8; opcode 1111
006C22: F8E8                     dc.w    $f8e8; opcode 1111
006C24: F8D8                     dc.w    $f8d8; opcode 1111
006C26: F8F8                     dc.w    $f8f8; opcode 1111
006C28: F8F8                     dc.w    $f8f8; opcode 1111
006C2A: F8E8                     dc.w    $f8e8; opcode 1111
006C2C: F8D8                     dc.w    $f8d8; opcode 1111
006C2E: F8C8                     dc.w    $f8c8; opcode 1111
006C30: F8F8                     dc.w    $f8f8; opcode 1111
006C32: 0100                     btst    D0, D0
006C34: 0100                     btst    D0, D0
006C36: 0100                     btst    D0, D0
006C38: 0100                     btst    D0, D0
006C3A: 0100                     btst    D0, D0
006C3C: 0102                     btst    D0, D2
006C3E: 0102                     btst    D0, D2
006C40: 0102                     btst    D0, D2
006C42: 0100                     btst    D0, D0
006C44: 0103                     btst    D0, D3
006C46: 0103                     btst    D0, D3
006C48: 0100                     btst    D0, D0
006C4A: 0104                     btst    D0, D4
006C4C: 0100                     btst    D0, D0
006C4E: 0C79 0208 0006 10AC      cmpi.w  #$208, $610ac.l
006C56: 6702                     beq     $6c5a
006C58: 4E75                     rts
006C5A: 4EB9 0000 6C66           jsr     $6c66.l
006C60: 4EF9 0000 6D44           jmp     $6d44.l
006C66: 4A28 001E                tst.b   ($1e,A0)
006C6A: 6706                     beq     $6c72
006C6C: 5328 001E                subq.b  #1, ($1e,A0)
006C70: 4E75                     rts
006C72: 0839 0004 0006 06E9      btst    #$4, $606e9.l
006C7A: 6602                     bne     $6c7e
006C7C: 4E75                     rts
006C7E: 1010                     move.b  (A0), D0
006C80: E248                     lsr.w   #1, D0
006C82: 0240 0001                andi.w  #$1, D0
006C86: 43F9 0006 26B6           lea     $626b6.l, A1
006C8C: 4A39 0006 06EB           tst.b   $606eb.l
006C92: 661E                     bne     $6cb2
006C94: 1231 0000                move.b  (A1,D0.w), D1
006C98: 0C01 0004                cmpi.b  #$4, D1
006C9C: 6432                     bcc     $6cd0
006C9E: 117C 0008 001E           move.b  #$8, ($1e,A0)
006CA4: 5231 0000                addq.b  #1, (A1,D0.w)
006CA8: 4A39 0006 06E6           tst.b   $606e6.l
006CAE: 673A                     beq     $6cea
006CB0: 604A                     bra     $6cfc
006CB2: 1231 0000                move.b  (A1,D0.w), D1
006CB6: 0C01 0002                cmpi.b  #$2, D1
006CBA: 6414                     bcc     $6cd0
006CBC: 117C 0008 001E           move.b  #$8, ($1e,A0)
006CC2: 5231 0000                addq.b  #1, (A1,D0.w)
006CC6: 4A39 0006 06E6           tst.b   $606e6.l
006CCC: 6704                     beq     $6cd2
006CCE: 600E                     bra     $6cde
006CD0: 4E75                     rts
006CD2: 4BFA 0004                lea     ($4,PC) ; ($6cd8), A5
006CD6: 6028                     bra     $6d00
006CD8: 0000 0008                ori.b   #$8, D0
006CDC: 0C00 4BFA                cmpi.b  #-$6, D0
006CE0: 0004 601C                ori.b   #$1c, D4
006CE4: 0008                     dc.w    $0008; ILLEGAL
006CE6: 0000 0E00                ori.b   #$0, D0
006CEA: 4BFA 0004                lea     ($4,PC) ; ($6cf0), A5
006CEE: 6010                     bra     $6d00
006CF0: 0000 0008                ori.b   #$8, D0
006CF4: 0800 0008                btst    #$8, D0
006CF8: 0000 0A00                ori.b   #$0, D0
006CFC: 4BFA FFF8                lea     (-$8,PC) ; ($6cf6), A5
006D00: 7407                     moveq   #$7, D2
006D02: 43F9 0006 12CC           lea     $612cc.l, A1
006D08: 4A00                     tst.b   D0
006D0A: 6708                     beq     $6d14
006D0C: 7408                     moveq   #$8, D2
006D0E: 43F9 0006 134C           lea     $6134c.l, A1
006D14: D3FC 0000 0020           adda.l  #$20, A1
006D1A: 4A11                     tst.b   (A1)
006D1C: 66F6                     bne     $6d14
006D1E: 3228 0002                move.w  ($2,A0), D1
006D22: D25D                     add.w   (A5)+, D1
006D24: 3341 0002                move.w  D1, ($2,A1)
006D28: 3228 0006                move.w  ($6,A0), D1
006D2C: D25D                     add.w   (A5)+, D1
006D2E: 3341 0006                move.w  D1, ($6,A1)
006D32: 329D                     move.w  (A5)+, (A1)
006D34: 4229 0015                clr.b   ($15,A1)
006D38: 4269 0016                clr.w   ($16,A1)
006D3C: 3342 001E                move.w  D2, ($1e,A1)
006D40: 4E75                     rts
006D42: 4E75                     rts
006D44: 0839 0005 0006 06E9      btst    #$5, $606e9.l
006D4C: 67F4                     beq     $6d42
006D4E: 0C10 0002                cmpi.b  #$2, (A0)
006D52: 6614                     bne     $6d68
006D54: 45F9 0006 26B4           lea     $626b4.l, A2
006D5A: 4A12                     tst.b   (A2)
006D5C: 66E4                     bne     $6d42
006D5E: 43F9 0006 12AC           lea     $612ac.l, A1
006D64: 7005                     moveq   #$5, D0
006D66: 6012                     bra     $6d7a
006D68: 45F9 0006 26B5           lea     $626b5.l, A2
006D6E: 4A12                     tst.b   (A2)
006D70: 66D0                     bne     $6d42
006D72: 43F9 0006 12CC           lea     $612cc.l, A1
006D78: 7006                     moveq   #$6, D0
006D7A: 5212                     addq.b  #1, (A2)
006D7C: 3368 0002 0002           move.w  ($2,A0), ($2,A1)
006D82: 3368 0006 0006           move.w  ($6,A0), ($6,A1)
006D88: 3340 001E                move.w  D0, ($1e,A1)
006D8C: 4A39 0006 06E6           tst.b   $606e6.l
006D92: 6616                     bne     $6daa
006D94: 5069 0006                addq.w  #8, ($6,A1)
006D98: 32BC 0200                move.w  #$200, (A1)
006D9C: 137C 0040 0012           move.b  #$40, ($12,A1)
006DA2: 137C 002F 0014           move.b  #$2f, ($14,A1)
006DA8: 4E75                     rts
006DAA: 5069 0002                addq.w  #8, ($2,A1)
006DAE: 32BC 0400                move.w  #$400, (A1)
006DB2: 237C 0300 8000 0010      move.l  #$3008000, ($10,A1)
006DBA: 137C 002F 0015           move.b  #$2f, ($15,A1)
006DC0: 137C 0008 0016           move.b  #$8, ($16,A1)
006DC6: 137C 0086 0014           move.b  #$86, ($14,A1)
006DCC: 137C 0060 0017           move.b  #$60, ($17,A1)
006DD2: 0C10 0002                cmpi.b  #$2, (A0)
006DD6: 670C                     beq     $6de4
006DD8: 137C 0006 0014           move.b  #$6, ($14,A1)
006DDE: 137C 00A0 0017           move.b  #$a0, ($17,A1)
006DE4: 4E75                     rts
006DE6: 4240                     clr.w   D0
006DE8: 41F9 0006 26B4           lea     $626b4.l, A0
006DEE: D018                     add.b   (A0)+, D0
006DF0: D018                     add.b   (A0)+, D0
006DF2: D018                     add.b   (A0)+, D0
006DF4: D018                     add.b   (A0)+, D0
006DF6: 6602                     bne     $6dfa
006DF8: 4E75                     rts
006DFA: 5340                     subq.w  #1, D0
006DFC: 13FC 0011 0006 06E7      move.b  #$11, $606e7.l
006E04: 41F9 0006 12AC           lea     $612ac.l, A0
006E0A: 47F9 0006 1095           lea     $61095.l, A3
006E10: 49F9 0006 0F60           lea     $60f60.l, A4
006E16: 2A4B                     movea.l A3, A5
006E18: 2C4C                     movea.l A4, A6
006E1A: 4EF9 0000 622C           jmp     $622c.l
006E20: 0839 0004 0006 0621      btst    #$4, $60621.l
006E28: 6600 D088                bne     $3eb2
006E2C: 7000                     moveq   #$0, D0
006E2E: 1039 0006 0601           move.b  $60601.l, D0
006E34: 303B 0006                move.w  ($6,PC,D0.w), D0
006E38: 2040                     movea.l D0, A0
006E3A: 4ED0                     jmp     (A0)
006E3C: 6EAA                     bgt     $6de8
006E3E: 6EBE                     bgt     $6dfe
006E40: 6F1A                     ble     $6e5c
006E42: 6EAA                     bgt     $6dee
006E44: 6FBC                     ble     $6e02
006E46: 6FFA                     ble     $6e42
006E48: 6EAA                     bgt     $6df4
006E4A: 70FA                     moveq   #-$6, D0
006E4C: 7130                     dc.w    $7130; ILLEGAL
006E4E: 718A                     dc.w    $718a; ILLEGAL
006E50: 7300                     dc.w    $7300; ILLEGAL
006E52: 730E                     dc.w    $730e; ILLEGAL
006E54: 0839 0000 0006 0623      btst    #$0, $60623.l
006E5C: 670C                     beq     $6e6a
006E5E: 13C0 0006 0601           move.b  D0, $60601.l
006E64: DFFC 0000 0004           adda.l  #$4, A7
006E6A: 4E75                     rts
006E6C: 41F9 0006 0700           lea     $60700.l, A0
006E72: 303C 01FF                move.w  #$1ff, D0
006E76: 217C 0010 0010 0800      move.l  #$100010, ($800,A0)
006E7E: 4298                     clr.l   (A0)+
006E80: 51C8 FFF4                dbra    D0, $6e76
006E84: 4E75                     rts
006E86: 243C 0006 0700           move.l  #$60700, D2
006E8C: 4EF9 0000 46D4           jmp     $46d4.l
006E92: 7008                     moveq   #$8, D0
006E94: 4EB9 0000 77C8           jsr     $77c8.l
006E9A: 33FC 0280 0006 060A      move.w  #$280, $6060a.l
006EA2: 7004                     moveq   #$4, D0
006EA4: 4EF9 0000 77C8           jmp     $77c8.l
006EAA: 0279 B07F 0006 0604      andi.w  #$b07f, $60604.l
006EB2: 5439 0006 0601           addq.b  #2, $60601.l
006EB8: 4EF9 0000 7612           jmp     $7612.l
006EBE: 61AC                     bsr     $6e6c
006EC0: 41F9 0006 0D50           lea     $60d50.l, A0
006EC6: 43F9 0006 0CCC           lea     $60ccc.l, A1
006ECC: 700F                     moveq   #$f, D0
006ECE: 7230                     moveq   #$30, D1
006ED0: 7410                     moveq   #$10, D2
006ED2: 3142 0800                move.w  D2, ($800,A0)
006ED6: 30C1                     move.w  D1, (A0)+
006ED8: 3342 0800                move.w  D2, ($800,A1)
006EDC: 3281                     move.w  D1, (A1)
006EDE: 5241                     addq.w  #1, D1
006EE0: 0C41 003A                cmpi.w  #$3a, D1
006EE4: 6602                     bne     $6ee8
006EE6: 7241                     moveq   #$41, D1
006EE8: 93FC 0000 0040           suba.l  #$40, A1
006EEE: 51C8 FFE2                dbra    D0, $6ed2
006EF2: 45F9 0000 6F08           lea     $6f08.l, A2
006EF8: 618C                     bsr     $6e86
006EFA: 4279 0006 066E           clr.w   $6066e.l
006F00: 5439 0006 0601           addq.b  #2, $60601.l
006F06: 608A                     bra     $6e92
006F08: 0152                     bchg    D0, (A2)
006F0A: 1052                     dc.w    $1052; ILLEGAL
006F0C: 4F4D                     dc.w    $4f4d; ILLEGAL
006F0E: 2030 2020                move.l  ($20,A0,D2.w), D0
006F12: 434F                     dc.w    $434f; ILLEGAL
006F14: 4C4F                     dc.w    $4c4f; ILLEGAL
006F16: 5220                     addq.b  #1, -(A0)
006F18: 3000                     move.w  D0, D0
006F1A: 7006                     moveq   #$6, D0
006F1C: 6100 FF36                bsr     $6e54
006F20: 6100 0072                bsr     $6f94
006F24: 1039 0006 066E           move.b  $6066e.l, D0
006F2A: 0200 0007                andi.b  #$7, D0
006F2E: 1C00                     move.b  D0, D6
006F30: 1239 0006 066F           move.b  $6066f.l, D1
006F36: 1E01                     move.b  D1, D7
006F38: E909                     lsl.b   #4, D1
006F3A: 8001                     or.b    D1, D0
006F3C: 41F9 0006 0CD0           lea     $60cd0.l, A0
006F42: 4243                     clr.w   D3
006F44: 740F                     moveq   #$f, D2
006F46: 2248                     movea.l A0, A1
006F48: 720F                     moveq   #$f, D1
006F4A: 3340 0800                move.w  D0, ($800,A1)
006F4E: 32C3                     move.w  D3, (A1)+
006F50: 5243                     addq.w  #1, D3
006F52: 51C9 FFF6                dbra    D1, $6f4a
006F56: 91FC 0000 0040           suba.l  #$40, A0
006F5C: 51CA FFE8                dbra    D2, $6f46
006F60: 1006                     move.b  D6, D0
006F62: 43F9 0006 085A           lea     $6085a.l, A1
006F68: 323C 0010                move.w  #$10, D1
006F6C: 4EB9 0000 46A8           jsr     $46a8.l
006F72: 1007                     move.b  D7, D0
006F74: 0200 000F                andi.b  #$f, D0
006F78: 43F9 0006 086C           lea     $6086c.l, A1
006F7E: 4EB9 0000 46A8           jsr     $46a8.l
006F84: 0079 0180 0006 0604      ori.w   #$180, $60604.l
006F8C: 7010                     moveq   #$10, D0
006F8E: 4EF9 0000 77C8           jmp     $77c8.l
006F94: 41F9 0006 066E           lea     $6066e.l, A0
006F9A: 1039 0006 061F           move.b  $6061f.l, D0
006FA0: 1200                     move.b  D0, D1
006FA2: 6100 0006                bsr     $6faa
006FA6: 1001                     move.b  D1, D0
006FA8: E408                     lsr.b   #2, D0
006FAA: 0200 0003                andi.b  #$3, D0
006FAE: 6708                     beq     $6fb8
006FB0: 0200 0001                andi.b  #$1, D0
006FB4: 6602                     bne     $6fb8
006FB6: 70FF                     moveq   #-$1, D0
006FB8: D118                     add.b   D0, (A0)+
006FBA: 4E75                     rts
006FBC: 6100 FEAE                bsr     $6e6c
006FC0: 45F9 0000 6FE0           lea     $6fe0.l, A2
006FC6: 6100 FEBE                bsr     $6e86
006FCA: 42B9 0006 066E           clr.l   $6066e.l
006FD0: 4279 0006 0672           clr.w   $60672.l
006FD6: 5439 0006 0601           addq.b  #2, $60601.l
006FDC: 6000 FEB4                bra     $6e92
006FE0: 0744                     bchg    D3, D4
006FE2: 1049                     dc.w    $1049; ILLEGAL
006FE4: 4E56 3020                link    A6, #$3020
006FE8: 2020                     move.l  -(A0), D0
006FEA: 2043                     movea.l D3, A0
006FEC: 4F4C                     dc.w    $4f4c; ILLEGAL
006FEE: 4F52                     dc.w    $4f52; ILLEGAL
006FF0: 3030 2020                move.w  ($20,A0,D2.w), D0
006FF4: 5843                     addq.w  #4, D3
006FF6: 4730                     dc.w    $4730; ILLEGAL
006FF8: 3000                     move.w  D0, D0
006FFA: 700C                     moveq   #$c, D0
006FFC: 6100 FE56                bsr     $6e54
007000: 41F9 0006 066E           lea     $6066e.l, A0
007006: 1039 0006 061F           move.b  $6061f.l, D0
00700C: 3400                     move.w  D0, D2
00700E: 0240 0003                andi.w  #$3, D0
007012: 6710                     beq     $7024
007014: 323C 00C0                move.w  #$c0, D1
007018: 0200 0001                andi.b  #$1, D0
00701C: 6604                     bne     $7022
00701E: 323C FF40                move.w  #$ff40, D1
007022: D350                     add.w   D1, (A0)
007024: 41F9 0006 0670           lea     $60670.l, A0
00702A: 3002                     move.w  D2, D0
00702C: E448                     lsr.w   #2, D0
00702E: 6100 FF7A                bsr     $6faa
007032: 1039 0006 0621           move.b  $60621.l, D0
007038: 1200                     move.b  D0, D1
00703A: 6100 FF6E                bsr     $6faa
00703E: 1001                     move.b  D1, D0
007040: E448                     lsr.w   #2, D0
007042: 6100 FF66                bsr     $6faa
007046: 41F9 0006 066E           lea     $6066e.l, A0
00704C: 3018                     move.w  (A0)+, D0
00704E: 0240 07FF                andi.w  #$7ff, D0
007052: 3E00                     move.w  D0, D7
007054: 1218                     move.b  (A0)+, D1
007056: E859                     ror.w   #4, D1
007058: 0241 3000                andi.w  #$3000, D1
00705C: 8240                     or.w    D0, D1
00705E: 1418                     move.b  (A0)+, D2
007060: 0242 001F                andi.w  #$1f, D2
007064: E14A                     lsl.w   #8, D2
007066: 1618                     move.b  (A0)+, D3
007068: 0243 007F                andi.w  #$7f, D3
00706C: 8443                     or.w    D3, D2
00706E: 41F9 0006 0000           lea     $60000.l, A0
007074: 760B                     moveq   #$b, D3
007076: 3A3C 10A0                move.w  #$10a0, D5
00707A: 780F                     moveq   #$f, D4
00707C: 3C3C 0090                move.w  #$90, D6
007080: 30C5                     move.w  D5, (A0)+
007082: 30C1                     move.w  D1, (A0)+
007084: 5241                     addq.w  #1, D1
007086: 0241 37FF                andi.w  #$37ff, D1
00708A: 5247                     addq.w  #1, D7
00708C: 0C47 0800                cmpi.w  #$800, D7
007090: 6504                     bcs     $7096
007092: 4246                     clr.w   D6
007094: 4245                     clr.w   D5
007096: 30C2                     move.w  D2, (A0)+
007098: 30C6                     move.w  D6, (A0)+
00709A: 0646 0010                addi.w  #$10, D6
00709E: 51CC FFE0                dbra    D4, $7080
0070A2: 0645 0010                addi.w  #$10, D5
0070A6: 51CB FFD2                dbra    D3, $707a
0070AA: 41F9 0006 0670           lea     $60670.l, A0
0070B0: 1018                     move.b  (A0)+, D0
0070B2: 0200 0003                andi.b  #$3, D0
0070B6: 43F9 0006 0E4A           lea     $60e4a.l, A1
0070BC: 323C 0010                move.w  #$10, D1
0070C0: 4EB9 0000 46A8           jsr     $46a8.l
0070C6: 1018                     move.b  (A0)+, D0
0070C8: 0200 001F                andi.b  #$1f, D0
0070CC: 43F9 0006 0E5E           lea     $60e5e.l, A1
0070D2: 4EB9 0000 4698           jsr     $4698.l
0070D8: 1010                     move.b  (A0), D0
0070DA: 0200 007F                andi.b  #$7f, D0
0070DE: 43F9 0006 0E6C           lea     $60e6c.l, A1
0070E4: 4EB9 0000 4698           jsr     $4698.l
0070EA: 0079 0380 0006 0604      ori.w   #$380, $60604.l
0070F2: 7010                     moveq   #$10, D0
0070F4: 4EF9 0000 77C8           jmp     $77c8.l
0070FA: 5439 0006 0601           addq.b  #2, $60601.l
007100: 4240                     clr.w   D0
007102: 4EB9 0004 0006           jsr     $40006.l
007108: 4240                     clr.w   D0
00710A: 4EB9 0004 005A           jsr     $4005a.l
007110: 33FC 0002 0006 07CC      move.w  #$2, $607cc.l
007118: 33FC 0002 0006 07D0      move.w  #$2, $607d0.l
007120: 4279 0006 07CE           clr.w   $607ce.l
007126: 4279 0006 07D2           clr.w   $607d2.l
00712C: 6000 FD64                bra     $6e92
007130: 5C39 0006 0601           addq.b  #6, $60601.l
007136: 0079 0D00 0006 0604      ori.w   #$d00, $60604.l
00713E: 23FC 0004 7E70 0006 066E move.l  #$47e70, $6066e.l
007148: 23FC 0004 8058 0006 0672 move.l  #$48058, $60672.l
007152: 23FC 0004 8150 0006 0676 move.l  #$48150, $60676.l
00715C: 23FC 0004 8338 0006 067A move.l  #$48338, $6067a.l
007166: 4239 0006 067E           clr.b   $6067e.l
00716C: 4279 0006 06D4           clr.w   $606d4.l
007172: 13FC 0002 0006 06C0      move.b  #$2, $606c0.l
00717A: 13FC 0001 0006 06E6      move.b  #$1, $606e6.l
007182: 7016                     moveq   #$16, D0
007184: 4EF9 0000 77C8           jmp     $77c8.l
00718A: 7000                     moveq   #$0, D0
00718C: 6100 FCC6                bsr     $6e54
007190: 4239 0006 07CA           clr.b   $607ca.l
007196: 4239 0006 07CB           clr.b   $607cb.l
00719C: 0079 0080 0006 0604      ori.w   #$80, $60604.l
0071A4: 0839 0001 0006 0623      btst    #$1, $60623.l
0071AC: 6722                     beq     $71d0
0071AE: 5239 0006 06E6           addq.b  #1, $606e6.l
0071B4: 0239 0001 0006 06E6      andi.b  #$1, $606e6.l
0071BC: 13F9 0006 06E6 0006 06C0 move.b  $606e6.l, $606c0.l
0071C6: 5239 0006 06C0           addq.b  #1, $606c0.l
0071CC: 6000 0122                bra     $72f0
0071D0: 0839 0000 0006 061F      btst    #$0, $6061f.l
0071D8: 6708                     beq     $71e2
0071DA: 0879 0002 0006 0604      bchg    #$2, $60604.l
0071E2: 0839 0001 0006 061F      btst    #$1, $6061f.l
0071EA: 6708                     beq     $71f4
0071EC: 0879 0003 0006 0604      bchg    #$3, $60604.l
0071F4: 0839 0004 0006 061F      btst    #$4, $6061f.l
0071FC: 673A                     beq     $7238
0071FE: 0CB9 0004 8053 0006 066E cmpi.l  #$48053, $6066e.l
007208: 672E                     beq     $7238
00720A: 52B9 0006 066E           addq.l  #1, $6066e.l
007210: 52B9 0006 0676           addq.l  #1, $60676.l
007216: 0639 0080 0006 067E      addi.b  #-$80, $6067e.l
00721E: 640C                     bcc     $722c
007220: 52B9 0006 0672           addq.l  #1, $60672.l
007226: 52B9 0006 067A           addq.l  #1, $6067a.l
00722C: 0679 0080 0006 06D4      addi.w  #$80, $606d4.l
007234: 6000 00BA                bra     $72f0
007238: 0839 0005 0006 061F      btst    #$5, $6061f.l
007240: 673A                     beq     $727c
007242: 0CB9 0004 7E70 0006 066E cmpi.l  #$47e70, $6066e.l
00724C: 672E                     beq     $727c
00724E: 53B9 0006 066E           subq.l  #1, $6066e.l
007254: 53B9 0006 0676           subq.l  #1, $60676.l
00725A: 0439 0080 0006 067E      subi.b  #-$80, $6067e.l
007262: 640C                     bcc     $7270
007264: 53B9 0006 0672           subq.l  #1, $60672.l
00726A: 53B9 0006 067A           subq.l  #1, $6067a.l
007270: 0479 0080 0006 06D4      subi.w  #$80, $606d4.l
007278: 6000 0076                bra     $72f0
00727C: 7012                     moveq   #$12, D0
00727E: 4EB9 0000 77C8           jsr     $77c8.l
007284: 7020                     moveq   #$20, D0
007286: 4EB9 0000 77C8           jsr     $77c8.l
00728C: 1039 0006 0603           move.b  $60603.l, D0
007292: 3200                     move.w  D0, D1
007294: 0240 0003                andi.w  #$3, D0
007298: 660A                     bne     $72a4
00729A: 0241 000C                andi.w  #$c, D1
00729E: 207B 1040                movea.l ($40,PC,D1.w), A0
0072A2: 4E90                     jsr     (A0)
0072A4: 41F9 0006 066E           lea     $6066e.l, A0
0072AA: 4A39 0006 06E6           tst.b   $606e6.l
0072B0: 6602                     bne     $72b4
0072B2: 5088                     addq.l  #8, A0
0072B4: 45F9 0006 0680           lea     $60680.l, A2
0072BA: 7401                     moveq   #$1, D2
0072BC: 2258                     movea.l (A0)+, A1
0072BE: 1011                     move.b  (A1), D0
0072C0: 6100 0006                bsr     $72c8
0072C4: 2250                     movea.l (A0), A1
0072C6: 1011                     move.b  (A1), D0
0072C8: 4241                     clr.w   D1
0072CA: 0240 00FF                andi.w  #$ff, D0
0072CE: 670C                     beq     $72dc
0072D0: 5300                     subq.b  #1, D0
0072D2: 44FC 0004                move    #$4, CCR
0072D6: C302                     abcd    D2, D1
0072D8: 51C8 FFFC                dbra    D0, $72d6
0072DC: 14C1                     move.b  D1, (A2)+
0072DE: 4E75                     rts
0072E0: 0004 0146                ori.b   #$46, D4
0072E4: 0004 0170                ori.b   #$70, D4
0072E8: 0004 0146                ori.b   #$46, D4
0072EC: 0004 0170                ori.b   #$70, D4
0072F0: 5439 0006 0601           addq.b  #2, $60601.l
0072F6: 0279 FF7F 0006 0604      andi.w  #$ff7f, $60604.l
0072FE: 4E75                     rts
007300: 5439 0006 0601           addq.b  #2, $60601.l
007306: 7016                     moveq   #$16, D0
007308: 4EF9 0000 77C8           jmp     $77c8.l
00730E: 5939 0006 0601           subq.b  #4, $60601.l
007314: 33F9 0006 06DA 0006 0606 move.w  $606da.l, $60606.l
00731E: 33F9 0006 06E2 0006 0608 move.w  $606e2.l, $60608.l
007328: 13F9 0006 06DE 0006 0616 move.b  $606de.l, $60616.l
007332: 13F9 0006 06DF 0006 0615 move.b  $606df.l, $60615.l
00733C: 13F9 0006 06D6 0006 0618 move.b  $606d6.l, $60618.l
007346: 13F9 0006 06D7 0006 0617 move.b  $606d7.l, $60617.l
007350: 33FC 0E0F 0006 060A      move.w  #$e0f, $6060a.l
007358: 7004                     moveq   #$4, D0
00735A: 4EF9 0000 77C8           jmp     $77c8.l
007360: 7000                     moveq   #$0, D0
007362: 1039 0006 0601           move.b  $60601.l, D0
007368: 303B 0006                move.w  ($6,PC,D0.w), D0
00736C: 2040                     movea.l D0, A0
00736E: 4ED0                     jmp     (A0)
007370: 7376                     dc.w    $7376; ILLEGAL
007372: 739C                     dc.w    $739c; ILLEGAL
007374: 73BA                     dc.w    $73ba; ILLEGAL
007376: 5439 0006 0601           addq.b  #2, $60601.l
00737C: 1039 0006 0620           move.b  $60620.l, D0
007382: 0200 0031                andi.b  #$31, D0
007386: 0C00 0031                cmpi.b  #$31, D0
00738A: 6608                     bne     $7394
00738C: 33FC 0400 0006 0600      move.w  #$400, $60600.l
007394: 7008                     moveq   #$8, D0
007396: 4EF9 0000 77C8           jmp     $77c8.l
00739C: 5439 0006 0601           addq.b  #2, $60601.l
0073A2: 7008                     moveq   #$8, D0
0073A4: 4EB9 0000 77C8           jsr     $77c8.l
0073AA: 33FC 0287 0006 060A      move.w  #$287, $6060a.l
0073B2: 7004                     moveq   #$4, D0
0073B4: 4EF9 0000 77C8           jmp     $77c8.l
0073BA: 0879 0006 0006 0604      bchg    #$6, $60604.l
0073C2: 0079 0180 0006 0604      ori.w   #$180, $60604.l
0073CA: 4EB9 0000 7612           jsr     $7612.l
0073D0: 7014                     moveq   #$14, D0
0073D2: 4EB9 0000 77C8           jsr     $77c8.l
0073D8: 7004                     moveq   #$4, D0
0073DA: 4EB9 0000 77C8           jsr     $77c8.l
0073E0: 43F9 0006 060A           lea     $6060a.l, A1
0073E6: 41F9 0006 0624           lea     $60624.l, A0
0073EC: 45F9 0006 061E           lea     $6061e.l, A2
0073F2: 32BC 0600                move.w  #$600, (A1)
0073F6: 1018                     move.b  (A0)+, D0
0073F8: 4640                     not.w   D0
0073FA: 1340 0005                move.b  D0, ($5,A1)
0073FE: 1018                     move.b  (A0)+, D0
007400: 4640                     not.w   D0
007402: 1340 0006                move.b  D0, ($6,A1)
007406: 1010                     move.b  (A0), D0
007408: 0240 000F                andi.w  #$f, D0
00740C: 1228 0005                move.b  ($5,A0), D1
007410: E949                     lsl.w   #4, D1
007412: 0241 0030                andi.w  #$30, D1
007416: 1428 0003                move.b  ($3,A0), D2
00741A: E41A                     ror.b   #2, D2
00741C: 0242 0040                andi.w  #$40, D2
007420: 1628 0004                move.b  ($4,A0), D3
007424: E21B                     ror.b   #1, D3
007426: 0243 0080                andi.w  #$80, D3
00742A: 8001                     or.b    D1, D0
00742C: 8002                     or.b    D2, D0
00742E: 8003                     or.b    D3, D0
007430: 1340 0007                move.b  D0, ($7,A1)
007434: 137C 0002 0009           move.b  #$2, ($9,A1)
00743A: 4A28 0001                tst.b   ($1,A0)
00743E: 6706                     beq     $7446
007440: 137C 0005 0009           move.b  #$5, ($9,A1)
007446: 137C 0006 000A           move.b  #$6, ($a,A1)
00744C: 4A28 0002                tst.b   ($2,A0)
007450: 6706                     beq     $7458
007452: 137C 0009 000A           move.b  #$9, ($a,A1)
007458: 1028 0006                move.b  ($6,A0), D0
00745C: E908                     lsl.b   #4, D0
00745E: 0200 00F0                andi.b  #$f0, D0
007462: 1228 0007                move.b  ($7,A0), D1
007466: 0201 000F                andi.b  #$f, D1
00746A: 8001                     or.b    D1, D0
00746C: 1340 000F                move.b  D0, ($f,A1)
007470: 1028 0008                move.b  ($8,A0), D0
007474: E908                     lsl.b   #4, D0
007476: 0200 00F0                andi.b  #$f0, D0
00747A: 1228 0009                move.b  ($9,A0), D1
00747E: 0201 000F                andi.b  #$f, D1
007482: 8001                     or.b    D1, D0
007484: 1340 0010                move.b  D0, ($10,A1)
007488: 102A 0000                move.b  ($0,A2), D0
00748C: 4640                     not.w   D0
00748E: 1340 0002                move.b  D0, ($2,A1)
007492: 102A 0002                move.b  ($2,A2), D0
007496: 4640                     not.w   D0
007498: 1340 0003                move.b  D0, ($3,A1)
00749C: 102A 0004                move.b  ($4,A2), D0
0074A0: 4640                     not.w   D0
0074A2: 1340 0004                move.b  D0, ($4,A1)
0074A6: 102A 0000                move.b  ($0,A2), D0
0074AA: 122A 0002                move.b  ($2,A2), D1
0074AE: 0839 0000 0006 066E      btst    #$0, $6066e.l
0074B6: 6608                     bne     $74c0
0074B8: 102A 0002                move.b  ($2,A2), D0
0074BC: 122A 0000                move.b  ($0,A2), D1
0074C0: 4A00                     tst.b   D0
0074C2: 670A                     beq     $74ce
0074C4: 4A01                     tst.b   D1
0074C6: 6606                     bne     $74ce
0074C8: 5239 0006 066E           addq.b  #1, $6066e.l
0074CE: 4229 0001                clr.b   ($1,A1)
0074D2: 0839 0000 0006 066E      btst    #$0, $6066e.l
0074DA: 6706                     beq     $74e2
0074DC: 137C 0001 0001           move.b  #$1, ($1,A1)
0074E2: 102A 0001                move.b  ($1,A2), D0
0074E6: 0839 0000 0006 066E      btst    #$0, $6066e.l
0074EE: 6704                     beq     $74f4
0074F0: 102A 0003                move.b  ($3,A2), D0
0074F4: 0200 0003                andi.b  #$3, D0
0074F8: 6746                     beq     $7540
0074FA: 41F9 0006 066F           lea     $6066f.l, A0
007500: 0800 0000                btst    #$0, D0
007504: 660A                     bne     $7510
007506: 5310                     subq.b  #1, (A0)
007508: 6410                     bcc     $751a
00750A: 10BC 0023                move.b  #$23, (A0)
00750E: 600A                     bra     $751a
007510: 5210                     addq.b  #1, (A0)
007512: 0C10 0024                cmpi.b  #$24, (A0)
007516: 6502                     bcs     $751a
007518: 4210                     clr.b   (A0)
00751A: 7000                     moveq   #$0, D0
00751C: 1010                     move.b  (A0), D0
00751E: D040                     add.w   D0, D0
007520: 41FA 0020                lea     ($20,PC) ; ($7542), A0
007524: 1430 0000                move.b  (A0,D0.w), D2
007528: 1370 0001 0011           move.b  ($1,A0,D0.w), ($11,A1)
00752E: 303C 003F                move.w  #$3f, D0
007532: 4EB9 0000 77EA           jsr     $77ea.l
007538: 3002                     move.w  D2, D0
00753A: 4EB9 0000 77EA           jsr     $77ea.l
007540: 4E75                     rts
007542: 0101                     btst    D0, D1
007544: 0202 0303                andi.b  #$3, D2
007548: 0404 0505                subi.b  #$5, D4
00754C: 0606 0707                addi.b  #$7, D6
007550: 0808                     dc.w    $0808; ILLEGAL
007552: 0909 0A10                movep.w ($a10,A1), D4
007556: 0B11                     btst    D5, (A1)
007558: 0C12 0D13                cmpi.b  #$13, (A2)
00755C: 0E14                     dc.w    $0e14; ILLEGAL
00755E: 0F15                     btst    D7, (A5)
007560: 1F31 2032                move.b  ($32,A1,D2.w), -(A7)
007564: 2133 2234                move.l  INVALID 33, -(A0)
007568: 2335 2436                move.l  INVALID 35, -(A1)
00756C: 2537 2638                move.l  INVALID 37, -(A2)
007570: 2739 2E46 2F47           move.l  $2e462f47.l, -(A3)
007576: 3048                     movea.w A0, A0
007578: 3149 3250                move.w  A1, ($3250,A0)
00757C: 3351 3452                move.w  (A1), ($3452,A1)
007580: 3553 3654                move.w  (A3), ($3654,A2)
007584: 3755 3856                move.w  (A5), ($3856,A3)
007588: 3957 43F9                move.w  (A7), ($43f9,A4)
00758C: 0006 0000                ori.b   #$0, D6
007590: 303C 0FFF                move.w  #$fff, D0
007594: 4299                     clr.l   (A1)+
007596: 51C8 FFFC                dbra    D0, $7594
00759A: 33FC 8010 0006 0604      move.w  #$8010, $60604.l
0075A2: 4ED0                     jmp     (A0)
0075A4: 41F9 0006 0F00           lea     $60f00.l, A0
0075AA: 7200                     moveq   #$0, D1
0075AC: 303C 006A                move.w  #$6a, D0
0075B0: 20C1                     move.l  D1, (A0)+
0075B2: 51C8 FFFC                dbra    D0, $75b0
0075B6: 4E75                     rts
0075B8: 41F9 0006 061E           lea     $6061e.l, A0
0075BE: 3039 0007 8000           move.w  $78000.l, D0
0075C4: 4640                     not.w   D0
0075C6: 3400                     move.w  D0, D2
0075C8: 1210                     move.b  (A0), D1
0075CA: 10C0                     move.b  D0, (A0)+
0075CC: 4641                     not.w   D1
0075CE: C240                     and.w   D0, D1
0075D0: 10C1                     move.b  D1, (A0)+
0075D2: 3039 0007 8002           move.w  $78002.l, D0
0075D8: 4640                     not.w   D0
0075DA: 3600                     move.w  D0, D3
0075DC: 1210                     move.b  (A0), D1
0075DE: 10C0                     move.b  D0, (A0)+
0075E0: 4641                     not.w   D1
0075E2: C240                     and.w   D0, D1
0075E4: 10C1                     move.b  D1, (A0)+
0075E6: E04A                     lsr.w   #8, D2
0075E8: 0242 000F                andi.w  #$f, D2
0075EC: E84B                     lsr.w   #4, D3
0075EE: 0243 0070                andi.w  #$70, D3
0075F2: 8443                     or.w    D3, D2
0075F4: 1210                     move.b  (A0), D1
0075F6: 10C2                     move.b  D2, (A0)+
0075F8: 4641                     not.w   D1
0075FA: C242                     and.w   D2, D1
0075FC: 1081                     move.b  D1, (A0)
0075FE: 4E75                     rts
007600: 0304                     btst    D1, D4
007602: 0506                     btst    D2, D6
007604: 0101                     btst    D0, D1
007606: 0102                     btst    D0, D2
007608: 0201 0101                andi.b  #$1, D1
00760C: 0102                     btst    D0, D2
00760E: 0201 0203                andi.b  #$3, D1
007612: 3039 0007 8004           move.w  $78004.l, D0
007618: 4640                     not.w   D0
00761A: 13C0 0006 0624           move.b  D0, $60624.l
007620: 3200                     move.w  D0, D1
007622: 41F9 0006 0626           lea     $60626.l, A0
007628: 43FA FFD6                lea     (-$2a,PC) ; ($7600), A1
00762C: 0240 0003                andi.w  #$3, D0
007630: 10F1 0000                move.b  (A1,D0.w), (A0)+
007634: E459                     ror.w   #2, D1
007636: 3001                     move.w  D1, D0
007638: 0240 0001                andi.w  #$1, D0
00763C: 10C0                     move.b  D0, (A0)+
00763E: E259                     ror.w   #1, D1
007640: 3001                     move.w  D1, D0
007642: 0240 0001                andi.w  #$1, D0
007646: 10C0                     move.b  D0, (A0)+
007648: E259                     ror.w   #1, D1
00764A: 3001                     move.w  D1, D0
00764C: 0240 0001                andi.w  #$1, D0
007650: 10C0                     move.b  D0, (A0)+
007652: E259                     ror.w   #1, D1
007654: 3001                     move.w  D1, D0
007656: 0240 0001                andi.w  #$1, D0
00765A: 10C0                     move.b  D0, (A0)+
00765C: E259                     ror.w   #1, D1
00765E: 0241 0003                andi.w  #$3, D1
007662: 10C1                     move.b  D1, (A0)+
007664: 3039 0007 8006           move.w  $78006.l, D0
00766A: 4640                     not.w   D0
00766C: 13C0 0006 0625           move.b  D0, $60625.l
007672: 3200                     move.w  D0, D1
007674: 0240 0003                andi.w  #$3, D0
007678: 0C40 0003                cmpi.w  #$3, D0
00767C: 6716                     beq     $7694
00767E: D040                     add.w   D0, D0
007680: 30F1 0004                move.w  ($4,A1,D0.w), (A0)+
007684: E459                     ror.w   #2, D1
007686: 3001                     move.w  D1, D0
007688: 0240 0003                andi.w  #$3, D0
00768C: D040                     add.w   D0, D0
00768E: 30F1 000A                move.w  ($a,A1,D0.w), (A0)+
007692: 6008                     bra     $769c
007694: E459                     ror.w   #2, D1
007696: 20FC FFFF FFFF           move.l  #$ffffffff, (A0)+
00769C: E659                     ror.w   #3, D1
00769E: 3001                     move.w  D1, D0
0076A0: 0240 0001                andi.w  #$1, D0
0076A4: 10C0                     move.b  D0, (A0)+
0076A6: E259                     ror.w   #1, D1
0076A8: 0241 0003                andi.w  #$3, D1
0076AC: 1081                     move.b  D1, (A0)
0076AE: 4E75                     rts
0076B0: 0839 0007 0006 062C      btst    #$7, $6062c.l
0076B8: 670C                     beq     $76c6
0076BA: 33FC 9999 0006 0632      move.w  #$9999, $60632.l
0076C2: 6000 00A8                bra     $776c
0076C6: 0839 0002 0006 0623      btst    #$2, $60623.l
0076CE: 6738                     beq     $7708
0076D0: 5239 0006 0634           addq.b  #1, $60634.l
0076D6: 303C 0001                move.w  #$1, D0
0076DA: 4EBA 010E                jsr     ($10e,PC) ; ($77ea)
0076DE: 5239 0006 0636           addq.b  #1, $60636.l
0076E4: 1039 0006 0636           move.b  $60636.l, D0
0076EA: 9039 0006 062C           sub.b   $6062c.l, D0
0076F0: 6516                     bcs     $7708
0076F2: 13C0 0006 0636           move.b  D0, $60636.l
0076F8: 1039 0006 062D           move.b  $6062d.l, D0
0076FE: 41F9 0006 0632           lea     $60632.l, A0
007704: 4EBA 00B0                jsr     ($b0,PC) ; ($77b6)
007708: 0839 0003 0006 0623      btst    #$3, $60623.l
007710: 6738                     beq     $774a
007712: 5239 0006 0635           addq.b  #1, $60635.l
007718: 303C 0001                move.w  #$1, D0
00771C: 4EBA 00CC                jsr     ($cc,PC) ; ($77ea)
007720: 5239 0006 0637           addq.b  #1, $60637.l
007726: 1039 0006 0637           move.b  $60637.l, D0
00772C: 9039 0006 062E           sub.b   $6062e.l, D0
007732: 6516                     bcs     $774a
007734: 13C0 0006 0637           move.b  D0, $60637.l
00773A: 1039 0006 062F           move.b  $6062f.l, D0
007740: 41F9 0006 0633           lea     $60633.l, A0
007746: 4EBA 006E                jsr     ($6e,PC) ; ($77b6)
00774A: 0839 0004 0006 0623      btst    #$4, $60623.l
007752: 6718                     beq     $776c
007754: 41F9 0006 0632           lea     $60632.l, A0
00775A: 0C10 0099                cmpi.b  #-$67, (A0)
00775E: 6606                     bne     $7766
007760: 41F9 0006 0633           lea     $60633.l, A0
007766: 7001                     moveq   #$1, D0
007768: 4EBA 004C                jsr     ($4c,PC) ; ($77b6)
00776C: 1039 0006 0603           move.b  $60603.l, D0
007772: 0200 0003                andi.b  #$3, D0
007776: 663C                     bne     $77b4
007778: 41F9 0006 0605           lea     $60605.l, A0
00777E: 43F9 0006 0634           lea     $60634.l, A1
007784: 0850 0000                bchg    #$0, (A0)
007788: 6610                     bne     $779a
00778A: 0850 0000                bchg    #$0, (A0)
00778E: 1011                     move.b  (A1), D0
007790: 5300                     subq.b  #1, D0
007792: 6506                     bcs     $779a
007794: 1280                     move.b  D0, (A1)
007796: 08D0 0000                bset    #$0, (A0)
00779A: 0850 0001                bchg    #$1, (A0)
00779E: 6614                     bne     $77b4
0077A0: 0850 0001                bchg    #$1, (A0)
0077A4: 1029 0001                move.b  ($1,A1), D0
0077A8: 5300                     subq.b  #1, D0
0077AA: 6508                     bcs     $77b4
0077AC: 1340 0001                move.b  D0, ($1,A1)
0077B0: 08D0 0001                bset    #$1, (A0)
0077B4: 4E75                     rts
0077B6: 1210                     move.b  (A0), D1
0077B8: 44FC 0004                move    #$4, CCR
0077BC: C300                     abcd    D0, D1
0077BE: 6404                     bcc     $77c4
0077C0: 123C 0099                move.b  #$99, D1
0077C4: 1081                     move.b  D1, (A0)
0077C6: 4E75                     rts
0077C8: 47F9 0006 0648           lea     $60648.l, A3
0077CE: 3239 0006 066C           move.w  $6066c.l, D1
0077D4: 3780 1000                move.w  D0, (A3,D1.w)
0077D8: 5441                     addq.w  #2, D1
0077DA: 0C41 0020                cmpi.w  #$20, D1
0077DE: 6602                     bne     $77e2
0077E0: 4241                     clr.w   D1
0077E2: 33C1 0006 066C           move.w  D1, $6066c.l
0077E8: 4E75                     rts
0077EA: 2F0B                     move.l  A3, -(A7)
0077EC: 2F01                     move.l  D1, -(A7)
0077EE: 47F9 0006 0638           lea     $60638.l, A3
0077F4: 3239 0006 0668           move.w  $60668.l, D1
0077FA: 1780 1000                move.b  D0, (A3,D1.w)
0077FE: 5241                     addq.w  #1, D1
007800: 0C41 0010                cmpi.w  #$10, D1
007804: 6602                     bne     $7808
007806: 4241                     clr.w   D1
007808: 33C1 0006 0668           move.w  D1, $60668.l
00780E: 221F                     move.l  (A7)+, D1
007810: 265F                     movea.l (A7)+, A3
007812: 4E75                     rts
007814: 41F9 0006 0638           lea     $60638.l, A0
00781A: 3039 0006 066A           move.w  $6066a.l, D0
007820: 1230 0000                move.b  (A0,D0.w), D1
007824: 6738                     beq     $785e
007826: 4230 0000                clr.b   (A0,D0.w)
00782A: 0C01 0001                cmpi.b  #$1, D1
00782E: 6718                     beq     $7848
007830: 0C01 003F                cmpi.b  #$3f, D1
007834: 6712                     beq     $7848
007836: 0C39 0002 0006 0600      cmpi.b  #$2, $60600.l
00783E: 6708                     beq     $7848
007840: 4A39 0006 0629           tst.b   $60629.l
007846: 6706                     beq     $784e
007848: 33C1 0007 C00A           move.w  D1, $7c00a.l
00784E: 5240                     addq.w  #1, D0
007850: 0C40 0010                cmpi.w  #$10, D0
007854: 6602                     bne     $7858
007856: 4240                     clr.w   D0
007858: 33C0 0006 066A           move.w  D0, $6066a.l
00785E: 4E75                     rts
007860: 5239 0006 07D4           addq.b  #1, $607d4.l
007866: 1039 0006 07D4           move.b  $607d4.l, D0
00786C: 0240 001F                andi.w  #$1f, D0
007870: 103B 0004                move.b  ($4,PC,D0.w), D0
007874: 4E75                     rts
007876: 0010 0C1C                ori.b   #$1c, (A0)
00787A: 1D01                     move.b  D1, -(A6)
00787C: 110D                     dc.w    $110d; ILLEGAL
00787E: 0B1B                     btst    D5, (A3)+
007880: 0212 1A0A                andi.b  #$a, (A2)
007884: 1303                     move.b  D3, -(A1)
007886: 0E14                     dc.w    $0e14; ILLEGAL
007888: 041E 1505                subi.b  #$5, (A6)+
00788C: 1909                     dc.w    $1909; ILLEGAL
00788E: 0616 0818                addi.b  #$18, (A6)
007892: 1F07                     move.b  D7, -(A7)
007894: 170F                     dc.w    $170f; ILLEGAL
007896: 0681 0000 7973           addi.l  #$7973, D1
00789C: 2A41                     movea.l D1, A5
00789E: 4DF9 0006 06B9           lea     $606b9.l, A6
0078A4: 4A39 0006 07D5           tst.b   $607d5.l
0078AA: 6706                     beq     $78b2
0078AC: 4DF9 0006 06BD           lea     $606bd.l, A6
0078B2: 44FC 0004                move    #$4, CCR
0078B6: CD0D                     abcd    -(A5), -(A6)
0078B8: CD0D                     abcd    -(A5), -(A6)
0078BA: CD0D                     abcd    -(A5), -(A6)
0078BC: 2216                     move.l  (A6), D1
0078BE: B2B9 0006 06B2           cmp.l   $606b2.l, D1
0078C4: 6306                     bls     $78cc
0078C6: 23C1 0006 06B2           move.l  D1, $606b2.l
0078CC: 4A39 0006 10AC           tst.b   $610ac.l
0078D2: 6A02                     bpl     $78d6
0078D4: 4E75                     rts
0078D6: 3F00                     move.w  D0, -(A7)
0078D8: 4BF9 0006 06AA           lea     $606aa.l, A5
0078DE: 4A39 0006 07D5           tst.b   $607d5.l
0078E4: 6706                     beq     $78ec
0078E6: 4BF9 0006 06AE           lea     $606ae.l, A5
0078EC: B295                     cmp.l   (A5), D1
0078EE: 6564                     bcs     $7954
0078F0: 1039 0006 062B           move.b  $6062b.l, D0
0078F6: 0240 0003                andi.w  #$3, D0
0078FA: E548                     lsl.w   #2, D0
0078FC: B2BB 005A                cmp.l   ($5a,PC,D0.w), D1
007900: 644C                     bcc     $794e
007902: 4DFA 0068                lea     ($68,PC) ; ($796c), A6
007906: 4A39 0006 0628           tst.b   $60628.l
00790C: 6704                     beq     $7912
00790E: 4DFA 0060                lea     ($60,PC) ; ($7970), A6
007912: 588D                     addq.l  #4, A5
007914: 44FC 0004                move    #$4, CCR
007918: CB0E                     abcd    -(A6), -(A5)
00791A: CB0E                     abcd    -(A6), -(A5)
00791C: CB0E                     abcd    -(A6), -(A5)
00791E: CB0E                     abcd    -(A6), -(A5)
007920: 4DF9 0006 06BE           lea     $606be.l, A6
007926: 4A39 0006 07D5           tst.b   $607d5.l
00792C: 6706                     beq     $7934
00792E: 4DF9 0006 06BF           lea     $606bf.l, A6
007934: 1016                     move.b  (A6), D0
007936: 0C00 0099                cmpi.b  #-$67, D0
00793A: 6418                     bcc     $7954
00793C: 7201                     moveq   #$1, D1
00793E: 44FC 0004                move    #$4, CCR
007942: C101                     abcd    D1, D0
007944: 1C80                     move.b  D0, (A6)
007946: 7008                     moveq   #$8, D0
007948: 6100 FEA0                bsr     $77ea
00794C: 6006                     bra     $7954
00794E: 2ABC FFFF FFFF           move.l  #$ffffffff, (A5)
007954: 301F                     move.w  (A7)+, D0
007956: 4E75                     rts
007958: 0040 0000                ori.w   #$0, D0
00795C: 0030 0000 0020           ori.b   #$0, ($20,A0,D0.w)
007962: 0000 0010                ori.b   #$10, D0
007966: 0000 0006                ori.b   #$6, D0
00796A: 0000 0009                ori.b   #$9, D0
00796E: 0000 0000                ori.b   #$0, D0
007972: 0100                     btst    D0, D0
007974: 0000 0200                ori.b   #$0, D0
007978: 0000 0300                ori.b   #$0, D0
00797C: 0000 0500                ori.b   #$0, D0
007980: 0000 1000                ori.b   #$0, D0
007984: 0000 3000                ori.b   #$0, D0
007988: 0000 5000                ori.b   #$0, D0
00798C: 0001 0000                ori.b   #$0, D1
007990: 0005 0000                ori.b   #$0, D5
007994: 0010 0000                ori.b   #$0, (A0)
007998: 0000 0600                ori.b   #$0, D0
00799C: 48A7 C000                movem.w D0-D1, -(A7)
0079A0: 7200                     moveq   #$0, D1
0079A2: 1210                     move.b  (A0), D1
0079A4: E249                     lsr.w   #1, D1
0079A6: 123B 101D                move.b  ($1d,PC,D1.w), D1
0079AA: 0828 0001 000F           btst    #$1, ($f,A0)
0079B0: 670A                     beq     $79bc
0079B2: 4240                     clr.w   D0
0079B4: 4EB9 0000 EEEC           jsr     $eeec.l
0079BA: 7210                     moveq   #$10, D1
0079BC: 6100 FED8                bsr     $7896
0079C0: 4C9F 0003                movem.w (A7)+, D0-D1
0079C4: 4E75                     rts
0079C6: 0000 0008                ori.b   #$8, D0
0079CA: 0004 080C                ori.b   #$c, D4
0079CE: 0400 0000                subi.b  #$0, D0
0079D2: 0000 0404                ori.b   #$4, D0
0079D6: 0404 0404                subi.b  #$4, D4
0079DA: 0404 0404                subi.b  #$4, D4
0079DE: 0808                     dc.w    $0808; ILLEGAL
0079E0: 0808                     dc.w    $0808; ILLEGAL
0079E2: 0800 0000                btst    #$0, D0
0079E6: 0000 0000                ori.b   #$0, D0
0079EA: 0000 0000                ori.b   #$0, D0
0079EE: 0000 0000                ori.b   #$0, D0
0079F2: 48A7 C000                movem.w D0-D1, -(A7)
0079F6: 7200                     moveq   #$0, D1
0079F8: 1210                     move.b  (A0), D1
0079FA: E249                     lsr.w   #1, D1
0079FC: 123B 101D                move.b  ($1d,PC,D1.w), D1
007A00: 0828 0001 000F           btst    #$1, ($f,A0)
007A06: 670A                     beq     $7a12
007A08: 4240                     clr.w   D0
007A0A: 4EB9 0000 EEEC           jsr     $eeec.l
007A10: 7210                     moveq   #$10, D1
007A12: 6100 FE82                bsr     $7896
007A16: 4C9F 0003                movem.w (A7)+, D0-D1
007A1A: 4E75                     rts
007A1C: 0000 0004                ori.b   #$4, D0
007A20: 0404 0008                subi.b  #$8, D4
007A24: 0800 0400                btst    #$0, D0
007A28: 0004 0408                ori.b   #$8, D4
007A2C: 0404 0000                subi.b  #$0, D4
007A30: 0004 0400                ori.b   #$0, D4
007A34: 0000 0004                ori.b   #$4, D0
007A38: 0408                     dc.w    $0408; ILLEGAL
007A3A: 0808                     dc.w    $0808; ILLEGAL
007A3C: 0800 0000                btst    #$0, D0
007A40: 0000 0000                ori.b   #$0, D0
007A44: 0000 0800                ori.b   #$0, D0
007A48: 0000 0004                ori.b   #$4, D0
007A4C: 0400 102B                subi.b  #$2b, D0
007A50: 1079                     dc.w    $1079; ILLEGAL
007A52: 1070                     dc.w    $1070; ILLEGAL
007A54: 105F                     dc.w    $105f; ILLEGAL
007A56: 104E                     dc.w    $104e; ILLEGAL
007A58: 1045                     dc.w    $1045; ILLEGAL
007A5A: 1032 1027                move.b  ($27,A2,D1.w), D0
007A5E: 1016                     move.b  (A6), D0
007A60: 100D                     dc.w    $100d; ILLEGAL
007A62: 0FEC 0FD9                bset    D7, ($fd9,A4)
007A66: 0FD0                     bset    D7, (A0)
007A68: 0FBF                     dc.w    $0fbf; ILLEGAL
007A6A: 0FAC 0F9B                bclr    D7, ($f9b,A4)
007A6E: 0F92                     bclr    D7, (A2)
007A70: 0F8E 0F69                movep.w D7, ($f69,A6)
007A74: 0F60                     bchg    D7, -(A0)
007A76: 0F5D                     bchg    D7, (A5)+
007A78: 0F52                     bchg    D7, (A2)
007A7A: 0F50                     bchg    D7, (A0)
007A7C: 0F4E 0F4A                movep.l ($f4a,A6), D7
007A80: 0F40                     bchg    D7, D0
007A82: 0F3E                     dc.w    $0f3e; ILLEGAL
007A84: 0F33 0F00                btst    D7, INVALID 33
007A88: 1079                     dc.w    $1079; ILLEGAL
007A8A: 102B 1070                move.b  ($1070,A3), D0
007A8E: 105F                     dc.w    $105f; ILLEGAL
007A90: 104E                     dc.w    $104e; ILLEGAL
007A92: 1045                     dc.w    $1045; ILLEGAL
007A94: 1032 1016                move.b  ($16,A2,D1.w), D0
007A98: 100D                     dc.w    $100d; ILLEGAL
007A9A: 1027                     move.b  -(A7), D0
007A9C: 0FEC 0FD9                bset    D7, ($fd9,A4)
007AA0: 0FD0                     bset    D7, (A0)
007AA2: 0FBF                     dc.w    $0fbf; ILLEGAL
007AA4: 0FAC 0F9B                bclr    D7, ($f9b,A4)
007AA8: 0F92                     bclr    D7, (A2)
007AAA: 0F8E 0F69                movep.w D7, ($f69,A6)
007AAE: 0F60                     bchg    D7, -(A0)
007AB0: 0F5D                     bchg    D7, (A5)+
007AB2: 0F52                     bchg    D7, (A2)
007AB4: 0F50                     bchg    D7, (A0)
007AB6: 0F4E 0F4A                movep.l ($f4a,A6), D7
007ABA: 0F40                     bchg    D7, D0
007ABC: 0F3E                     dc.w    $0f3e; ILLEGAL
007ABE: 0F33 0F00                btst    D7, INVALID 33
007AC2: 1079                     dc.w    $1079; ILLEGAL
007AC4: 102B 1070                move.b  ($1070,A3), D0
007AC8: 105F                     dc.w    $105f; ILLEGAL
007ACA: 104E                     dc.w    $104e; ILLEGAL
007ACC: 1045                     dc.w    $1045; ILLEGAL
007ACE: 1032 1027                move.b  ($27,A2,D1.w), D0
007AD2: 1016                     move.b  (A6), D0
007AD4: 100D                     dc.w    $100d; ILLEGAL
007AD6: 0FEC 0FD9                bset    D7, ($fd9,A4)
007ADA: 0FD0                     bset    D7, (A0)
007ADC: 0FBF                     dc.w    $0fbf; ILLEGAL
007ADE: 0FAC 0F9B                bclr    D7, ($f9b,A4)
007AE2: 0F92                     bclr    D7, (A2)
007AE4: 0F8E 0F69                movep.w D7, ($f69,A6)
007AE8: 0F60                     bchg    D7, -(A0)
007AEA: 0F5D                     bchg    D7, (A5)+
007AEC: 0F52                     bchg    D7, (A2)
007AEE: 0F50                     bchg    D7, (A0)
007AF0: 0F4E 0F4A                movep.l ($f4a,A6), D7
007AF4: 0F40                     bchg    D7, D0
007AF6: 0F3E                     dc.w    $0f3e; ILLEGAL
007AF8: 0F33 0F00                btst    D7, INVALID 33
007AFC: 1079                     dc.w    $1079; ILLEGAL
007AFE: 102B 1070                move.b  ($1070,A3), D0
007B02: 105F                     dc.w    $105f; ILLEGAL
007B04: 104E                     dc.w    $104e; ILLEGAL
007B06: 1045                     dc.w    $1045; ILLEGAL
007B08: 1032 1016                move.b  ($16,A2,D1.w), D0
007B0C: 100D                     dc.w    $100d; ILLEGAL
007B0E: 0FEC 0FD9                bset    D7, ($fd9,A4)
007B12: 0FD0                     bset    D7, (A0)
007B14: 0FBF                     dc.w    $0fbf; ILLEGAL
007B16: 0FAC 1027                bclr    D7, ($1027,A4)
007B1A: 0F9B                     bclr    D7, (A3)+
007B1C: 0F92                     bclr    D7, (A2)
007B1E: 0F8E 0F69                movep.w D7, ($f69,A6)
007B22: 0F60                     bchg    D7, -(A0)
007B24: 0F5D                     bchg    D7, (A5)+
007B26: 0F52                     bchg    D7, (A2)
007B28: 0F50                     bchg    D7, (A0)
007B2A: 0F4E 0F4A                movep.l ($f4a,A6), D7
007B2E: 0F40                     bchg    D7, D0
007B30: 0F3E                     dc.w    $0f3e; ILLEGAL
007B32: 0F33 0F00                btst    D7, INVALID 33
007B36: 1079                     dc.w    $1079; ILLEGAL
007B38: 1070                     dc.w    $1070; ILLEGAL
007B3A: 105F                     dc.w    $105f; ILLEGAL
007B3C: 104E                     dc.w    $104e; ILLEGAL
007B3E: 1045                     dc.w    $1045; ILLEGAL
007B40: 1032 102B                move.b  ($2b,A2,D1.w), D0
007B44: 1027                     move.b  -(A7), D0
007B46: 1016                     move.b  (A6), D0
007B48: 100D                     dc.w    $100d; ILLEGAL
007B4A: 0FEC 0FD9                bset    D7, ($fd9,A4)
007B4E: 0FD0                     bset    D7, (A0)
007B50: 0FBF                     dc.w    $0fbf; ILLEGAL
007B52: 0FAC 0F9B                bclr    D7, ($f9b,A4)
007B56: 0F92                     bclr    D7, (A2)
007B58: 0F8E 0F69                movep.w D7, ($f69,A6)
007B5C: 0F60                     bchg    D7, -(A0)
007B5E: 0F5D                     bchg    D7, (A5)+
007B60: 0F52                     bchg    D7, (A2)
007B62: 0F50                     bchg    D7, (A0)
007B64: 0F4E 0F4A                movep.l ($f4a,A6), D7
007B68: 0F40                     bchg    D7, D0
007B6A: 0F3E                     dc.w    $0f3e; ILLEGAL
007B6C: 0F33 0F00                btst    D7, INVALID 33
007B70: 1079                     dc.w    $1079; ILLEGAL
007B72: 1070                     dc.w    $1070; ILLEGAL
007B74: 105F                     dc.w    $105f; ILLEGAL
007B76: 104E                     dc.w    $104e; ILLEGAL
007B78: 1045                     dc.w    $1045; ILLEGAL
007B7A: 1032 102B                move.b  ($2b,A2,D1.w), D0
007B7E: 1027                     move.b  -(A7), D0
007B80: 1016                     move.b  (A6), D0
007B82: 100D                     dc.w    $100d; ILLEGAL
007B84: 0FEC 0FD9                bset    D7, ($fd9,A4)
007B88: 0FD0                     bset    D7, (A0)
007B8A: 0FBF                     dc.w    $0fbf; ILLEGAL
007B8C: 0FAC 0F9B                bclr    D7, ($f9b,A4)
007B90: 0F92                     bclr    D7, (A2)
007B92: 0F8E 0F69                movep.w D7, ($f69,A6)
007B96: 0F60                     bchg    D7, -(A0)
007B98: 0F5D                     bchg    D7, (A5)+
007B9A: 0F52                     bchg    D7, (A2)
007B9C: 0F50                     bchg    D7, (A0)
007B9E: 0F4E 0F4A                movep.l ($f4a,A6), D7
007BA2: 0F40                     bchg    D7, D0
007BA4: 0F3E                     dc.w    $0f3e; ILLEGAL
007BA6: 0F33 0F00                btst    D7, INVALID 33
007BAA: 108A                     dc.w    $108a; ILLEGAL
007BAC: 1079                     dc.w    $1079; ILLEGAL
007BAE: 1070                     dc.w    $1070; ILLEGAL
007BB0: 105F                     dc.w    $105f; ILLEGAL
007BB2: 104E                     dc.w    $104e; ILLEGAL
007BB4: 1045                     dc.w    $1045; ILLEGAL
007BB6: 1032 102B                move.b  ($2b,A2,D1.w), D0
007BBA: 1016                     move.b  (A6), D0
007BBC: 100D                     dc.w    $100d; ILLEGAL
007BBE: 0FEC 0FD9                bset    D7, ($fd9,A4)
007BC2: 0FD0                     bset    D7, (A0)
007BC4: 0FBF                     dc.w    $0fbf; ILLEGAL
007BC6: 0FAC 1027                bclr    D7, ($1027,A4)
007BCA: 0F9B                     bclr    D7, (A3)+
007BCC: 0F92                     bclr    D7, (A2)
007BCE: 0F8E 0F69                movep.w D7, ($f69,A6)
007BD2: 0F60                     bchg    D7, -(A0)
007BD4: 0F5D                     bchg    D7, (A5)+
007BD6: 0F52                     bchg    D7, (A2)
007BD8: 0F50                     bchg    D7, (A0)
007BDA: 0F4E 0F4A                movep.l ($f4a,A6), D7
007BDE: 0F40                     bchg    D7, D0
007BE0: 0F3E                     dc.w    $0f3e; ILLEGAL
007BE2: 0F33 0F00                btst    D7, INVALID 33
007BE6: 1079                     dc.w    $1079; ILLEGAL
007BE8: 102B 1070                move.b  ($1070,A3), D0
007BEC: 105F                     dc.w    $105f; ILLEGAL
007BEE: 104E                     dc.w    $104e; ILLEGAL
007BF0: 1045                     dc.w    $1045; ILLEGAL
007BF2: 1032 1016                move.b  ($16,A2,D1.w), D0
007BF6: 100D                     dc.w    $100d; ILLEGAL
007BF8: 0FD9                     bset    D7, (A1)+
007BFA: 0FD0                     bset    D7, (A0)
007BFC: 0FBF                     dc.w    $0fbf; ILLEGAL
007BFE: 1027                     move.b  -(A7), D0
007C00: 0FEC 0FAC                bset    D7, ($fac,A4)
007C04: 0F9B                     bclr    D7, (A3)+
007C06: 0F92                     bclr    D7, (A2)
007C08: 0F8E 0F69                movep.w D7, ($f69,A6)
007C0C: 0F60                     bchg    D7, -(A0)
007C0E: 0F5D                     bchg    D7, (A5)+
007C10: 0F52                     bchg    D7, (A2)
007C12: 0F50                     bchg    D7, (A0)
007C14: 0F4E 0F4A                movep.l ($f4a,A6), D7
007C18: 0F40                     bchg    D7, D0
007C1A: 0F3E                     dc.w    $0f3e; ILLEGAL
007C1C: 0F33 0F00                btst    D7, INVALID 33
007C20: 0000 7A4E                ori.b   #$4e, D0
007C24: 0000 001B                ori.b   #$1b, D0
007C28: 0000 7A88                ori.b   #$88, D0
007C2C: 0008                     dc.w    $0008; ILLEGAL
007C2E: 0013 0000                ori.b   #$0, (A3)
007C32: 7AC2                     moveq   #-$3e, D5
007C34: 0009                     dc.w    $0009; ILLEGAL
007C36: 0012 0000                ori.b   #$0, (A2)
007C3A: 7AFC                     moveq   #-$4, D5
007C3C: 0008                     dc.w    $0008; ILLEGAL
007C3E: 0013 0000                ori.b   #$0, (A3)
007C42: 7B36                     dc.w    $7b36; ILLEGAL
007C44: 0017 0004                ori.b   #$4, (A7)
007C48: 0000 7B70                ori.b   #$70, D0
007C4C: FFFF                     dc.w    $ffff; opcode 1111
007C4E: 001C 0000                ori.b   #$0, (A4)+
007C52: 7BAC                     dc.w    $7bac; ILLEGAL
007C54: 0017 0004                ori.b   #$4, (A7)
007C58: 0000 7BE6                ori.b   #$e6, D0
007C5C: 0008                     dc.w    $0008; ILLEGAL
007C5E: 0013 0000                ori.b   #$0, (A3)
007C62: 7A4E                     moveq   #$4e, D5
007C64: 001B 0000                ori.b   #$0, (A3)+
007C68: 23CF 0006 077A           move.l  A7, $6077a.l
007C6E: 4240                     clr.w   D0
007C70: 1039 0006 0630           move.b  $60630.l, D0
007C76: 4A39 0006 06E6           tst.b   $606e6.l
007C7C: 6702                     beq     $7c80
007C7E: 5540                     subq.w  #2, D0
007C80: 33C0 0006 0778           move.w  D0, $60778.l
007C86: 41F9 0000 7BAA           lea     $7baa.l, A0
007C8C: 43F9 0006 0000           lea     $60000.l, A1
007C92: 721C                     moveq   #$1c, D1
007C94: 4242                     clr.w   D2
007C96: 3018                     move.w  (A0)+, D0
007C98: 1382 00FF                move.b  D2, (-$1,A1,D0.w)
007C9C: 51C9 FFF8                dbra    D1, $7c96
007CA0: 3E39 0006 07EA           move.w  $607ea.l, D7
007CA6: 4A39 0006 06E6           tst.b   $606e6.l
007CAC: 6706                     beq     $7cb4
007CAE: 3E39 0006 07EC           move.w  $607ec.l, D7
007CB4: 47F9 0000 7C20           lea     $7c20.l, A3
007CBA: 2073 7000                movea.l (A3,D7.w), A0
007CBE: 43F9 0006 108C           lea     $6108c.l, A1
007CC4: 45F9 0006 0000           lea     $60000.l, A2
007CCA: 363C 00C0                move.w  #$c0, D3
007CCE: 3033 7004                move.w  ($4,A3,D7.w), D0
007CD2: 6B12                     bmi     $7ce6
007CD4: 3F07                     move.w  D7, -(A7)
007CD6: 3A3C 2000                move.w  #$2000, D5
007CDA: 6100 0024                bsr     $7d00
007CDE: 3E1F                     move.w  (A7)+, D7
007CE0: 47F9 0000 7C20           lea     $7c20.l, A3
007CE6: 3033 7006                move.w  ($6,A3,D7.w), D0
007CEA: 3A3C 1000                move.w  #$1000, D5
007CEE: 6100 0010                bsr     $7d00
007CF2: 5343                     subq.w  #1, D3
007CF4: 6508                     bcs     $7cfe
007CF6: 429A                     clr.l   (A2)+
007CF8: 429A                     clr.l   (A2)+
007CFA: 51CB FFFA                dbra    D3, $7cf6
007CFE: 4E75                     rts
007D00: 223C 0006 0000           move.l  #$60000, D1
007D06: D258                     add.w   (A0)+, D1
007D08: 2641                     movea.l D1, A3
007D0A: 4241                     clr.w   D1
007D0C: 121B                     move.b  (A3)+, D1
007D0E: 6606                     bne     $7d16
007D10: 51C8 FFEE                dbra    D0, $7d00
007D14: 4E75                     rts
007D16: EB49                     lsl.w   #5, D1
007D18: 3C31 1002                move.w  ($2,A1,D1.w), D6
007D1C: 3E31 1006                move.w  ($6,A1,D1.w), D7
007D20: 9E79 0006 0778           sub.w   $60778.l, D7
