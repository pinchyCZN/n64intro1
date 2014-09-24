INITVID:            addiu   t0,r0,8  ;init video RUTINE
                    lui     at,$BFC0
                    sw      t0,$07FC(at) ;CLEAR BUTTONS??
                    lui     a0,$A440
                    li      t1,$00013006
                    sw      t1,0(a0)   ;STATUS REG=$0001.3006
                    lw      t1,frame       ;ORIGIN=frame
                    sw      t1,4(a0)
                    li      t1,$0140
                    sw      t1,$8(a0)   ;WIDTH=140

           ;****TEST IF PAL AND INIT ACCORDINGLY******
                    lw      t1,($A0000300)
;                    beqz    t1,pal_init
  b pal_init
                    nop
           ;****continue with NTSC init*********
ntsc_init           li      t1,$200
                    sw      t1,$C(a0)   ;INTERUPT AT LINE 200
                    li      t1,0
                    sw      t1,$10(a0)   ;CLEAR INTERUPT TO 0
                    li      t1,$03E52239
                    sw      t1,$14(a0)   ;VIDEO TIMING=03E5.2239
                    li      t1,$20D
                    sw      t1,$18(a0)   ;V_SYNC=020D
                    li      t1,$C15
                    sw      t1,$1C(a0)   ;H_SYNC=0C15
                    li      t1,$0C150C15
                    sw      t1,$20(a0)   ;H_SYNC_LEAP=0C15
                    li      t1,$6C02EC
                    sw      t1,$24(a0)   ;H_VID=006C.02EC(640 PIXELS)
                    li      t1,$2501FF
                    sw      t1,$28(a0)   ;V_VID=0025.01FF
                    li      t1,$000E0204
                    sw      t1,$2C(a0)   ;V_BURST=000E.0204
                    li      t1,$200
                    sw      t1,$30(a0)   ;X_SCALE=0200
                    li      t1,$400
                    sw      t1,$34(a0)   ;Y_SCALE=0200
                    jr      ra
                    nop
pal_init:
                    li      t1,$200
                    sw      t1,$C(a0)   ;INTERUPT AT LINE 200
                    li      t1,$18E
                    sw      t1,$10(a0)     
                    li      t1,$4541E3A
                    sw      t1,$14(a0)
                    li      t1,$271
                    sw      t1,$18(a0)
                    li      t1,$170C69
                    sw      t1,$1C(a0)
                    li      t1,$C6F0C6D
                    sw      t1,$20(a0)
                    li      t1,$800300
                    sw      t1,$24(a0)    ;H_VID=0800.0300(640 PIXELS)
                    li      t1,$5F0239
                    sw      t1,$28(a0)    ;V_VID=005F.0239
                    li      t1,$9026B
                    sw      t1,$2C(a0)    ;V_BURST=0009.026B
                    li      t1,$200
                    sw      t1,$30(a0)
                    li      t1,$400
                    sw      t1,$34(a0)
                    jr      ra
                    nop

storeINT            la    a0,INT_VECTOR
                    li    a1,$A0000180
                    la    d0,(END_VECTOR-INT_VECTOR)/4  ;number of words
@storeloop:         lw    d1,0(a0)
                    addiu a0,a0,4
                    sw    d1,0(a1)
                    sync
                    cache $10,0(a1)
                    addiu a1,a1,4
                    bne   d0,r0,@storeloop
                    addiu d0,d0,-1
                    jr ra
                    nop

INT_VECTOR:
      obj $80000180
             LA   k0,INT_HANDLER
             JR   K0
             NOP
      objend
END_VECTOR

INT_HANDLER:
             la   k0,intstack
             mfc0 k1,C0_SR
             nop
             nop
             sw   at,0(k0)
             sw   k1,-4(k0)
             and  k1,~(SR_EXL|SR_IE|SR_KSU_MASK)
             mtc0 k1,C0_SR

;        SW     at,$0000(K0)
        SW     v0,$0004(K0)
        SW     v1,$0008(K0)
        SW     a0,$000c(K0)
        SW     a1,$0010(K0)
        SW     a2,$0014(K0)
        SW     a3,$0018(K0)
        SW     t0,$001c(K0)
        SW     t1,$0020(K0)
        SW     t2,$0024(K0)
        SW     t3,$0028(K0)
        SW     t4,$002c(K0)
        SW     t5,$0030(K0)
        SW     t6,$0034(K0)
        SW     t7,$0038(K0)
        SW     s0,$003c(K0)
        SW     s1,$0040(K0)
        SW     s2,$0044(K0)
        SW     s3,$0048(K0)
        SW     s4,$004c(K0)
        SW     s5,$0050(K0)
        SW     s6,$0054(K0)
        SW     s7,$0058(K0)
        SW     t8,$005c(K0)
        SW     t9,$0060(K0)
        SW     sp,$0064(K0)
        SW     s8,$0068(K0)
        sw     ra,$006c(K0)



             lw      d0,MI_INTR_REG     ; # get rcp interrupt register
             andi    d0,0x3f            ;             # look at 6 bits only
             andi    d1,d0,MI_INTR_SP
             beqz    d1,vi_int
             nop
;*******sp int**********             
             andi    d0,~MI_INTR_SP & $3F  ;note it was seen
             lw      d2,SP_STATUS_REG
             li      d3,SP_CLR_INTR
             sw      d3,SP_STATUS_REG

;**********VI INT***********

vi_int       andi    d1,d0,MI_INTR_VI
             beqz    d1,ai_int
             nop

             andi    d0,~MI_INTR_VI & $3F
             sw      r0,VI_CURRENT_REG
             li      d2,1
             sw      d2,vblankdone
             lw      d2,watchpoint
             addu    d2,1
             sw      d2,watchpoint
;             lw      d2,continuedepack
;             bnez    d2,exitdepack
             nop
             beqz    d0,NOMORE_RCP_INTS
             NOP
ai_int       andi    d1,d0,MI_INTR_AI
             beqz    d1,si_int
             nop
             andi    d0,~MI_INTR_AI & $3F
             li      d1,1
             sw      d1,AI_STATUS_REG
             beqz    d0,NOMORE_RCP_INTS
             NOP
si_int       andi    d1,d0,MI_INTR_SI
             beqz    d1,pi_int
             nop
             andi    d0,~MI_INTR_SI & $3F
             sw      r0,SI_STATUS_REG
             beqz    d0,NOMORE_RCP_INTS
             nop
pi_int       andi    d1,d0,MI_INTR_PI
             beqz    d1,dp_int
             nop
             andi    d0,~MI_INTR_PI & $3F
             li      d1,PI_CLR_INTR
             sw      d1,PI_STATUS_REG
             beqz    d0,NOMORE_RCP_INTS
             nop
dp_int
             andi    d1,d0,MI_INTR_DP
             beqz    d1,NOMORE_RCP_INTS
             nop
             andi    d0,~MI_INTR_DP & $3F
             li      d1,MI_CLR_DP_INTR
             sw      d1,MI_BASE_REG
NOMORE_RCP_INTS



             la   k0,intstack

        lw     at,$0000(K0)
        lw     d0,$001c(K0)
        lw     d1,$0020(K0)
        lw     d2,$0024(K0)
        lw     d3,$0028(K0)
        lw     a0,$000c(K0)
        lw     a1,$0010(K0)
             lw  k1,-4(k0)

             nop
             mtc0 k1,C0_SR
             nop
             nop
             eret
             nop


       nop
       
intstack:
       dcb 32*4,0
