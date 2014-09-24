
SPsegment       li      t0,$BC000000    ;a0=base  a1=segment a3=glist
                sll     a1,2+8
                or      t0,a1
                or      t0,$06     ;G_MW_SEGMENT
                sw      t0,0(a3)
                andi    a0,$FFFFFF
                sw      a0,4(a3)
                addu    a3,8
                jr      ra
                nop

SPviewport:     li      t0,$03000000    ;a0=viewport    a1=glist
                or      t0,$80<<16
                or      t0,$10
                sw      t0,0(a1)
                andi    a0,$FFFFFF
                sw      a0,4(a1)
                addu    a1,8
                jr      ra
                nop

DPsetscissor    li      t0,G_SETSCISSOR<<24
                sll     a0,12
                or      t0,a0
                or      t0,a1
                sw      t0,0(a4)
                sll     a2,12
                or      a2,a3
                sw      a2,4(a4)
                addu    a4,8
                jr      ra
                nop

DPsetfillcolor
                li      t0,G_SETFILLCOLOR<<24
                sw      t0,0(a1)
                sw      a0,4(a1)
                addu    a1,8
                jr      ra
                nop

DPfillrectangle
                li      t0,G_FILLRECT<<24
                sll     a2,14
                or      t0,a2
                sll     a3,2
                or      t0,a3
                sw      t0,0(a4)
                sll     a0,14
                sll     a1,2
                or      a0,a1
                sw      a0,4(a4)
                addu    a4,8
                jr      ra
                nop

DPsetColorImage
                li      t0,(G_SETCIMG<<24)|(G_IM_FMT_RGBA<<21)|(G_IM_SIZ_16b<<19)|$13F
                sw      t0,0(a1)
                sw      a0,4(a1)
                jr      ra
                addu    a1,8


DPsetdepthimage
                li      t0,(G_SETZIMG<<24)
                sw      t0,0(a1)
                sw      a0,4(a1)
                jr      ra
                addu    a1,8


DPloadTextureBlock
                li      t0,(G_SETTIMG<<24)|(G_IM_FMT_RGBA<<21)|(G_IM_SIZ_16b<<19)
                sw      t0,0(a3)
                sw      a0,4(a3)

                li      t2,(G_SETTILE<<24)|(G_IM_FMT_RGBA<<21)|(G_IM_SIZ_16b<<19)
                sw      t2,8(a3)
                li      t3,(G_TX_LOADTILE<<24)
                sw      t3,12(a3)

                li      t4,G_RDPLOADSYNC<<24
                sw      t4,16(a3)
                sw      r0,20(a3)

                li      t4,G_LOADBLOCK<<24
                sw      t4,24(a3)
                multu   a1,a2
                mflo    t0
                li      t1,G_TX_LOADTILE<<24
;                addu    t0,G_IM_SIZ_16b_INCR
;                srl     t0,G_IM_SIZ_16b_SHIFT
                addu    t0,-1
                andi    t0,$FFF
                sll     t0,12
                or      t1,t0

                li      t2,(1<<G_TX_DXT_FRAC)
                sll     t3,a1,1
                srl     t3,3    ;TXL2WRDS
                beqzl   t3,@here
                li      t3,1
@here           addu    t2,t3
                addu    t2,-1
                divu    t2,t3
                mflo    t2
                or      t1,t2
                sw      t1,28(a3)

                li      t0,G_RDPPIPESYNC<<24
                sw      t0,32(a3)
                sw      r0,36(a3)

                li      t1,(G_SETTILE<<24)|(G_IM_FMT_RGBA<<21)|(G_IM_SIZ_16b<<19)
                sll     t2,a1,1
                addu    t2,7
                srl     t2,3
                sll     t2,9
                or      t1,t2
                sw      t1,40(a3)
                li      t0,(G_TX_RENDERTILE<<24)
                sw      t0,44(a3)

                li      t1,(G_SETTILESIZE<<24)
                sw      t1,48(a3)
                li      t2,G_TX_RENDERTILE<<24
                addu    t3,a1,-1
                sll     t3,G_TEXTURE_IMAGE_FRAC+12
                addu    t4,a2,-1
                sll     t4,G_TEXTURE_IMAGE_FRAC
                or      t2,t3
                or      t2,t4
                sw      t2,52(a3)
                addu    a3,56
                jr      ra
                nop

