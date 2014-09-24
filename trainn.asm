TRAINN:
     OBJ $A0000180

                    nop
                    mfc0    k0,r14
                    nop
                    add     k0,k0,4
                    li    k1,$80000018
                    sd      d0,0(k1)       ;dont use d5!!!
                    sd      d1,8(k1)
                    sd      a0,16(k1)
                    sd      at,24(k1)
                    sd      d2,32(k1)
                    la      a0,INTdelay
                    lhu     d0,0(a0)
                    addiu   d0,d0,-1
                    bgtzl   d0,INTreturn
                    sh      d0,0(a0)


            lw  t0,$80119448
            bne t0,$8e440000,There1
            li  t0,$21
TRAIN1      sb  t0,$80102ee7 ;all levels

There1
            lw  t0,$8006da0c
            beqz t0,There2
TRAIN2      sw  r0,$8006da0c    ;health
There2
            lhu t1,$800648d8
            bne t1,$0092,There3
            li  t2,$80
TRAIN3      sb  t2,$800648d9    ;ammo reduction disable
There3  

INTreturn:
                    ld      d0,0(k1)       
                    ld      d1,8(k1)
                    ld      a0,$10(k1)
                    ld      at,$18(k1)
                    ld      d2,32(k1)
                    mtc0    r0,r18
                    jr      k0
                    nop
INTdelay: Dh $400
oldjoyTRAINER dh 0
 cnop 0,8
INT_stack:
   OBJEND
TRAINNEND:

