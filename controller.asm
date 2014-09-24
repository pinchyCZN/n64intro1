controller:
            sw      ra,-4(a8)

            lui     a0,$BFC0
;            lbu     d1,$7FF(a0)
;            bne     d1,1,nosystem_reset
;            nop
;            j       system_reset
            nop
nosystem_reset
            lhu     d0,$7c4(a0)   ;pif2+4
            lhu     d4,oldjoy
            beq     d0,d4,butt9
            nop
            bne     d0,CONT_START,butt2
            nop
            j       EXIT
            nop
butt2       andi    d1,d0,CONT_DOWN
            beqz    d1,butt3
            nop
            lw      d2,option_num
            addu    d2,1
            li      d3,cheatnumber
            beq     d3,d2,exitcont
            sw      d2,option_num
butt3       andi    d1,d0,CONT_UP
            beqz    d1,butt4
            nop
            lw      d2,option_num
            addu    d2,-1
            bltz    d2,exitcont
            sw      d2,option_num
butt4       andi    d1,d0,CONT_A
            beqz    d1,butt5   ;no
            nop
            lw      d2,option_num
            la      a0,statTRN1
            addu    a0,d2
            sb      r0,0(a0)
butt5       andi    d1,d0,CONT_B
            beqz    d1,BUTT6   ;yes
            NOP
            lw      d2,option_num
            la      a0,statTRN1
            addu    a0,d2
            li      d3,1
            sb      d3,0(a0)
butt6       andi    d1,d0,CONT_LEFT
            beqz    d1,butt7  ;no
            nop
            lw      d2,option_num
            la      a0,statTRN1
            addu    a0,d2
            sb      r0,0(a0)
butt7       andi    d1,d0,CONT_RIGHT
            beqz    d1,butt8  ;yes
            nop
            lw      d2,option_num
            la      a0,statTRN1
            addu    a0,d2
            li      d3,1
            sb      d3,0(a0)
butt8       andi    d1,d0,CONT_Z
            beqz        d1,butt9
            lw      d2,swaptvmode
            xori    d2,1                ;1=ntsc
            sw      d2,swaptvmode
            addu    d2,-1               ;>=0 =ntsc
            bgezal  d2,ntsc_init
            lui     a0,$A440
            bltzal  d2,pal_init
            nop

butt9           andi    d1,d0,CONT_CUP
                beqz    d1,butt10
            lh  d3,vortex_object+(2*2)
            addu        d3,100
            sh  d3,vortex_object+(2*2)

butt10           andi    d1,d0,CONT_CDOWN
                beqz    d1,butt11
            lh  d3,vortex_object+(2*2)
            addu        d3,-100
            sh  d3,vortex_object+(2*2)
butt11


exitcont:
            sh      d0,oldjoy
            lw  ra,-4(a8)
            jr  ra
            nop

oldjoy: dw 0

Readcontroller1:
            la      d0,pif1
            lui     a0,$A480       ;SI DRAM ADDR.
            sw      d0,0(a0)  ; pif1
            li      d0,$1FC007C0
            sw      d0,$10(a0)  ;64B DRAM -> PIF
            jr      ra
            nop

Readcontroller2:
            lui     a0,$A480
            la      d0,pif2
            sw      d0,$0000(a0) ;si dram address
            lui     d0,$1FC0     
            ori     d0,d0,$07C0  ;PIF joychannel
            sw      d0,$0004(a0) ;64B PIF->DRAM
            jr ra
            nop


 CNOP 0,8
pif1:  DW $FF010401
 DW $00000000
 DW $FF010401
 DW $00000000 
 DW $FF010401
 DW $00000000
 DW $FF010401
 DW $00000000
 DW $FE000000
 DW $00000000
 DW $00000000
 DW $00000000
 DW $00000000
 DW $00000000
 DW $00000000
 DW $00000001
 
pif2: DW 0,0,0,0,0,0,0,0
      DW 0,0,0,0,0,0,0,0