SPtexturerectangle
                li      t0,G_TEXRECT<<24
                addu    a2,a0
                addu    a3,a1
                sll     a0,2+12
                sll     a1,2
                sll     a2,2+12
                sll     a3,2
                or      a2,a3
                or      t0,a2
                sw      t0,0(a4)
                or      a0,a1
                or      a0,(G_TX_LOADTILE<<24)
                sw      a0,4(a4)
                li      t1,(G_RDPHALF_1<<24)
                sw      t1,8(a4)
                sw      r0,12(a4)
                li      t2,(G_RDPHALF_2<<24)
                sw      t2,16(a4)
                li      t3,$04000400
                sw      t3,20(a4)
                addu    a4,24
                jr      ra
                nop


DPsetprimcolor  li      t0,G_SETPRIMCOLOR<<24
                sw      t0,0(a1)
                sw      a0,4(a1)
                jr      ra
                addu    a1,8

DPsetenvcolor  li      t0,G_SETENVCOLOR<<24
                sw      t0,0(a1)
                sw      a0,4(a1)
                jr      ra
                addu    a1,8
DPsetblendcolor  li      t0,G_SETBLENDCOLOR<<24
                sw      t0,0(a1)
                sw      a0,4(a1)
                jr      ra
                addu    a1,8
DPsetfogcolor   li      t0,G_SETFOGCOLOR<<24
                sw      t0,0(a1)
                sw      a0,4(a1)
                jr      ra
                addu    a1,8






Spmatrix        li      t0,$01000000    ;a0=matrixaddress a1=parameters a2= glist  
                or      t0,$40  ;size of matrix
                andi    a1,$FF
                sll     a1,16
                or      t0,a1
                sw      t0,0(a2)
                andi    a0,$FFFFFF
                sw      a0,4(a2)
                addu    a2,8
                jr      ra
                nop

SPlights1       li      t0,(G_MOVEWORD<<24)|(G_MWO_NUMLIGHT<<8)|(G_MW_NUMLIGHT)
                sw      t0,0(a1)
                li      t1,(((1)+1)*32+0x80000000)
                sw      t1,4(a1)
                li      t2,(G_MOVEMEM<<24)|((((1)-1)*2+G_MV_L0)<<16)|(4*4)
                sw      t2,8(a1)
                addu    t3,a0,8
                andi    t3,$FFFFFF
                sw      t3,12(a1)

                li      t4,(G_MOVEMEM<<24)|((((2)-1)*2+G_MV_L0)<<16)|(4*4)
                sw      t4,16(a1)
                addu    t5,a0,0
                andi    t5,$FFFFFF
                sw      t5,20(a1)
                addu    a1,24
                jr      ra
                nop




SPvertex:       li      t0,$04000000    ;a0=address,a1=number vertices,a2=index a4=glispt
                sll     t2,a1,4
                or      t0,t2
                addu    t1,a1,-1
                sll     t1,4
                or      t1,a2
                sll     t1,16
                or      t0,t1
                sw      t0,0(a4)
                sw      a0,4(a4)
                jr      ra
                addu    a4,8

SPtri1:         li      t0,$BF000000    ;a0=v1, a1=v2 a2=v3 a3=flag a4=glist
                li      t1,10
                multu   a0,t1
                mflo    a0
                sw      t0,0(a4)
                li      t2,0
                sll     a0,16
                multu   a1,t1
                or      t2,a0
                mflo    a1
                sll     a1,8
                or      t2,a1
                multu   a2,t1
                mflo    a2
                or      t2,a2
                sw      t2,4(a4)
                jr      ra
                addu    a4,8

SPTexture:      li      t0,$BB000000
                ;a0=s  a1=t
                ;a2=level  a3=tile
                ;a4=G_ON   a5=glistp
                sll     a2,11
                or      t0,a2
                sll     a3,8
                or      t0,a3
                or      t0,a4
                sw      t0,0(a5)
                sll     a0,16
                andi    a1,$0000FFFF
                or      a0,a1
                sw      a0,4(a5)
                addu    a5,8
                jr      ra
                nop
SPperspective   li      t0,$BC000000    ;a0=perspective a1=glistp
                or      t0,$0E          ;g_perspnrom
                sw      t0,0(a1)
                sw      a0,4(a1)
                addu    a1,8
                jr      ra
                nop
