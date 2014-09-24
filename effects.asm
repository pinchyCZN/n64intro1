circsin:      dh 0
circsin2:       dh 0
circradius:     dh 1000
circradspeed:   dh 0
  cnop 0,4
moveletters
        la      a3,sintable             ;a3=sin   a4=cos
        la      a4,sintable+128*4
        lh      d0,circsin
        lh      d1,circradius
        li      d9,3
@loop1
        la      a0,object1
        beq     d9,3,@startit
        nop
        la      a0,object2
        beq     d9,2,@startit
        nop
        la      a0,object3
@startit
        sll     d2,d0,2
        addu    a5,a3,d2
        lw      d3,0(a5)
        multu   d3,d1
        mflo    d3
        sra     d3,16
        sh      d3,2(a0)
        addu    a5,a4,d2
        lw      d4,0(a5)
        multu   d4,d1
        mflo    d4
        sra     d4,16
        sh      d4,0(a0)
        addu    d0,100           ;spacing between next one
        andi    d0,$1ff
        bne     d9,1,@loop1
        addu    d9,-1
        lh      d0,circsin
        lh      d1,circsin2
        addu    d1,1            ;speed2
        andi    d1,$1ff
        sh      d1,circsin2
        sll     d1,2
        addu    a5,a3,d1
        lw      d2,0(a5)
        li      d3,10
        multu   d2,d3
        mflo    d2
        sra     d2,16
        addu    d0,d2
        andi    d0,$1ff
        sh      d0,circsin
        lh      d1,circradspeed
        addu    d1,1
        andi    d1,$1ff
        sh      d1,circradspeed
        sll     d1,2
        addu    a5,a3,d1
        lw      d3,0(a5)
        li      d4,500
        multu   d3,d4
        mflo    d3
        sra     d3,16
        addu    d3,1000
        sh      d3,circradius

        jr      ra
        nop




createstaticlist:
        li      d9,4
        sw      ra,-16(a8)

@donextletter
        la      a0,c_verts
        la      a1,c_vertslist|$A0000000
        li      d0,336
        beq     d9,4,@loop1
        nop
        la      a0,z_verts
        la      a1,z_vertslist|$A0000000
        li      d0,108
        beq     d9,3,@loop1
        nop
        la      a0,n_verts
        la      a1,n_vertslist|$A0000000
        li      d0,108
        beq     d9,2,@loop1
        nop
        b     @exit

@loop1
        sw      a0,0(a8)
        sw      a1,-4(a8)
        sw      d0,-8(a8)
        blt     d0,15,@loop2

        move    a4,a1  ;glistp
        li      a1,15  ;#of vetices
        li      a2,0    ;index
        jal     SPvertex
        nop
        li      a0,0
        li      d8,5-1
@subloop1
        sw      a0,-12(a8)
        addu    a1,a0,1
        addu    a2,a0,2
        jal     SPtri1
        nop
        lw      a0,-12(a8)
        addu    a0,3
        bnez    d8,@subloop1
        addu    d8,-1


        lw      a0,0(a8)
        move    a1,a4
        lw      d0,-8(a8)
        addu    a0,$10*15
        addu    d0,-15
        b       @loop1
        nop

@loop2
        lw      a0,0(a8)
        lw      a1,-4(a8)
        lw      d0,-8(a8)
        blez    d0,@nomore
        move    a4,a1  ;glistp
        move    a1,d0  ;#of vetices
        li      a2,0    ;index
        jal     SPvertex
        nop
        li      a0,0
        lw      d8,-8(a8)
        addu    d8,-1
        
@subloop2
        sw      a0,-12(a8)
        addu    a1,a0,1
        addu    a2,a0,2
        jal     SPtri1
        nop
        lw      a0,-12(a8)
        addu    a0,3
        bnez    d8,@subloop2
        addu    d8,-1
        move    a1,a4


@nomore
        addu    d9,-1
        move    a2,a1
        jal     SPendDisplaylist
        nop
        b       @donextletter
        nop

@exit   lw      ra,-16(a8)
        jr      ra
        nop


createvortexlist
        sw      ra,4(a8)
        la      a0,vortexvertices
        la      a1,vortex_vertslist|$A0000000
        li      d0,vortexnumber
@loop2
        sw      a0,0(a8)
        sw      a1,-4(a8)
        sw      d0,-8(a8)
        move    a4,a1  ;glistp
        li      a1,12  ;#of vetices
        li      a2,0    ;index
        jal     SPvertex
        nop

        li      a0,0
        li      d9,3-1
@loop1
        sw      a0,-12(a8)
        addu    a1,a0,1
        addu    a2,a0,2
        jal     SPtri1
        nop
        lw      a0,-12(a8)
        addu    a0,2
        addu    a1,a0,1
        addu    a2,a0,-2
        jal     SPtri1
        nop
        lw      a0,-12(a8)
        addu    a0,4
        bnez    d9,@loop1
        addu    d9,-1

        lw      d0,-8(a8)
        lw      a0,0(a8)
        move    a1,a4
        addu    a0,$10*12
        addu    d0,-12
        bgtz    d0,@loop2
        nop
        move    a2,a1
        jal     SPendDisplaylist
        nop
        lw      ra,4(a8)
        jr      ra
        nop


diagposition    dw 0
cyclecolor      dw $22112211
copperfx
        sw      ra,4(a8)
        lw      a4,glistp
        lw      a5,diagposition
        lw      a6,cyclecolor
        addu    a0,a5,-15
        addu    a1,a5,-15
        negu     a5
        addu    a2,a5,319+15
        addu    a3,a5,239+15
        li      d7,16
        sw      d7,-16(a8)
@cycle
        sw      a0,0(a8)
        sw      a1,-4(a8)
        xor     a6,$FFFeFFFe
        move    a0,a6
        move    a1,a4
        jal     DPsetfillcolor
        nop
        lw      a0,0(a8)
        bltzl   a0,@make0
        li      a0,0      
@make0  move    a4,a1
        lw      a1,-4(a8)
        bltzl   a1,@make0a
        li      a1,0
@make0a
        sw      a2,-8(a8)
        sw      a3,-12(a8)
        jal     DPfillrectangle
        nop
        lw      a0,0(a8)
        lw      a1,-4(a8)
        lw      a2,-8(a8)
        lw      a3,-12(a8)
                li      t0,$E7000000
                sw      t0,0(a4)
                sw      r0,4(a4)
                addu    a4,8
        lw      d7,-16(a8)
        addu    a0,d7
        addu    a1,d7
        subu    a2,d7
        subu    a3,d7
        addu    d7,-2      ;slope
        andi    d7,15
        sw      d7,-16(a8)
        blt     a0,150,@cycle
        nop
        neg     a5
        addu    a5,1
        bne     a5,16,@here
        andi    a5,$F
        lw      d0,cyclecolor
        xor     d0,$FFFeFFFe
        sw      d0,cyclecolor

@here   sw      a5,diagposition
        sw      a4,glistp

        lhu     d0,cyclecolor
        addu    d0,2
        andi    d0,$FFFF
        sll     d1,d0,16
        or      d0,d1
        sw      d0,cyclecolor

        lw      ra,4(a8)
        jr      ra
        nop
