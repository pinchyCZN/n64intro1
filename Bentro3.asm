;command line: asm bentro3 send  base
 include regs.asm

vortexnumber = 400
cheatnumber EQU 3

drawcolor = 1   ;for drawing
printf = 1      ;dumper
base equ   $80310000  ;$80000400;
gamereturn equ $80000400

 org (base)  ;-$1000)
; DCB $1000,0
;   OPT M-   ;NO MACROS
    OPT W-   ;NO WARNINGS
    opt WS+  ;data spaces
 include "gfxdefs.asm"

    include macros.asm
    include staticm.asm

            
            jal     INITVID  ;initialize video screen
            nop
@wait2
                lw      t2,$A4600010
                andi    t2,3
                bnez    t2,@wait2

            LA      sp,STACK
            la      a8,stack-$400
            jal     storeint
            nop
        jal     ModikInit
        nop
        
;        jal     ModikStartPlay
        nop
        jal     createstaticlist
        nop
        jal     createvortexlist
        nop
        jal     RNDplot
        nop

        li      t0,MI_INTR_MASK_SET_VI  ;only catch vi int
;        sw      t0,MI_INTR_MASK_REG

        li      t0,(SR_IBIT3|SR_IE)
        mfc0    t1,C0_SR
        nop
        nop
        or      t1,t0
;        mtc0    t0,C0_SR
        nop




START:     
            jal Readcontroller1
            nop

START2:
            jal WTOF            ;wait TOF loop at Beginning
            nop


            jal swapframebuffers
            nop
        jal ADDz
        nop
           la   a0,texture|$A0000000
           li   d0,32*32/2
           li   d1,$185C185C
@clear
           sw   d1,0(a0)
           addu a0,4
           bnez d0,@clear
           addu d0,-1
        jal drawstars
        nop
        la  a0,Vadds
        jal addangles
        nop
        la    a0,Greensquare|$A0000000
        lw    d0,vortexmotion
        li    d1,40*2
        multu d0,d1
        mflo  d2
        addu  d2,2*1
        addu  a1,a0,d2
        li    d3,40-2
@loop1
        sh    r0,0(a1)
        addu  a1,2
        bnez  d3,@loop1
        addu  d3,-1

        li    d4,((240>>3)<<(1+5)) ;|1

        addu  d0,1
        beql  d0,40,@make00
        li    d0,0
@make00 sw    d0,vortexmotion
        li    d1,40*2
        multu d0,d1
        mflo  d2
        addu  d2,2*1
        addu  a1,a0,d2
        li    d3,40-2
@loop2
        sh    d4,0(a1)
        addu  a1,2
        bnez  d3,@loop2
        addu  d3,-1
        
        

                jal     readcontroller2
                nop
                jal     controller
                nop
                jal     moveletters
                nop

                la      a0,object1
                la      a1,matrix1
                jal     rotateobject
                nop

                la      a0,object2
                la      a1,matrix1+4*16*4
                jal     rotateobject
                nop

                la      a0,object3
                la      a1,matrix1+4*16*8
                jal     rotateobject
                nop
                la      a0,vortex_object
                la      a1,matrix1+4*16*12
                jal     rotateobject
                nop
            li   a1,$BFC007C0
            lh   d0,6(a1)
            move d1,d0
            sra  d0,8+2     ;l/r
            la   a0,vortex_object+2*3
            lh   d2,2(a0)   ;yaxis
            addu d2,d0
            andi d2,511
            sh   d2,2(a0)   ;yaxis
            lh   d3,0(a0)   ;xaxis
            sll  d1,24
            sra  d1,24+2    ;u/d
            addu d3,d1
            andi d3,511
            sh   d3,0(a0)   ;xaxis

          lw    d0,glistswap
          xor   d0,1
          sw    d0,glistswap
          la    a0,(RDP_start|$A0000000)+$80000
          beqz  d0,@swap1
          nop
          la    a0,(RDP_start|$A0000000)
@swap1    sw    a0,glistp
          sw    a0,glistp0



  gSegment             0,0,glistp 
  gDisplaylist         clearscreenDL,glistp

  gSetColorImage       frame2,glistp
  gFillRectangle       0, 0, 319, 239,glistp

  gNoOp                glistp
  gPipeSync            glistp
  gSetColorImage       Zimg,glistp
  gSetFillColor        (($3fff>>8)&%11111),(($3fff>>3)&%11111),(($3fff>>2)&%11111),1,glistp
;  gSetFillColor        0,0,0,0,glistp
  gFillRectangle       0, 0, 319, 239,glistp
  gNoOp                glistp
  gPipeSync            glistp
  gSetColorImage       frame2,glistp
  gSetDepthImage       Zimg,glistp

  gSetCycleType        G_CYC_2CYCLE,glistp
  G_RM_AA_XLU_SURF     1
  G_RM_AA_XLU_SURF     2     
  gRenderMode          glistp
  gTexture             $8000,$8000,0,0,G_ON,glistp