Setothermode:   ;a0=cmd  a1=sft a2=len  a3=data a4=glist
                sll     a0,24
                sll     a1,8
                or      a0,a1
                or      a0,a2
                sw      a0,0(a4)
                sw      a3,4(a4)
                addu    a4,8
                jr      ra
                nop
DPpipeline      ;a0=pipeline,a1=glist
                move    a3,a0
                move    a4,a1
                li      a0,$BA
                li      a1,23   ;pipemode
                li      a2,1
                b       Setothermode
                nop
DPcycletype     ;a0=type  a1=glist
                move    a3,a0
                move    a4,a1
                li      a0,$BA
                li      a1,20    ;cylce
                li      a2,2
                b       Setothermode
                nop
DPtexturepersp  ;a0=type a1=glistp
                move    a3,a0
                move    a4,a1
                li      a0,G_SETOTHERMODE_H
                li      a1,G_MDSFT_TEXTPERSP
                li      a2,1
                b       Setothermode
                nop
DPtexturedetail
                move    a3,a0
                move    a4,a1
                li      a0,G_SETOTHERMODE_H
                li      a1,G_MDSFT_TEXTDETAIL
                li      a2,2
                b       Setothermode
                nop
DPtextureLOD    move    a3,a0
                move    a4,a1
                li      a0,G_SETOTHERMODE_H
                li      a1,G_MDSFT_TEXTLOD
                li      a2,1
                b       Setothermode
                nop
DPtextureLUT    move    a3,a0
                move    a4,a1
                li      a0,G_SETOTHERMODE_H
                li      a1,G_MDSFT_TEXTLUT
                li      a2,2
                b       Setothermode
                nop
DPtexturefilter
                move    a3,a0
                move    a4,a1
                li      a0,G_SETOTHERMODE_H
                li      a1,G_MDSFT_TEXTFILT
                li      a2,2
                b       Setothermode
                nop

DPtextureconvert 
                move    a3,a0
                move    a4,a1
                li      a0,G_SETOTHERMODE_H
                li      a1,G_MDSFT_TEXTCONV
                li      a2,3
                b       Setothermode
                nop

DPcombinekey
                move    a3,a0
                move    a4,a1
                li      a0,G_SETOTHERMODE_H
                li      a1,G_MDSFT_COMBKEY 
                li      a2,1
                b       Setothermode
                nop

DPcolordither  
                move    a3,a0
                move    a4,a1
                li      a0,G_SETOTHERMODE_H
                li      a1,G_MDSFT_COLORDITHER
                li      a2,2
                b       Setothermode
                nop

DPalphacompare 
                move    a3,a0
                move    a4,a1
                li      a0,G_SETOTHERMODE_L
                li      a1,G_MDSFT_ALPHACOMPARE
                li      a2,2
                b       Setothermode
                nop
DPalphadither  
                move    a3,a0
                move    a4,a1
                li      a0,G_SETOTHERMODE_H
                li      a1,G_MDSFT_ALPHADITHER
                li      a2,2
                b       Setothermode
                nop

DPsetrendermode:        ;a0=mode1|mode2 a2=glistp
                move    a3,a0
                move    a4,a2
                li      a0,G_SETOTHERMODE_L
                li      a1,G_MDSFT_RENDERMODE
                li      a2,29
                b       Setothermode
                nop



DPCombineLerp
                li      t0,G_SETCOMBINE<<24
                or      t0,a0
                sw      t0,0(a2)
                sw      a1,4(a2)
                addu    a2,8
                jr      ra
                nop





SPclearGeometrymode:
                ;a0=modes to clear, a2=glistp
                li      t0,$B6000000
                sw      t0,0(a2)
                sw      a0,4(a2)
                addu    a2,8
                jr      ra
                nop
SPsetGeometrymode:
                ;a0=modes to set, a2=glistp
                li      t0,$B7000000
                sw      t0,0(a2)
                sw      a0,4(a2)
                addu    a2,8
                jr      ra
                nop
SPendDisplaylist:                ;a2=glistp
                li      t0,$B8000000
                sw      t0,0(a2)
                sw      r0,4(a2)
                addu    a2,8
                jr      ra
                nop

SPdisplaylist   li      t0,(G_DL<<24)|(G_DL_PUSH<<16)
                sw      t0,0(a1)
                andi    a0,$FFFFFF
                sw      a0,4(a1)
                addu    a1,8
                jr      ra
                nop

                


