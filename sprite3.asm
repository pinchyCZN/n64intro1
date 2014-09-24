
dosprite:  

               la     a0,width
               li     d3,2
checkagain
               lw     d0,0(a0)    ;width
               lw     d1,8(a0)    ;xposition
               lw     d2,16(a0)   ;xscale
               blez   d2,nosprite
               multu  d2,d0        ;xscale*width
               mflo   d2
               sra    d2,16        ;scaled width
               addu   d8,d1,d2     ;xpos+scaledwidth
               blez   d8,nosprite
               lw     d6,24(a0)      ;maxscreen
               subu   d9,d6,d1       ;-position
               blez   d9,nosprite
               addiu  d3,-1
               bgtz   d3,checkagain   ;check y vales
               addu   a0,4


               lw     a0,glistp
               lw     d0,width
               lw     a6,spritepointer
               lw     a5,oldtexture
               sw     a6,oldtexture
;               beq    a5,a6,sametexture

               li      d8,$FD100000 ;setTimg
               sw      d8,0(a0)
               sw      a6,4(a0)
                addiu   a0,a0,8
               li      d8,$F5100000  ;SetTile
               sw      d8,0(a0)
               li      d7,$00080200  ;0
               sw      d7,4(a0)
                addiu   a0,a0,8
               li      d8,$E6000000  ;RDPLoadSync
               sw      d8,0(a0)
               sw      r0,4(a0)
                addiu   a0,a0,8
               li      d8,$F3000000
               sw      d8,0(a0)


               li      d7,$007FF000 ;077ff
               srl     d6,d0,2     ;width/4
               beql    d6,r0,@make1
               li      d6,1
@make1:        addiu   d8,d6,2048-1
               divu    d8,d6
               mflo    d8
               or      d7,d7,d8
               sw      d7,4(a0)      ;LoadBlock
                addiu   a0,a0,8
               li      d8,$E7000000  ;RDPPipesync
               sw      d8,0(a0)
               sw      r0,4(a0)
                addiu   a0,a0,8
               li      d8,$F5100000
               srl     d7,d0,2         ;width/4
               sll     d7,d7,9         ;<<9
               or      d8,d8,d7
               sw      d8,0(a0)
               li      d7,$00080200  
               sw      d7,4(a0)        ;SetTile
                addiu   a0,a0,8
               li      d8,$F2000000
               sw      d8,0(a0)
               addiu   d7,d0,-1        ;(width-1)*4
               sll     d7,d7,2+12
               lw      d1,height
               addu    d1,-1
               sll     d1,2            ;(height-1)*4
               or      d7,d7,d1
               sw      d7,4(a0)
                addiu   a0,a0,8


sametexture:
               li      d8,$E4000000    ;TextREct
               lw      d0,width
               lw      d1,xscale
               lw      d2,xposition
               multu   d0,d1
               mflo    d1
               sra     d1,16      ;scaled width
               addu    d7,d1,d2   ;scaledwidth+xpos
               lw      d6,maxscreenwidth
               subu    d3,d6,d7   ;maxscreen-xend
               bltzl   d3,@no_adjustwidth
               move    d7,d6
@no_adjustwidth:
               andi    d7,d7,$3FF      ;weed out shit
               sll     d7,d7,14        ;xend
               or      d8,d8,d7



               lw      d0,height
               lw      d1,yscale
               lw      d2,yposition
               multu   d1,d0
               mflo    d1         ;scaled height
               sra     d1,16
               addu    d7,d1,d2   ;scaled height+ypos
               lw      d6,maxscreenheight

               subu    d3,d6,d7
               bltzl   d3,@no_adjustyend
               move    d7,d6
@no_adjustyend:
               andi    d7,$3FF
               sll     d7,2
               or      d8,d8,d7
               sw      d8,0(a0)   ;$E4|xend|yend



               lw      d0,xposition
               lw      d1,yposition
               bltzl   d0,@makexpos0
               move    d0,r0
@makexpos0     bltzl   d1,@makeypos0
               move    d1,r0
@makeypos0     sll     d0,d0,14
               sll     d1,d1,2
               or      d8,d1,d0
               sw      d8,4(a0)   ;xstart|ystart

               lw      d0,xposition
               lw      d1,yposition
               bgezl   d0,@no_xposfix
               move    d6,r0
               negu    d6,d0
               sll     d6,d6,(16+5)  ;image shift
               lw      d2,xscale
               divu    d6,d2
               mflo    d6
               sll     d6,d6,16
@no_xposfix
               bgezl   d1,@no_yposfix
               nop     
               negu    d5,d1
               sll     d5,(16+5)
               lw      d3,yscale
               divu    d5,d3
               mflo    d5
               or      d6,d5
@no_yposfix
               li      d7,(G_RDPHALF_1<<24)
               sw      d7,8(a0)
               sw      d6,12(a0) ;image shift
;               sw      r0,12(a0) ;image shift
               
               lw      d0,xscale
               li      d7,$04000000
               divu    d7,d0      ;$04000000/ above#
               mflo    d9
               nop
               lw      d1,yscale
               sll     d8,d9,16
               nop
               divu    d7,d1
               mflo    d9

               li      d0,(G_RDPHALF_2<<24)
               sw      d0,16(a0)
               or      d8,d8,d9
               sw      d8,20(a0)  ;xscale|yscale
               li      d7,$E7000000
               sw      d7,24(a0)
               sw      r0,28(a0)
                addiu   a0,a0,32

               sw      a0,glistp
nosprite:
               jr ra
               nop






spritepointer: dw 100
width: DW 32
height:  DW 32
xposition: dw 0
yposition: dw 90
xscale: DW $10000
yscale: DW $10000
maxscreenwidth: dw 320
maxscreenheight: dw 240

oldtexture: dw 0