;  gTextureRectangle    40,40,32,32,glistp

  gPerspective          perspective,glistp

  G_RM_AA_XLU_SURF 1
  G_RM_AA_XLU_SURF 2     
  gRenderMode          glistp
  gMatrix               projmatrix,G_MTX_PROJECTION|G_MTX_LOAD|G_MTX_NOPUSH,glistp

  lw    d0,swaptvmode
  bnez  d0,@skipvortex

  gLoadTextureBlock greensquare,40,40,glistp
  gCLEARgeometrymode      (G_CULL_BACK),glistp
  gMatrix               matrix1+4*16*12,G_MTX_MODELVIEW|G_MTX_LOAD|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*13,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*14,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*15,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gDisplaylist         vortex_vertslist,glistp
@skipvortex

  gLoadTextureBlock Texture,32,32,glistp
  gSetGeometryMode     (G_SHADE|G_SHADING_SMOOTH|G_ZBUFFER|G_LIGHTING|G_CULL_BACK),glistp
  gMatrix               matrix1+4*16*8,G_MTX_MODELVIEW|G_MTX_LOAD|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*9,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*10,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*11,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gDisplaylist         c_vertslist,glistp

  gMatrix               matrix1+4*16*4,G_MTX_MODELVIEW|G_MTX_LOAD|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*5,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*6,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*7,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gDisplaylist         z_vertslist,glistp

  gMatrix               matrix1,G_MTX_MODELVIEW|G_MTX_LOAD|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*2,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gMatrix               matrix1+4*16*3,G_MTX_MODELVIEW|G_MTX_MUL|G_MTX_NOPUSH,glistp
  gDisplaylist         n_vertslist,glistp
  

  gSpriteInit          glistp

  gSetPrimcolor 255,255,255,255,glistp

  lw    d0,text_Z
  li    d1,$40
  multu d0,d1
  mflo  d1
  addu  d1,$10000
  sw    d1,fontscale

  addu  d0,25
  bgtz  d0,@skipadd
  sw    d0,text_Z
  b     @skipwait

@skipadd
  lw    d2,text_wait
  addu  d2,1
  sw    d2,text_wait
  lbu   d5,textfade1
  sll   a0,d5,24
  sll   d4,d5,16
  or    a0,d4
  sll   d3,d5,8
  or    a0,d3
  or    a0,d5
  addu  d5,-2
  sb    d5,textfade1
  sw    d0,0(a8)
                lw      a1,glistp
                jal     DPsetprimcolor
                nop
                sw      a1,glistp
  lw    d0,0(a8)



  bne   d2,74,@skipwait  ;@waitup
  li    d3,-$400
  sw    d3,text_Z
  lw    d4,varioustext
  addu  d4,22
  sw    d4,varioustext
  la    d5,endgreets
  sw    r0,text_wait
  li    d2,255
  sb    d2,textfade1
  bne   d4,d5,@skipwait
  la    d5,greets
  sw    d5,varioustext
@skipwait

  li    d2,10
  div   d0,d2
  mflo  d2
  addu  d1,d2,210


  li    d4,-7
  div   d0,d4
  mflo  d0
  addu  d0,18

;  li    d0,20
;  li    d1,210
  lw    a0,varioustext
  jal   placetext
  nop

  gSetPrimcolor 255,255,255,255,glistp
  jal  showoptions
  nop



  gFullSync            glistp
  gEndDisplayList      glistp

           lw   d0,glistp
           lw   d1,glistp0
           subu d2,d0,d1
           la   a0,(GFXtask+$30)|$A0000000
           sw   d1,0(a0)
           sw   d2,4(a0)
           cache $10,0(a0)
           cache $10,4(a0)

;           sw   d0,memory+$10*3+3*4

           lw   a0,glistp
           addu a0,-9000
           li   d0,9000
@cacheloop1
;           cache $10,0(a0)
;           addu a0,4
;           sync
;           bnez d0,@cacheloop1
;           addu d0,-4

        lw      d0,swaptvmode
        bnez    d0,@skipmod
        nop
        jal updatemod
        nop

@skipmod
           jal dorsp
           nop



 if (printf=0)

            lw d0,watchpoint
            sw   d0,memory+$10*3+3*4

            jal cursor2
            nop
            jal cursor
            nop
            jal showmem
            nop
            jal peekmem
            nop
            jal showloc
            nop
            jal showposit
            nop
            jal tellstatus
            nop
 endif

             j start
             nop
;--------------------------------------------------------------
EXIT:
            la    a0,TRAINN
            la    a2,TRAINNEND
            li    a1,$A0000180