DOrsp
                sw      ra,0(a8)
                li      a0,SP_CLR_SIG0|SP_CLR_SIG1|SP_CLR_SIG2 ;$2B00
;                jal     SPsetSTATUS
                nop
                li      a0,$04001000
                jal     SPsetPC
                nop
                la      a1,GFXtask
                li      a0,$04000FC0 ;rspdest
                li      a2,$40       ;size
                li      a3,1         ;rdram->rsp
                jal     SPrawDMA
                nop
                jal     SPdeviceBUSY
                nop
                la      t0,GFXtask    
                lw      a1,8(t0)     ;a1 rsp
                li      a0,$04001000 ;rsp
                lw      a2,8+4(t0)   ;size
                li      a3,1         ;rdram->rsp
                jal     SPrawDMA
                nop

                ;taskstartgo
                jal     SPdeviceBusy
                nop
  if (1=0)
        li      d1,1
        lw      d2,doit1
        blt     d2,1,@here3
@here2
        lw      a0,VI_ORIGIN_REG
        or      a0,$A0000000
        sw      a0,frame2
        li      d0,320*240
@loopclear
        sh      d1,0(a0)
        addu    a0,2
        bnez    d0,@loopclear
        addu    d0,-1
        lw      d3,SP_STATUS_REG
        sw      d3,memory
            jal showmem
            nop
@here4
        lw      d2,doit1
        bgt     d2,0,@here4
        li      d1,1
@here3  addu    d2,1
        sw      d2,doit1
  endif
                li      a0,$25
                jal     SPsetSTATUS
                nop

                lw      ra,0(a8)
                jr      ra
                nop
doit1 dw 0






SPsetSTATUS:
                sw      a0,$A4040010
                jr      ra
                nop
SPsetPC:        li      a1,$A4040010
                lw      t0,0(a1)
                andi    t0,1
                beqz    t0,SPsetPC
                nop
                sw      a0,$a4080000
                jr      ra
                nop
SPdeviceBUSY    lw      t0,$A4040010
                andi    t0,$1C
                bnez    t0,SPdeviceBUSY
                nop
                jr      ra
                nop

SPrawDMA        li      t0,$A4040000    ;a3=1 then rdram->rsp
                sw      a0,0(t0)        ;rsp dest     ;a0
                sw      a1,4(t0)        ;rdram source ;a1
                beqzl   a3,@RSP_DRAM
                sw      a2,$C(t0)       ;size   ;a2
                sw      a2,8(t0)
@RSP_DRAM       jr      ra
                nop

 cnop 0,8
GFXtask:
                dw 1    ;M_GFXTASK      ;$C0
                dw 0    ;flags		;$C4
	
                dw RSPboot		;$C8
                dw $d0    ;bootsize	;$CC

                dw FAST3dTEXT		;D0
                dw 4096			;D4

                dw FAST3dDATA		;D8
                dw 2048			;DC

                dw rspdrambuf		;E0
                dw 1024			;E4

                dw 0  ;outputbuf	;E8
                dw 0			;EC

                dw RDP_start		;F0        ;$30
                dw 0    ;$34		;F4

                dw 0  ;yeild		;F8
                dw 0			;FC

        cnop 0,8
FAST3dDATA:
        incbin gfast3ddata.bin

        cnop 0,8
FAST3dTEXT:
        incbin gfast3dtext.bin

        cnop 0,8
RSPboot:
        incbin rspboot.bin
RSPbootEND:

        cnop 0,8
rspdrambuf dcb 1024,0

 cnop 0,8
SEGMENT1:
Viewport: dh 320/2*4,240/2*4,$3ff,0,320/2*4,240/2*4,0,0
Lights:   dw $64646400,$64646400,$FFFFFF00,$FFFFFF00
          dw $A6005A00,$00000000      

                
spinitdata:
        DW      $E7000000,0
        DW      $BA001402,0
        DW      $BB000001,$80008000
        DW      $B9000002,0
        DW      $BA001301,0
        DW      $BA000C02,$00002000
        DW      $BA000903,$00000C00
        DW      $BA001102,0
        DW      $BA001001,0
        DW      $BA000E02,0
        DW      $B900031D,$0F0A7008
        DW      $B7000000,$00020205
        DW      $FA000000,$FFFFFFFF
        DW      $FC11FE23,$FFFFF3F9
        gsEndDisplayList
ENDSPINITDATA:
