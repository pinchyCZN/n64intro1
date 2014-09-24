                   ;d0=x pos
                   ;d1=y
                   ;a0=text pointer
GREETS
  db "CRAZY NATION PRESENTS",0
  db "    TWINE  +3        ",0
  DB "GREETS GO OUT TO     ",0
  DB "THE AWESOME TITANIK  ",0
  DB "SISPEO,LOOM,WILDFIRE ",0
  DB "STEVE,COUNT0         ",0
  DB "LAC,NAGRARAR,KEMURI  ",0
  DB "CFORMAN,SUBICE,REFRIE",0
  DB "DEMO,DX,RAVEMAX,ZILMA",0
  DB "ACTRAISER,POYZ,STEVE ",0
  DB "ANGELO, CODEMASTER   ",0
  DB "HEY DATAWIZ,BLACKBAG ",0
  DB "HYJINX,TS-GARP       ",0
  DB "IGGY,ICARUS,IMMO,BUFF",0
  DB "SOS,KIDSTARD,WIDGET  ",0
  DB "HOTBLACK             ",0
  DB "AND ALL THE OTHERS!  ",0
  DB "ENJOY THIS TRAINER   ",0
endgreets
textfade1 db 255
  cnop 0,4
varioustext: DW GREETS
text_Z: dw -$400
text_wait: dw 0
fontscale dw $10000
fontxpos dw 0
fontfade dw 0
placetext:
              move  d5,d0  ;save xpos
              lw    d7,fontscale
              sw    d7,yscale
              sw     d7,xscale
              LI    D6,16
              SW    D6,width
              sw    d6,height

@nextletter
              lbu   d8,0(a0)
              beqz  d8,@exit
              addu  a0,1
              bne   d8,1,@nolinefeed
              nop
              addu  d1,16
              b     @nextletter
              move  d0,d5    ;xpos

@nolinefeed   addu  d8,-32
              BEQZ  D8,@SKIPSPACE
              sll   d8,9
              la    a1,FONTS1
              addu  a1,d8
              sw    a1,spritepointer
              sw    d0,xposition
              sw    d1,yposition
              sw    d0,-4(a8)
              sw    d1,-8(a8)
              sw    a0,-24(a8)
              sw    ra,-28(a8)
              sw    d5,-32(a8)
              jal   dosprite
              nop
              lw    d0,-4(a8)
              lw    d1,-8(a8)
              lw    a0,-24(a8)
              lw    ra,-28(a8)
              lw    d5,-32(a8)

@SKIPSPACE
              lw    d7,fontscale
              li    d6,16
              multu d6,d7
              mflo  d7
              sra   d7,16
              addu  d0,d7       ;next xpos
              b     @nextletter
              nop
@exit         jr ra
              nop

showoptions:
              li   d0,20   ;xpos
              li   d1,117  ;initial y
              lw   d7,option_position
              subu d1,d7   ;move up  y
              li   d6,8
              sw   d6,width
              sw   d6,height
              li   d5,$10000
              sw   d5,xscale
              sw   d5,yscale
              la   a0,traintxt
           sw ra,0(a8)    

@textloop
              lbu  d3,0(a0)
              addu a0,1
              beqz d3,@finished
              li   d4,1
              bne  d3,d4,@nolinefeed
              nop
              lbu  d3,0(a0)
              addu a0,1
              addu d1,9   ;next line
              li   d0,20  ;reset xpos
          bgt  d1,200,@finished

@nolinefeed
              addu d3,-32
              beqz d3,@skipnull
              sll  d3,7    ;7=8x8  |9=16x16
              la   d5,raw8fonts
              addu d5,d3
              sw   d5,spritepointer
              sw   d0,xposition
              sw   d1,yposition
              sw   d0,-4(a8)
              sw   d1,-8(a8)
              sw   a0,-12(a8)

              jal  dosprite
              nop
              lw   d0,-4(a8)
              lw   d1,-8(a8)
              lw   a0,-12(a8)
@skipnull
              addu d0,8      ;next xpos

              b    @textloop
              nop
@finished      
              li   d0,20-10   ;xpos        ;draw the pointer
              li   d1,117  ;initial y
              sw   d0,xposition
              sw   d1,yposition
              la   a0,raw8fonts+(('>'-32)<<7)
              sw   a0,spritepointer
              jal  dosprite
              nop
     ;draw either yes or no
              la   a3,statTRN1
              li    d0,176     ;initial xpos
              li    d1,117  ;initial y
              lw    d7,option_position
              subu  d1,d7   ;move up  y

@statloop
              sw    d1,yposition
              lbu   d4,0(a3)
              addu  a3,1
              la    a0,strno
              beqz  d4,@itsno
              nop
              la    a0,stryes

@itsno
              lbu   d5,0(a0)
              addu  a0,1
              beq   d5,1,@finished1
              addu  d5,-32
              sll   d5,7    ;for 8x8
              la    a1,raw8fonts
              addu  a1,d5
              sw    a1,spritepointer
              sw    d0,xposition
              sw    d1,-4(a8)
              sw    a3,-8(a8)
              sw    a0,-12(a8)
              sw    d0,-16(a8)
              jal   dosprite
              nop
              lw    d1,-4(a8)
              lw    a3,-8(a8)
              lw    a0,-12(a8)
              lw    d0,-16(a8)
              addu  d0,8    ;next xpos
              b     @itsno
              nop
@finished1    li    d0,176  ;reset xpos
              addu  d1,9    ;next ypos
              la    a0,endstatTRN
              bne   a0,a3,@statloop
              nop
            lw  d0,option_num
            li  d1,9
            multu d0,d1
            mflo  d1      ;desired pos
            lw    d2,option_position  ;actual pos
            beq   d1,d2,@skip
            subu  d3,d1,d2
            bltzl  d3,@subpos
            addu  d2,-1
@subpos     bgtzl  d3,@addpos
            addu  d2,1
@addpos
            sw    d2,option_position
@skip

              lw   ra,0(a8)
              jr   ra
              nop

option_num dw 0
option_position: dw 0


traintxt:
          DB "LEVELS  UNLOCKED   ",1    
          DB "INFINITE HEALTH    ",1
          DB "INFINITE AMMO      ",1
          DB "  DESTOP-12/1/00   ",0
 CNOP 0,4
stryes: DB "YES",1
strno:  DB "NO",1
 cnop 0,4