@storetrain: lw    d1,0(a0)
            sw    d1,0(a1)
            addiu a1,a1,4
            bne   a0,a2,@storetrain
            addiu a0,a0,4

;*******KIL CERTAIN OPTIONS************
        la   a0,statTRN1
        la   a1,trainpointers
        li   d7,cheatnumber-1
@loopy
        lbu  d0,0(a0)
        addu a0,1
        bnez d0,@itsok
        lw   a4,0(a1)
        sw   r0,0(a4)
@itsok  addu a1,4
        bnez d7,@loopy
        addu d7,-1
;----------------------------

        lw   a0,$A0000300
        beq  a0,1,@ntscmode
        li   d1,1
        sw   d1,$A0000300
@ntscmode

        sw      r0,$A00a9240    ;disable mtc0 watchlo

        ori     t0,r0,$189   ;1+$00000188
        mtc0    t0,r18
        nop
        li      t0,$800d7050 ;twine
        li      t1,$00040000 ;
        li      at,GAMERETURN+$c
        jr      at
        nop
statTRN1:
 REPT  CHEATNUMBER
 DB 1
 ENDR
endstatTRN
 cnop 0,4
trainpointers
 DW TRAIN1+4,TRAIN2+4,TRAIN3+4
 cnop 0,4
  
temp:   dw 0
temp3:  DW vortex_object          ;where to look at
temp4:  DW vortex_object ;            ;RDP_start 
xstat: DW 0        ;0=peek memory 1=poke memory
alternate: DW 1
position1:  DW 0
position2: DW 0
color:   DW $1E00
color2:  DW $1E00
joypad: DW 0
statusreg: dw 0
glistp0:        dw RDP_start|$A0000000
glistp:         dw RDP_start|$A0000000
glistswap       dw 0

vortexmotion dw 0
swaptvmode: dw 0


watchpoint: dw 0


WTOF:
               lui     a0,$A440     ;wait for TOF
               lw      d1,$10(a0)
               ADDIU   d0,r0,$00
               bne    d0,d1,WTOF
               nop

               jr      ra
               nop
vblankdone: dw 0


rotateobject:
                ;a0=object
                ;a1=matrix
                or      a1,$A0000000
                lh      t0,0(a0)
                sh      t0,12*2(a1)
                lh      t1,2(a0)
                sh      t1,13*2(a1)
                lh      t2,4(a0)
                sh      t2,14*2(a1)


                addu    a1,32*2
                addu    a0,3*2
                la      a2,sintable
                la      a3,sintable+(128*4)
;x axis
                lh      t0,0(a0)        ;x
                andi    t0,$1ff
                sll     t0,2
                addu    a4,t0,a2
                lw      t1,0(a4)        ;sin
                srl     t3,t1,16
                sh      t3,6*2(a1)
                sh      t1,16*2+6*2(a1)
                negu    t1
                srl     t4,t1,16
                sh      t4,9*2(a1)
                sh      t1,16*2+9*2(a1)

                addu    a5,t0,a3
                lw      t2,0(a5)        ;cos
                srl     t3,t2,16
                sh      t3,5*2(a1)
                sh      t2,16*2+5*2(a1)
                sh      t3,10*2(a1)
                sh      t2,16*2+10*2(a1)

                addu    a1,32*2
;y axis
                lh      t0,2(a0)
                andi    t0,$1ff
                sll     t0,2
                addu    a4,a2,t0
                lw      t1,0(a4)        ;sin
                srl     t2,t1,16

                sh      t2,8*2(a1)
                sh      t1,16*2+8*2(a1)
                negu    t1
                srl     t2,t1,16
                sh      t2,2*2(a1)
                sh      t1,16*2+2*2(a1)
                addu    a4,a3,t0        ;cos
                lw      t1,0(a4)
                srl     t2,t1,16
                sh      t2,0(a1)
                sh      t1,16*2(a1)
                sh      t2,10*2(a1)
                sh      t1,16*2+10*2(a1)

                addu    a1,32*2
;z-axis
                lh      t0,4(a0)
                andi    t0,$1ff
                sll     t0,2
                addu    a4,a2,t0        ;sin
                lw      t1,0(a4)
                srl     t2,t1,16
                sh      t2,1*2(a1)
                sh      t1,16*2+1*2(a1)
                negu    t1
                srl     t3,t1,16
                sh      t3,4*2(a1)
                sh      t1,16*2+4*2(a1)
                addu    a4,a3,t0
                lw      t2,0(a4)
                srl     t3,t2,16
                sh      t3,0(a1)
                sh      t2,16*2(a1)
                sh      t3,5*2(a1)
                sh      t2,16*2+5*2(a1)
       ;--update rotas
                li      d8,3-1
@here
                lh      t0,0(a0)
                lh      t1,3*2(a0)
                addu    t0,t1
                andi    t0,$1ff
                sh      t0,0(a0)
                addu    a0,2
                bnez    d8,@here
                addu    d8,-1
                jr      ra
                nop







perspective: dw $11

 include musak1.asm
 include rdp.asm
 include controller.asm
; include dumper.asm
 include effects.asm
 include sprite3.asm
 include stars.asm
 include text.asm
 include RSP3d.asm
 include inits.asm
 include trainn.asm

 include c.asm
 include z.asm
 include n.asm
 include vortex1.asm

  cnop 0,8
clearscreenDL:
  gsViewport            Viewport
  gsCleargeometryMode   (G_SHADE|G_SHADING_SMOOTH|G_CULL_BOTH|G_FOG|G_LIGHTING|G_TEXTURE_GEN|G_TEXTURE_GEN_LINEAR|G_LOD)
  gsTexture             0,0,0,0,G_OFF
  gsSetGeometryMode     (G_SHADE|G_SHADING_SMOOTH|G_ZBUFFER|G_LIGHTING)
  gsSetCycleType        G_CYC_1CYCLE
  gsPipelineMode        G_PM_1PRIMITIVE
  gsSetScissor          0, 0, 320, 240
  gsTextureLOD          G_TL_LOD
  gsTextureLUT          G_TT_NONE
  gsTextureDetail       G_TD_CLAMP
  gsTexturePersp        G_TP_PERSP
  gsTextureFilter       G_TF_BILERP
  gsTextureConvert      G_TC_FILT
  gsCombineKey          G_CK_NONE
  gsAlphaCompare        G_AC_NONE
  gsColorDither         G_CD_ENABLE
  gsSetLights1          lights
  gsCombineMode         \G_CC_TRILERP\,\G_CC_MODULATEI2\
  gsPipeSync            
  gsSetCycleType        G_CYC_FILL
  G_RM_OPA_SURF        1
  G_RM_OPA_SURF        2
  gsRenderMode          
  gsSetFillColor        0,0,0,1
  gsenddisplaylist


 cnop 0,8
PROJMATRIX:
        DW        0x00010000, 0x00000000
        DW        0x00000002, 0x00000000
        DW        0x00000000, 0xFFFEFFFF
        DW        0x00000000, 0xFF350000
 ;       /* fractional portion: */
        DW        0xCF870000, 0x00000000
        DW        0x00006A09, 0x00000000
        DW        0x00000000, 0xF9150000
        DW        0x00000000, 0x4C1C0000

MATRIX1:
   rept 4
        DW        0x00010000, 0x00000000
        DW        0x00000001, 0x00000000
        DW        0x00000000, 0x00010000
        DW        0x00000000, 0x00000001
 ;       /* fractional portion: */
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
;MATRIX2:
        DW        0x00010000, 0x00000000
        DW        0x00000001, 0x00000000
        DW        0x00000000, 0x00010000
        DW        0x00000000, 0x00000001
 ;       /* fractional portion: */
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
;MATRIX4:
        DW        0x00010000, 0x00000000
        DW        0x00000001, 0x00000000
        DW        0x00000000, 0x00010000
        DW        0x00000000, 0x00000001
 ;       /* fractional portion: */
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
;MATRIX5:
        DW        0x00010000, 0x00000000
        DW        0x00000001, 0x00000000
        DW        0x00000000, 0x00010000
        DW        0x00000000, 0x00000001
 ;       /* fractional portion: */
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
        DW        0x00000000, 0x00000000
 CNOP 0,8
 endr

 cnop 0,4
object1:
         dh 20,20,-3700      ;x,y,z
         dh 0,0,0       ;rotations
         dh 2,0,0

object2:
         dh 120,120,-3720       ;x,y,z
         dh 0,0,0       ;rotations
         dh 0,-2,0
object3:
         dh 220,220,-3720       ;x,y,z
         dh 0,0,0       ;rotations
         dh 0,3,0

         dcb 32,0

vortex_object
         dh 220,220,0       ;x,y,z
         dh 0,0,0       ;rotations
         dh 0,0,3

 cnop 0,4
sintable:
 include "32sin.asm"

 cnop 0,8
fonts1:
 incbin font16nn.aa






 cnop 0,8
Texture:
  dcb 32*32*2,0

 cnop 0,8
Greensquare
 incbin square.raw

 cnop 0,8
raw8fonts:
 incbin c64font1.til
 cnop 0,8

 obj *|$A0000000
modikbuffer
 objend

 obj $8036A000
stack
 objend

 obj $80170000
 CNOP 0,8
RDP_start:
 objend

 obj $80130000
c_vertslist
 objend
 obj $80140000
n_vertslist
 objend
 obj $80150000
z_vertslist
 objend
 obj $80160000
vortex_vertslist
 objend
